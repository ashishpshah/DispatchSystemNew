using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CL_SocketService
{
	public class DataContextService
	{
		private readonly string _connectionString_SQL;
		private string filePath { get; set; }
		private bool MDA_QR_Scan_Log_IsActive { get; set; }

		public DataContextService(string connectionString_SQL, string _MDA_QR_Scan_Log_File_Path, bool _MDA_QR_Scan_Log_IsActive)
		{
			_connectionString_SQL = connectionString_SQL;
			filePath = _MDA_QR_Scan_Log_File_Path;
			MDA_QR_Scan_Log_IsActive = _MDA_QR_Scan_Log_IsActive;
		}

		public DataTable ExecuteQuery_SQL(string query)
		{
			DataTable dt = new DataTable();

			try
			{
				MySqlConnection connection = new MySqlConnection(_connectionString_SQL);

				MySqlDataAdapter oraAdapter = new MySqlDataAdapter(query, connection);

				oraAdapter.Fill(dt);

			}
			catch (Exception ex)
			{
				if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteQuery_SQL | { query } | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}

			return dt;
		}

		public DataSet ExecuteQuery_DataSet_SQL(string sqlquerys)
		{
			DataSet ds = new DataSet();

			try
			{
				DataTable dt = new DataTable();

				MySqlConnection connection = new MySqlConnection(_connectionString_SQL);

				foreach (var sqlquery in sqlquerys.Split(";"))
				{
					dt = new DataTable();

					MySqlDataAdapter oraAdapter = new MySqlDataAdapter(sqlquery, connection);

					MySqlCommandBuilder oraBuilder = new MySqlCommandBuilder(oraAdapter);

					oraAdapter.Fill(dt);

					if (dt != null)
						ds.Tables.Add(dt);
				}

			}
			catch (Exception ex)
			{
				if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteQuery_DataSet_SQL | {sqlquerys} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}

			return ds;
		}

		public DataTable ExecuteStoredProcedure_DataTable_SQL(string query, List<MySqlParameter> parameters = null, bool returnParameter = false)
		{
			DataTable dt = new DataTable();

			try
			{
				using (MySqlConnection conn = new MySqlConnection(_connectionString_SQL))
				{
					using (MySqlCommand cmd = new MySqlCommand(query, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;

						if (parameters != null)
							foreach (MySqlParameter param in parameters)
								cmd.Parameters.Add(param);

						MySqlDataAdapter da = new MySqlDataAdapter(cmd);

						da.Fill(dt);

						parameters = null;
					}
				}
			}
			catch (Exception ex)
			{
				if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteStoredProcedure_DataTable_SQL | { query } | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}

			return dt;
		}

		public DataSet ExecuteStoredProcedure_DataSet_SQL(string sp, List<MySqlParameter> spCol = null, bool returnParameter = false)
		{
			try
			{
				using (MySqlConnection con = new MySqlConnection(_connectionString_SQL))
				{
					using (MySqlCommand cmd = new MySqlCommand(sp, con))
					{
						cmd.CommandType = CommandType.StoredProcedure;

						if (spCol != null && spCol.Count > 0)
							cmd.Parameters.AddRange(spCol.ToArray());

						using (MySqlDataAdapter adp = new MySqlDataAdapter(cmd))
						{
							DataSet ds = new DataSet();
							adp.Fill(ds);
							return ds;
						}
					}
				}
			}
			catch (Exception ex)
			{
				if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteStoredProcedure_DataSet_SQL | { sp } | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}
		}

		public bool ExecuteNonQuery_SQL(string query, List<MySqlParameter> parameters = null)
		{
			try
			{
				using (MySqlConnection con = new MySqlConnection(_connectionString_SQL))
				{
					con.Open();

					MySqlCommand cmd = con.CreateCommand();

					cmd.CommandType = CommandType.Text;
					cmd.CommandText = query;

					if (parameters != null)
						foreach (MySqlParameter param in parameters)
							cmd.Parameters.Add(param);

					cmd.ExecuteNonQuery();
				}

				return true;
			}
			catch (Exception ex)
			{
				if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteNonQuery_SQL | { query } | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return false;
			}
		}

		public (bool, string, long) ExecuteStoredProcedure_SQL(string query, List<MySqlParameter> parameters, bool returnParameter = false)
		{
			var response = string.Empty;

			using (MySqlConnection con = new MySqlConnection(_connectionString_SQL))
			{
				using (MySqlCommand cmd = con.CreateCommand())
				{
					try
					{
						con.Open();

						cmd.CommandType = CommandType.StoredProcedure;
						cmd.CommandText = query;
						//cmd.DeriveParameters();

						if (parameters != null && parameters.Count > 0)
							cmd.Parameters.AddRange(parameters.ToArray());

						if (returnParameter)
							cmd.Parameters.Add(new MySqlParameter("P_RESULT", MySqlDbType.VarString, 2000) { Direction = ParameterDirection.Output });

						cmd.CommandTimeout = 86400;
						cmd.ExecuteNonQuery();

						//RETURN VALUE
						//response = cmd.Parameters["P_Response"].Value.ToString();

						response = "S|Success";

						if (cmd.Parameters.Contains("P_RESULT"))
						{
							response = cmd.Parameters["P_RESULT"].Value.ToString();
						}

						con.Close();
						cmd.Parameters.Clear();
						cmd.Dispose();

					}
					catch (Exception ex)
					{
						con.Close();
						cmd.Parameters.Clear();
						cmd.Dispose();

						if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteStoredProcedure_SQL | { query } | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

						response = "E|Opps!... Something went wrong. " + JsonConvert.SerializeObject(ex) + "|0";
					}
				}
			}

			if (!string.IsNullOrEmpty(response) && response.Contains("|"))
			{
				var msgtype = response.Split('|').Length > 0 ? Convert.ToString(response.Split('|')[0]) : "";
				var message = response.Split('|').Length > 1 ? Convert.ToString(response.Split('|')[1]).Replace("\"", "") : "";

				Int64 strid = 0;
				if (Int64.TryParse(response.Split('|').Length > 2 ? Convert.ToString(response.Split('|')[2]).Replace("\"", "") : "0", out strid)) { }

				return (msgtype.Contains("S"), message, strid);
			}
			else
				return (false, "Opps!... Something went wrong.", 0);
		}

		public bool ExecuteNonQuery_Delete_SQL(string query, List<MySqlParameter> parameters = null)
		{
			try
			{
				using (MySqlConnection con = new MySqlConnection(_connectionString_SQL))
				{
					con.Open();

					MySqlCommand cmd = con.CreateCommand();
					cmd.CommandType = CommandType.Text;
					cmd.CommandText = query;

					if (parameters != null)
						foreach (MySqlParameter param in parameters)
							cmd.Parameters.Add(param);

					cmd.ExecuteNonQuery();
				}

				return true;
			}
			catch (Exception ex)
			{
				if (MDA_QR_Scan_Log_IsActive) Write_Log($"Error | DataBase | ExecuteNonQuery_Delete_SQL | { query } | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return false;
			}
		}


		private void Write_Log(string text)
		{
			if (!string.IsNullOrEmpty(text) && MDA_QR_Scan_Log_IsActive)
			{
				try
				{
					var _filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd"));
					_filePath = _filePath.Replace("<HH>", DateTime.Now.ToString("HH"));

					if (!System.IO.Directory.Exists(Path.GetDirectoryName(_filePath)))
						System.IO.Directory.CreateDirectory(Path.GetDirectoryName(_filePath));

					if (!System.IO.File.Exists(_filePath))
						System.IO.File.Create(_filePath).Dispose();

					using (StreamWriter sw = System.IO.File.AppendText(_filePath))
						sw.WriteLine((text.StartsWith("<$>") ? System.Environment.NewLine : "") + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text.Replace("<$>", "") + System.Environment.NewLine);
				}
				catch (Exception) { }

			}

			Console.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text);
		}
	}

}
