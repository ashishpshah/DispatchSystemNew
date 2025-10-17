using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace CL_SyncBatch
{
	public static class DataContextService
	{
		private static string _connectionString_SQL;
		private static string _connectionString_Oracle;
		private static string filePath;

		static DataContextService() { }

		public static void Configure(string connectionString_SQL, string connectionString_Oracle, string filePath)
		{
			_connectionString_SQL = connectionString_SQL;
			_connectionString_Oracle = connectionString_Oracle;
			filePath = filePath;
		}

		public static string Get_DbSchemaName_SQL()
		{
			string keyValue = "database=";
			int startIndex = _connectionString_SQL.IndexOf(keyValue) + keyValue.Length;
			int endIndex = _connectionString_SQL.IndexOf(';', startIndex);
			return _connectionString_SQL.Substring(startIndex, endIndex - startIndex);
		}

		public static DataTable ExecuteQuery(string sqlquery)
		{
			DataTable dt = new DataTable();
			try
			{

				OracleConnection connection = new OracleConnection(_connectionString_Oracle);

				OracleDataAdapter oraAdapter = new OracleDataAdapter(sqlquery, connection);

				OracleCommandBuilder oraBuilder = new OracleCommandBuilder(oraAdapter);

				oraAdapter.Fill(dt);
			}
			catch (Exception ex)
			{
				Write_Log($"Error | DataBase | ExecuteQuery | {sqlquery} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
			}
			return dt;
		}

		public static DataSet ExecuteQuery_DataSet(string sqlquerys)
		{
			DataSet ds = new DataSet();

			try
			{
				DataTable dt = new DataTable();

				OracleConnection connection = new OracleConnection(_connectionString_Oracle);

				foreach (var sqlquery in sqlquerys.Split(";"))
				{
					if (!string.IsNullOrEmpty(sqlquery.Trim()))
					{
						try
						{

							dt = new DataTable();

							OracleDataAdapter oraAdapter = new OracleDataAdapter(sqlquery, connection);

							OracleCommandBuilder oraBuilder = new OracleCommandBuilder(oraAdapter);

							oraAdapter.Fill(dt);

							if (dt != null)
								ds.Tables.Add(dt);
						}
						catch (Exception ex)
						{ dt = new DataTable(); ds.Tables.Add(dt); continue; }
					}
				}
			}
			catch (Exception ex)
			{
				Write_Log($"Error | DataBase | ExecuteQuery_DataSet | {sqlquerys} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
			}

			return ds;
		}

		public static bool ExecuteNonQuery(string query, List<OracleParameter> parameters = null)
		{
			var strParams = "";

			try
			{
				using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
				{
					con.Open();

					OracleCommand cmd = con.CreateCommand();
					cmd.CommandType = CommandType.Text;
					cmd.CommandText = query;

					//if (parameters != null)
					//{
					//	foreach (OracleParameter param in parameters)
					//	{
					//		try
					//		{
					//			if (param.Direction == ParameterDirection.Input)
					//				strParams = strParams + param.ParameterName + " : " + param.Value.ToString() + " | ";
					//		}
					//		catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

					//		cmd.Parameters.Add(param);
					//	}
					//}

					if (parameters != null)
						foreach (OracleParameter param in parameters)
							cmd.Parameters.Add(param);

					int rowsAffected = cmd.ExecuteNonQuery();
				}

				return true;
			}
			catch (Exception ex)
			{
				Write_Log($"Error | DataBase | ExecuteNonQuery | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
				return false;
			}
		}


		public static bool ExecuteNonQuery_Delete(string query, OracleParameter[] parameters = null)
		{
			try
			{
				using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
				{
					con.Open();

					OracleCommand cmd = con.CreateCommand();
					cmd.CommandType = CommandType.Text;
					cmd.CommandText = query;

					cmd.ExecuteNonQuery();
				}

				return true;
			}
			catch (Exception ex)
			{
				Write_Log($"Error | DataBase | ExecuteNonQuery_Delete | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
				return false;
			}
		}

		public static string ExecuteInsertQuery(string query)
		{
			using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
			{
				try
				{
					con.Open();

					OracleCommand cmd = con.CreateCommand();
					cmd.CommandType = CommandType.Text;
					cmd.CommandText = query;

					int rowsUpdated = cmd.ExecuteNonQuery();

					con.Close();

					if (rowsUpdated == 1)
						return "S|Success!";
				}
				catch (Exception ex)
				{
					Write_Log($"Error | DataBase | ExecuteInsertQuery | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
					con.Close();
				}
			}

			return "E|Opps!... Somthing went wrong to save data.";
		}

		public static string ExecuteUpdateQuery(string query, List<OracleParameter> parameters = null)
		{
			using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
			{
				try
				{
					con.Open();

					OracleCommand cmd = con.CreateCommand();
					cmd.CommandType = CommandType.Text;
					cmd.CommandText = query;

					if (parameters != null && parameters.Count > 0)
						cmd.Parameters.AddRange(parameters.ToArray());

					int rowsUpdated = cmd.ExecuteNonQuery();

					con.Close();

					if (rowsUpdated == 1)
						return "S|Success!";
				}
				catch (Exception ex)
				{
					Write_Log($"Error | DataBase | ExecuteUpdateQuery | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
					con.Close();
				}
			}

			return "E|Opps!... Somthing went wrong to save data.";
		}


		public static string ExecuteFunction(string strFunction, List<OracleParameter> parameters = null)
		{
			var strParams = "";

			using (OracleConnection objConn = new OracleConnection(_connectionString_Oracle))
			{
				OracleCommand objCmd = new OracleCommand();
				objCmd.Connection = objConn;
				objCmd.CommandText = strFunction;
				objCmd.CommandType = CommandType.StoredProcedure;

				foreach (OracleParameter param in parameters)
				{
					try
					{
						if (param.Direction == ParameterDirection.Input)
							strParams = strParams + param.ParameterName + " : " + param.Value.ToString() + " | ";
					}
					catch (Exception ex) { }

					objCmd.Parameters.Add(param);
				}

				objCmd.Parameters.Add("return_value", OracleDbType.Varchar2).Direction = ParameterDirection.ReturnValue;

				try
				{
					objConn.Open();
					objCmd.ExecuteNonQuery();
					return Convert.ToString(objCmd.Parameters["return_value"].Value);
				}
				catch (Exception ex)
				{
					Write_Log($"Error | DataBase | ExecuteFunction | {strFunction} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
				}

				objConn.Close();
			}

			return null;
		}

		public static (bool, string, long) ExecuteStoredProcedure(string query, List<OracleParameter> parameters, bool returnParameter = false)
		{
			var response = string.Empty;

			using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
			{
				using (OracleCommand cmd = con.CreateCommand())
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
							cmd.Parameters.Add(new OracleParameter("P_RESULT", OracleDbType.Varchar2, 2000) { Direction = ParameterDirection.Output });

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

						Write_Log($"Error | DataBase | ExecuteStoredProcedure | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

						response = "E|Opps!... Something went wrong.|0";
					}
				}
			}

			if (!string.IsNullOrEmpty(response) && response.Contains("|"))
			{
				var msgtype = response.Split('|').Length > 0 ? Convert.ToString(response.Split('|')[0]) : "";
				var message = response.Split('|').Length > 1 ? Convert.ToString(response.Split('|')[1]).Replace("\"", "") : "";
				var strid = response.Split('|').Length > 2 ? Convert.ToString(response.Split('|')[2]).Replace("\"", "") : "0";

				return (msgtype.Contains("S"), message, Convert.ToInt64(string.IsNullOrEmpty(strid) ? "0" : strid));
			}
			else
				return (false, "Opps!... Something went wrong.", 0);
		}

		//public static string ExecuteStoredProcedure(string query, List<OracleParameter> parameters, bool returnParameter = false)
		//{
		//	var result = string.Empty;

		//	using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
		//	{
		//		using (OracleCommand cmd = con.CreateCommand())
		//		{
		//			try
		//			{
		//				con.Open();

		//				cmd.CommandType = CommandType.StoredProcedure;
		//				cmd.CommandText = query;
		//				//cmd.DeriveParameters();

		//				if (parameters != null && parameters.Count > 0)
		//					cmd.Parameters.AddRange(parameters.ToArray());

		//				if (returnParameter)
		//					cmd.Parameters.Add(new OracleParameter("P_RESULT", OracleDbType.Varchar2, ParameterDirection.Output));

		//				cmd.ExecuteNonQuery();

		//				//RETURN VALUE
		//				//result = cmd.Parameters["P_Response"].Value.ToString();

		//				result = "S|Success";

		//				if (cmd.Parameters.Contains("P_RESULT"))
		//				{
		//					result = cmd.Parameters["P_RESULT"].Value.ToString();
		//				}

		//				con.Close();
		//				cmd.Parameters.Clear();
		//				cmd.Dispose();

		//			}
		//			catch (Exception ex)
		//			{
		//				con.Close();
		//				cmd.Parameters.Clear();
		//				cmd.Dispose();

		//				result = "E|Error";
		//			}
		//		}
		//	}

		//	return result;
		//}

		public static DataTable ExecuteStoredProcedure_DataTable(string query, List<OracleParameter> parameters, bool returnParameter = false)
		{
			DataTable dt = new DataTable();

			try
			{
				using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
				{
					using (OracleCommand cmd = con.CreateCommand())
					{
						con.Open();

						cmd.CommandType = CommandType.StoredProcedure;
						cmd.CommandText = query;
						//cmd.DeriveParameters();

						if (parameters != null && parameters.Count > 0)
							cmd.Parameters.AddRange(parameters.ToArray());

						if (returnParameter)
							cmd.Parameters.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

						//if (returnParameter)

						//cmd.ExecuteNonQuery();

						//if (cmd.Parameters.Contains("P_OUT"))
						//{
						//    var oracleRefCursor = (OracleRefCursor)(cmd.Parameters["P_OUT"].Value);
						//    var result = oracleRefCursor.GetDataReader();
						//}

						OracleDataAdapter oraAdapter = new OracleDataAdapter(cmd);

						OracleCommandBuilder oraBuilder = new OracleCommandBuilder(oraAdapter);

						oraAdapter.Fill(dt);
					}
				}
			}
			catch (Exception ex)
			{
				Write_Log($"Error | DataBase | ExecuteStoredProcedure_DataTable | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
			}

			return dt;
		}

		public static DataSet ExecuteStoredProcedure_DataSet(string query, List<OracleParameter> parameters)
		{
			//List<OracleParameter> oParams = new List<OracleParameter>();
			//oParams.Add(new OracleParameter(reportParams.Split('=')[0], reportParams.Split('=')[1]));

			//oParams.Add(new OracleParameter("P_RDATE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
			//oParams.Add(new OracleParameter("P_DRAWDOC", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

			DataSet ds = new DataSet();

			try
			{
				DataTable dt = new DataTable();

				using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
				{
					using (OracleCommand cmd = con.CreateCommand())
					{
						con.Open();

						cmd.CommandType = CommandType.StoredProcedure;
						cmd.CommandText = query;
						//cmd.DeriveParameters();

						if (parameters != null && parameters.Count > 0)
							cmd.Parameters.AddRange(parameters.ToArray());

						//if (returnParameter)

						//cmd.ExecuteNonQuery();

						//if (cmd.Parameters.Contains("P_OUT"))
						//{
						//    var oracleRefCursor = (OracleRefCursor)(cmd.Parameters["P_OUT"].Value);
						//    var result = oracleRefCursor.GetDataReader();
						//}

						OracleDataAdapter da = new OracleDataAdapter(cmd);

						da.Fill(ds);
					}
				}
			}
			catch (Exception ex)
			{
				Write_Log($"Error | DataBase | ExecuteStoredProcedure_DataSet | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");
			}

			return ds;
		}

		public static DataTable ExecuteQuery_SQL(string query)
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
				Write_Log($"Error | DataBase | ExecuteQuery_SQL | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}

			return dt;
		}

		public static DataSet ExecuteQuery_DataSet_SQL(string sqlquerys)
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
				Write_Log($"Error | DataBase | ExecuteQuery_DataSet_SQL | {sqlquerys} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}

			return ds;
		}

		public static DataTable ExecuteStoredProcedure_DataTable_SQL(string query, List<MySqlParameter> parameters = null, bool returnParameter = false)
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
				Write_Log($"Error | DataBase | ExecuteStoredProcedure_DataTable_SQL | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}

			return dt;
		}

		public static DataSet ExecuteStoredProcedure_DataSet_SQL(string sp, List<MySqlParameter> spCol = null, bool returnParameter = false)
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
				Write_Log($"Error | DataBase | ExecuteStoredProcedure_DataSet_SQL | {sp} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return null;
			}
		}

		public static bool ExecuteNonQuery_SQL(string query, List<MySqlParameter> parameters = null)
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
				Write_Log($"Error | DataBase | ExecuteNonQuery_SQL | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return false;
			}
		}

		public static (bool, string, long) ExecuteStoredProcedure_SQL(string query, List<MySqlParameter> parameters, bool returnParameter = false)
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

						Write_Log($"Error | DataBase | ExecuteStoredProcedure_SQL | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

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

		public static bool ExecuteNonQuery_Delete_SQL(string query, List<MySqlParameter> parameters = null)
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
				Write_Log($"Error | DataBase | ExecuteNonQuery_Delete_SQL | {query} | {Environment.NewLine}Error: {JsonConvert.SerializeObject(ex)}");

				return false;
			}
		}


		private static void Write_Log(string text)
		{
			if (!string.IsNullOrEmpty(text))
			{
				try
				{
					if (string.IsNullOrEmpty(filePath)) filePath = "\\\\IFFCOKRL-PROD\\KalolReports\\LogFile\\<YYYYMMDD>\\PreRequesite_<TT>.txt";

					var _filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd")).Replace("<HH>", DateTime.Now.ToString("HH"));

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
