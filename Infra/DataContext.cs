using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Presentation;
using DocumentFormat.OpenXml.Spreadsheet;
using Humanizer;
using MessagePack.Formatters;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Globalization;

namespace Dispatch_System
{
    public static class DataContext
    {
        public static string _connectionString_Oracle = AppHttpContextAccessor.AppConfiguration.GetSection("ConnectionString_Oracle").Value;
        public static string _connectionString_SQL = AppHttpContextAccessor.AppConfiguration.GetSection("ConnectionString_SQL").Value;
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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteQuery", sqlquery, ex);
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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteQuery_DataSet", sqlquerys, ex);
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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteNonQuery", query, ex);
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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteNonQuery_Delete", query, ex);
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
                    if (AppHttpContextAccessor.IsLogActive)
                        LogService.LogInsert("Error | DataBase | ExecuteInsertQuery", query, ex);
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
                    con.Close();

                    if (AppHttpContextAccessor.IsLogActive)
                        LogService.LogInsert("Error | DataBase | ExecuteUpdateQuery", query, ex);
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
                    if (AppHttpContextAccessor.IsLogActive)
                        LogService.LogInsert("Error | DataBase | ExecuteFunction", strFunction, ex);
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

                        if (AppHttpContextAccessor.IsLogActive)
                            LogService.LogInsert("Error | DataBase | ExecuteStoredProcedure", query, ex);

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
                return (false, ResponseStatusMessage.Error, 0);
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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteStoredProcedure_DataTable", query, ex);
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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteStoredProcedure_DataSet", query, ex);
            }

            return ds;
        }

        public static void OracleBulkCopy(string tableName, DataTable dt)
        {
            try
            {
                using (OracleConnection con = new OracleConnection(_connectionString_Oracle))
                {
                    con.Open();

                    foreach (DataRow row in dt.Rows)
                    {
                        foreach (DataColumn column in dt.Columns)
                        {
                            var columnValue = row[column];

                            if (columnValue != DBNull.Value && columnValue is string stringValue && stringValue.Length > 2 && columnValue.ToString().IndexOf("/") == 2 && columnValue.ToString().IndexOf("/", columnValue.ToString().IndexOf("/") + 1) == 5)
                                row[column] = DateTime.ParseExact(stringValue, "dd/MM/yyyy HH:mm", null).ToString("dd-MMM-yyyy hh:mm:ss tt").ToUpper();

                        }
                    }


                    using (OracleBulkCopy bulkCopy = new OracleBulkCopy(con))
                    {
                        bulkCopy.DestinationTableName = tableName;
                        bulkCopy.WriteToServer(dt);
                    }

                    //if (dt != null && dt.Rows.Count > 0)
                    //{
                    //	List<string> columnNames = new List<string>();
                    //	List<string> insertValues = new List<string>();
                    //	List<OracleParameter> parameters = new List<OracleParameter>();

                    //	foreach (DataColumn column in dt.Columns)
                    //	{
                    //		columnNames.Add(column.ColumnName);
                    //	}

                    //	for (int k = 0; k < dt.Rows.Count; k++)
                    //	{
                    //		DataRow row = dt.Rows[k];
                    //		List<string> rowValues = new List<string>();

                    //		foreach (DataColumn column in dt.Columns)
                    //		{
                    //			string parameterName = $":{column.ColumnName}{k}";
                    //			rowValues.Add(parameterName);
                    //			//parameters.Add(new OracleParameter(parameterName, row[column.ColumnName]));
                    //			var columnValue = row[column.ColumnName];

                    //			if (columnValue != DBNull.Value && columnValue is string stringValue && stringValue.Length > 2 && stringValue[2] == '/' && stringValue[4] == '/')
                    //				// This is a date value, format it to TO_DATE
                    //				parameters.Add(new OracleParameter(parameterName, OracleDbType.Date)
                    //				{
                    //					Value = DateTime.ParseExact(stringValue, "dd/MM/yyyy HH:mm", null)
                    //				});
                    //			else
                    //				parameters.Add(new OracleParameter(parameterName, columnValue));
                    //		}

                    //		insertValues.Add($"({string.Join(", ", rowValues)})");
                    //	}

                    //	string insertQuery = $@"INSERT INTO {tableName} ({string.Join(", ", columnNames)}) VALUES {string.Join(", ", insertValues)}";

                    //	using (OracleCommand insertCommand = new OracleCommand(insertQuery, con))
                    //	{
                    //		insertCommand.Parameters.AddRange(parameters.ToArray());
                    //		insertCommand.ExecuteNonQuery();
                    //	}
                    //}

                    con.Close();
                }
            }
            catch (Exception ex) { }

        }

        public static DataTable ExecuteQuery_SQL(string query)
        {
            try
            {
                DataTable dt = new DataTable();

                MySqlConnection connection = new MySqlConnection(_connectionString_SQL);

                MySqlDataAdapter oraAdapter = new MySqlDataAdapter(query, connection);

                oraAdapter.Fill(dt);

                return dt;
            }
            catch (Exception ex)
            {
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteQuery_SQL", query, ex);

                return null;
            }

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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteQuery_DataSet_SQL", sqlquerys, ex);

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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteStoredProcedure_DataTable_SQL", query, ex);

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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteStoredProcedure_DataSet_SQL", sp, ex);

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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteNonQuery_SQL", query, ex);

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

                        if (AppHttpContextAccessor.IsLogActive)
                            LogService.LogInsert("Error | DataBase | ExecuteStoredProcedure_SQL", query, ex);

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
                return (false, ResponseStatusMessage.Error, 0);
        }

        //public static dynamic ExecuteStoredProcedure_SQL(string query, MySqlParameter[] parameters = null)
        //{
        //	try
        //	{
        //		dynamic exo = new System.Dynamic.ExpandoObject();

        //		using (MySqlConnection con = new MySqlConnection(_connectionString_SQL))
        //		{
        //			con.Open();

        //			MySqlCommand cmd = con.CreateCommand();

        //			cmd.CommandType = CommandType.StoredProcedure;
        //			cmd.CommandText = query;

        //			if (parameters != null && parameters.Count() > 0)
        //				foreach (MySqlParameter param in parameters)
        //					cmd.Parameters.Add(param);

        //			cmd.ExecuteNonQuery();

        //			MySqlParameterCollection paramCollection = cmd.Parameters;

        //			for (int i = 0; i < paramCollection.Count; i++)
        //				if (paramCollection[i].Direction == ParameterDirection.Output)
        //					((IDictionary<String, Object>)exo).Add(paramCollection[i].ParameterName.Replace("@", ""), paramCollection[i].Value);
        //		}

        //		if (((IDictionary<String, Object>)exo) != null && ((IDictionary<String, Object>)exo).Count == 1 && ((IDictionary<String, Object>)exo).ContainsKey("response"))
        //			return Convert.ToString(((IDictionary<String, Object>)exo).FirstOrDefault().Value);

        //		return exo;
        //	}
        //	catch (Exception ex)
        //	{
        //		LogService.LogInsert("ExecuteStoredProcedure - DataContext", "", ex);
        //		return null;
        //	}
        //}

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
                if (AppHttpContextAccessor.IsLogActive)
                    LogService.LogInsert("Error | DataBase | ExecuteNonQuery_Delete_SQL", query, ex);

                return false;
            }
        }


        public static async Task SyncData_LocalToCloud(string tableName, List<long> ids_GateInOut, List<long> ids_MDA)
        {
            DataTable dtSql = null;
            DataTable dtOracle = null;
            DataTable filteredDataTable = null;
            DateTime? nullDateTime = null;

            ids_GateInOut = ids_GateInOut == null ? new List<long>() { } : ids_GateInOut;
            ids_MDA = ids_MDA == null ? new List<long>() { } : ids_MDA;

            var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

            plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "EXP_FG_GATE_IN_OUT")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT" +
                            ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
                            ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                            ", EXPECTED_QTY, TRANS_SYS_ID, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                            ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                            "FROM EXP_FG_GATE_IN_OUT WHERE 1 = 1 " +
                            $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        										FROM EXP_FG_GATE_IN_OUT 
        										WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) 
        										IN ({string.Join(", ", checkValues)}) ");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["TRUCK_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
                                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                    ", EXPECTED_QTY, TRANS_SYS_ID, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                                    ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM EXP_FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
                                    "IN (" + string.Join(", ", checkValues) + ") ");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_EXPECTED_QTY", OracleDbType.Int64) { Value = (dr["EXPECTED_QTY"] != DBNull.Value ? Convert.ToInt64(dr["EXPECTED_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_EXP_FG_GATE_IN_OUT", parameters, false);

                                }
                            }
                        }

                    }


                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        										FROM EXP_FG_GATE_IN_OUT 
        										WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL
        										{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
                                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                ", EXPECTED_QTY, TRANS_SYS_ID, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                                ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                "FROM EXP_FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1) ");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

                                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

                                parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_EXP_FG_GATE_IN_OUT", parameters, false);

                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "EXP_FG_GATE_IN_OUT", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "EXP_FG_WEIGHMENT_DETAIL")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                        ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                        ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM EXP_FG_WEIGHMENT_DETAIL WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        											FROM EXP_FG_WEIGHMENT_DETAIL 
        											WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        											IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                    ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                    "FROM EXP_FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_EXP_FG_WEIGHMENT_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        											FROM EXP_FG_WEIGHMENT_DETAIL 
        											WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0 
        											{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                "FROM EXP_FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_EXP_FG_WEIGHMENT_DETAIL", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "EXP_FG_WEIGHMENT_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "FG_GATE_IN_OUT")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                            ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
                            ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                            ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                            ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, MDA_SYS_IDS " +
                            "FROM FG_GATE_IN_OUT WHERE 1 = 1 AND MDA_SYS_IDS IS NOT NULL " +
                            $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO, string MDA_SYS_IDS)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}")
                                            , Convert.ToString($"{row["MDA_SYS_IDS"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_SYS_IDS}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO, MDA_SYS_IDS
        										FROM FG_GATE_IN_OUT 
        										WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO, MDA_SYS_IDS) 
        										IN ({string.Join(", ", checkValues)}) AND MDA_SYS_IDS IS NOT NULL ");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_SYS_IDS"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_SYS_IDS}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
                                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                                    ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED, MDA_SYS_IDS " +
                                    "FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO, MDA_SYS_IDS) " +
                                    "IN (" + string.Join(", ", checkValues) + ") AND MDA_SYS_IDS IS NOT NULL ");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_IDS", OracleDbType.NVarchar2) { Value = (dr["MDA_SYS_IDS"] != DBNull.Value ? Convert.ToString(dr["MDA_SYS_IDS"]) : "") });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_FG_GATE_IN_OUT", parameters, false);

                                }
                            }
                        }

                    }


                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO, MDA_SYS_IDS
        										FROM FG_GATE_IN_OUT 
        										WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL AND MDA_SYS_IDS IS NOT NULL
        										{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO, string MDA_SYS_IDS)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}")
                                            , Convert.ToString($"{row["MDA_SYS_IDS"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_SYS_IDS}')";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
                                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                                ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED, MDA_SYS_IDS " +
                                "FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO, MDA_SYS_IDS) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1) AND MDA_SYS_IDS IS NOT NULL ");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_MDA_SYS_IDS", OracleDbType.NVarchar2) { Value = (dr["MDA_SYS_IDS"] != DBNull.Value ? Convert.ToString(dr["MDA_SYS_IDS"]) : "") });

                                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

                                parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_GATE_IN_OUT", parameters, false);

                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "FG_GATE_IN_OUT", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "FG_WEIGHMENT_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                        ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                        ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM FG_WEIGHMENT_DETAIL WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        											FROM FG_WEIGHMENT_DETAIL 
        											WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        											IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                    ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                    "FROM FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_FG_WEIGHMENT_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        											FROM FG_WEIGHMENT_DETAIL 
        											WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0 
        											{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                "FROM FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_WEIGHMENT_DETAIL", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "FG_WEIGHMENT_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_HEADER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
                        ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
                        "FROM MDA_HEADER WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        										FROM MDA_HEADER 
        										WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
                                        ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
                                        $"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DI_NO", OracleDbType.NVarchar2) { Value = (dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_PLANT_CD", OracleDbType.NVarchar2) { Value = (dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_WH_CD", OracleDbType.NVarchar2) { Value = (dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_PARTY_NAME", OracleDbType.NVarchar2) { Value = (dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER", OracleDbType.NVarchar2) { Value = (dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "") });
                                    parameters.Add(new OracleParameter("P_VEHICLE_NO", OracleDbType.NVarchar2) { Value = (dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_MOBILE_NO", OracleDbType.NVarchar2) { Value = (dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DIST", OracleDbType.Int64) { Value = (dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_ECHIT_NO", OracleDbType.NVarchar2) { Value = (dr["ECHIT_NO"] != DBNull.Value ? Convert.ToString(dr["ECHIT_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_GST_NO", OracleDbType.NVarchar2) { Value = (dr["GST_NO"] != DBNull.Value ? Convert.ToString(dr["GST_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DESP_PLACE", OracleDbType.NVarchar2) { Value = (dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "") });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_HEADER", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        										FROM MDA_HEADER 
        										WHERE PLANT_ID = {plant_id} AND OUT_TIME IS NULL 
        										{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
                                    ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
                                    $"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)}) AND OUT_TIME IS NOT NULL");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_MDA_HEADER", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_HEADER", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, MDA_DT" +
                        ", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM MDA_DETAIL WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_DTL_SYS_ID, long MDA_SYS_ID, string MDA_NO, long PROD_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID
        										FROM MDA_DETAIL 
        										WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
                                checkValues.Add(checkValue);
                            }


                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT" +
                            ", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                            "FROM MDA_DETAIL WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID)  " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_MDA_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_DTL_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_PROD_SNO", OracleDbType.Int64) { Value = (dr["PROD_SNO"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SNO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SHIPMENT_NO", OracleDbType.Int64) { Value = (dr["SHIPMENT_NO"] != DBNull.Value ? Convert.ToInt64(dr["SHIPMENT_NO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_REQUISITION_DATA")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO, MDA_DATE, SKU_CODE, SKU_NAME" +
                        ", BOTTLE_QTY, CARTON_QTY, LOADING_BAY, LOADING_BAY_SYS_ID, SKU_ORDER, STATUS_CODE, LOADING_STATUS, LOADED_QTY, SHORT_QTY, ADDITIONAL_QTY" +
                        ", REASON, LOADING_PROGRESS, LOADED_ITEM, API_RESULT, API_REMARK, IS_POSTED, LOAD_IN_TIME, LOAD_OUT_TIME " +
                        "FROM MDA_REQUISITION_DATA WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_REQ_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID, string TRUCK_NO, string MDA_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_REQ_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_REQ_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_NO}')";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO
        										FROM MDA_REQUISITION_DATA 
        										WHERE (PLANT_ID, MDA_REQ_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_REQ_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_REQ_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_NO}')";
                                checkValues.Add(checkValue);
                            }


                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO, DATE_FORMAT(MDA_DATE, '%d/%m/%Y %H:%i:%s') AS MDA_DATE, SKU_CODE, SKU_NAME" +
                            ", BOTTLE_QTY, CARTON_QTY, LOADING_BAY, LOADING_BAY_SYS_ID, SKU_ORDER, STATUS_CODE, LOADING_STATUS, LOADED_QTY, SHORT_QTY, ADDITIONAL_QTY" +
                            ", REASON, LOADING_PROGRESS, LOADED_ITEM, API_RESULT, API_REMARK, IS_POSTED, DATE_FORMAT(LOAD_IN_TIME, '%d/%m/%Y %H:%i:%s') AS LOAD_IN_TIME, DATE_FORMAT(LOAD_OUT_TIME, '%d/%m/%Y %H:%i:%s') AS LOAD_OUT_TIME " +
                            $"FROM MDA_REQUISITION_DATA WHERE (PLANT_ID, MDA_REQ_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_MDA_REQ_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_REQ_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_REQ_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_MDA_DATE", OracleDbType.Date) { Value = (dr["MDA_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SKU_CODE", OracleDbType.NVarchar2) { Value = (dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_SKU_NAME", OracleDbType.NVarchar2) { Value = (dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_BOTTLE_QTY", OracleDbType.Int64) { Value = (dr["BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CARTON_QTY", OracleDbType.Int64) { Value = (dr["CARTON_QTY"] != DBNull.Value ? Convert.ToInt64(dr["CARTON_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_LOADING_BAY", OracleDbType.NVarchar2) { Value = (dr["LOADING_BAY"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY"]) : "") });
                                    parameters.Add(new OracleParameter("P_LOADING_BAY_SYS_ID", OracleDbType.Int64) { Value = (dr["LOADING_BAY_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["LOADING_BAY_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SKU_ORDER", OracleDbType.Int64) { Value = (dr["SKU_ORDER"] != DBNull.Value ? Convert.ToInt64(dr["SKU_ORDER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_STATUS_CODE", OracleDbType.NVarchar2) { Value = (dr["STATUS_CODE"] != DBNull.Value ? Convert.ToString(dr["STATUS_CODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_LOADING_STATUS", OracleDbType.NVarchar2) { Value = (dr["LOADING_STATUS"] != DBNull.Value ? Convert.ToString(dr["LOADING_STATUS"]) : "") });
                                    parameters.Add(new OracleParameter("P_LOADED_QTY", OracleDbType.Int64) { Value = (dr["LOADED_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SHORT_QTY", OracleDbType.Int64) { Value = (dr["SHORT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["SHORT_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_ADDITIONAL_QTY", OracleDbType.Int64) { Value = (dr["ADDITIONAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["ADDITIONAL_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_REASON", OracleDbType.NVarchar2) { Value = (dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_LOADING_PROGRESS", OracleDbType.NVarchar2) { Value = (dr["LOADING_PROGRESS"] != DBNull.Value ? Convert.ToString(dr["LOADING_PROGRESS"]) : "") });
                                    parameters.Add(new OracleParameter("P_LOADED_ITEM", OracleDbType.Int64) { Value = (dr["LOADED_ITEM"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_ITEM"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_API_RESULT", OracleDbType.NVarchar2) { Value = (dr["API_RESULT"] != DBNull.Value ? Convert.ToString(dr["API_RESULT"]) : "") });
                                    parameters.Add(new OracleParameter("P_API_REMARK", OracleDbType.NVarchar2) { Value = (dr["API_REMARK"] != DBNull.Value ? Convert.ToString(dr["API_REMARK"]) : "") });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_LOAD_IN_TIME", OracleDbType.Date) { Value = (dr["LOAD_IN_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["LOAD_IN_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_LOAD_OUT_TIME", OracleDbType.Date) { Value = (dr["LOAD_OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["LOAD_OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_REQUISITION_DATA", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_REQUISITION_DATA", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_SEQUENCE")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, MDA_SEQUENCE_NO, MDA_STATUS" +
                    ", MDA_REASON, MDA_REMARK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
                    ", DATE_FORMAT(MDA_STATUS_DATETIME, '%d/%m/%Y %H:%i:%s') AS MDA_STATUS_DATETIME " +
                        "FROM MDA_SEQUENCE WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_SEQ_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SEQ_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SEQ_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID
        										FROM MDA_SEQUENCE 
        										WHERE (PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SEQ_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SEQ_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }


                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, MDA_SEQUENCE_NO, MDA_STATUS" +
                                            ", MDA_REASON, MDA_REMARK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
                                            ", DATE_FORMAT(MDA_STATUS_DATETIME, '%d/%m/%Y %H:%i:%s') AS MDA_STATUS_DATETIME " +
                                            $"FROM MDA_SEQUENCE WHERE (PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();


                                    parameters.Add(new OracleParameter("P_MDA_SEQ_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SEQ_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SEQ_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SEQUENCE_NO", OracleDbType.Int64) { Value = (dr["MDA_SEQUENCE_NO"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SEQUENCE_NO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_STATUS", OracleDbType.NVarchar2) { Value = (dr["MDA_STATUS"] != DBNull.Value ? Convert.ToString(dr["MDA_STATUS"]) : "") });
                                    parameters.Add(new OracleParameter("P_MDA_REASON", OracleDbType.NVarchar2) { Value = (dr["MDA_REASON"] != DBNull.Value ? Convert.ToString(dr["MDA_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_MDA_REMARK", OracleDbType.NVarchar2) { Value = (dr["MDA_REMARK"] != DBNull.Value ? Convert.ToString(dr["MDA_REMARK"]) : "") });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_STATUS_DATETIME", OracleDbType.Date) { Value = (dr["MDA_STATUS_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_STATUS_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_SEQUENCE", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_INVOICE_QR")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQRCODE, BASE64INVQRCODE" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, IS_DISPATCHED " +
                        "FROM MDA_INVOICE_QR WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDAINVQR_SYS_ID, long GATE_SYS_ID, long MDA_SYS_ID, string MDA_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDAINVQR_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToString($"{row["MDA_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDAINVQR_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}')";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO
        										FROM MDA_INVOICE_QR 
        										WHERE (PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, NVL(MDA_SYS_ID, 0), MDA_NO) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDAINVQR_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToString($"{row["MDA_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDAINVQR_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}')";
                                checkValues.Add(checkValue);
                            }


                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQRCODE, BASE64INVQRCODE" +
                            ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, IS_DISPATCHED " +
                            $"FROM MDA_INVOICE_QR WHERE (PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, IFNULL(MDA_SYS_ID, 0), MDA_NO) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();


                                    parameters.Add(new OracleParameter("P_MDAINVQR_SYS_ID", OracleDbType.Int64) { Value = (dr["MDAINVQR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDAINVQR_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_INVOICEQRCODE", OracleDbType.NVarchar2) { Value = (dr["INVOICEQRCODE"] != DBNull.Value ? Convert.ToString(dr["INVOICEQRCODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_BASE64INVQRCODE", OracleDbType.NVarchar2) { Value = (dr["BASE64INVQRCODE"] != DBNull.Value ? Convert.ToString(dr["BASE64INVQRCODE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_DISPATCHED", OracleDbType.Int64) { Value = (dr["IS_DISPATCHED"] != DBNull.Value ? Convert.ToInt64(dr["IS_DISPATCHED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_INVOICE_QR", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_SEQUENCE", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_ADD_QTY_REQUEST")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON" +
                    ", REQUEST_STATUS, RESPONSE_MSG, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM MDA_ADD_QTY_REQUEST WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_ADD_SYS_ID, long GATE_SYS_ID, long MDA_SYS_ID, long PROD_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_ADD_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_ADD_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.PROD_SYS_ID})";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID
        										FROM MDA_ADD_QTY_REQUEST 
        										WHERE (PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_ADD_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_ADD_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.PROD_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON" +
                                    ", REQUEST_STATUS, RESPONSE_MSG, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                    "FROM MDA_ADD_QTY_REQUEST WHERE (PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_MDA_ADD_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_ADD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_ADD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_REQUIRED_SHIPPER_QTY", OracleDbType.Int64) { Value = (dr["REQUIRED_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_REASON", OracleDbType.Varchar2) { Value = (dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_REQUEST_STATUS", OracleDbType.Varchar2) { Value = (dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "") });
                                    parameters.Add(new OracleParameter("P_RESPONSE_MSG", OracleDbType.Varchar2) { Value = (dr["RESPONSE_MSG"] != DBNull.Value ? Convert.ToString(dr["RESPONSE_MSG"]) : "") });

                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_ADD_QTY_REQUEST", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_ADD_QTY_REQUEST", ex); }

            }



            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "RM_GATE_IN_OUT")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                        ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM RM_GATE_IN_OUT WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long PO_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.PO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID
												FROM RM_GATE_IN_OUT 
												WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PO_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.PO_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
                                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                                    ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM RM_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRANSPORTER_NAME", OracleDbType.NVarchar2) { Value = (dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "") });

                                    parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_RM_GATE_IN_OUT", parameters, false);

                                }
                            }
                        }
                    }


                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID
												FROM RM_GATE_IN_OUT 
												WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long PO_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.PO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
                                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                                ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                "FROM RM_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });

                                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                parameters.Add(new OracleParameter("P_IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_RM_GATE_IN_OUT", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "RM_GATE_IN_OUT", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "RM_WEIGHMENT_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                        ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                        ", NET_WT" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM RM_WEIGHMENT_DETAIL WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
													FROM RM_WEIGHMENT_DETAIL 
													WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
													IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                    ", NET_WT" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                    "FROM RM_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_RM_WEIGHMENT_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
													FROM RM_WEIGHMENT_DETAIL 
													WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                ", NET_WT" +
                                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                "FROM RM_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_RM_WEIGHMENT_DETAIL", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "RM_WEIGHMENT_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PO_HEADER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, PO_SYS_ID, PO_NO, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i:%s') AS PO_DATE, " +
                        "COST_CENTER, PO_DESCCRIPTION, VENDOR_SYS_ID, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_HEADER WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND PO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long PO_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.PO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, PO_SYS_ID
												FROM OTHER_HEADER 
												WHERE (PLANT_ID, STATION_ID, PO_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["PO_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.PO_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, PO_SYS_ID, PO_NO, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i:%s') AS PO_DATE, " +
                                    "COST_CENTER, PO_DESCCRIPTION, VENDOR_SYS_ID, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM OTHER_HEADER WHERE (PLANT_ID, STATION_ID, PO_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PO_NO", OracleDbType.NVarchar2) { Value = (dr["PO_NO"] != DBNull.Value ? Convert.ToInt64(dr["PO_NO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PO_DATE", OracleDbType.Date) { Value = (dr["PO_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["PO_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_COST_CENTER", OracleDbType.NVarchar2) { Value = (dr["COST_CENTER"] != DBNull.Value ? Convert.ToString(dr["COST_CENTER"]) : "") });
                                    parameters.Add(new OracleParameter("P_PO_DESCCRIPTION", OracleDbType.NVarchar2) { Value = (dr["PO_DESCCRIPTION"] != DBNull.Value ? Convert.ToString(dr["PO_DESCCRIPTION"]) : "") });
                                    parameters.Add(new OracleParameter("P_VENDOR_SYS_ID", OracleDbType.Int64) { Value = (dr["VENDOR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_PO_MANUAL", OracleDbType.Int64) { Value = (dr["IS_PO_MANUAL"] != DBNull.Value ? Convert.ToInt64(dr["IS_PO_MANUAL"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_PO_HEADER", parameters, false);

                                }
                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "PO_HEADER", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PO_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID, PO_LINE_NO, " +
                        "LINE_DESC, LINE_QTY, UMO, RECEIVE_QTY, RECEIVE_UOM, SHORT_QTY" +
                        ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_DETAIL WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND PO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long PO_DTL_SYS_ID, long PO_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["PO_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.PO_DTL_SYS_ID}, {tuple.PO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID
												FROM OTHER_DETAIL 
												WHERE (PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["PO_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["PO_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.PO_DTL_SYS_ID}, {tuple.PO_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID, PO_LINE_NO, " +
                                    "LINE_DESC, LINE_QTY, UMO, RECEIVE_QTY, RECEIVE_UOM, SHORT_QTY" +
                                    ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM OTHER_DETAIL WHERE (PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_PO_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_DTL_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PO_LINE_NO", OracleDbType.NVarchar2) { Value = (dr["PO_LINE_NO"] != DBNull.Value ? Convert.ToInt64(dr["PO_LINE_NO"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_LINE_DESC", OracleDbType.NVarchar2) { Value = (dr["LINE_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_DESC"]) : "") });
                                    parameters.Add(new OracleParameter("P_UMO", OracleDbType.NVarchar2) { Value = (dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "") });
                                    parameters.Add(new OracleParameter("P_LINE_QTY", OracleDbType.Int64) { Value = (dr["LINE_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["LINE_QTY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_RECEIVE_QTY", OracleDbType.Int64) { Value = (dr["RECEIVE_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["RECEIVE_QTY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_RECEIVE_UOM", OracleDbType.Int64) { Value = (dr["RECEIVE_UOM"] != DBNull.Value ? Convert.ToString(dr["RECEIVE_UOM"]) : "") });
                                    parameters.Add(new OracleParameter("P_SHORT_QTY", OracleDbType.Int64) { Value = (dr["SHORT_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["SHORT_QTY"]) : 0) });

                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    //parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_DETAIL", parameters, false);

                                }
                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "PO_DETAIL", ex); }

            }



            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SP_GATE_IN_OUT")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM SP_GATE_IN_OUT WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long SO_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.SO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID
												FROM SP_GATE_IN_OUT 
												WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["SO_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.SO_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
                                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM SP_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TRANSPORTER_NAME", OracleDbType.NVarchar2) { Value = (dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "") });

                                    parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SP_GATE_IN_OUT", parameters, false);

                                }
                            }
                        }
                    }


                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID
												FROM SP_GATE_IN_OUT 
												WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long SO_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.SO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                            ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
                            ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                            ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                            ", GATE_SYS_ID_OLD, IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                            "FROM SP_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO) " +
                            "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });

                                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });
                                parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_SP_GATE_IN_OUT", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "SP_GATE_IN_OUT", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SP_WEIGHMENT_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                        ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                        ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM SP_WEIGHMENT_DETAIL WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
													FROM SP_WEIGHMENT_DETAIL 
													WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
													IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                    ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                    "FROM SP_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SP_WEIGHMENT_DETAIL", parameters, false);
                                }
                            }
                        }
                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
													FROM SP_WEIGHMENT_DETAIL 
													WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                "FROM SP_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_SP_WEIGHMENT_DETAIL", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "SP_WEIGHMENT_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SO_HEADER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_SYS_ID, UNIT_CODE, SO_NO, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i:%s') AS SO_DATE, DATE_FORMAT(SO_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS SO_RELEASE_DATE" +
                        ", DATE_FORMAT(SO_VALID_DATE, '%d/%m/%Y %H:%i:%s') AS SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, DATE_FORMAT(TENDER_DATE, '%d/%m/%Y %H:%i:%s') AS TENDER_DATE" +
                        ", VENSOR_SYS_ID, CUST_CD, CUST_NAME, CUST_SITE_CD, SITE_NAME" +
                        ", ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST, TEL_NO, SO_REMARKS, STATUS, STATUS_DATE, STATUS_REMARKS, EMD_AMT, TERMS_PRICE" +
                        ", TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS, TENDER_TYPE, AMEND_NO, DATE_FORMAT(AMEND_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS AMEND_RELEASE_DATE" +
                        ", RIVISION, CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_HEADER WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND SO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long SO_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.SO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, SO_SYS_ID
												FROM OTHER_HEADER 
												WHERE (PLANT_ID, STATION_ID, SO_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["SO_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.SO_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_SYS_ID, UNIT_CODE, SO_NO, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i:%s') AS SO_DATE, DATE_FORMAT(SO_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS SO_RELEASE_DATE" +
                                    ", DATE_FORMAT(SO_VALID_DATE, '%d/%m/%Y %H:%i:%s') AS SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, DATE_FORMAT(TENDER_DATE, '%d/%m/%Y %H:%i:%s') AS TENDER_DATE" +
                                    ", VENSOR_SYS_ID, CUST_CD, CUST_NAME, CUST_SITE_CD, SITE_NAME" +
                                    ", ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST, TEL_NO, SO_REMARKS, STATUS, STATUS_DATE, STATUS_REMARKS, EMD_AMT, TERMS_PRICE" +
                                    ", TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS, TENDER_TYPE, AMEND_NO, DATE_FORMAT(AMEND_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS AMEND_RELEASE_DATE" +
                                    ", RIVISION, CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM OTHER_HEADER WHERE (PLANT_ID, STATION_ID, SO_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SO_NO", OracleDbType.NVarchar2) { Value = (dr["SO_NO"] != DBNull.Value ? Convert.ToInt64(dr["SO_NO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SO_DATE", OracleDbType.Date) { Value = (dr["SO_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_SO_RELEASE_DATE", OracleDbType.Date) { Value = (dr["SO_RELEASE_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_RELEASE_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_SO_VALID_DATE", OracleDbType.Date) { Value = (dr["SO_VALID_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_VALID_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                    parameters.Add(new OracleParameter("P_SEQUENCE_NO", OracleDbType.NVarchar2) { Value = (dr["SEQUENCE_NO"] != DBNull.Value ? Convert.ToString(dr["SEQUENCE_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_TENDER_NO", OracleDbType.NVarchar2) { Value = (dr["TENDER_NO"] != DBNull.Value ? Convert.ToString(dr["TENDER_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_TENDER_DATE", OracleDbType.Date) { Value = (dr["TENDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TENDER_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_VENSOR_SYS_ID", OracleDbType.Int64) { Value = (dr["VENSOR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENSOR_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CUST_CD", OracleDbType.NVarchar2) { Value = (dr["CUST_CD"] != DBNull.Value ? Convert.ToString(dr["CUST_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_CUST_NAME", OracleDbType.NVarchar2) { Value = (dr["CUST_NAME"] != DBNull.Value ? Convert.ToString(dr["CUST_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_CUST_SITE_CD", OracleDbType.NVarchar2) { Value = (dr["CUST_SITE_CD"] != DBNull.Value ? Convert.ToString(dr["CUST_SITE_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_SITE_NAME", OracleDbType.NVarchar2) { Value = (dr["SITE_NAME"] != DBNull.Value ? Convert.ToString(dr["SITE_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_ADD1", OracleDbType.NVarchar2) { Value = (dr["ADD1"] != DBNull.Value ? Convert.ToString(dr["ADD1"]) : "") });
                                    parameters.Add(new OracleParameter("P_ADD2", OracleDbType.NVarchar2) { Value = (dr["ADD2"] != DBNull.Value ? Convert.ToString(dr["ADD2"]) : "") });
                                    parameters.Add(new OracleParameter("P_ADD3", OracleDbType.NVarchar2) { Value = (dr["ADD3"] != DBNull.Value ? Convert.ToString(dr["ADD3"]) : "") });
                                    parameters.Add(new OracleParameter("P_CITY", OracleDbType.NVarchar2) { Value = (dr["CITY"] != DBNull.Value ? Convert.ToString(dr["CITY"]) : "") });
                                    parameters.Add(new OracleParameter("P_PIN", OracleDbType.NVarchar2) { Value = (dr["PIN"] != DBNull.Value ? Convert.ToString(dr["PIN"]) : "") });
                                    parameters.Add(new OracleParameter("P_STATE", OracleDbType.NVarchar2) { Value = (dr["STATE"] != DBNull.Value ? Convert.ToString(dr["STATE"]) : "") });
                                    parameters.Add(new OracleParameter("P_STATE_CD", OracleDbType.NVarchar2) { Value = (dr["STATE_CD"] != DBNull.Value ? Convert.ToString(dr["STATE_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_GSTN_NO", OracleDbType.NVarchar2) { Value = (dr["GSTN_NO"] != DBNull.Value ? Convert.ToString(dr["GSTN_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_PAN_NO", OracleDbType.NVarchar2) { Value = (dr["PAN_NO"] != DBNull.Value ? Convert.ToString(dr["PAN_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_CUST_NON_GST", OracleDbType.NVarchar2) { Value = (dr["CUST_NON_GST"] != DBNull.Value ? Convert.ToString(dr["CUST_NON_GST"]) : "") });
                                    parameters.Add(new OracleParameter("P_TEL_NO", OracleDbType.NVarchar2) { Value = (dr["TEL_NO"] != DBNull.Value ? Convert.ToString(dr["TEL_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_SO_REMARKS", OracleDbType.NVarchar2) { Value = (dr["SO_REMARKS"] != DBNull.Value ? Convert.ToString(dr["SO_REMARKS"]) : "") });
                                    parameters.Add(new OracleParameter("P_STATUS", OracleDbType.NVarchar2) { Value = (dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "") });
                                    parameters.Add(new OracleParameter("P_STATUS_DATE", OracleDbType.Date) { Value = (dr["STATUS_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["STATUS_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_STATUS_REMARKS", OracleDbType.NVarchar2) { Value = (dr["STATUS_REMARKS"] != DBNull.Value ? Convert.ToString(dr["STATUS_REMARKS"]) : "") });
                                    parameters.Add(new OracleParameter("P_EMD_AMT", OracleDbType.Decimal) { Value = (dr["EMD_AMT"] != DBNull.Value ? Convert.ToDecimal(dr["EMD_AMT"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TERMS_PRICE", OracleDbType.Decimal) { Value = (dr["TERMS_PRICE"] != DBNull.Value ? Convert.ToDecimal(dr["TERMS_PRICE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TERMS_PYMT_TERM", OracleDbType.NVarchar2) { Value = (dr["TERMS_PYMT_TERM"] != DBNull.Value ? Convert.ToString(dr["TERMS_PYMT_TERM"]) : "") });
                                    parameters.Add(new OracleParameter("P_TERMS_LIFTING_PERIOD_DAYS", OracleDbType.NVarchar2) { Value = (dr["TERMS_LIFTING_PERIOD_DAYS"] != DBNull.Value ? Convert.ToString(dr["TERMS_LIFTING_PERIOD_DAYS"]) : "") });
                                    parameters.Add(new OracleParameter("P_TENDER_TYPE", OracleDbType.NVarchar2) { Value = (dr["TENDER_TYPE"] != DBNull.Value ? Convert.ToString(dr["TENDER_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_AMEND_NO", OracleDbType.NVarchar2) { Value = (dr["AMEND_NO"] != DBNull.Value ? Convert.ToString(dr["AMEND_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_AMEND_RELEASE_DATE", OracleDbType.Date) { Value = (dr["AMEND_RELEASE_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["AMEND_RELEASE_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_RIVISION", OracleDbType.NVarchar2) { Value = (dr["RIVISION"] != DBNull.Value ? Convert.ToString(dr["RIVISION"]) : "") });

                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_UNIT_CODE", OracleDbType.Int64) { Value = (dr["UNIT_CODE"] != DBNull.Value ? Convert.ToString(dr["UNIT_CODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SO_HEADER", parameters, false);

                                }
                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "SO_HEADER", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SO_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_CD, SCRAP_DESC" +
                        ", UOM, ERP_UOM_CD, SO_QTY, BASIC_AMT, LOADING_QTY, LOADING_UOM, UNIT_CODE, IS_POSTED " +
                        "FROM SO_DETAIL WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND SO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long SO_DTL_SYS_ID, long SO_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["SO_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.SO_DTL_SYS_ID}, {tuple.SO_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID
												FROM OTHER_DETAIL 
												WHERE (PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["SO_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["SO_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.SO_DTL_SYS_ID}, {tuple.SO_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_CD, SCRAP_DESC" +
                            ", UOM, ERP_UOM_CD, SO_QTY, BASIC_AMT, LOADING_QTY, LOADING_UOM, UNIT_CODE, IS_POSTED " +
                                    "FROM SO_DETAIL WHERE (PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_SO_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_DTL_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SO_NO", OracleDbType.NVarchar2) { Value = (dr["SO_NO"] != DBNull.Value ? Convert.ToString(dr["SO_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_SLNO", OracleDbType.NVarchar2) { Value = (dr["SLNO"] != DBNull.Value ? Convert.ToString(dr["SLNO"]) : "") });

                                    parameters.Add(new OracleParameter("P_SCRAP_CD", OracleDbType.NVarchar2) { Value = (dr["SCRAP_CD"] != DBNull.Value ? Convert.ToString(dr["SCRAP_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_SCRAP_DESC", OracleDbType.NVarchar2) { Value = (dr["SCRAP_DESC"] != DBNull.Value ? Convert.ToString(dr["SCRAP_DESC"]) : "") });
                                    parameters.Add(new OracleParameter("P_UOM", OracleDbType.NVarchar2) { Value = (dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "") });
                                    parameters.Add(new OracleParameter("P_ERP_UOM_CD", OracleDbType.NVarchar2) { Value = (dr["ERP_UOM_CD"] != DBNull.Value ? Convert.ToString(dr["ERP_UOM_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_SO_QTY", OracleDbType.Decimal) { Value = (dr["SO_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["SO_QTY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_BASIC_AMT", OracleDbType.Decimal) { Value = (dr["BASIC_AMT"] != DBNull.Value ? Convert.ToDecimal(dr["BASIC_AMT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_LOADING_QTY", OracleDbType.Decimal) { Value = (dr["LOADING_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["LOADING_QTY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_LOADING_UOM", OracleDbType.NVarchar2) { Value = (dr["LOADING_UOM"] != DBNull.Value ? Convert.ToString(dr["LOADING_UOM"]) : "") });

                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_UNIT_CODE", OracleDbType.Int64) { Value = (dr["UNIT_CODE"] != DBNull.Value ? Convert.ToString(dr["UNIT_CODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SO_DETAIL", parameters, false);

                                }
                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "SO_DETAIL", ex); }

            }



            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_GATE_IN_OUT")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID, TRANSACTION_TYPE" +
                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, OTHER_SYS_ID, TRUCK_NO" +
                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                        ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_GATE_IN_OUT WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long OTHER_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.OTHER_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID
												FROM OTHER_GATE_IN_OUT 
												WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["OTHER_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.OTHER_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, OTHER_SYS_ID, TRUCK_NO" +
                                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                                    ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM OTHER_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRANSACTION_TYPE", OracleDbType.NVarchar2) { Value = (dr["TRANSACTION_TYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTION_TYPE"]) : "") });

                                    parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_GATE_IN_OUT", parameters, false);

                                }
                            }
                        }
                    }


                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID, TRUCK_NO
												FROM OTHER_GATE_IN_OUT 
												WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long OTHER_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.OTHER_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, OTHER_SYS_ID, TRUCK_NO" +
                                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
                                ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                "FROM OTHER_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID, TRUCK_NO) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });

                                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                parameters.Add(new OracleParameter("P_IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_OTHER_GATE_IN_OUT", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "OTHER_GATE_IN_OUT", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_WEIGHMENT_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                        ", IFNULL(WEIGHIN_WT, 0)WEIGHIN_WT, DATE_FORMAT(WEIGHIN_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHIN_WT_DT, WEIGHIN_WT_NOTE" +
                        ", WEIGHOUT_WT, DATE_FORMAT(WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHOUT_WT_DT, WEIGHOUT_WT_NOTE" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_WEIGHMENT_DETAIL WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
													FROM OTHER_WEIGHMENT_DETAIL 
													WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
													IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                            ", WEIGHIN_WT, DATE_FORMAT(WEIGHIN_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHIN_WT_DT, WEIGHIN_WT_NOTE" +
                            ", WEIGHOUT_WT, DATE_FORMAT(WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHOUT_WT_DT, WEIGHOUT_WT_NOTE" +
                            ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                            "FROM OTHER_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                            "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_WEIGHIN_WT", OracleDbType.Decimal) { Value = (dr["WEIGHIN_WT"] != DBNull.Value ? Convert.ToDecimal(dr["WEIGHIN_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_WEIGHIN_WT_DT", OracleDbType.Date) { Value = (dr["WEIGHIN_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGHIN_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_WEIGHIN_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["WEIGHIN_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["WEIGHIN_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_WEIGHOUT_WT", OracleDbType.Decimal) { Value = (dr["WEIGHOUT_WT"] != DBNull.Value ? Convert.ToDecimal(dr["WEIGHOUT_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_WEIGHOUT_WT_DT", OracleDbType.Date) { Value = (dr["WEIGHOUT_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGHOUT_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_WEIGHOUT_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["WEIGHOUT_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["WEIGHOUT_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_WEIGHMENT_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
													FROM OTHER_WEIGHMENT_DETAIL 
													WHERE PLANT_ID = {plant_id} AND NVL(WEIGHOUT_WT, 0) = 0");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                ", WEIGHIN_WT, DATE_FORMAT(WEIGHIN_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHIN_WT_DT, WEIGHIN_WT_MANUALLY, WEIGHIN_WT_NOTE" +
                                ", WEIGHOUT_WT, DATE_FORMAT(WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHOUT_WT_DT, WEIGHOUT_WT_MANUALLY, WEIGHOUT_WT_NOTE" +
                                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                "FROM OTHER_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(WEIGHIN_WT, 0) > 0");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });

                                parameters.Add(new OracleParameter("P_WEIGHOUT_WT", OracleDbType.Decimal) { Value = (dr["WEIGHOUT_WT"] != DBNull.Value ? Convert.ToDecimal(dr["WEIGHOUT_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_WEIGHOUT_WT_DT", OracleDbType.Date) { Value = (dr["WEIGHOUT_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGHOUT_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_WEIGHOUT_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["WEIGHOUT_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["WEIGHOUT_WT_NOTE"]) : "") });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_OTHER_WEIGHMENT_DETAIL", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "OTHER_WEIGHMENT_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_HEADER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, OTHER_SYS_ID, ORDER_NO, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i:%s') AS ORDER_DATE, " +
                        "COST_CENTER, DESCCRIPTION, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_HEADER WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND OTHER_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long OTHER_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.OTHER_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, OTHER_SYS_ID
												FROM OTHER_HEADER 
												WHERE (PLANT_ID, STATION_ID, OTHER_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["OTHER_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.OTHER_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, OTHER_SYS_ID, ORDER_NO, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i:%s') AS ORDER_DATE, " +
                                    "COST_CENTER, DESCCRIPTION, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM OTHER_HEADER WHERE (PLANT_ID, STATION_ID, OTHER_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_ORDER_NO", OracleDbType.NVarchar2) { Value = (dr["ORDER_NO"] != DBNull.Value ? Convert.ToInt64(dr["ORDER_NO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_ORDER_DATE", OracleDbType.Date) { Value = (dr["ORDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ORDER_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_COST_CENTER", OracleDbType.NVarchar2) { Value = (dr["COST_CENTER"] != DBNull.Value ? Convert.ToString(dr["COST_CENTER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DESCCRIPTION", OracleDbType.NVarchar2) { Value = (dr["DESCCRIPTION"] != DBNull.Value ? Convert.ToString(dr["DESCCRIPTION"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_IS_PO_MANUAL", OracleDbType.Int64) { Value = (dr["IS_PO_MANUAL"] != DBNull.Value ? Convert.ToInt64(dr["IS_PO_MANUAL"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_HEADER", parameters, false);

                                }
                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "OTHER_HEADER", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID, SR_NO, " +
                        "MATERIAL, MATERIAL_DESC, QTY, UMO" +
                        ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM OTHER_DETAIL WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND OTHER_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long OTHER_DTL_SYS_ID, long OTHER_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["OTHER_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.OTHER_DTL_SYS_ID}, {tuple.OTHER_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID
												FROM OTHER_DETAIL 
												WHERE (PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID) 
												IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["OTHER_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["OTHER_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.OTHER_DTL_SYS_ID}, {tuple.OTHER_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID, SR_NO, " +
                                    "MATERIAL, MATERIAL_DESC, QTY, UMO" +
                                    ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM OTHER_DETAIL WHERE (PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_OTHER_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_DTL_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SR_NO", OracleDbType.NVarchar2) { Value = (dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_MATERIAL", OracleDbType.NVarchar2) { Value = (dr["MATERIAL"] != DBNull.Value ? Convert.ToString(dr["MATERIAL"]) : "") });
                                    parameters.Add(new OracleParameter("P_MATERIAL_DESC", OracleDbType.NVarchar2) { Value = (dr["MATERIAL_DESC"] != DBNull.Value ? Convert.ToString(dr["MATERIAL_DESC"]) : "") });
                                    parameters.Add(new OracleParameter("P_UMO", OracleDbType.NVarchar2) { Value = (dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "") });
                                    parameters.Add(new OracleParameter("P_QTY", OracleDbType.Int64) { Value = (dr["QTY"] != DBNull.Value ? Convert.ToDecimal(dr["QTY"]) : 0) });

                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    //parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_DETAIL", parameters, false);

                                }
                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "OTHER_DETAIL", ex); }
            }


            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_LOADING")
            {
                try
                {

                    //var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
                    //		", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
                    //		", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
                    //		"FROM MDA_LOADING WHERE IFNULL(SHIPPER_QR_CODE,'') != '' AND CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
                    //		$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                    //		$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
                    //		$"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) NOT IN ({string.Join(", ", _checkValues)})" : "")} " +
                    //		$"ORDER BY MDA_LOD_SYS_ID DESC ");

                    dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
                    $"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID");

                    List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
                        _idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();

                    var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
                            "FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
                            "GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID ");

                    List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
                        _idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();


                    var notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

                    List<string> _checkValues = new List<string>();

                    foreach (var tuple in notInOracle)
                    {
                        string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
                        _checkValues.Add(checkValue);
                    }

                    dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
                        $"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
                        "AND (PLANT_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
                        $"IN ({string.Join(", ", _checkValues)})");

                    _idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

                    dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
                            "FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
                            "AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
                            $"IN ({string.Join(", ", _checkValues)}) ");

                    _idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

                    notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

                    _checkValues = new List<string>();

                    foreach (var tuple in notInOracle)
                    {
                        string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
                        _checkValues.Add(checkValue);
                    }

                    dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
                            ", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
                            ", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
                            "FROM MDA_LOADING WHERE IFNULL(SHIPPER_QR_CODE,'') != '' AND CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
                            $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                            $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
                            $"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) IN ({string.Join(", ", _checkValues)})" : "")} " +
                            $"ORDER BY MDA_LOD_SYS_ID DESC ");

                    if (dtSql_All != null && dtSql_All.Rows.Count > 0)
                    {
                        int chunkSize = 5000;

                        int numberOfTasks = (int)Math.Ceiling((double)dtSql_All.Rows.Count / chunkSize);

                        Task[] tasks = new Task[numberOfTasks];

                        for (int i = 0; i < numberOfTasks; i++)
                        {
                            int start_Index = i * chunkSize;
                            tasks[i] = Task.Run(() =>
                            {
                                try
                                {
                                    dtSql = dtSql_All.AsEnumerable()
                                    .Skip(start_Index)
                                    .Take(chunkSize)
                                    .CopyToDataTable();

                                    List<string> checkValues = new List<string>();

                                    List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID)>
                                        idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
                                                        , (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

                                    foreach (var tuple in idsToFilter)
                                    {
                                        string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
                                        checkValues.Add(checkValue);
                                    }

                                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID 
        														FROM MDA_LOADING 
        														WHERE (PLANT_ID, MDA_LOD_SYS_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) 
        														IN ({string.Join(", ", checkValues)})");

                                    checkValues = new List<string>();

                                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                                        idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
                                                        , (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

                                    if (idsToFilter != null && idsToFilter.Count() > 0)
                                    {
                                        foreach (var tuple in idsToFilter)
                                        {
                                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
                                            checkValues.Add(checkValue);
                                        }

                                        dtSql = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
                                                ", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                                ", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
                                                $"FROM MDA_LOADING WHERE (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) IN({string.Join(", ", checkValues)})");

                                        if (dtSql != null && dtSql.Rows.Count > 0)
                                        {
                                            int startIndex = 0;

                                            while (startIndex < dtSql.Rows.Count)
                                            {
                                                DataTable nextBatch = dtSql.AsEnumerable()
                                                    .Skip(startIndex)
                                                    .Take(1000)
                                                    .CopyToDataTable();

                                                var sqlQuery = "INSERT INTO PRD.MDA_LOADING (MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
                                                    ", SHIPPER_QR_CODE, IS_MANUAL_SCAN, ENTRY_TIME, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID, IS_POSTED) ";

                                                var sqlQuery_Select = "";

                                                foreach (DataRow dr in nextBatch.Rows)
                                                {
                                                    try
                                                    {
                                                        if ((dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0) > 0)
                                                        {
                                                            sqlQuery_Select += $"SELECT {(dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0)} MDA_LOD_SYS_ID" +
                                                                $", {(dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0)} GATE_SYS_ID" +
                                                                $", {(dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0)} MDA_SYS_ID" +
                                                                $", {(dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)} PROD_SYS_ID" +
                                                                $", {(dr["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER"]) : 0)} REQUIRED_SHIPPER" +
                                                                $", {(dr["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_SHIPPER"]) : 0)} LOADED_SHIPPER" +
                                                                $", '{(dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "")}' SHIPPER_QR_CODE" +
                                                                $", {(dr["IS_MANUAL_SCAN"] != DBNull.Value ? Convert.ToInt64(dr["IS_MANUAL_SCAN"]) : 0)} IS_MANUAL_SCAN" +
                                                                $", TO_DATE('{(dr["ENTRY_TIME"] != DBNull.Value ? Convert.ToString(dr["ENTRY_TIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS')  ENTRY_TIME" +
                                                                $", {(dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0)} CREATED_BY_ID" +
                                                                $", TO_DATE('{(dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS') CREATED_DATETIME" +
                                                                $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
                                                                $", {(dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0)} IS_POSTED " +
                                                                $" FROM DUAL UNION ";
                                                        }

                                                    }
                                                    catch (Exception) { continue; }
                                                }

                                                if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                    sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

                                                DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                                startIndex += 1000;
                                            }


                                            //foreach (DataRow dr in dtSql.Rows)
                                            //{
                                            //	List<OracleParameter> parameters = new List<OracleParameter>();

                                            //	parameters.Add(new OracleParameter("P_MDA_LOD_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_REQUIRED_SHIPPER", OracleDbType.Int64) { Value = (dr["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_LOADED_SHIPPER", OracleDbType.Int64) { Value = (dr["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_SHIPPER"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_SHIPPER_QR_CODE", OracleDbType.NVarchar2) { Value = (dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "") });
                                            //	parameters.Add(new OracleParameter("P_IS_MANUAL_SCAN", OracleDbType.Int64) { Value = (dr["IS_MANUAL_SCAN"] != DBNull.Value ? Convert.ToInt64(dr["IS_MANUAL_SCAN"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                            //	parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
                                            //	parameters.Add(new OracleParameter("P_ENTRY_TIME", OracleDbType.Date) { Value = (dr["ENTRY_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ENTRY_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                            //	var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_LOADING", parameters, false);

                                            //}
                                        }
                                    }

                                }
                                catch (Exception ex) { }


                            });
                        }

                        Task.WaitAll(tasks);

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_LOADING", ex); }
            }


            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PRODUCT_MASTER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, PLANT_CD, PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC" +
                            ", PRD_WT_FILL, SHIP_WT_FILL, PROD_PER_SHIPPER, TOLERANCE_PER, PAL_WT_FILL, SHIP_PER_PALLET, NOTE, ISACTIVE" +
                            ", PRD_DESC_H, PRINT_ORDER, PRD_DESC_SHORT, EXTRA1, EXTRA2, EXTRA3, PRD_TYPE, SUB_PLANT_CD, PRD_CATEGORY, ACTIVE" +
                            ", HSN_CODE, PRD_CD_GROUP_APP, UOM, CONV_FACTOR, UOM_EVIKAS, GTIN, BPEX, VALIDITY_MONTH" +
                            ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                            "FROM PRODUCT_MASTER WHERE 1 = 1 ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long PROD_SYS_ID, string SKU_CODE, string PRD_CD)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
                                            , Convert.ToString($"{row["SKU_CODE"]}"), Convert.ToString($"{row["PRD_CD"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.PROD_SYS_ID}, '{tuple.SKU_CODE}', '{tuple.PRD_CD}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, PROD_SYS_ID, SKU_CODE, PRD_CD
        										FROM PRODUCT_MASTER 
        										WHERE (PLANT_ID, PROD_SYS_ID, SKU_CODE, PRD_CD) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable()
                                            .Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
                                            , Convert.ToString($"{row["SKU_CODE"]}"), Convert.ToString($"{row["PRD_CD"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.PROD_SYS_ID}, '{tuple.SKU_CODE}', '{tuple.PRD_CD}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, PLANT_CD, PROD_SYS_ID, SKU_CODE, SKU_NAME, PRD_CD, PRD_DESC" +
                                    ", PRD_WT_FILL, SHIP_WT_FILL, PROD_PER_SHIPPER, TOLERANCE_PER, PAL_WT_FILL, SHIP_PER_PALLET, NOTE, ISACTIVE" +
                                    ", PRD_DESC_H, PRINT_ORDER, PRD_DESC_SHORT, EXTRA1, EXTRA2, EXTRA3, PRD_TYPE, SUB_PLANT_CD, PRD_CATEGORY, ACTIVE" +
                                    ", HSN_CODE, PRD_CD_GROUP_APP, UOM, CONV_FACTOR, UOM_EVIKAS, GTIN, BPEX, VALIDITY_MONTH" +
                                    ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 1 IS_POSTED " +
                                    "FROM PRODUCT_MASTER WHERE (PLANT_ID, PROD_SYS_ID, SKU_CODE, PRD_CD) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_SKU_CODE", OracleDbType.NVarchar2) { Value = (dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_SKU_NAME", OracleDbType.NVarchar2) { Value = (dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_PRD_CD", OracleDbType.NVarchar2) { Value = (dr["PRD_CD"] != DBNull.Value ? Convert.ToString(dr["PRD_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_PRD_DESC", OracleDbType.NVarchar2) { Value = (dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "") });
                                    parameters.Add(new OracleParameter("P_PRD_DESC_H", OracleDbType.NVarchar2) { Value = (dr["PRD_DESC_H"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC_H"]) : "") });
                                    parameters.Add(new OracleParameter("P_PRD_DESC_SHORT", OracleDbType.NVarchar2) { Value = (dr["PRD_DESC_SHORT"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC_SHORT"]) : "") });

                                    parameters.Add(new OracleParameter("P_PRD_WT_FILL", OracleDbType.Int64) { Value = (dr["PRD_WT_FILL"] != DBNull.Value ? Convert.ToInt64(dr["PRD_WT_FILL"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SHIP_WT_FILL", OracleDbType.Int64) { Value = (dr["SHIP_WT_FILL"] != DBNull.Value ? Convert.ToInt64(dr["SHIP_WT_FILL"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PROD_PER_SHIPPER", OracleDbType.Int64) { Value = (dr["PROD_PER_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["PROD_PER_SHIPPER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TOLERANCE_PER", OracleDbType.Int64) { Value = (dr["TOLERANCE_PER"] != DBNull.Value ? Convert.ToInt64(dr["TOLERANCE_PER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PAL_WT_FILL", OracleDbType.Int64) { Value = (dr["PAL_WT_FILL"] != DBNull.Value ? Convert.ToInt64(dr["PAL_WT_FILL"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SHIP_PER_PALLET", OracleDbType.Int64) { Value = (dr["SHIP_PER_PALLET"] != DBNull.Value ? Convert.ToInt64(dr["SHIP_PER_PALLET"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_NOTE", OracleDbType.NVarchar2) { Value = (dr["NOTE"] != DBNull.Value ? Convert.ToString(dr["NOTE"]) : "") });
                                    parameters.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Int64) { Value = (dr["ISACTIVE"] != DBNull.Value ? Convert.ToInt64(dr["ISACTIVE"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_PRINT_ORDER", OracleDbType.Int64) { Value = (dr["PRINT_ORDER"] != DBNull.Value ? Convert.ToInt64(dr["PRINT_ORDER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_EXTRA1", OracleDbType.NVarchar2) { Value = (dr["EXTRA1"] != DBNull.Value ? Convert.ToString(dr["EXTRA1"]) : "") });
                                    parameters.Add(new OracleParameter("P_EXTRA2", OracleDbType.NVarchar2) { Value = (dr["EXTRA2"] != DBNull.Value ? Convert.ToString(dr["EXTRA2"]) : "") });
                                    parameters.Add(new OracleParameter("P_EXTRA3", OracleDbType.NVarchar2) { Value = (dr["EXTRA3"] != DBNull.Value ? Convert.ToString(dr["EXTRA3"]) : "") });
                                    parameters.Add(new OracleParameter("P_PRD_TYPE", OracleDbType.NVarchar2) { Value = (dr["PRD_TYPE"] != DBNull.Value ? Convert.ToString(dr["PRD_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_SUB_PLANT_CD", OracleDbType.NVarchar2) { Value = (dr["SUB_PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["SUB_PLANT_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_PRD_CATEGORY", OracleDbType.NVarchar2) { Value = (dr["PRD_CATEGORY"] != DBNull.Value ? Convert.ToString(dr["PRD_CATEGORY"]) : "") });
                                    parameters.Add(new OracleParameter("P_ACTIVE", OracleDbType.NVarchar2) { Value = (dr["ACTIVE"] != DBNull.Value ? Convert.ToString(dr["ACTIVE"]) : "") });
                                    parameters.Add(new OracleParameter("P_HSN_CODE", OracleDbType.Int64) { Value = (dr["HSN_CODE"] != DBNull.Value ? Convert.ToInt64(dr["HSN_CODE"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_PRD_CD_GROUP_APP", OracleDbType.NVarchar2) { Value = (dr["PRD_CD_GROUP_APP"] != DBNull.Value ? Convert.ToString(dr["PRD_CD_GROUP_APP"]) : "") });
                                    parameters.Add(new OracleParameter("P_UOM", OracleDbType.NVarchar2) { Value = (dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : "") });
                                    parameters.Add(new OracleParameter("P_CONV_FACTOR", OracleDbType.Int64) { Value = (dr["CONV_FACTOR"] != DBNull.Value ? Convert.ToInt64(dr["CONV_FACTOR"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_UOM_EVIKAS", OracleDbType.NVarchar2) { Value = (dr["UOM_EVIKAS"] != DBNull.Value ? Convert.ToString(dr["UOM_EVIKAS"]) : "") });
                                    parameters.Add(new OracleParameter("P_GTIN", OracleDbType.NVarchar2) { Value = (dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "") });
                                    parameters.Add(new OracleParameter("P_BPEX", OracleDbType.NVarchar2) { Value = (dr["BPEX"] != DBNull.Value ? Convert.ToString(dr["BPEX"]) : "") });
                                    parameters.Add(new OracleParameter("P_VALIDITY_MONTH", OracleDbType.Int64) { Value = (dr["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt64(dr["VALIDITY_MONTH"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_PLANT_CD", OracleDbType.NVarchar2) { Value = (dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_PRODUCT_MASTER", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "PRODUCT_MASTER", ex); }
            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PLANT_MASTER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANTID, PLANTCODE, PLANTADDRESS, PLANT_NAME " +
                            "FROM PLANT_MASTER WHERE 1 = 1 ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANTID, string PLANTCODE, string PLANTADDRESS, string PLANT_NAME)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANTID"]}"), Convert.ToString($"{row["PLANTCODE"]}")
                                            , Convert.ToString($"{row["PLANTADDRESS"]}"), Convert.ToString($"{row["PLANT_NAME"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANTID}, '{tuple.PLANTCODE}', '{tuple.PLANTADDRESS}', '{tuple.PLANT_NAME}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANTID, PLANTCODE, PLANTADDRESS, PLANT_NAME
        										FROM PLANT_MASTER 
        										WHERE (PLANTID, PLANTCODE, PLANTADDRESS, PLANT_NAME) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable()
                                            .Any(row => x == (Convert.ToInt64($"{row["PLANTID"]}"), Convert.ToString($"{row["PLANTCODE"]}")
                                            , Convert.ToString($"{row["PLANTADDRESS"]}"), Convert.ToString($"{row["PLANT_NAME"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANTID}, '{tuple.PLANTCODE}', '{tuple.PLANTADDRESS}', '{tuple.PLANT_NAME}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANTID, PLANTCODE, PLANTADDRESS, PLANT_NAME " +
                                    "FROM PLANT_MASTER WHERE (PLANTID, PLANTCODE, PLANTADDRESS, PLANT_NAME) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_PLANTID", OracleDbType.Int64) { Value = (dr["PLANTID"] != DBNull.Value ? Convert.ToInt64(dr["PLANTID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_PLANTCODE", OracleDbType.NVarchar2) { Value = (dr["PLANTCODE"] != DBNull.Value ? Convert.ToString(dr["PLANTCODE"]) : "") });
                                    parameters.Add(new OracleParameter("P_PLANTADDRESS", OracleDbType.NVarchar2) { Value = (dr["PLANTADDRESS"] != DBNull.Value ? Convert.ToString(dr["PLANTADDRESS"]) : "") });
                                    parameters.Add(new OracleParameter("P_PLANT_NAME", OracleDbType.NVarchar2) { Value = (dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "") });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_PLANT_MASTER", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "PLANT_MASTER", ex); }
            }

        }

        public static async Task SyncData_LocalToCloud_Export(string tableName, List<long> ids_GateInOut, List<long> ids_MDA)
        {
            DataTable dtSql = null;
            DataTable dtOracle = null;
            DataTable filteredDataTable = null;
            DateTime? nullDateTime = null;

            ids_GateInOut = ids_GateInOut == null ? new List<long>() { } : ids_GateInOut;
            ids_MDA = ids_MDA == null ? new List<long>() { } : ids_MDA;

            var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

            plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "EXP_FG_GATE_IN_OUT")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT" +
                            ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
                            ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                            ", EXPECTED_QTY, TRANS_SYS_ID, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                            ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                            "FROM EXP_FG_GATE_IN_OUT WHERE 1 = 1 " +
                            $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        										FROM EXP_FG_GATE_IN_OUT 
        										WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) 
        										IN ({string.Join(", ", checkValues)}) ");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["TRUCK_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
                                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                    ", EXPECTED_QTY, TRANS_SYS_ID, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                                    ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                    "FROM EXP_FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
                                    "IN (" + string.Join(", ", checkValues) + ") ");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
                                    parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_EXPECTED_QTY", OracleDbType.Int64) { Value = (dr["EXPECTED_QTY"] != DBNull.Value ? Convert.ToInt64(dr["EXPECTED_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_EXP_FG_GATE_IN_OUT", parameters, false);

                                }
                            }
                        }

                    }


                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        										FROM EXP_FG_GATE_IN_OUT 
        										WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL
        										{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
                                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
                                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                                ", EXPECTED_QTY, TRANS_SYS_ID, RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                                ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
                                "FROM EXP_FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1) ");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

                                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
                                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

                                parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_EXP_FG_GATE_IN_OUT", parameters, false);

                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "EXP_FG_GATE_IN_OUT", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "EXP_FG_WEIGHMENT_DETAIL")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                        ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                        ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM EXP_FG_WEIGHMENT_DETAIL WHERE 1 = 1 " +
                        $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        											FROM EXP_FG_WEIGHMENT_DETAIL 
        											WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        											IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                    ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                    "FROM EXP_FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

                                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                    parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_EXP_FG_WEIGHMENT_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        											FROM EXP_FG_WEIGHMENT_DETAIL 
        											WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0 
        											{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
                                            , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
                                ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
                                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
                                ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
                                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                                "FROM EXP_FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
                                "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
                                parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

                                parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
                                parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

                                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_EXP_FG_WEIGHMENT_DETAIL", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "EXP_FG_WEIGHMENT_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_HEADER")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
                        ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
                        "FROM MDA_HEADER WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        										FROM MDA_HEADER 
        										WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
                                        ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
                                        $"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DI_NO", OracleDbType.NVarchar2) { Value = (dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_PLANT_CD", OracleDbType.NVarchar2) { Value = (dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_WH_CD", OracleDbType.NVarchar2) { Value = (dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "") });
                                    parameters.Add(new OracleParameter("P_PARTY_NAME", OracleDbType.NVarchar2) { Value = (dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "") });
                                    parameters.Add(new OracleParameter("P_DRIVER", OracleDbType.NVarchar2) { Value = (dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "") });
                                    parameters.Add(new OracleParameter("P_VEHICLE_NO", OracleDbType.NVarchar2) { Value = (dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_MOBILE_NO", OracleDbType.NVarchar2) { Value = (dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_DIST", OracleDbType.Int64) { Value = (dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_ECHIT_NO", OracleDbType.NVarchar2) { Value = (dr["ECHIT_NO"] != DBNull.Value ? Convert.ToString(dr["ECHIT_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_GST_NO", OracleDbType.NVarchar2) { Value = (dr["GST_NO"] != DBNull.Value ? Convert.ToString(dr["GST_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_DESP_PLACE", OracleDbType.NVarchar2) { Value = (dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "") });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_HEADER", parameters, false);

                                }
                            }
                        }

                    }

                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        										FROM MDA_HEADER 
        										WHERE PLANT_ID = {plant_id} AND OUT_TIME IS NULL 
        										{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
                            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
                            checkValues.Add(checkValue);
                        }

                        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
                                    ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
                                    $"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)}) AND OUT_TIME IS NOT NULL");

                        if (dtSql != null && dtSql.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dtSql.Rows)
                            {
                                List<OracleParameter> parameters = new List<OracleParameter>();

                                parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                parameters.Add(new OracleParameter("P_OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

                                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_MDA_HEADER", parameters, false);

                            }
                        }
                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_HEADER", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_DETAIL")
            {
                try
                {

                    dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, MDA_DT" +
                        ", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                        "FROM MDA_DETAIL WHERE 1 = 1 " +
                        $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long PLANT_ID, long MDA_DTL_SYS_ID, long MDA_SYS_ID, string MDA_NO, long PROD_SYS_ID)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
                                            , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
                            checkValues.Add(checkValue);
                        }


                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID
        										FROM MDA_DETAIL 
        										WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}")
                                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
                                checkValues.Add(checkValue);
                            }


                            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT" +
                            ", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
                            "FROM MDA_DETAIL WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID)  " +
                                    "IN (" + string.Join(", ", checkValues) + ")");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                foreach (DataRow dr in dtSql.Rows)
                                {
                                    List<OracleParameter> parameters = new List<OracleParameter>();

                                    parameters.Add(new OracleParameter("P_MDA_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_DTL_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
                                    parameters.Add(new OracleParameter("P_PROD_SNO", OracleDbType.Int64) { Value = (dr["PROD_SNO"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SNO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_SHIPMENT_NO", OracleDbType.Int64) { Value = (dr["SHIPMENT_NO"] != DBNull.Value ? Convert.ToInt64(dr["SHIPMENT_NO"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
                                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

                                    parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
                                    parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

                                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_DETAIL", parameters, false);

                                }
                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "MDA_DETAIL", ex); }

            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "EXP_MDA_PALLATE_LOADING")
            {
                try
                {
                    dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
                    $"FROM EXP_MDA_PALLATE_LOADING WHERE PLANT_ID = " + plant_id + " GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID");

                    List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
                        _idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();

                    var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
                            "FROM EXP_MDA_PALLATE_LOADING WHERE PLANT_ID = " + plant_id + " " +
                            "GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID ");

                    List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
                        _idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();


                    var notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

                    List<string> _checkValues = new List<string>();

                    foreach (var tuple in notInOracle)
                    {
                        string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
                        _checkValues.Add(checkValue);
                    }

                    dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
                        $"FROM EXP_MDA_PALLATE_LOADING WHERE PLANT_ID = " + plant_id + " " +
                        "AND (PLANT_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
                        $"IN ({string.Join(", ", _checkValues)})");

                    _idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

                    dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
                            "FROM EXP_MDA_PALLATE_LOADING WHERE PLANT_ID = " + plant_id + " " +
                            "AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
                            $"IN ({string.Join(", ", _checkValues)}) ");

                    _idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
                                        , Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
                                        , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

                    notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

                    _checkValues = new List<string>();

                    foreach (var tuple in notInOracle)
                    {
                        string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
                        _checkValues.Add(checkValue);
                    }

                    dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID" +
                            ", PALLATE_NO, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME " +
                            "FROM EXP_MDA_PALLATE_LOADING WHERE IFNULL(PALLATE_NO,'') != '' " +
                            $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
                            $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
                            $"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) IN ({string.Join(", ", _checkValues)})" : "")} " +
                            $"ORDER BY MDA_LOD_SYS_ID DESC ");

                    if (dtSql_All != null && dtSql_All.Rows.Count > 0)
                    {
                        int chunkSize = 5000;

                        int numberOfTasks = (int)Math.Ceiling((double)dtSql_All.Rows.Count / chunkSize);

                        Task[] tasks = new Task[numberOfTasks];

                        for (int i = 0; i < numberOfTasks; i++)
                        {
                            int start_Index = i * chunkSize;
                            tasks[i] = Task.Run(() =>
                            {
                                try
                                {
                                    dtSql = dtSql_All.AsEnumerable()
                                    .Skip(start_Index)
                                    .Take(chunkSize)
                                    .CopyToDataTable();

                                    List<string> checkValues = new List<string>();

                                    List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID)>
                                        idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
                                                        , (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

                                    foreach (var tuple in idsToFilter)
                                    {
                                        string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
                                        checkValues.Add(checkValue);
                                    }

                                    dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID 
        														FROM EXP_MDA_PALLATE_LOADING 
        														WHERE (PLANT_ID, MDA_LOD_SYS_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) 
        														IN ({string.Join(", ", checkValues)})");

                                    checkValues = new List<string>();

                                    if (dtOracle != null && dtOracle.Rows.Count > 0)
                                        idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
                                                        , (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

                                    if (idsToFilter != null && idsToFilter.Count() > 0)
                                    {
                                        foreach (var tuple in idsToFilter)
                                        {
                                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
                                            checkValues.Add(checkValue);
                                        }

                                        dtSql = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID" +
                                                ", PALLATE_NO, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME " +
                                                $"FROM EXP_MDA_PALLATE_LOADING WHERE (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) IN({string.Join(", ", checkValues)})");

                                        if (dtSql != null && dtSql.Rows.Count > 0)
                                        {
                                            int startIndex = 0;

                                            while (startIndex < dtSql.Rows.Count)
                                            {
                                                DataTable nextBatch = dtSql.AsEnumerable()
                                                    .Skip(startIndex)
                                                    .Take(1000)
                                                    .CopyToDataTable();

                                                var sqlQuery = "INSERT INTO EXP_MDA_PALLATE_LOADING (MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID" +
                                                    ", PALLATE_NO, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID) ";

                                                var sqlQuery_Select = "";

                                                foreach (DataRow dr in nextBatch.Rows)
                                                {
                                                    try
                                                    {
                                                        if ((dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0) > 0)
                                                        {
                                                            sqlQuery_Select += $"SELECT {(dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0)} MDA_LOD_SYS_ID" +
                                                                $", {(dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0)} GATE_SYS_ID" +
                                                                $", {(dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0)} MDA_SYS_ID" +
                                                                $", {(dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)} PROD_SYS_ID" +
                                                                $", '{(dr["PALLATE_NO"] != DBNull.Value ? Convert.ToString(dr["PALLATE_NO"]) : "")}' PALLATE_NO" +
                                                                $", {(dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0)} CREATED_BY_ID" +
                                                                $", TO_DATE('{(dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS') CREATED_DATETIME" +
                                                                $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
                                                                $" FROM DUAL UNION ";
                                                        }

                                                    }
                                                    catch (Exception) { continue; }
                                                }

                                                if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                    sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

                                                DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                                startIndex += 1000;
                                            }

                                        }
                                    }

                                }
                                catch (Exception ex) { }


                            });
                        }

                        Task.WaitAll(tasks);

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "EXP_MDA_PALLATE_LOADING", ex); }
            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PALLATE_MASTER")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT ID, PLANT_ID, PLANT_ID, DI_NO, PALLATE_NO, PALLATE_TYPE, SHIPPER_QTY, DISPATCH_MODE" +
                        ", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME " +
                            "FROM PALLATE_MASTER WHERE 1 = 1 ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long ID, long PLANT_ID, string DI_NO, string PALLATE_NO)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["ID"]}"), Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToString($"{row["DI_NO"]}")
                                            , Convert.ToString($"{row["PALLATE_NO"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.ID}, {tuple.PLANT_ID}, '{tuple.DI_NO}', '{tuple.PALLATE_NO}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT ID, PLANT_ID, DI_NO, PALLATE_NO
        										FROM PALLATE_MASTER 
        										WHERE (ID, PLANT_ID, DI_NO, PALLATE_NO) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable()
                                            .Any(row => x == (Convert.ToInt64($"{row["ID"]}"), Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToString($"{row["DI_NO"]}")
                                            , Convert.ToString($"{row["PALLATE_NO"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.ID}, {tuple.PLANT_ID}, '{tuple.DI_NO}', '{tuple.PALLATE_NO}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT DISTINCT ID, PLANT_ID, DI_NO, PALLATE_NO, PALLATE_TYPE, SHIPPER_QTY, DISPATCH_MODE" +
                                    ", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME " +
                                    $"FROM PALLATE_MASTER WHERE (ID, PLANT_ID, DI_NO, PALLATE_NO) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                int startIndex = 0;

                                while (startIndex < dtSql.Rows.Count)
                                {
                                    DataTable nextBatch = dtSql.AsEnumerable()
                                        .Skip(startIndex)
                                        .Take(1000)
                                        .CopyToDataTable();

                                    var sqlQuery = "INSERT INTO PALLATE_MASTER (ID, PLANT_ID, DI_NO, PALLATE_NO, PALLATE_TYPE, SHIPPER_QTY, DISPATCH_MODE, CREATED_BY, CREATED_DATETIME) ";

                                    var sqlQuery_Select = "";

                                    foreach (DataRow dr in nextBatch.Rows)
                                    {
                                        try
                                        {
                                            if ((dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0) > 0)
                                            {
                                                sqlQuery_Select += $"SELECT {(dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0)} ID" +
                                                    $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
                                                    $", '{(dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "")}' DI_NO" +
                                                    $", '{(dr["PALLATE_NO"] != DBNull.Value ? Convert.ToString(dr["PALLATE_NO"]) : "")}' PALLATE_NO" +
                                                    $", '{(dr["PALLATE_TYPE"] != DBNull.Value ? Convert.ToString(dr["PALLATE_TYPE"]) : "")}' PALLATE_TYPE" +
                                                    $", {(dr["SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QTY"]) : 0)} SHIPPER_QTY" +
                                                    $", '{(dr["DISPATCH_MODE"] != DBNull.Value ? Convert.ToString(dr["DISPATCH_MODE"]) : "")}' DISPATCH_MODE" +
                                                    $", {(dr["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY"]) : 0)} CREATED_BY" +
                                                    $", TO_DATE('{(dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS') CREATED_DATETIME" +
                                                    $" FROM DUAL UNION ";
                                            }

                                        }
                                        catch (Exception) { continue; }
                                    }

                                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                    sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

                                    DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                    startIndex += 1000;
                                }

                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "PALLATE_MASTER", ex); }
            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PALLATE_SHIPPER")
            {
                try
                {
                    dtSql = DataContext.ExecuteQuery_SQL("SELECT ID, PLANT_ID, DI_NO, PALLATE_ID, SHIPPER_QR_CODE, STATUS, REASON" +
                        ", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME " +
                            "FROM PALLATE_SHIPPER WHERE 1 = 1 ");

                    if (dtSql != null && dtSql.Rows.Count > 0)
                    {
                        List<string> checkValues = new List<string>();

                        List<(long ID, long PLANT_ID, string DI_NO, long PALLATE_ID, string SHIPPER_QR_CODE, string STATUS)>
                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["ID"]}"), Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToString($"{row["DI_NO"]}")
                                            , Convert.ToInt64($"{row["PALLATE_ID"]}"), Convert.ToString($"{row["SHIPPER_QR_CODE"]}"), Convert.ToString($"{row["STATUS"]}"))).ToList();

                        foreach (var tuple in idsToFilter)
                        {
                            string checkValue = $"({tuple.ID}, {tuple.PLANT_ID}, '{tuple.DI_NO}', {tuple.PALLATE_ID}, '{tuple.SHIPPER_QR_CODE}', '{tuple.STATUS}')";
                            checkValues.Add(checkValue);
                        }

                        if (ids_GateInOut == null || ids_GateInOut.Count == 0)
                            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT ID, PLANT_ID, DI_NO, PALLATE_ID, SHIPPER_QR_CODE, STATUS
        										FROM PALLATE_SHIPPER 
        										WHERE (ID, PLANT_ID, DI_NO, PALLATE_ID, SHIPPER_QR_CODE, STATUS) 
        										IN ({string.Join(", ", checkValues)})");

                        checkValues = new List<string>();

                        if (dtOracle != null && dtOracle.Rows.Count > 0)
                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable()
                                            .Any(row => x == (Convert.ToInt64($"{row["ID"]}"), Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToString($"{row["DI_NO"]}")
                                            , Convert.ToInt64($"{row["PALLATE_ID"]}"), Convert.ToString($"{row["SHIPPER_QR_CODE"]}"), Convert.ToString($"{row["STATUS"]}")))).ToList();

                        if (idsToFilter != null && idsToFilter.Count() > 0)
                        {
                            foreach (var tuple in idsToFilter)
                            {
                                string checkValue = $"({tuple.ID}, {tuple.PLANT_ID}, '{tuple.DI_NO}', {tuple.PALLATE_ID}, '{tuple.SHIPPER_QR_CODE}', '{tuple.STATUS}')";
                                checkValues.Add(checkValue);
                            }

                            dtSql = DataContext.ExecuteQuery_SQL("SELECT DISTINCT ID, PLANT_ID, DI_NO, PALLATE_ID, SHIPPER_QR_CODE, STATUS, REASON" +
                                    ", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME " +
                                    $"FROM PALLATE_SHIPPER WHERE (ID, PLANT_ID, DI_NO, PALLATE_ID, SHIPPER_QR_CODE, STATUS) IN({string.Join(", ", checkValues)})");

                            if (dtSql != null && dtSql.Rows.Count > 0)
                            {
                                int startIndex = 0;

                                while (startIndex < dtSql.Rows.Count)
                                {
                                    DataTable nextBatch = dtSql.AsEnumerable()
                                        .Skip(startIndex)
                                        .Take(1000)
                                        .CopyToDataTable();

                                    var sqlQuery = "INSERT INTO PALLATE_SHIPPER (ID, PLANT_ID, DI_NO, PALLATE_ID, SHIPPER_QR_CODE, STATUS, REASON, CREATED_BY, CREATED_DATETIME) ";

                                    var sqlQuery_Select = "";

                                    foreach (DataRow dr in nextBatch.Rows)
                                    {
                                        try
                                        {
                                            if ((dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0) > 0)
                                            {
                                                sqlQuery_Select += $"SELECT {(dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0)} ID" +
                                                    $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
                                                    $", '{(dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "")}' DI_NO" +
                                                    $", {(dr["PALLATE_ID"] != DBNull.Value ? Convert.ToString(dr["PALLATE_ID"]) : "")} PALLATE_ID" +
                                                    $", '{(dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "")}' SHIPPER_QR_CODE" +
                                                    $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                    $", '{(dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "")}' REASON" +
                                                    $", {(dr["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY"]) : 0)} CREATED_BY" +
                                                    $", TO_DATE('{(dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS') CREATED_DATETIME" +
                                                    $" FROM DUAL UNION ";
                                            }

                                        }
                                        catch (Exception) { continue; }
                                    }

                                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                    sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

                                    DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                    startIndex += 1000;
                                }

                            }
                        }

                    }

                }
                catch (Exception ex) { LogService.LogInsert("SyncData_LocalToCloud", "PALLATE_SHIPPER", ex); }
            }

        }

        //public static async Task SyncData_LocalToCloud(string tableName, List<long> ids_GateInOut, List<long> ids_MDA)
        //{
        //    DataTable dtSql = null;
        //    DataTable dtOracle = null;
        //    DataTable filteredDataTable = null;
        //    DateTime? nullDateTime = null;

        //    ids_GateInOut = ids_GateInOut == null ? new List<long>() { } : ids_GateInOut;
        //    ids_MDA = ids_MDA == null ? new List<long>() { } : ids_MDA;

        //    var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

        //    plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

        //    // Table : FG_GATE_IN_OUT 

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "FG_GATE_IN_OUT")
        //    {
        //        //dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT" +
        //        //		", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
        //        //		", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //        //		", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //        //		", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //        //		"FROM FG_GATE_IN_OUT WHERE IFNULL(IS_POSTED,0) = 0 AND GATE_OUT_DT IS NOT NULL " +
        //        //		$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
        //                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //                ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM FG_GATE_IN_OUT WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //                                , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        //				FROM FG_GATE_IN_OUT 
        //				WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["TRUCK_NO"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
        //                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //                        ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_FG_GATE_IN_OUT", parameters, false);

        //                    }
        //                }
        //            }

        //        }


        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        //        										FROM FG_GATE_IN_OUT 
        //        										WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL
        //        										{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //                                , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //                checkValues.Add(checkValue);
        //            }


        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
        //                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //                    ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                    "FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");


        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_GATE_IN_OUT", parameters, false);

        //                }
        //            }

        //        }

        //        //dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        //        //FROM FG_GATE_IN_OUT 
        //        //WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

        //        //    if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        //    {
        //        //        List<string> checkValues = new List<string>();

        //        //        List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
        //        //            idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //        //                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //        //                            , Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //        //                            , Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

        //        //        foreach (var tuple in idsToFilter)
        //        //        {
        //        //            string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //        //            checkValues.Add(checkValue);
        //        //        }


        //        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //        //                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
        //        //                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //        //                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //        //                ", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //        //                "FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
        //        //                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");


        //        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        //        {
        //        //            foreach (DataRow dr in dtSql.Rows)
        //        //            {
        //        //                List<OracleParameter> parameters = new List<OracleParameter>();

        //        //                parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //        //                parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //        //                parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //        //                parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //        //                parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //        //                parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

        //        //                parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
        //        //                parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //        //                parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //        //                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_GATE_IN_OUT", parameters, false);

        //        //            }
        //        //        }

        //        //    }

        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "FG_WEIGHMENT_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM FG_WEIGHMENT_DETAIL WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM FG_WEIGHMENT_DETAIL 
        //					WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        //					IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                        ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                        ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                        "FROM FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_FG_WEIGHMENT_DETAIL", parameters, false);

        //                    }
        //                }
        //            }

        //        }

        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM FG_WEIGHMENT_DETAIL 
        //					WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                    ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                    "FROM FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_WEIGHMENT_DETAIL", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_HEADER")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
        //                ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
        //                "FROM MDA_HEADER WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y')  " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //                                , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
        //                checkValues.Add(checkValue);
        //            }


        //            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        //				FROM MDA_HEADER 
        //				WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //                                , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
        //                            ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
        //                            $"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)})");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("DI_NO", OracleDbType.NVarchar2) { Value = (dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("PLANT_CD", OracleDbType.NVarchar2) { Value = (dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });

        //                        parameters.Add(new OracleParameter("WH_CD", OracleDbType.NVarchar2) { Value = (dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("PARTY_NAME", OracleDbType.NVarchar2) { Value = (dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("DRIVER", OracleDbType.NVarchar2) { Value = (dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "") });
        //                        parameters.Add(new OracleParameter("VEHICLE_NO", OracleDbType.NVarchar2) { Value = (dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("MOBILE_NO", OracleDbType.NVarchar2) { Value = (dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("DIST", OracleDbType.Int64) { Value = (dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0M) });
        //                        parameters.Add(new OracleParameter("BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
        //                        parameters.Add(new OracleParameter("NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("ECHIT_NO", OracleDbType.NVarchar2) { Value = (dr["ECHIT_NO"] != DBNull.Value ? Convert.ToString(dr["ECHIT_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("GST_NO", OracleDbType.NVarchar2) { Value = (dr["GST_NO"] != DBNull.Value ? Convert.ToString(dr["GST_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                        parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("DESP_PLACE", OracleDbType.NVarchar2) { Value = (dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "") });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_HEADER", parameters, false);

        //                    }
        //                }
        //            }

        //        }

        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        //				FROM MDA_HEADER 
        //				WHERE PLANT_ID = {plant_id} AND OUT_TIME IS NULL");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //                                , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
        //                        ", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
        //                        $"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)}) AND OUT_TIME IS NOT NULL");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                    parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_MDA_HEADER", parameters, false);

        //                }
        //            }
        //        }

        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, MDA_DT" +
        //                ", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM MDA_DETAIL WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDA_DTL_SYS_ID, long MDA_SYS_ID, string MDA_NO, long PROD_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //                                , Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }


        //            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID
        //				FROM MDA_DETAIL 
        //				WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }


        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT" +
        //                ", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM MDA_DETAIL WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID)  " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("MDA_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_DTL_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("PROD_SNO", OracleDbType.Int64) { Value = (dr["PROD_SNO"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SNO"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("SHIPMENT_NO", OracleDbType.Int64) { Value = (dr["SHIPMENT_NO"] != DBNull.Value ? Convert.ToInt64(dr["SHIPMENT_NO"]) : 0M) });
        //                        parameters.Add(new OracleParameter("BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
        //                        parameters.Add(new OracleParameter("NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                        parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_DETAIL", parameters, false);

        //                    }
        //                }
        //            }

        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_REQUISITION_DATA")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO, MDA_DATE, SKU_CODE, SKU_NAME" +
        //                ", BOTTLE_QTY, CARTON_QTY, LOADING_BAY, LOADING_BAY_SYS_ID, SKU_ORDER, STATUS_CODE, LOADING_STATUS, LOADED_QTY, SHORT_QTY, ADDITIONAL_QTY" +
        //                ", REASON, LOADING_PROGRESS, LOADED_ITEM, API_RESULT, API_REMARK, IS_POSTED, LOAD_IN_TIME, LOAD_OUT_TIME " +
        //                "FROM MDA_REQUISITION_DATA WHERE MDA_DATE > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDA_REQ_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID, string TRUCK_NO, string MDA_NO)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_REQ_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
        //                                , Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_NO"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_REQ_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_NO}')";
        //                checkValues.Add(checkValue);
        //            }


        //            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO
        //				FROM MDA_REQUISITION_DATA 
        //				WHERE (PLANT_ID, MDA_REQ_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_REQ_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
        //                                , Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_NO"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_REQ_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_NO}')";
        //                    checkValues.Add(checkValue);
        //                }


        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO, DATE_FORMAT(MDA_DATE, '%d/%m/%Y %H:%i:%s') AS MDA_DATE, SKU_CODE, SKU_NAME" +
        //                ", BOTTLE_QTY, CARTON_QTY, LOADING_BAY, LOADING_BAY_SYS_ID, SKU_ORDER, STATUS_CODE, LOADING_STATUS, LOADED_QTY, SHORT_QTY, ADDITIONAL_QTY" +
        //                ", REASON, LOADING_PROGRESS, LOADED_ITEM, API_RESULT, API_REMARK, IS_POSTED, DATE_FORMAT(LOAD_IN_TIME, '%d/%m/%Y %H:%i:%s') AS LOAD_IN_TIME, DATE_FORMAT(LOAD_OUT_TIME, '%d/%m/%Y %H:%i:%s') AS LOAD_OUT_TIME " +
        //                $"FROM MDA_REQUISITION_DATA WHERE (PLANT_ID, MDA_REQ_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO) IN({string.Join(", ", checkValues)})");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("MDA_REQ_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_REQ_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_REQ_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("MDA_DATE", OracleDbType.Date) { Value = (dr["MDA_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("SKU_CODE", OracleDbType.NVarchar2) { Value = (dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "") });
        //                        parameters.Add(new OracleParameter("SKU_NAME", OracleDbType.NVarchar2) { Value = (dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("BOTTLE_QTY", OracleDbType.Int64) { Value = (dr["BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("CARTON_QTY", OracleDbType.Int64) { Value = (dr["CARTON_QTY"] != DBNull.Value ? Convert.ToInt64(dr["CARTON_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("LOADING_BAY", OracleDbType.NVarchar2) { Value = (dr["LOADING_BAY"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY"]) : "") });
        //                        parameters.Add(new OracleParameter("LOADING_BAY_SYS_ID", OracleDbType.Int64) { Value = (dr["LOADING_BAY_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["LOADING_BAY_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("SKU_ORDER", OracleDbType.Int64) { Value = (dr["SKU_ORDER"] != DBNull.Value ? Convert.ToInt64(dr["SKU_ORDER"]) : 0M) });
        //                        parameters.Add(new OracleParameter("STATUS_CODE", OracleDbType.NVarchar2) { Value = (dr["STATUS_CODE"] != DBNull.Value ? Convert.ToString(dr["STATUS_CODE"]) : "") });
        //                        parameters.Add(new OracleParameter("LOADING_STATUS", OracleDbType.NVarchar2) { Value = (dr["LOADING_STATUS"] != DBNull.Value ? Convert.ToString(dr["LOADING_STATUS"]) : "") });
        //                        parameters.Add(new OracleParameter("LOADED_QTY", OracleDbType.Int64) { Value = (dr["LOADED_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("SHORT_QTY", OracleDbType.Int64) { Value = (dr["SHORT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["SHORT_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("ADDITIONAL_QTY", OracleDbType.Int64) { Value = (dr["ADDITIONAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["ADDITIONAL_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("REASON", OracleDbType.NVarchar2) { Value = (dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("LOADING_PROGRESS", OracleDbType.NVarchar2) { Value = (dr["LOADING_PROGRESS"] != DBNull.Value ? Convert.ToString(dr["LOADING_PROGRESS"]) : "") });
        //                        parameters.Add(new OracleParameter("LOADED_ITEM", OracleDbType.Int64) { Value = (dr["LOADED_ITEM"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_ITEM"]) : 0M) });
        //                        parameters.Add(new OracleParameter("API_RESULT", OracleDbType.NVarchar2) { Value = (dr["API_RESULT"] != DBNull.Value ? Convert.ToString(dr["API_RESULT"]) : "") });
        //                        parameters.Add(new OracleParameter("API_REMARK", OracleDbType.NVarchar2) { Value = (dr["API_REMARK"] != DBNull.Value ? Convert.ToString(dr["API_REMARK"]) : "") });
        //                        parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("LOAD_IN_TIME", OracleDbType.Date) { Value = (dr["LOAD_IN_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["LOAD_IN_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("LOAD_OUT_TIME", OracleDbType.Date) { Value = (dr["LOAD_OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["LOAD_OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_REQUISITION_DATA", parameters, false);

        //                    }
        //                }
        //            }

        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_SEQUENCE")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, MDA_SEQUENCE_NO, MDA_STATUS" +
        //            ", MDA_REASON, MDA_REMARK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //            ", DATE_FORMAT(MDA_STATUS_DATETIME, '%d/%m/%Y %H:%i:%s') AS MDA_STATUS_DATETIME " +
        //                "FROM MDA_SEQUENCE WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDA_SEQ_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SEQ_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SEQ_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }


        //            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID
        //				FROM MDA_SEQUENCE 
        //				WHERE (PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SEQ_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SEQ_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }


        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, MDA_SEQUENCE_NO, MDA_STATUS" +
        //                                ", MDA_REASON, MDA_REMARK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //                                ", DATE_FORMAT(MDA_STATUS_DATETIME, '%d/%m/%Y %H:%i:%s') AS MDA_STATUS_DATETIME " +
        //                                $"FROM MDA_SEQUENCE WHERE (PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID) IN({string.Join(", ", checkValues)})");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();


        //                        parameters.Add(new OracleParameter("MDA_SEQ_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SEQ_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SEQ_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_SEQUENCE_NO", OracleDbType.Int64) { Value = (dr["MDA_SEQUENCE_NO"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SEQUENCE_NO"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_STATUS", OracleDbType.NVarchar2) { Value = (dr["MDA_STATUS"] != DBNull.Value ? Convert.ToString(dr["MDA_STATUS"]) : "") });
        //                        parameters.Add(new OracleParameter("MDA_REASON", OracleDbType.NVarchar2) { Value = (dr["MDA_REASON"] != DBNull.Value ? Convert.ToString(dr["MDA_REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("MDA_REMARK", OracleDbType.NVarchar2) { Value = (dr["MDA_REMARK"] != DBNull.Value ? Convert.ToString(dr["MDA_REMARK"]) : "") });
        //                        parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_STATUS_DATETIME", OracleDbType.Date) { Value = (dr["MDA_STATUS_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_STATUS_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_SEQUENCE", parameters, false);

        //                    }
        //                }
        //            }

        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_INVOICE_QR")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQRCODE, BASE64INVQRCODE" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, IS_DISPATCHED " +
        //                "FROM MDA_INVOICE_QR WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDAINVQR_SYS_ID, long GATE_SYS_ID, long MDA_SYS_ID, string MDA_NO)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDAINVQR_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToString($"{row["MDA_NO"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDAINVQR_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}')";
        //                checkValues.Add(checkValue);
        //            }


        //            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO
        //				FROM MDA_INVOICE_QR 
        //				WHERE (PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, NVL(MDA_SYS_ID, 0), MDA_NO) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDAINVQR_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToString($"{row["MDA_NO"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.MDAINVQR_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}')";
        //                    checkValues.Add(checkValue);
        //                }


        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQRCODE, BASE64INVQRCODE" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, IS_DISPATCHED " +
        //                $"FROM MDA_INVOICE_QR WHERE (PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, IFNULL(MDA_SYS_ID, 0), MDA_NO) IN({string.Join(", ", checkValues)})");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();


        //                        parameters.Add(new OracleParameter("MDAINVQR_SYS_ID", OracleDbType.Int64) { Value = (dr["MDAINVQR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDAINVQR_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("INVOICEQRCODE", OracleDbType.NVarchar2) { Value = (dr["INVOICEQRCODE"] != DBNull.Value ? Convert.ToString(dr["INVOICEQRCODE"]) : "") });
        //                        parameters.Add(new OracleParameter("BASE64INVQRCODE", OracleDbType.NVarchar2) { Value = (dr["BASE64INVQRCODE"] != DBNull.Value ? Convert.ToString(dr["BASE64INVQRCODE"]) : 0M) });
        //                        parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("IS_DISPATCHED", OracleDbType.Int64) { Value = (dr["IS_DISPATCHED"] != DBNull.Value ? Convert.ToInt64(dr["IS_DISPATCHED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_INVOICE_QR", parameters, false);

        //                    }
        //                }
        //            }

        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_ADD_QTY_REQUEST")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON" +
        //            ", REQUEST_STATUS, RESPONSE_MSG, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM MDA_ADD_QTY_REQUEST WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long MDA_ADD_SYS_ID, long GATE_SYS_ID, long MDA_SYS_ID, long PROD_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_ADD_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_ADD_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.PROD_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }


        //            dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID
        //				FROM MDA_ADD_QTY_REQUEST 
        //				WHERE (PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_ADD_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_ADD_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.PROD_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }


        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON" +
        //            ", REQUEST_STATUS, RESPONSE_MSG, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM MDA_ADD_QTY_REQUEST WHERE (PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("MDA_ADD_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_ADD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_ADD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("REQUIRED_SHIPPER_QTY", OracleDbType.Int64) { Value = (dr["REQUIRED_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER_QTY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("REASON", OracleDbType.Varchar2) { Value = (dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("REQUEST_STATUS", OracleDbType.Varchar2) { Value = (dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "") });
        //                        parameters.Add(new OracleParameter("RESPONSE_MSG", OracleDbType.Varchar2) { Value = (dr["RESPONSE_MSG"] != DBNull.Value ? Convert.ToString(dr["RESPONSE_MSG"]) : "") });

        //                        parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_ADD_QTY_REQUEST", parameters, false);

        //                    }
        //                }
        //            }

        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_LOADING")
        //    {
        //        //var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //        //		", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //        //		", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
        //        //		"FROM MDA_LOADING WHERE IFNULL(SHIPPER_QR_CODE,'') != '' AND CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //        //		$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //        //		$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
        //        //		$"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) NOT IN ({string.Join(", ", _checkValues)})" : "")} " +
        //        //		$"ORDER BY MDA_LOD_SYS_ID DESC ");

        //        dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
        //            $"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID");

        //        List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
        //            _idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //                            , (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();

        //        var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
        //                "FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
        //                "GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID ");

        //        List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
        //            _idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //                            , (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();


        //        var notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

        //        List<string> _checkValues = new List<string>();

        //        foreach (var tuple in notInOracle)
        //        {
        //            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //            _checkValues.Add(checkValue);
        //        }

        //        dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
        //            $"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
        //            "AND (PLANT_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
        //            $"IN ({string.Join(", ", _checkValues)})");

        //        _idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //                            , Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

        //        dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
        //                "FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
        //                "AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
        //                $"IN ({string.Join(", ", _checkValues)}) ");

        //        _idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //                            , Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //                            , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

        //        notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

        //        _checkValues = new List<string>();

        //        foreach (var tuple in notInOracle)
        //        {
        //            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //            _checkValues.Add(checkValue);
        //        }

        //        dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //                ", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //                ", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
        //                "FROM MDA_LOADING WHERE IFNULL(SHIPPER_QR_CODE,'') != '' AND CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //                $"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
        //                $"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) IN ({string.Join(", ", _checkValues)})" : "")} " +
        //                $"ORDER BY MDA_LOD_SYS_ID DESC ");

        //        if (dtSql_All != null && dtSql_All.Rows.Count > 0)
        //        {
        //            int chunkSize = 5000;

        //            int numberOfTasks = (int)Math.Ceiling((double)dtSql_All.Rows.Count / chunkSize);

        //            Task[] tasks = new Task[numberOfTasks];

        //            for (int i = 0; i < numberOfTasks; i++)
        //            {
        //                int start_Index = i * chunkSize;
        //                tasks[i] = Task.Run(() =>
        //                {
        //                    try
        //                    {
        //                        dtSql = dtSql_All.AsEnumerable()
        //                        .Skip(start_Index)
        //                        .Take(chunkSize)
        //                        .CopyToDataTable();

        //                        List<string> checkValues = new List<string>();

        //                        List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID)>
        //                            idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
        //                                            , (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

        //                        foreach (var tuple in idsToFilter)
        //                        {
        //                            string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
        //                            checkValues.Add(checkValue);
        //                        }

        //                        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID 
        //								FROM MDA_LOADING 
        //								WHERE (PLANT_ID, MDA_LOD_SYS_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) 
        //								IN ({string.Join(", ", checkValues)})");

        //                        checkValues = new List<string>();

        //                        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                            idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
        //                                            , (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

        //                        if (idsToFilter != null && idsToFilter.Count() > 0)
        //                        {
        //                            foreach (var tuple in idsToFilter)
        //                            {
        //                                string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
        //                                checkValues.Add(checkValue);
        //                            }

        //                            dtSql = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //                                    ", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                                    ", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
        //                                    $"FROM MDA_LOADING WHERE (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) IN({string.Join(", ", checkValues)})");

        //                            if (dtSql != null && dtSql.Rows.Count > 0)
        //                            {
        //                                int startIndex = 0;

        //                                while (startIndex < dtSql.Rows.Count)
        //                                {
        //                                    DataTable nextBatch = dtSql.AsEnumerable()
        //                                        .Skip(startIndex)
        //                                        .Take(1000)
        //                                        .CopyToDataTable();

        //                                    var sqlQuery = "INSERT INTO PRD.MDA_LOADING (MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //                                        ", SHIPPER_QR_CODE, IS_MANUAL_SCAN, ENTRY_TIME, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID, IS_POSTED) ";

        //                                    var sqlQuery_Select = "";

        //                                    foreach (DataRow dr in nextBatch.Rows)
        //                                    {
        //                                        try
        //                                        {
        //                                            if ((dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0) > 0)
        //                                            {
        //                                                sqlQuery_Select += $"SELECT {(dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0)} MDA_LOD_SYS_ID" +
        //                                                    $", {(dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0)} GATE_SYS_ID" +
        //                                                    $", {(dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0)} MDA_SYS_ID" +
        //                                                    $", {(dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)} PROD_SYS_ID" +
        //                                                    $", {(dr["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER"]) : 0)} REQUIRED_SHIPPER" +
        //                                                    $", {(dr["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_SHIPPER"]) : 0)} LOADED_SHIPPER" +
        //                                                    $", '{(dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "")}' SHIPPER_QR_CODE" +
        //                                                    $", {(dr["IS_MANUAL_SCAN"] != DBNull.Value ? Convert.ToInt64(dr["IS_MANUAL_SCAN"]) : 0)} IS_MANUAL_SCAN" +
        //                                                    $", TO_DATE('{(dr["ENTRY_TIME"] != DBNull.Value ? Convert.ToString(dr["ENTRY_TIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS')  ENTRY_TIME" +
        //                                                    $", {(dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0)} CREATED_BY_ID" +
        //                                                    $", TO_DATE('{(dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS') CREATED_DATETIME" +
        //                                                    $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
        //                                                    $", {(dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0)} IS_POSTED " +
        //                                                    $" FROM DUAL UNION ";
        //                                            }

        //                                        }
        //                                        catch (Exception) { continue; }
        //                                    }

        //                                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //                                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //                                    sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

        //                                    DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

        //                                    startIndex += 1000;
        //                                }


        //                                //foreach (DataRow dr in dtSql.Rows)
        //                                //{
        //                                //	List<OracleParameter> parameters = new List<OracleParameter>();

        //                                //	parameters.Add(new OracleParameter("MDA_LOD_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("REQUIRED_SHIPPER", OracleDbType.Int64) { Value = (dr["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("LOADED_SHIPPER", OracleDbType.Int64) { Value = (dr["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_SHIPPER"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("SHIPPER_QR_CODE", OracleDbType.NVarchar2) { Value = (dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "") });
        //                                //	parameters.Add(new OracleParameter("IS_MANUAL_SCAN", OracleDbType.Int64) { Value = (dr["IS_MANUAL_SCAN"] != DBNull.Value ? Convert.ToInt64(dr["IS_MANUAL_SCAN"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                                //	parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //                                //	parameters.Add(new OracleParameter("ENTRY_TIME", OracleDbType.Date) { Value = (dr["ENTRY_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ENTRY_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                                //	var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_LOADING", parameters, false);

        //                                //}
        //                            }
        //                        }

        //                    }
        //                    catch (Exception ex) { }


        //                });
        //            }

        //            Task.WaitAll(tasks);

        //        }
        //    }




        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "RM_GATE_IN_OUT")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
        //                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM RM_GATE_IN_OUT WHERE 1 = 1 " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long PO_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.PO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID
        //				FROM RM_GATE_IN_OUT 
        //				WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PO_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.PO_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
        //                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                        ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM RM_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRANSPORTER_NAME", OracleDbType.NVarchar2) { Value = (dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "") });

        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_RM_GATE_IN_OUT", parameters, false);

        //                    }
        //                }
        //            }
        //        }


        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID
        //				FROM RM_GATE_IN_OUT 
        //				WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long PO_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.PO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
        //                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                    ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                    "FROM RM_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, PO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                    parameters.Add(new OracleParameter("P_IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_RM_GATE_IN_OUT", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "RM_WEIGHMENT_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                ", NET_WT" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM RM_WEIGHMENT_DETAIL WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM RM_WEIGHMENT_DETAIL 
        //					WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        //					IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                        ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                        ", NET_WT" +
        //                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                        "FROM RM_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_RM_WEIGHMENT_DETAIL", parameters, false);

        //                    }
        //                }
        //            }

        //        }

        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM RM_WEIGHMENT_DETAIL 
        //					WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                    ", NET_WT" +
        //                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                    "FROM RM_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_RM_WEIGHMENT_DETAIL", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PO_HEADER")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, PO_SYS_ID, PO_NO, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i:%s') AS PO_DATE, " +
        //                "COST_CENTER, PO_DESCCRIPTION, VENDOR_SYS_ID, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_HEADER WHERE 1 = 1 " +
        //                $"{(ids_MDA.Count() > 0 ? " AND PO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long PO_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.PO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, PO_SYS_ID
        //				FROM OTHER_HEADER 
        //				WHERE (PLANT_ID, STATION_ID, PO_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["PO_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.PO_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, PO_SYS_ID, PO_NO, DATE_FORMAT(PO_DATE, '%d/%m/%Y %H:%i:%s') AS PO_DATE, " +
        //                        "COST_CENTER, PO_DESCCRIPTION, VENDOR_SYS_ID, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
        //                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM OTHER_HEADER WHERE (PLANT_ID, STATION_ID, PO_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PO_NO", OracleDbType.NVarchar2) { Value = (dr["PO_NO"] != DBNull.Value ? Convert.ToInt64(dr["PO_NO"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PO_DATE", OracleDbType.Date) { Value = (dr["PO_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["PO_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                        parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_COST_CENTER", OracleDbType.NVarchar2) { Value = (dr["COST_CENTER"] != DBNull.Value ? Convert.ToString(dr["COST_CENTER"]) : "") });
        //                        parameters.Add(new OracleParameter("P_PO_DESCCRIPTION", OracleDbType.NVarchar2) { Value = (dr["PO_DESCCRIPTION"] != DBNull.Value ? Convert.ToString(dr["PO_DESCCRIPTION"]) : "") });
        //                        parameters.Add(new OracleParameter("P_VENDOR_SYS_ID", OracleDbType.Int64) { Value = (dr["VENDOR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_IS_PO_MANUAL", OracleDbType.Int64) { Value = (dr["IS_PO_MANUAL"] != DBNull.Value ? Convert.ToInt64(dr["IS_PO_MANUAL"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_PO_HEADER", parameters, false);

        //                    }
        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "PO_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID, PO_LINE_NO, " +
        //                "LINE_DESC, LINE_QTY, UMO, RECEIVE_QTY, RECEIVE_UOM, SHORT_QTY" +
        //                ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_DETAIL WHERE 1 = 1 " +
        //                $"{(ids_MDA.Count() > 0 ? " AND PO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long PO_DTL_SYS_ID, long PO_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["PO_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["PO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.PO_DTL_SYS_ID}, {tuple.PO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID
        //				FROM OTHER_DETAIL 
        //				WHERE (PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["PO_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["PO_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.PO_DTL_SYS_ID}, {tuple.PO_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID, PO_LINE_NO, " +
        //                        "LINE_DESC, LINE_QTY, UMO, RECEIVE_QTY, RECEIVE_UOM, SHORT_QTY" +
        //                        ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM OTHER_DETAIL WHERE (PLANT_ID, PO_DTL_SYS_ID, PO_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_PO_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_DTL_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PO_SYS_ID", OracleDbType.Int64) { Value = (dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PO_LINE_NO", OracleDbType.NVarchar2) { Value = (dr["PO_LINE_NO"] != DBNull.Value ? Convert.ToInt64(dr["PO_LINE_NO"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_LINE_DESC", OracleDbType.NVarchar2) { Value = (dr["LINE_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_DESC"]) : "") });
        //                        parameters.Add(new OracleParameter("P_UMO", OracleDbType.NVarchar2) { Value = (dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_LINE_QTY", OracleDbType.Int64) { Value = (dr["LINE_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["LINE_QTY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_RECEIVE_QTY", OracleDbType.Int64) { Value = (dr["RECEIVE_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["RECEIVE_QTY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_RECEIVE_UOM", OracleDbType.Int64) { Value = (dr["RECEIVE_UOM"] != DBNull.Value ? Convert.ToString(dr["RECEIVE_UOM"]) : "") });
        //                        parameters.Add(new OracleParameter("P_SHORT_QTY", OracleDbType.Int64) { Value = (dr["SHORT_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["SHORT_QTY"]) : 0) });

        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        //parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_DETAIL", parameters, false);

        //                    }
        //                }
        //            }
        //        }
        //    }



        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SP_GATE_IN_OUT")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
        //                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM SP_GATE_IN_OUT WHERE 1 = 1 " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long SO_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.SO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID
        //				FROM SP_GATE_IN_OUT 
        //				WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["SO_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.SO_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
        //                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD, IS_GOODS_TRANSFER" +
        //                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM SP_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TRANSPORTER_NAME", OracleDbType.NVarchar2) { Value = (dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "") });

        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SP_GATE_IN_OUT", parameters, false);

        //                    }
        //                }
        //            }
        //        }


        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID
        //				FROM SP_GATE_IN_OUT 
        //				WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long SO_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.SO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, SO_SYS_ID, TRANS_SYS_ID, TRANSPORTER_NAME, TRUCK_NO" +
        //                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                ", GATE_SYS_ID_OLD, IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                "FROM SP_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, SO_SYS_ID, TRANSPORTER_NAME, TRUCK_NO) " +
        //                "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_SP_GATE_IN_OUT", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SP_WEIGHMENT_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                ", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM SP_WEIGHMENT_DETAIL WHERE CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM SP_WEIGHMENT_DETAIL 
        //					WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        //					IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                        ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                        ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                        ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                        "FROM SP_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SP_WEIGHMENT_DETAIL", parameters, false);
        //                    }
        //                }
        //            }
        //        }

        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM SP_WEIGHMENT_DETAIL 
        //					WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                    ", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //                    ", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //                    ", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                    "FROM SP_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //                    parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_SP_WEIGHMENT_DETAIL", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SO_HEADER")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_SYS_ID, UNIT_CODE, SO_NO, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i:%s') AS SO_DATE, DATE_FORMAT(SO_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS SO_RELEASE_DATE" +
        //                ", DATE_FORMAT(SO_VALID_DATE, '%d/%m/%Y %H:%i:%s') AS SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, DATE_FORMAT(TENDER_DATE, '%d/%m/%Y %H:%i:%s') AS TENDER_DATE" +
        //                ", VENSOR_SYS_ID, CUST_CD, CUST_NAME, CUST_SITE_CD, SITE_NAME" +
        //                ", ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST, TEL_NO, SO_REMARKS, STATUS, STATUS_DATE, STATUS_REMARKS, EMD_AMT, TERMS_PRICE" +
        //                ", TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS, TENDER_TYPE, AMEND_NO, DATE_FORMAT(AMEND_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS AMEND_RELEASE_DATE" +
        //                ", RIVISION, CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_HEADER WHERE 1 = 1 " +
        //                $"{(ids_MDA.Count() > 0 ? " AND SO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long SO_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.SO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, SO_SYS_ID
        //				FROM OTHER_HEADER 
        //				WHERE (PLANT_ID, STATION_ID, SO_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["SO_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.SO_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_SYS_ID, UNIT_CODE, SO_NO, DATE_FORMAT(SO_DATE, '%d/%m/%Y %H:%i:%s') AS SO_DATE, DATE_FORMAT(SO_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS SO_RELEASE_DATE" +
        //                        ", DATE_FORMAT(SO_VALID_DATE, '%d/%m/%Y %H:%i:%s') AS SO_VALID_DATE, SEQUENCE_NO, TENDER_NO, DATE_FORMAT(TENDER_DATE, '%d/%m/%Y %H:%i:%s') AS TENDER_DATE" +
        //                        ", VENSOR_SYS_ID, CUST_CD, CUST_NAME, CUST_SITE_CD, SITE_NAME" +
        //                        ", ADD1, ADD2, ADD3, CITY, PIN, STATE, STATE_CD, GSTN_NO, PAN_NO, CUST_NON_GST, TEL_NO, SO_REMARKS, STATUS, STATUS_DATE, STATUS_REMARKS, EMD_AMT, TERMS_PRICE" +
        //                        ", TERMS_PYMT_TERM, TERMS_LIFTING_PERIOD_DAYS, TENDER_TYPE, AMEND_NO, DATE_FORMAT(AMEND_RELEASE_DATE, '%d/%m/%Y %H:%i:%s') AS AMEND_RELEASE_DATE" +
        //                        ", RIVISION, CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM OTHER_HEADER WHERE (PLANT_ID, STATION_ID, SO_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_SO_NO", OracleDbType.NVarchar2) { Value = (dr["SO_NO"] != DBNull.Value ? Convert.ToInt64(dr["SO_NO"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_SO_DATE", OracleDbType.Date) { Value = (dr["SO_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_SO_RELEASE_DATE", OracleDbType.Date) { Value = (dr["SO_RELEASE_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_RELEASE_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_SO_VALID_DATE", OracleDbType.Date) { Value = (dr["SO_VALID_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_VALID_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                        parameters.Add(new OracleParameter("P_SEQUENCE_NO", OracleDbType.NVarchar2) { Value = (dr["SEQUENCE_NO"] != DBNull.Value ? Convert.ToString(dr["SEQUENCE_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TENDER_NO", OracleDbType.NVarchar2) { Value = (dr["TENDER_NO"] != DBNull.Value ? Convert.ToString(dr["TENDER_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TENDER_DATE", OracleDbType.Date) { Value = (dr["TENDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TENDER_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_VENSOR_SYS_ID", OracleDbType.Int64) { Value = (dr["VENSOR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENSOR_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CUST_CD", OracleDbType.NVarchar2) { Value = (dr["CUST_CD"] != DBNull.Value ? Convert.ToString(dr["CUST_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CUST_NAME", OracleDbType.NVarchar2) { Value = (dr["CUST_NAME"] != DBNull.Value ? Convert.ToString(dr["CUST_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CUST_SITE_CD", OracleDbType.NVarchar2) { Value = (dr["CUST_SITE_CD"] != DBNull.Value ? Convert.ToString(dr["CUST_SITE_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("P_SITE_NAME", OracleDbType.NVarchar2) { Value = (dr["SITE_NAME"] != DBNull.Value ? Convert.ToString(dr["SITE_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("P_ADD1", OracleDbType.NVarchar2) { Value = (dr["ADD1"] != DBNull.Value ? Convert.ToString(dr["ADD1"]) : "") });
        //                        parameters.Add(new OracleParameter("P_ADD2", OracleDbType.NVarchar2) { Value = (dr["ADD2"] != DBNull.Value ? Convert.ToString(dr["ADD2"]) : "") });
        //                        parameters.Add(new OracleParameter("P_ADD3", OracleDbType.NVarchar2) { Value = (dr["ADD3"] != DBNull.Value ? Convert.ToString(dr["ADD3"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CITY", OracleDbType.NVarchar2) { Value = (dr["CITY"] != DBNull.Value ? Convert.ToString(dr["CITY"]) : "") });
        //                        parameters.Add(new OracleParameter("P_PIN", OracleDbType.NVarchar2) { Value = (dr["PIN"] != DBNull.Value ? Convert.ToString(dr["PIN"]) : "") });
        //                        parameters.Add(new OracleParameter("P_STATE", OracleDbType.NVarchar2) { Value = (dr["STATE"] != DBNull.Value ? Convert.ToString(dr["STATE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_STATE_CD", OracleDbType.NVarchar2) { Value = (dr["STATE_CD"] != DBNull.Value ? Convert.ToString(dr["STATE_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("P_GSTN_NO", OracleDbType.NVarchar2) { Value = (dr["GSTN_NO"] != DBNull.Value ? Convert.ToString(dr["GSTN_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_PAN_NO", OracleDbType.NVarchar2) { Value = (dr["PAN_NO"] != DBNull.Value ? Convert.ToString(dr["PAN_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CUST_NON_GST", OracleDbType.NVarchar2) { Value = (dr["CUST_NON_GST"] != DBNull.Value ? Convert.ToString(dr["CUST_NON_GST"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TEL_NO", OracleDbType.NVarchar2) { Value = (dr["TEL_NO"] != DBNull.Value ? Convert.ToString(dr["TEL_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_SO_REMARKS", OracleDbType.NVarchar2) { Value = (dr["SO_REMARKS"] != DBNull.Value ? Convert.ToString(dr["SO_REMARKS"]) : "") });
        //                        parameters.Add(new OracleParameter("P_STATUS", OracleDbType.NVarchar2) { Value = (dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "") });
        //                        parameters.Add(new OracleParameter("P_STATUS_DATE", OracleDbType.Date) { Value = (dr["STATUS_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["STATUS_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_STATUS_REMARKS", OracleDbType.NVarchar2) { Value = (dr["STATUS_REMARKS"] != DBNull.Value ? Convert.ToString(dr["STATUS_REMARKS"]) : "") });
        //                        parameters.Add(new OracleParameter("P_EMD_AMT", OracleDbType.Decimal) { Value = (dr["EMD_AMT"] != DBNull.Value ? Convert.ToDecimal(dr["EMD_AMT"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TERMS_PRICE", OracleDbType.Decimal) { Value = (dr["TERMS_PRICE"] != DBNull.Value ? Convert.ToDecimal(dr["TERMS_PRICE"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_TERMS_PYMT_TERM", OracleDbType.NVarchar2) { Value = (dr["TERMS_PYMT_TERM"] != DBNull.Value ? Convert.ToString(dr["TERMS_PYMT_TERM"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TERMS_LIFTING_PERIOD_DAYS", OracleDbType.NVarchar2) { Value = (dr["TERMS_LIFTING_PERIOD_DAYS"] != DBNull.Value ? Convert.ToString(dr["TERMS_LIFTING_PERIOD_DAYS"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TENDER_TYPE", OracleDbType.NVarchar2) { Value = (dr["TENDER_TYPE"] != DBNull.Value ? Convert.ToString(dr["TENDER_TYPE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_AMEND_NO", OracleDbType.NVarchar2) { Value = (dr["AMEND_NO"] != DBNull.Value ? Convert.ToString(dr["AMEND_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_AMEND_RELEASE_DATE", OracleDbType.Date) { Value = (dr["AMEND_RELEASE_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["AMEND_RELEASE_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_RIVISION", OracleDbType.NVarchar2) { Value = (dr["RIVISION"] != DBNull.Value ? Convert.ToString(dr["RIVISION"]) : "") });

        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_UNIT_CODE", OracleDbType.Int64) { Value = (dr["UNIT_CODE"] != DBNull.Value ? Convert.ToString(dr["UNIT_CODE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SO_HEADER", parameters, false);

        //                    }
        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SO_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_CD, SCRAP_DESC" +
        //                ", UOM, ERP_UOM_CD, SO_QTY, BASIC_AMT, LOADING_QTY, LOADING_UOM, UNIT_CODE, IS_POSTED " +
        //                "FROM SO_DETAIL WHERE 1 = 1 " +
        //                $"{(ids_MDA.Count() > 0 ? " AND SO_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long SO_DTL_SYS_ID, long SO_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["SO_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["SO_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.SO_DTL_SYS_ID}, {tuple.SO_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID
        //				FROM OTHER_DETAIL 
        //				WHERE (PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["SO_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["SO_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.SO_DTL_SYS_ID}, {tuple.SO_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID, SO_NO, SLNO, SCRAP_CD, SCRAP_DESC" +
        //                ", UOM, ERP_UOM_CD, SO_QTY, BASIC_AMT, LOADING_QTY, LOADING_UOM, UNIT_CODE, IS_POSTED " +
        //                        "FROM SO_DETAIL WHERE (PLANT_ID, SO_DTL_SYS_ID, SO_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_SO_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_DTL_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_SO_SYS_ID", OracleDbType.Int64) { Value = (dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_SO_NO", OracleDbType.NVarchar2) { Value = (dr["SO_NO"] != DBNull.Value ? Convert.ToString(dr["SO_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_SLNO", OracleDbType.NVarchar2) { Value = (dr["SLNO"] != DBNull.Value ? Convert.ToString(dr["SLNO"]) : "") });

        //                        parameters.Add(new OracleParameter("P_SCRAP_CD", OracleDbType.NVarchar2) { Value = (dr["SCRAP_CD"] != DBNull.Value ? Convert.ToString(dr["SCRAP_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("P_SCRAP_DESC", OracleDbType.NVarchar2) { Value = (dr["SCRAP_DESC"] != DBNull.Value ? Convert.ToString(dr["SCRAP_DESC"]) : "") });
        //                        parameters.Add(new OracleParameter("P_UOM", OracleDbType.NVarchar2) { Value = (dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_ERP_UOM_CD", OracleDbType.NVarchar2) { Value = (dr["ERP_UOM_CD"] != DBNull.Value ? Convert.ToString(dr["ERP_UOM_CD"]) : "") });
        //                        parameters.Add(new OracleParameter("P_SO_QTY", OracleDbType.Decimal) { Value = (dr["SO_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["SO_QTY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_BASIC_AMT", OracleDbType.Decimal) { Value = (dr["BASIC_AMT"] != DBNull.Value ? Convert.ToDecimal(dr["BASIC_AMT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_LOADING_QTY", OracleDbType.Decimal) { Value = (dr["LOADING_QTY"] != DBNull.Value ? Convert.ToDecimal(dr["LOADING_QTY"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_LOADING_UOM", OracleDbType.NVarchar2) { Value = (dr["LOADING_UOM"] != DBNull.Value ? Convert.ToString(dr["LOADING_UOM"]) : "") });

        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_UNIT_CODE", OracleDbType.Int64) { Value = (dr["UNIT_CODE"] != DBNull.Value ? Convert.ToString(dr["UNIT_CODE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_SO_DETAIL", parameters, false);

        //                    }
        //                }
        //            }
        //        }
        //    }



        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_GATE_IN_OUT")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID, TRANSACTION_TYPE" +
        //                ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, OTHER_SYS_ID, TRUCK_NO" +
        //                ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_GATE_IN_OUT WHERE 1 = 1 " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long OTHER_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.OTHER_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID
        //				FROM OTHER_GATE_IN_OUT 
        //				WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["OTHER_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.OTHER_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                        ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, OTHER_SYS_ID, TRUCK_NO" +
        //                        ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                        ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                        ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM OTHER_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRANSACTION_TYPE", OracleDbType.NVarchar2) { Value = (dr["TRANSACTION_TYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTION_TYPE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                        parameters.Add(new OracleParameter("IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_GATE_IN_OUT", parameters, false);

        //                    }
        //                }
        //            }
        //        }


        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID, TRUCK_NO
        //				FROM OTHER_GATE_IN_OUT 
        //				WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long OTHER_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.OTHER_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //                    ", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, OTHER_SYS_ID, TRUCK_NO" +
        //                    ", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //                    ", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON" +
        //                    ", IS_UNLOAD_TRUCK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                    "FROM OTHER_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, OTHER_SYS_ID, TRUCK_NO) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //                    parameters.Add(new OracleParameter("P_IS_UNLOAD_TRUCK", OracleDbType.Int64) { Value = (dr["IS_UNLOAD_TRUCK"] != DBNull.Value ? Convert.ToInt64(dr["IS_UNLOAD_TRUCK"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_OTHER_GATE_IN_OUT", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_WEIGHMENT_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                ", IFNULL(WEIGHIN_WT, 0)WEIGHIN_WT, DATE_FORMAT(WEIGHIN_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHIN_WT_DT, WEIGHIN_WT_NOTE" +
        //                ", WEIGHOUT_WT, DATE_FORMAT(WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHOUT_WT_DT, WEIGHOUT_WT_NOTE" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_WEIGHMENT_DETAIL WHERE 1 = 1 " +
        //                $"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM OTHER_WEIGHMENT_DETAIL 
        //					WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        //					IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                ", WEIGHIN_WT, DATE_FORMAT(WEIGHIN_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHIN_WT_DT, WEIGHIN_WT_NOTE" +
        //                ", WEIGHOUT_WT, DATE_FORMAT(WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHOUT_WT_DT, WEIGHOUT_WT_NOTE" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_WEIGHIN_WT", OracleDbType.Decimal) { Value = (dr["WEIGHIN_WT"] != DBNull.Value ? Convert.ToDecimal(dr["WEIGHIN_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_WEIGHIN_WT_DT", OracleDbType.Date) { Value = (dr["WEIGHIN_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGHIN_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_WEIGHIN_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["WEIGHIN_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["WEIGHIN_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_WEIGHOUT_WT", OracleDbType.Decimal) { Value = (dr["WEIGHOUT_WT"] != DBNull.Value ? Convert.ToDecimal(dr["WEIGHOUT_WT"]) : 0) });
        //                        parameters.Add(new OracleParameter("P_WEIGHOUT_WT_DT", OracleDbType.Date) { Value = (dr["WEIGHOUT_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGHOUT_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_WEIGHOUT_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["WEIGHOUT_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["WEIGHOUT_WT_NOTE"]) : "") });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_WEIGHMENT_DETAIL", parameters, false);

        //                    }
        //                }
        //            }

        //        }

        //        dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //					FROM OTHER_WEIGHMENT_DETAIL 
        //					WHERE PLANT_ID = {plant_id} AND NVL(WEIGHOUT_WT, 0) = 0");

        //        if (dtOracle != null && dtOracle.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //                idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //                    ", WEIGHIN_WT, DATE_FORMAT(WEIGHIN_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHIN_WT_DT, WEIGHIN_WT_MANUALLY, WEIGHIN_WT_NOTE" +
        //                    ", WEIGHOUT_WT, DATE_FORMAT(WEIGHOUT_WT_DT, '%d/%m/%Y %H:%i:%s') AS WEIGHOUT_WT_DT, WEIGHOUT_WT_MANUALLY, WEIGHOUT_WT_NOTE" +
        //                    ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                    "FROM OTHER_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //                    "IN (" + string.Join(", ", checkValues) + ") AND IFNULL(WEIGHIN_WT, 0) > 0");

        //            if (dtSql != null && dtSql.Rows.Count > 0)
        //            {
        //                foreach (DataRow dr in dtSql.Rows)
        //                {
        //                    List<OracleParameter> parameters = new List<OracleParameter>();

        //                    parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });

        //                    parameters.Add(new OracleParameter("P_WEIGHOUT_WT", OracleDbType.Decimal) { Value = (dr["WEIGHOUT_WT"] != DBNull.Value ? Convert.ToDecimal(dr["WEIGHOUT_WT"]) : 0) });
        //                    parameters.Add(new OracleParameter("P_WEIGHOUT_WT_DT", OracleDbType.Date) { Value = (dr["WEIGHOUT_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGHOUT_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                    parameters.Add(new OracleParameter("P_WEIGHOUT_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["WEIGHOUT_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["WEIGHOUT_WT_NOTE"]) : "") });

        //                    parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                    parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_OTHER_WEIGHMENT_DETAIL", parameters, false);

        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_HEADER")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, OTHER_SYS_ID, ORDER_NO, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i:%s') AS ORDER_DATE, " +
        //                "COST_CENTER, DESCCRIPTION, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
        //                ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_HEADER WHERE 1 = 1 " +
        //                $"{(ids_MDA.Count() > 0 ? " AND OTHER_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long STATION_ID, long OTHER_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.OTHER_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, OTHER_SYS_ID
        //				FROM OTHER_HEADER 
        //				WHERE (PLANT_ID, STATION_ID, OTHER_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //                                , Convert.ToInt64($"{row["OTHER_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.OTHER_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, OTHER_SYS_ID, ORDER_NO, DATE_FORMAT(ORDER_DATE, '%d/%m/%Y %H:%i:%s') AS ORDER_DATE, " +
        //                        "COST_CENTER, DESCCRIPTION, TRANS_SYS_ID, TRUCK_NO, IS_PO_MANUAL" +
        //                        ", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM OTHER_HEADER WHERE (PLANT_ID, STATION_ID, OTHER_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_ORDER_NO", OracleDbType.NVarchar2) { Value = (dr["ORDER_NO"] != DBNull.Value ? Convert.ToInt64(dr["ORDER_NO"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_ORDER_DATE", OracleDbType.Date) { Value = (dr["ORDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ORDER_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //                        parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_COST_CENTER", OracleDbType.NVarchar2) { Value = (dr["COST_CENTER"] != DBNull.Value ? Convert.ToString(dr["COST_CENTER"]) : "") });
        //                        parameters.Add(new OracleParameter("P_DESCCRIPTION", OracleDbType.NVarchar2) { Value = (dr["DESCCRIPTION"] != DBNull.Value ? Convert.ToString(dr["DESCCRIPTION"]) : "") });
        //                        parameters.Add(new OracleParameter("P_TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_IS_PO_MANUAL", OracleDbType.Int64) { Value = (dr["IS_PO_MANUAL"] != DBNull.Value ? Convert.ToInt64(dr["IS_PO_MANUAL"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_HEADER", parameters, false);

        //                    }
        //                }
        //            }
        //        }
        //    }

        //    if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "OTHER_DETAIL")
        //    {
        //        dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID, SR_NO, " +
        //                "MATERIAL, MATERIAL_DESC, QTY, UMO" +
        //                ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //                "FROM OTHER_DETAIL WHERE 1 = 1 " +
        //                $"{(ids_MDA.Count() > 0 ? " AND OTHER_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //        if (dtSql != null && dtSql.Rows.Count > 0)
        //        {
        //            List<string> checkValues = new List<string>();

        //            List<(long PLANT_ID, long OTHER_DTL_SYS_ID, long OTHER_SYS_ID)>
        //                idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["OTHER_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["OTHER_SYS_ID"]}"))).ToList();

        //            foreach (var tuple in idsToFilter)
        //            {
        //                string checkValue = $"({tuple.PLANT_ID}, {tuple.OTHER_DTL_SYS_ID}, {tuple.OTHER_SYS_ID})";
        //                checkValues.Add(checkValue);
        //            }

        //            if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //                dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID
        //				FROM OTHER_DETAIL 
        //				WHERE (PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID) 
        //				IN ({string.Join(", ", checkValues)})");

        //            checkValues = new List<string>();

        //            if (dtOracle != null && dtOracle.Rows.Count > 0)
        //                idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["OTHER_DTL_SYS_ID"]}")
        //                                , Convert.ToInt64($"{row["OTHER_SYS_ID"]}")))).ToList();

        //            if (idsToFilter != null && idsToFilter.Count() > 0)
        //            {
        //                foreach (var tuple in idsToFilter)
        //                {
        //                    string checkValue = $"({tuple.PLANT_ID}, {tuple.OTHER_DTL_SYS_ID}, {tuple.OTHER_SYS_ID})";
        //                    checkValues.Add(checkValue);
        //                }

        //                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID, SR_NO, " +
        //                        "MATERIAL, MATERIAL_DESC, QTY, UMO" +
        //                        ", DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //                        "FROM OTHER_DETAIL WHERE (PLANT_ID, OTHER_DTL_SYS_ID, OTHER_SYS_ID) " +
        //                        "IN (" + string.Join(", ", checkValues) + ")");

        //                if (dtSql != null && dtSql.Rows.Count > 0)
        //                {
        //                    foreach (DataRow dr in dtSql.Rows)
        //                    {
        //                        List<OracleParameter> parameters = new List<OracleParameter>();

        //                        parameters.Add(new OracleParameter("P_OTHER_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_DTL_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_OTHER_SYS_ID", OracleDbType.Int64) { Value = (dr["OTHER_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["OTHER_SYS_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_SR_NO", OracleDbType.NVarchar2) { Value = (dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0M) });

        //                        parameters.Add(new OracleParameter("P_MATERIAL", OracleDbType.NVarchar2) { Value = (dr["MATERIAL"] != DBNull.Value ? Convert.ToString(dr["MATERIAL"]) : "") });
        //                        parameters.Add(new OracleParameter("P_MATERIAL_DESC", OracleDbType.NVarchar2) { Value = (dr["MATERIAL_DESC"] != DBNull.Value ? Convert.ToString(dr["MATERIAL_DESC"]) : "") });
        //                        parameters.Add(new OracleParameter("P_UMO", OracleDbType.NVarchar2) { Value = (dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "") });
        //                        parameters.Add(new OracleParameter("P_QTY", OracleDbType.Int64) { Value = (dr["QTY"] != DBNull.Value ? Convert.ToDecimal(dr["QTY"]) : 0) });

        //                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //                        //parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //                        parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_OTHER_DETAIL", parameters, false);

        //                    }
        //                }
        //            }
        //        }
        //    }

        //}

        //public static async Task SyncData_LocalToCloud_GateOut(string tableName, List<long> ids_GateInOut, List<long> ids_MDA)
        //{
        //	DataTable dtSql = null;
        //	DataTable dtOracle = null;
        //	DataTable filteredDataTable = null;
        //	DateTime? nullDateTime = null;

        //	ids_GateInOut = ids_GateInOut == null ? new List<long>() { } : ids_GateInOut;
        //	ids_MDA = ids_MDA == null ? new List<long>() { } : ids_MDA;

        //	var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

        //	plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "FG_GATE_IN_OUT")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //				", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
        //				", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //				", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //				", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //				"FROM FG_GATE_IN_OUT WHERE 1 = 1 " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //								, Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //				checkValues.Add(checkValue);
        //			}

        //			if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //				dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        //										FROM FG_GATE_IN_OUT 
        //										WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["TRUCK_NO"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //					checkValues.Add(checkValue);
        //				}

        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //						", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
        //						", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //						", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //						", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //						"FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
        //						"IN (" + string.Join(", ", checkValues) + ")");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();

        //						parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_GATE_IN_DT", OracleDbType.Date) { Value = (dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("P_INWARD_SYS_ID", OracleDbType.Int64) { Value = (dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //						parameters.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //						parameters.Add(new OracleParameter("P_DRIVER_ID_TYPE", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_TYPE"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_TYPE"]) : "") });
        //						parameters.Add(new OracleParameter("P_DRIVER_ID_NUMBER", OracleDbType.NVarchar2) { Value = (dr["DRIVER_ID_NUMBER"] != DBNull.Value ? Convert.ToString(dr["DRIVER_ID_NUMBER"]) : "") });
        //						parameters.Add(new OracleParameter("P_DRIVER_NAME", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "") });
        //						parameters.Add(new OracleParameter("P_DRIVER_CONTACT", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "") });
        //						parameters.Add(new OracleParameter("P_DRIVER_CHANGED", OracleDbType.Int64) { Value = (dr["DRIVER_CHANGED"] != DBNull.Value ? Convert.ToInt64(dr["DRIVER_CHANGED"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_DRIVER_NAME_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_NAME_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME_NEW"]) : "") });
        //						parameters.Add(new OracleParameter("P_DRIVER_CONTACT_NEW", OracleDbType.NVarchar2) { Value = (dr["DRIVER_CONTACT_NEW"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT_NEW"]) : "") });
        //						parameters.Add(new OracleParameter("P_TRUCK_VALIDATION", OracleDbType.Int64) { Value = (dr["TRUCK_VALIDATION"] != DBNull.Value ? Convert.ToInt64(dr["TRUCK_VALIDATION"]) : 0M) });

        //						parameters.Add(new OracleParameter("P_RFSYSID", OracleDbType.Int64) { Value = (dr["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dr["RFSYSID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_VERIFIED_DOCUMENTS", OracleDbType.Int64) { Value = (dr["VERIFIED_DOCUMENTS"] != DBNull.Value ? Convert.ToInt64(dr["VERIFIED_DOCUMENTS"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_RFID_RECEIVE", OracleDbType.Int64) { Value = (dr["RFID_RECEIVE"] != DBNull.Value ? Convert.ToInt64(dr["RFID_RECEIVE"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_VERIFIED_OFFICER_ID", OracleDbType.NVarchar2) { Value = (dr["VERIFIED_OFFICER_ID"] != DBNull.Value ? Convert.ToString(dr["VERIFIED_OFFICER_ID"]) : "") });
        //						parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //						parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

        //						parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_FG_GATE_IN_OUT", parameters, false);

        //					}
        //				}
        //			}

        //		}


        //		dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO
        //										FROM FG_GATE_IN_OUT 
        //										WHERE PLANT_ID = {plant_id} AND GATE_OUT_DT IS NULL
        //										{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //		if (dtOracle != null && dtOracle.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long STATION_ID, long GATE_SYS_ID, long MDA_SYS_ID, string TRUCK_NO)>
        //				idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //								, Convert.ToString($"{row["TRUCK_NO"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.TRUCK_NO}')";
        //				checkValues.Add(checkValue);
        //			}


        //			dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, GATE_SYS_ID, DATE_FORMAT(GATE_IN_DT, '%d/%m/%Y %H:%i:%s') AS GATE_IN_DT, INWARD_SYS_ID" +
        //					", DATE_FORMAT(GATE_OUT_DT, '%d/%m/%Y %H:%i:%s') AS GATE_OUT_DT, MDA_SYS_ID, TRUCK_NO" +
        //					", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
        //					", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
        //					", IS_GOODS_TRANSFER, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, 0 IS_POSTED " +
        //					"FROM FG_GATE_IN_OUT WHERE (PLANT_ID, STATION_ID, GATE_SYS_ID, MDA_SYS_ID, TRUCK_NO) " +
        //					"IN (" + string.Join(", ", checkValues) + ") AND (GATE_OUT_DT IS NOT NULL OR CANCEL_GATE_IN = 1)");


        //			if (dtSql != null && dtSql.Rows.Count > 0)
        //			{
        //				foreach (DataRow dr in dtSql.Rows)
        //				{
        //					List<OracleParameter> parameters = new List<OracleParameter>();

        //					parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_GATE_OUT_DT", OracleDbType.Date) { Value = (dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //					parameters.Add(new OracleParameter("P_MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //					parameters.Add(new OracleParameter("P_CANCEL_GATE_IN", OracleDbType.Int64) { Value = (dr["CANCEL_GATE_IN"] != DBNull.Value ? Convert.ToInt64(dr["CANCEL_GATE_IN"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_CANCEL_GATE_REASON", OracleDbType.NVarchar2) { Value = (dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "") });
        //					parameters.Add(new OracleParameter("P_GATE_SYS_ID_OLD", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID_OLD"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID_OLD"]) : 0M) });

        //					parameters.Add(new OracleParameter("P_IS_GOODS_TRANSFER", OracleDbType.Int64) { Value = (dr["IS_GOODS_TRANSFER"] != DBNull.Value ? Convert.ToInt64(dr["IS_GOODS_TRANSFER"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_GATE_IN_OUT", parameters, false);

        //				}
        //			}

        //		}

        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "FG_WEIGHMENT_DETAIL")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //				", IFNULL(GROSS_WT, 0)GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //				", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //				", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //				", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //				"FROM FG_WEIGHMENT_DETAIL WHERE 1 = 1 " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //								, Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //				checkValues.Add(checkValue);
        //			}

        //			if (ids_GateInOut == null || ids_GateInOut.Count == 0)
        //				dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //											FROM FG_WEIGHMENT_DETAIL 
        //											WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) 
        //											IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //								, Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //					checkValues.Add(checkValue);
        //				}

        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //						", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //						", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //						", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //						", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //						"FROM FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //						"IN (" + string.Join(", ", checkValues) + ")");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();

        //						parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //						parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //						parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //						parameters.Add(new OracleParameter("P_TARE_WT", OracleDbType.Decimal) { Value = (dr["TARE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TARE_WT"]) : 0) });
        //						parameters.Add(new OracleParameter("P_TARE_WT_DT", OracleDbType.Date) { Value = (dr["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["TARE_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("P_TARE_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["TARE_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["TARE_WT_MANUALLY"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_TARE_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["TARE_WT_NOTE"]) : "") });

        //						parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
        //						parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
        //						parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
        //						parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

        //						parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("P_CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });


        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_FG_WEIGHMENT_DETAIL", parameters, false);

        //					}
        //				}
        //			}

        //		}

        //		dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID
        //											FROM FG_WEIGHMENT_DETAIL 
        //											WHERE PLANT_ID = {plant_id} AND NVL(GROSS_WT, 0) = 0 
        //											{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")}");

        //		if (dtOracle != null && dtOracle.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long STATION_ID, long WT_SYS_ID, long GATE_SYS_ID)>
        //				idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["STATION_ID"]}")
        //								, Convert.ToInt64($"{row["WT_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.STATION_ID}, {tuple.WT_SYS_ID}, {tuple.GATE_SYS_ID})";
        //				checkValues.Add(checkValue);
        //			}

        //			dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID" +
        //					", GROSS_WT, DATE_FORMAT(GROSS_WT_DT, '%d/%m/%Y %H:%i:%s') AS GROSS_WT_DT, GROSS_WT_MANUALLY, GROSS_WT_NOTE" +
        //					", TARE_WT, DATE_FORMAT(TARE_WT_DT, '%d/%m/%Y %H:%i:%s') AS TARE_WT_DT, TARE_WT_MANUALLY, TARE_WT_NOTE" +
        //					", NET_WT, OUT_OF_TOLERANCE_WT, TOLERANCE_WT, ALLOW_TOLERANCE_WT" +
        //					", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //					"FROM FG_WEIGHMENT_DETAIL WHERE (PLANT_ID, STATION_ID, WT_SYS_ID, GATE_SYS_ID) " +
        //					"IN (" + string.Join(", ", checkValues) + ") AND IFNULL(GROSS_WT, 0) > 0");

        //			if (dtSql != null && dtSql.Rows.Count > 0)
        //			{
        //				foreach (DataRow dr in dtSql.Rows)
        //				{
        //					List<OracleParameter> parameters = new List<OracleParameter>();

        //					parameters.Add(new OracleParameter("P_WT_SYS_ID", OracleDbType.Int64) { Value = (dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_GROSS_WT", OracleDbType.Decimal) { Value = (dr["GROSS_WT"] != DBNull.Value ? Convert.ToDecimal(dr["GROSS_WT"]) : 0) });
        //					parameters.Add(new OracleParameter("P_GROSS_WT_DT", OracleDbType.Date) { Value = (dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //					parameters.Add(new OracleParameter("P_GROSS_WT_MANUALLY", OracleDbType.Int64) { Value = (dr["GROSS_WT_MANUALLY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_WT_MANUALLY"]) : 0) });
        //					parameters.Add(new OracleParameter("P_GROSS_WT_NOTE", OracleDbType.NVarchar2) { Value = (dr["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dr["GROSS_WT_NOTE"]) : "") });

        //					parameters.Add(new OracleParameter("P_NET_WT", OracleDbType.Decimal) { Value = (dr["NET_WT"] != DBNull.Value ? Convert.ToDecimal(dr["NET_WT"]) : 0) });
        //					parameters.Add(new OracleParameter("P_OUT_OF_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0) });
        //					parameters.Add(new OracleParameter("P_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_WT"]) : 0) });
        //					parameters.Add(new OracleParameter("P_ALLOW_TOLERANCE_WT", OracleDbType.Decimal) { Value = (dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["ALLOW_TOLERANCE_WT"]) : 0) });

        //					parameters.Add(new OracleParameter("P_STATION_ID", OracleDbType.Int64) { Value = (dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0M) });
        //					parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_FG_WEIGHMENT_DETAIL", parameters, false);

        //				}
        //			}
        //		}
        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_HEADER")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
        //				", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
        //				"FROM MDA_HEADER WHERE 1 = 1 " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //								, Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
        //				checkValues.Add(checkValue);
        //			}


        //			dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        //										FROM MDA_HEADER 
        //										WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //								, Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
        //					checkValues.Add(checkValue);
        //				}

        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
        //							", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
        //							$"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)})");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();

        //						parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //						parameters.Add(new OracleParameter("DI_NO", OracleDbType.NVarchar2) { Value = (dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "") });
        //						parameters.Add(new OracleParameter("PLANT_CD", OracleDbType.NVarchar2) { Value = (dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "") });
        //						parameters.Add(new OracleParameter("MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("TRANS_SYS_ID", OracleDbType.Int64) { Value = (dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0M) });

        //						parameters.Add(new OracleParameter("WH_CD", OracleDbType.NVarchar2) { Value = (dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "") });
        //						parameters.Add(new OracleParameter("PARTY_NAME", OracleDbType.NVarchar2) { Value = (dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "") });
        //						parameters.Add(new OracleParameter("DRIVER", OracleDbType.NVarchar2) { Value = (dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "") });
        //						parameters.Add(new OracleParameter("VEHICLE_NO", OracleDbType.NVarchar2) { Value = (dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "") });
        //						parameters.Add(new OracleParameter("MOBILE_NO", OracleDbType.NVarchar2) { Value = (dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "") });
        //						parameters.Add(new OracleParameter("DIST", OracleDbType.Int64) { Value = (dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0M) });
        //						parameters.Add(new OracleParameter("BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
        //						parameters.Add(new OracleParameter("NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("ECHIT_NO", OracleDbType.NVarchar2) { Value = (dr["ECHIT_NO"] != DBNull.Value ? Convert.ToString(dr["ECHIT_NO"]) : "") });
        //						parameters.Add(new OracleParameter("GST_NO", OracleDbType.NVarchar2) { Value = (dr["GST_NO"] != DBNull.Value ? Convert.ToString(dr["GST_NO"]) : "") });
        //						parameters.Add(new OracleParameter("OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //						parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //						parameters.Add(new OracleParameter("DESP_PLACE", OracleDbType.NVarchar2) { Value = (dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "") });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_HEADER", parameters, false);

        //					}
        //				}
        //			}

        //		}

        //		dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO
        //										FROM MDA_HEADER 
        //										WHERE PLANT_ID = {plant_id} AND OUT_TIME IS NULL 
        //										{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //		if (dtOracle != null && dtOracle.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDA_SYS_ID, string MDA_NO, string DI_NO)>
        //				idsToFilter = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //								, Convert.ToString($"{row["MDA_NO"]}"), Convert.ToString($"{row["DI_NO"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', '{tuple.DI_NO}')";
        //				checkValues.Add(checkValue);
        //			}

        //			dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT, PLANT_CD, TRANS_SYS_ID, WH_CD, PARTY_NAME, DRIVER, VEHICLE_NO" +
        //						", MOBILE_NO, DIST, BAG_NOS, NETT_QTY, GROSS_QTY, ECHIT_NO, GST_NO, DATE_FORMAT(OUT_TIME, '%d/%m/%Y %H:%i:%s') AS OUT_TIME, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, DESP_PLACE " +
        //						$"FROM MDA_HEADER WHERE (PLANT_ID, MDA_SYS_ID, MDA_NO, DI_NO) IN({string.Join(", ", checkValues)}) AND OUT_TIME IS NOT NULL");

        //			if (dtSql != null && dtSql.Rows.Count > 0)
        //			{
        //				foreach (DataRow dr in dtSql.Rows)
        //				{
        //					List<OracleParameter> parameters = new List<OracleParameter>();

        //					parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //					parameters.Add(new OracleParameter("OUT_TIME", OracleDbType.Date) { Value = (dr["OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //					parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_UPDATE_MDA_HEADER", parameters, false);

        //				}
        //			}
        //		}

        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_DETAIL")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, MDA_DT" +
        //				", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //				"FROM MDA_DETAIL WHERE 1 = 1 " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")}");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDA_DTL_SYS_ID, long MDA_SYS_ID, string MDA_NO, long PROD_SYS_ID)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}")
        //								, Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
        //				checkValues.Add(checkValue);
        //			}


        //			dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID
        //										FROM MDA_DETAIL 
        //										WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_DTL_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToString($"{row["MDA_NO"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_DTL_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}', {tuple.PROD_SYS_ID})";
        //					checkValues.Add(checkValue);
        //				}


        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID, PROD_SNO, DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i:%s') AS MDA_DT" +
        //				", SHIPMENT_NO, BAG_NOS, NETT_QTY, GROSS_QTY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //				"FROM MDA_DETAIL WHERE (PLANT_ID, MDA_DTL_SYS_ID, MDA_SYS_ID, MDA_NO, PROD_SYS_ID)  " +
        //						"IN (" + string.Join(", ", checkValues) + ")");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();

        //						parameters.Add(new OracleParameter("MDA_DTL_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_DTL_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //						parameters.Add(new OracleParameter("PROD_SNO", OracleDbType.Int64) { Value = (dr["PROD_SNO"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SNO"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_DT", OracleDbType.Date) { Value = (dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("SHIPMENT_NO", OracleDbType.Int64) { Value = (dr["SHIPMENT_NO"] != DBNull.Value ? Convert.ToInt64(dr["SHIPMENT_NO"]) : 0M) });
        //						parameters.Add(new OracleParameter("BAG_NOS", OracleDbType.Int64) { Value = (dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0M) });
        //						parameters.Add(new OracleParameter("NETT_QTY", OracleDbType.Int64) { Value = (dr["NETT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["NETT_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("GROSS_QTY", OracleDbType.Int64) { Value = (dr["GROSS_QTY"] != DBNull.Value ? Convert.ToInt64(dr["GROSS_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });

        //						parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_DETAIL", parameters, false);

        //					}
        //				}
        //			}

        //		}
        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_REQUISITION_DATA")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO, MDA_DATE, SKU_CODE, SKU_NAME" +
        //				", BOTTLE_QTY, CARTON_QTY, LOADING_BAY, LOADING_BAY_SYS_ID, SKU_ORDER, STATUS_CODE, LOADING_STATUS, LOADED_QTY, SHORT_QTY, ADDITIONAL_QTY" +
        //				", REASON, LOADING_PROGRESS, LOADED_ITEM, API_RESULT, API_REMARK, IS_POSTED, LOAD_IN_TIME, LOAD_OUT_TIME " +
        //				"FROM MDA_REQUISITION_DATA WHERE 1 = 1 " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDA_REQ_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID, string TRUCK_NO, string MDA_NO)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_REQ_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
        //								, Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_NO"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_REQ_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_NO}')";
        //				checkValues.Add(checkValue);
        //			}


        //			dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO
        //										FROM MDA_REQUISITION_DATA 
        //										WHERE (PLANT_ID, MDA_REQ_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_REQ_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")
        //								, Convert.ToString($"{row["TRUCK_NO"]}"), Convert.ToString($"{row["MDA_NO"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_REQ_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID}, '{tuple.TRUCK_NO}', '{tuple.MDA_NO}')";
        //					checkValues.Add(checkValue);
        //				}


        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_REQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO, DATE_FORMAT(MDA_DATE, '%d/%m/%Y %H:%i:%s') AS MDA_DATE, SKU_CODE, SKU_NAME" +
        //				", BOTTLE_QTY, CARTON_QTY, LOADING_BAY, LOADING_BAY_SYS_ID, SKU_ORDER, STATUS_CODE, LOADING_STATUS, LOADED_QTY, SHORT_QTY, ADDITIONAL_QTY" +
        //				", REASON, LOADING_PROGRESS, LOADED_ITEM, API_RESULT, API_REMARK, IS_POSTED, DATE_FORMAT(LOAD_IN_TIME, '%d/%m/%Y %H:%i:%s') AS LOAD_IN_TIME, DATE_FORMAT(LOAD_OUT_TIME, '%d/%m/%Y %H:%i:%s') AS LOAD_OUT_TIME " +
        //				$"FROM MDA_REQUISITION_DATA WHERE (PLANT_ID, MDA_REQ_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, TRUCK_NO, MDA_NO) IN({string.Join(", ", checkValues)})");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();

        //						parameters.Add(new OracleParameter("MDA_REQ_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_REQ_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_REQ_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("TRUCK_NO", OracleDbType.NVarchar2) { Value = (dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "") });
        //						parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //						parameters.Add(new OracleParameter("MDA_DATE", OracleDbType.Date) { Value = (dr["MDA_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DATE"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("SKU_CODE", OracleDbType.NVarchar2) { Value = (dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "") });
        //						parameters.Add(new OracleParameter("SKU_NAME", OracleDbType.NVarchar2) { Value = (dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "") });
        //						parameters.Add(new OracleParameter("BOTTLE_QTY", OracleDbType.Int64) { Value = (dr["BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("CARTON_QTY", OracleDbType.Int64) { Value = (dr["CARTON_QTY"] != DBNull.Value ? Convert.ToInt64(dr["CARTON_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("LOADING_BAY", OracleDbType.NVarchar2) { Value = (dr["LOADING_BAY"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY"]) : "") });
        //						parameters.Add(new OracleParameter("LOADING_BAY_SYS_ID", OracleDbType.Int64) { Value = (dr["LOADING_BAY_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["LOADING_BAY_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("SKU_ORDER", OracleDbType.Int64) { Value = (dr["SKU_ORDER"] != DBNull.Value ? Convert.ToInt64(dr["SKU_ORDER"]) : 0M) });
        //						parameters.Add(new OracleParameter("STATUS_CODE", OracleDbType.NVarchar2) { Value = (dr["STATUS_CODE"] != DBNull.Value ? Convert.ToString(dr["STATUS_CODE"]) : "") });
        //						parameters.Add(new OracleParameter("LOADING_STATUS", OracleDbType.NVarchar2) { Value = (dr["LOADING_STATUS"] != DBNull.Value ? Convert.ToString(dr["LOADING_STATUS"]) : "") });
        //						parameters.Add(new OracleParameter("LOADED_QTY", OracleDbType.Int64) { Value = (dr["LOADED_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("SHORT_QTY", OracleDbType.Int64) { Value = (dr["SHORT_QTY"] != DBNull.Value ? Convert.ToInt64(dr["SHORT_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("ADDITIONAL_QTY", OracleDbType.Int64) { Value = (dr["ADDITIONAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["ADDITIONAL_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("REASON", OracleDbType.NVarchar2) { Value = (dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "") });
        //						parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("LOADING_PROGRESS", OracleDbType.NVarchar2) { Value = (dr["LOADING_PROGRESS"] != DBNull.Value ? Convert.ToString(dr["LOADING_PROGRESS"]) : "") });
        //						parameters.Add(new OracleParameter("LOADED_ITEM", OracleDbType.Int64) { Value = (dr["LOADED_ITEM"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_ITEM"]) : 0M) });
        //						parameters.Add(new OracleParameter("API_RESULT", OracleDbType.NVarchar2) { Value = (dr["API_RESULT"] != DBNull.Value ? Convert.ToString(dr["API_RESULT"]) : "") });
        //						parameters.Add(new OracleParameter("API_REMARK", OracleDbType.NVarchar2) { Value = (dr["API_REMARK"] != DBNull.Value ? Convert.ToString(dr["API_REMARK"]) : "") });
        //						parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //						parameters.Add(new OracleParameter("LOAD_IN_TIME", OracleDbType.Date) { Value = (dr["LOAD_IN_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["LOAD_IN_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("LOAD_OUT_TIME", OracleDbType.Date) { Value = (dr["LOAD_OUT_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["LOAD_OUT_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_REQUISITION_DATA", parameters, false);

        //					}
        //				}
        //			}

        //		}
        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_SEQUENCE")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, MDA_SEQUENCE_NO, MDA_STATUS" +
        //			", MDA_REASON, MDA_REMARK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //			", DATE_FORMAT(MDA_STATUS_DATETIME, '%d/%m/%Y %H:%i:%s') AS MDA_STATUS_DATETIME " +
        //				"FROM MDA_SEQUENCE WHERE 1 = 1 " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDA_SEQ_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SEQ_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SEQ_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //				checkValues.Add(checkValue);
        //			}


        //			dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID
        //										FROM MDA_SEQUENCE 
        //										WHERE (PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_SEQ_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["GATE_SYS_ID"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SEQ_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //					checkValues.Add(checkValue);
        //				}


        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, MDA_SEQUENCE_NO, MDA_STATUS" +
        //								", MDA_REASON, MDA_REMARK, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //								", DATE_FORMAT(MDA_STATUS_DATETIME, '%d/%m/%Y %H:%i:%s') AS MDA_STATUS_DATETIME " +
        //								$"FROM MDA_SEQUENCE WHERE (PLANT_ID, MDA_SEQ_SYS_ID, MDA_SYS_ID, GATE_SYS_ID) IN({string.Join(", ", checkValues)})");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();


        //						parameters.Add(new OracleParameter("MDA_SEQ_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SEQ_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SEQ_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_SEQUENCE_NO", OracleDbType.Int64) { Value = (dr["MDA_SEQUENCE_NO"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SEQUENCE_NO"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_STATUS", OracleDbType.NVarchar2) { Value = (dr["MDA_STATUS"] != DBNull.Value ? Convert.ToString(dr["MDA_STATUS"]) : "") });
        //						parameters.Add(new OracleParameter("MDA_REASON", OracleDbType.NVarchar2) { Value = (dr["MDA_REASON"] != DBNull.Value ? Convert.ToString(dr["MDA_REASON"]) : "") });
        //						parameters.Add(new OracleParameter("MDA_REMARK", OracleDbType.NVarchar2) { Value = (dr["MDA_REMARK"] != DBNull.Value ? Convert.ToString(dr["MDA_REMARK"]) : "") });
        //						parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_STATUS_DATETIME", OracleDbType.Date) { Value = (dr["MDA_STATUS_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_STATUS_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_SEQUENCE", parameters, false);

        //					}
        //				}
        //			}

        //		}
        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_INVOICE_QR")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQRCODE, BASE64INVQRCODE" +
        //				", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, IS_DISPATCHED " +
        //				"FROM MDA_INVOICE_QR WHERE 1 = 1 " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDAINVQR_SYS_ID, long GATE_SYS_ID, long MDA_SYS_ID, string MDA_NO)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDAINVQR_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToString($"{row["MDA_NO"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDAINVQR_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}')";
        //				checkValues.Add(checkValue);
        //			}


        //			dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO
        //										FROM MDA_INVOICE_QR 
        //										WHERE (PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, NVL(MDA_SYS_ID, 0), MDA_NO) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDAINVQR_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToString($"{row["MDA_NO"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.MDAINVQR_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, '{tuple.MDA_NO}')";
        //					checkValues.Add(checkValue);
        //				}


        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQRCODE, BASE64INVQRCODE" +
        //				", CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED, IS_DISPATCHED " +
        //				$"FROM MDA_INVOICE_QR WHERE (PLANT_ID, MDAINVQR_SYS_ID, GATE_SYS_ID, IFNULL(MDA_SYS_ID, 0), MDA_NO) IN({string.Join(", ", checkValues)})");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();


        //						parameters.Add(new OracleParameter("MDAINVQR_SYS_ID", OracleDbType.Int64) { Value = (dr["MDAINVQR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDAINVQR_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_NO", OracleDbType.NVarchar2) { Value = (dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "") });
        //						parameters.Add(new OracleParameter("INVOICEQRCODE", OracleDbType.NVarchar2) { Value = (dr["INVOICEQRCODE"] != DBNull.Value ? Convert.ToString(dr["INVOICEQRCODE"]) : "") });
        //						parameters.Add(new OracleParameter("BASE64INVQRCODE", OracleDbType.NVarchar2) { Value = (dr["BASE64INVQRCODE"] != DBNull.Value ? Convert.ToString(dr["BASE64INVQRCODE"]) : 0M) });
        //						parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //						parameters.Add(new OracleParameter("IS_DISPATCHED", OracleDbType.Int64) { Value = (dr["IS_DISPATCHED"] != DBNull.Value ? Convert.ToInt64(dr["IS_DISPATCHED"]) : 0M) });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_INVOICE_QR", parameters, false);

        //					}
        //				}
        //			}

        //		}
        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_ADD_QTY_REQUEST")
        //	{
        //		dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON" +
        //			", REQUEST_STATUS, RESPONSE_MSG, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //				"FROM MDA_ADD_QTY_REQUEST WHERE 1 = 1 " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} ");

        //		if (dtSql != null && dtSql.Rows.Count > 0)
        //		{
        //			List<string> checkValues = new List<string>();

        //			List<(long PLANT_ID, long MDA_ADD_SYS_ID, long GATE_SYS_ID, long MDA_SYS_ID, long PROD_SYS_ID)>
        //				idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_ADD_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["MDA_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

        //			foreach (var tuple in idsToFilter)
        //			{
        //				string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_ADD_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.PROD_SYS_ID})";
        //				checkValues.Add(checkValue);
        //			}


        //			dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID
        //										FROM MDA_ADD_QTY_REQUEST 
        //										WHERE (PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID) 
        //										IN ({string.Join(", ", checkValues)})");

        //			checkValues = new List<string>();

        //			if (dtOracle != null && dtOracle.Rows.Count > 0)
        //				idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_ADD_SYS_ID"]}")
        //								, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

        //			if (idsToFilter != null && idsToFilter.Count() > 0)
        //			{
        //				foreach (var tuple in idsToFilter)
        //				{
        //					string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_ADD_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.PROD_SYS_ID})";
        //					checkValues.Add(checkValue);
        //				}

        //				dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER_QTY, REASON" +
        //						", REQUEST_STATUS, RESPONSE_MSG, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //						"FROM MDA_ADD_QTY_REQUEST WHERE (PLANT_ID, MDA_ADD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID) " +
        //						"IN (" + string.Join(", ", checkValues) + ")");

        //				if (dtSql != null && dtSql.Rows.Count > 0)
        //				{
        //					foreach (DataRow dr in dtSql.Rows)
        //					{
        //						List<OracleParameter> parameters = new List<OracleParameter>();

        //						parameters.Add(new OracleParameter("MDA_ADD_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_ADD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_ADD_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("REQUIRED_SHIPPER_QTY", OracleDbType.Int64) { Value = (dr["REQUIRED_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER_QTY"]) : 0M) });
        //						parameters.Add(new OracleParameter("REASON", OracleDbType.Varchar2) { Value = (dr["REASON"] != DBNull.Value ? Convert.ToString(dr["REASON"]) : "") });
        //						parameters.Add(new OracleParameter("REQUEST_STATUS", OracleDbType.Varchar2) { Value = (dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "") });
        //						parameters.Add(new OracleParameter("RESPONSE_MSG", OracleDbType.Varchar2) { Value = (dr["RESPONSE_MSG"] != DBNull.Value ? Convert.ToString(dr["RESPONSE_MSG"]) : "") });

        //						parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //						parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //						parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });

        //						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_ADD_QTY_REQUEST", parameters, false);

        //					}
        //				}
        //			}

        //		}
        //	}

        //	if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "MDA_LOADING")
        //	{
        //		//var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //		//		", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //		//		", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
        //		//		"FROM MDA_LOADING WHERE IFNULL(SHIPPER_QR_CODE,'') != '' AND CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //		//		$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //		//		$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
        //		//		$"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) NOT IN ({string.Join(", ", _checkValues)})" : "")} " +
        //		//		$"ORDER BY MDA_LOD_SYS_ID DESC ");

        //		dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
        //			$"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID");

        //		List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
        //			_idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //							, (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //							, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();

        //		var dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_SYS_ID, GATE_SYS_ID, COUNT(*) CNT " +
        //				"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
        //				"GROUP BY PLANT_ID, MDA_SYS_ID, GATE_SYS_ID ");

        //		List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long CNT)>
        //			_idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //							, (long)0, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //							, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["CNT"]}"))).ToList();


        //		var notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

        //		List<string> _checkValues = new List<string>();

        //		foreach (var tuple in notInOracle)
        //		{
        //			string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //			_checkValues.Add(checkValue);
        //		}

        //		dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
        //			$"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
        //			"AND (PLANT_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
        //			$"IN ({string.Join(", ", _checkValues)})");

        //		_idsToFilter_Oracle = dtOracle.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //							, Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //							, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

        //		dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID " +
        //				"FROM MDA_LOADING WHERE PLANT_ID = " + plant_id + " " +
        //				"AND (PLANT_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) " +
        //				$"IN ({string.Join(", ", _checkValues)}) ");

        //		_idsToFilter_Sql = dtSql_All.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}")
        //							, Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}"), (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0)
        //							, Convert.ToInt64($"{row["GATE_SYS_ID"]}"), (long)0)).ToList();

        //		notInOracle = _idsToFilter_Sql.Except(_idsToFilter_Oracle).ToList();

        //		_checkValues = new List<string>();

        //		foreach (var tuple in notInOracle)
        //		{
        //			string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID})";
        //			_checkValues.Add(checkValue);
        //		}

        //		dtSql_All = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //				", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED" +
        //				", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
        //				"FROM MDA_LOADING WHERE IFNULL(SHIPPER_QR_CODE,'') != '' AND CREATED_DATETIME > STR_TO_DATE('15/06/2024', '%d/%m/%Y') " +
        //				$"{(ids_GateInOut.Count() > 0 ? " AND GATE_SYS_ID IN (" + string.Join(", ", ids_GateInOut) + ")" : "")} " +
        //				$"{(ids_MDA.Count() > 0 ? " AND MDA_SYS_ID IN (" + string.Join(", ", ids_MDA) + ")" : "")} " +
        //				$"{(_checkValues.Count() > 0 ? $" AND (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID) IN ({string.Join(", ", _checkValues)})" : "")} " +
        //				$"ORDER BY MDA_LOD_SYS_ID DESC ");

        //		if (dtSql_All != null && dtSql_All.Rows.Count > 0)
        //		{
        //			int chunkSize = 5000;

        //			int numberOfTasks = (int)Math.Ceiling((double)dtSql_All.Rows.Count / chunkSize);

        //			Task[] tasks = new Task[numberOfTasks];

        //			for (int i = 0; i < numberOfTasks; i++)
        //			{
        //				int start_Index = i * chunkSize;
        //				tasks[i] = Task.Run(() =>
        //				{
        //					try
        //					{
        //						dtSql = dtSql_All.AsEnumerable()
        //						.Skip(start_Index)
        //						.Take(chunkSize)
        //						.CopyToDataTable();

        //						List<string> checkValues = new List<string>();

        //						List<(long PLANT_ID, long MDA_LOD_SYS_ID, long MDA_SYS_ID, long GATE_SYS_ID, long PROD_SYS_ID)>
        //							idsToFilter = dtSql.AsEnumerable().Select(row => (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
        //											, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}"))).ToList();

        //						foreach (var tuple in idsToFilter)
        //						{
        //							string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
        //							checkValues.Add(checkValue);
        //						}

        //						dtOracle = DataContext.ExecuteQuery(@$"SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID 
        //														FROM MDA_LOADING 
        //														WHERE (PLANT_ID, MDA_LOD_SYS_ID, NVL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) 
        //														IN ({string.Join(", ", checkValues)})");

        //						checkValues = new List<string>();

        //						if (dtOracle != null && dtOracle.Rows.Count > 0)
        //							idsToFilter = idsToFilter.Where(x => !dtOracle.AsEnumerable().Any(row => x == (Convert.ToInt64($"{row["PLANT_ID"]}"), Convert.ToInt64($"{row["MDA_LOD_SYS_ID"]}")
        //											, (row["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64($"{row["MDA_SYS_ID"]}") : 0), Convert.ToInt64($"{row["GATE_SYS_ID"]}"), Convert.ToInt64($"{row["PROD_SYS_ID"]}")))).ToList();

        //						if (idsToFilter != null && idsToFilter.Count() > 0)
        //						{
        //							foreach (var tuple in idsToFilter)
        //							{
        //								string checkValue = $"({tuple.PLANT_ID}, {tuple.MDA_LOD_SYS_ID}, {tuple.MDA_SYS_ID}, {tuple.GATE_SYS_ID}, {tuple.PROD_SYS_ID})";
        //								checkValues.Add(checkValue);
        //							}

        //							dtSql = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, MDA_LOD_SYS_ID, MDA_SYS_ID, GATE_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //									", SHIPPER_QR_CODE, IS_MANUAL_SCAN, CREATED_BY_ID, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME, IS_POSTED " +
        //									", DATE_FORMAT(ENTRY_TIME, '%d/%m/%Y %H:%i:%s') AS ENTRY_TIME " +
        //									$"FROM MDA_LOADING WHERE (PLANT_ID, MDA_LOD_SYS_ID, IFNULL(MDA_SYS_ID, 0), GATE_SYS_ID, PROD_SYS_ID) IN({string.Join(", ", checkValues)})");

        //							if (dtSql != null && dtSql.Rows.Count > 0)
        //							{
        //								int startIndex = 0;

        //								while (startIndex < dtSql.Rows.Count)
        //								{
        //									DataTable nextBatch = dtSql.AsEnumerable()
        //										.Skip(startIndex)
        //										.Take(1000)
        //										.CopyToDataTable();

        //									var sqlQuery = "INSERT INTO PRD.MDA_LOADING (MDA_LOD_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, PROD_SYS_ID, REQUIRED_SHIPPER, LOADED_SHIPPER" +
        //										", SHIPPER_QR_CODE, IS_MANUAL_SCAN, ENTRY_TIME, CREATED_BY_ID, CREATED_DATETIME, PLANT_ID, IS_POSTED) ";

        //									var sqlQuery_Select = "";

        //									foreach (DataRow dr in nextBatch.Rows)
        //									{
        //										try
        //										{
        //											if ((dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0) > 0)
        //											{
        //												sqlQuery_Select += $"SELECT {(dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0)} MDA_LOD_SYS_ID" +
        //													$", {(dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0)} GATE_SYS_ID" +
        //													$", {(dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0)} MDA_SYS_ID" +
        //													$", {(dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)} PROD_SYS_ID" +
        //													$", {(dr["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER"]) : 0)} REQUIRED_SHIPPER" +
        //													$", {(dr["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_SHIPPER"]) : 0)} LOADED_SHIPPER" +
        //													$", '{(dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "")}' SHIPPER_QR_CODE" +
        //													$", {(dr["IS_MANUAL_SCAN"] != DBNull.Value ? Convert.ToInt64(dr["IS_MANUAL_SCAN"]) : 0)} IS_MANUAL_SCAN" +
        //													$", TO_DATE('{(dr["ENTRY_TIME"] != DBNull.Value ? Convert.ToString(dr["ENTRY_TIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS')  ENTRY_TIME" +
        //													$", {(dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0)} CREATED_BY_ID" +
        //													$", TO_DATE('{(dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI:SS') CREATED_DATETIME" +
        //													$", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
        //													$", {(dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0)} IS_POSTED " +
        //													$" FROM DUAL UNION ";
        //											}

        //										}
        //										catch (Exception) { continue; }
        //									}

        //									if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //										sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //									sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

        //									DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

        //									startIndex += 1000;
        //								}


        //								//foreach (DataRow dr in dtSql.Rows)
        //								//{
        //								//	List<OracleParameter> parameters = new List<OracleParameter>();

        //								//	parameters.Add(new OracleParameter("MDA_LOD_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("GATE_SYS_ID", OracleDbType.Int64) { Value = (dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("MDA_SYS_ID", OracleDbType.Int64) { Value = (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("PROD_SYS_ID", OracleDbType.Int64) { Value = (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("REQUIRED_SHIPPER", OracleDbType.Int64) { Value = (dr["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["REQUIRED_SHIPPER"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("LOADED_SHIPPER", OracleDbType.Int64) { Value = (dr["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_SHIPPER"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("SHIPPER_QR_CODE", OracleDbType.NVarchar2) { Value = (dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "") });
        //								//	parameters.Add(new OracleParameter("IS_MANUAL_SCAN", OracleDbType.Int64) { Value = (dr["IS_MANUAL_SCAN"] != DBNull.Value ? Convert.ToInt64(dr["IS_MANUAL_SCAN"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("CREATED_BY_ID", OracleDbType.Int64) { Value = (dr["CREATED_BY_ID"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY_ID"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("CREATED_DATETIME", OracleDbType.Date) { Value = (dr["CREATED_DATETIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["CREATED_DATETIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });
        //								//	parameters.Add(new OracleParameter("PLANT_ID", OracleDbType.Int64) { Value = (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("IS_POSTED", OracleDbType.Int64) { Value = (dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt64(dr["IS_POSTED"]) : 0M) });
        //								//	parameters.Add(new OracleParameter("ENTRY_TIME", OracleDbType.Date) { Value = (dr["ENTRY_TIME"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ENTRY_TIME"]).Replace("-", "/"), "dd/MM/yyyy HH:mm:ss", CultureInfo.InvariantCulture) : nullDateTime) });

        //								//	var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SAVE_MDA_LOADING", parameters, false);

        //								//}
        //							}
        //						}

        //					}
        //					catch (Exception ex) { }


        //				});
        //			}

        //			Task.WaitAll(tasks);

        //		}
        //	}

        //}


        public static void BulkInsertMySQL(DataTable table, string tableName)
        {
            try
            {
                using (MySqlConnection connection = new MySqlConnection(_connectionString_SQL))
                {
                    connection.Open();

                    using (MySqlTransaction tran = connection.BeginTransaction(IsolationLevel.Serializable))
                    {
                        using (MySqlCommand cmd = new MySqlCommand())
                        {
                            cmd.Connection = connection;
                            cmd.Transaction = tran;
                            cmd.CommandText = $"SELECT * FROM " + tableName + " limit 0";

                            using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmd))
                            {
                                adapter.UpdateBatchSize = 10000;
                                using (MySqlCommandBuilder cb = new MySqlCommandBuilder(adapter))
                                {
                                    cb.SetAllValues = true;
                                    adapter.Update(table);
                                    tran.Commit();
                                }
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void BulkInsertOracle(DataTable table, string tableName)
        {
            try
            {
                using (OracleConnection connection = new OracleConnection(_connectionString_Oracle))
                {
                    connection.Open();

                    using (OracleTransaction tran = connection.BeginTransaction(IsolationLevel.Serializable))
                    {
                        using (OracleCommand cmd = new OracleCommand())
                        {
                            cmd.Connection = connection;
                            cmd.Transaction = tran;
                            cmd.CommandText = $"SELECT * FROM " + tableName + " ROWNUM = 0";

                            using (OracleDataAdapter adapter = new OracleDataAdapter(cmd))
                            {
                                adapter.UpdateBatchSize = 10000;
                                using (OracleCommandBuilder cb = new OracleCommandBuilder(adapter))
                                {
                                    cb.SetAllValues = true;
                                    adapter.Update(table);
                                    tran.Commit();
                                }
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static DataTable FN_GATE_IN_OUT_MDA_GET(Int64 PLANT_ID = 0, Int64 GATE_SYS_ID = 0, Int64 MDA_SYS_ID = 0, string P_SEARCH_TERM = "")
        {
            DataTable dt = new DataTable();
            try
            {
                //var strQuery = @$"WITH TBL_MAIN AS (SELECT 
                //		TRIM(SUBSTRING_INDEX(input_string, ',', 1)) AS PLANT_ID,
                //		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 2), ',', -1)) AS GATE_SYS_ID,
                //		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 3), ',', -1)) AS MDA_SYS_ID,
                //		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 4), ',', -1)) AS MDA_NO,
                //		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 5), ',', -1)) AS VEHICLE_NO,
                //		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 6), ',', -1)) AS MDA_DT,
                //		TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, ',', 7), ',', -1)) AS OUT_TIME
                //	FROM (SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(input_string, '#', n.digit+1), '#', -1)) AS input_string
                //                                FROM (
                //                                    SELECT FN_GATE_IN_OUT_MDA_GET({PLANT_ID}, {GATE_SYS_ID}, {MDA_SYS_ID}, '{P_SEARCH_TERM}') AS input_string
                //                                ) AS data
                //                                CROSS JOIN (
                //                                    SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
                //                                ) AS n WHERE n.digit < LENGTH(input_string) - LENGTH(REPLACE(input_string, '#', '')) + 1) X)
                //            SELECT * FROM TBL_MAIN M_G
                //            WHERE IFNULL(M_G.OUT_TIME, '') = '' "; // DATE_FORMAT(STR_TO_DATE(MDA_DT, '%d/%m/%Y %H:%i'), '%d/%m/%Y %H:%i') = (SELECT DATE_FORMAT(MDA_DT, '%d/%m/%Y %H:%i') FROM (SELECT MAX(STR_TO_DATE(MDA_DT, '%d/%m/%Y %H:%i'))MDA_DT FROM TBL_MAIN) Z)";

                var strQuery = @$"SELECT DISTINCT GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO VEHICLE_NO, MH.MDA_SYS_ID, MH.MDA_NO
									FROM fg_gate_in_out GIO
									INNER JOIN mda_header MH ON GIO.PLANT_ID = MH.PLANT_ID AND FIND_IN_SET(MH.MDA_SYS_ID, GIO.MDA_SYS_IDS) > 0
									LEFT JOIN mda_detail MD ON MD.PLANT_ID = MH.PLANT_ID AND MD.MDA_SYS_ID = MH.MDA_SYS_ID
									WHERE MH.PLANT_ID = {PLANT_ID} AND COALESCE(GIO.CANCEL_GATE_IN, 0) = 0
									AND GIO.GATE_OUT_DT IS NULL AND MH.OUT_TIME IS NULL
									AND GIO.GATE_SYS_ID = {GATE_SYS_ID}
									AND 0 < (SELECT COUNT(*) FROM FG_WEIGHMENT_DETAIL XZ WHERE XZ.GATE_SYS_ID = GIO.GATE_SYS_ID 
									AND IFNULL(XZ.TARE_WT,0) > 0 AND XZ.TARE_WT_DT IS NOT NULL AND IFNULL(XZ.GROSS_WT,0) > 0 AND XZ.GROSS_WT_DT IS NOT NULL)
									AND 0 < (SELECT COUNT(*) FROM MDA_LOADING ML WHERE ML.PLANT_ID = GIO.PLANT_ID AND ML.GATE_SYS_ID = GIO.GATE_SYS_ID 
									AND ML.MDA_SYS_ID = MH.MDA_SYS_ID AND ML.PROD_SYS_ID = MD.PROD_SYS_ID)
									ORDER BY GIO.PLANT_ID, GIO.GATE_SYS_ID, GIO.TRUCK_NO, MH.MDA_SYS_ID, MH.MDA_NO DESC";

                dt = DataContext.ExecuteQuery_SQL(strQuery);

            }
            catch (Exception ex) { }

            return dt;
        }
    }

}
