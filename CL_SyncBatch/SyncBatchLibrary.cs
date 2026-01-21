using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Org.BouncyCastle.Utilities.Encoders;
using System.Data;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace CL_SyncBatch
{
	public class SyncBatchProcessor
	{
		private readonly string _plantCode;
		private readonly long _plantId;
		private readonly string _logFilePath;
		private readonly string _sourceFolderPath;
		private readonly string _destinationFolderPath;
		private readonly string _errorFolderPath;
		private readonly int _manufacture_Date_Before;
		private readonly int _manufacture_Date_After;

		public SyncBatchProcessor(long plantId, string plantCode, string logFilePath, string sourceFolderPath, string destinationFolderPath, string errorFolderPath
			, int manufacture_Date_Before, int manufacture_Date_After, string connectionString_SQL, string connectionString_Oracle)
		{
			_plantId = plantId;
			_plantCode = plantCode;
			_logFilePath = logFilePath;
			_sourceFolderPath = sourceFolderPath;
			_destinationFolderPath = destinationFolderPath;
			_errorFolderPath = errorFolderPath;
			_manufacture_Date_Before = manufacture_Date_Before;
			_manufacture_Date_After = manufacture_Date_After;

			DataContextService.Configure(connectionString_SQL, connectionString_Oracle, logFilePath);
		}

		public (bool IsSuccess, string Message, List<string> Errors) Process(string searchTerm = null)
		{
			(bool IsSuccess, string Message, List<string> Errors) _result = (false, "", new List<string>());

			if (!System.IO.Directory.Exists(_sourceFolderPath))
				System.IO.Directory.CreateDirectory(_sourceFolderPath);

			if (!System.IO.Directory.Exists(_destinationFolderPath))
				System.IO.Directory.CreateDirectory(_destinationFolderPath);

			if (!System.IO.Directory.Exists(_errorFolderPath))
				System.IO.Directory.CreateDirectory(_errorFolderPath);


			List<string> sourceFilePaths = Directory.GetFiles(_sourceFolderPath, "*.json", SearchOption.AllDirectories).ToList();
			List<string> destinationFilePaths = Directory.GetFiles(_destinationFolderPath, "*.json", SearchOption.AllDirectories).ToList();

			if (destinationFilePaths == null) destinationFilePaths = new List<string>() { "" };

			var dt = new DataTable();

			Write_Log($"File(s) Processing Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}", _logFilePath);

			if (!string.IsNullOrEmpty(searchTerm))
			{
				if (sourceFilePaths == null) sourceFilePaths = new List<string>() { "" };

				List<string> sourceFilePaths_ = Directory.GetFiles(_errorFolderPath, "*.json", SearchOption.AllDirectories).ToList();

				if (sourceFilePaths_ != null && sourceFilePaths_.Count() > 0 && sourceFilePaths_.Any(x => x.Contains(searchTerm)))
					sourceFilePaths.AddRange(sourceFilePaths_.Where(x => x.Contains(searchTerm)).ToList());

				if (sourceFilePaths != null && sourceFilePaths.Count() > 0 && sourceFilePaths.Any(x => x.Contains(searchTerm)))
					sourceFilePaths = sourceFilePaths.Where(x => x.Contains(searchTerm)).ToList();

				//destinationFilePaths = new List<string>() { "" };
			}

			if (sourceFilePaths != null && sourceFilePaths.Count() > 0)
			{
				List<(long Id, string GTIN, int ExpireInMonth)> listProduct = new List<(long Id, string GTIN, int ExpireInMonth)>();

				dt = DataContextService.ExecuteQuery_SQL("SELECT DISTINCT PROD_SYS_ID, GTIN, VALIDITY_MONTH FROM PRODUCT_MASTER WHERE IFNULL(GTIN, '') != '' ");

				if (dt != null && dt.Rows.Count > 0)
					listProduct = (from DataRow dr in dt.Rows
								   select (Id: (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)
								   , GSTIN: (dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "")
								   , ExpireInMonth: (dr["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["VALIDITY_MONTH"]) : 0))).ToList();

				var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

				foreach (var sourceFilePath in orderedFilePaths.Where(x => !x.Trim().Contains("_Error") && !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
				{
					if (!System.IO.File.Exists(sourceFilePath)) continue;

					var currentDateTime = DateTime.Now;

					Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
						$"Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}", _logFilePath);

					List<(string QRCode, string BottleQRCodes, string Type)> listShipperQRCode_Duplicate = new List<(string QRCode, string BottleQRCodes, string Type)>();

					//List<(string QRCode, string Type)> listBottleQRCode_Duplicate = new List<(string QRCode, string Type)>();

					var error = "";

					var shipperData = new ShipperData();

					StringBuilder fileContent = new StringBuilder();
					using (StreamReader sr = new StreamReader(sourceFilePath)) { fileContent.Append(sr.ReadToEnd()); }

					dt = new DataTable();

					try
					{
						#region Validate File

						if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
						{
							string fileContent_Str = Convert.ToString(fileContent);

							fileContent_Str = Regex.Replace(fileContent_Str, @"//.*?$", string.Empty, RegexOptions.Multiline);

							fileContent_Str = Regex.Replace(fileContent_Str, @"/\*.*?\*/", string.Empty, RegexOptions.Singleline);

							JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

							shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());
						}

						if (shipperData == null)
							error += $"Invalid data.";

						if (shipperData != null && string.IsNullOrEmpty(shipperData.Batch_no))
							error += $"Batch No is not null." + System.Environment.NewLine;

						if (shipperData != null && (string.IsNullOrEmpty(shipperData.ManufacturedBy) || shipperData.ManufacturedBy.ToLower() == "none"))
							shipperData.ManufacturedBy = "Indian Farmers Fertiliser Cooperative";

						if (shipperData != null && (string.IsNullOrEmpty(shipperData.MarketedBy) || shipperData.MarketedBy.ToLower() == "none"))
							shipperData.MarketedBy = "Indian Farmers Fertiliser Cooperative";

						var Mfg_Date = DateTime.MinValue;
						if (shipperData != null && (string.IsNullOrEmpty(shipperData.Mfg_Date) || !DateTime.TryParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Mfg_Date)))
							error += $"Invalid Manufacture Date.";

						if (Mfg_Date != DateTime.MinValue && (Mfg_Date.Date.Ticks < DateTime.Now.AddMonths(_manufacture_Date_Before).AddDays(1).Date.Ticks || Mfg_Date.Date.Ticks > DateTime.Now.AddMonths(_manufacture_Date_After).AddDays(-1).Date.Ticks))
							error += $"Manufacturing date cannot be more than 1 month old and must not be greater than 1 month from current date." + System.Environment.NewLine;

						int ExpireInMonth = listProduct != null && shipperData != null
							&& shipperData.ShipperQRCode_Data != null && shipperData.ShipperQRCode_Data.Count() > 0
							&& shipperData.ShipperQRCode_Data[0].BottleQRCode != null && shipperData.ShipperQRCode_Data[0].BottleQRCode.Count() > 0
							&& listProduct.Any(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)) ?
							listProduct.Where(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)).Select(y => y.ExpireInMonth).FirstOrDefault() : 0;

						if (ExpireInMonth == 0)
							error += $"Product's Expire In Month not available.";
						else
						{
							shipperData.Expiry_Date = Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("yyMMdd");

							Write_Log($"Manufacture date : {Mfg_Date.ToString("ddMMyyyy")}  ExpiryDate : {Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("ddMMyyyy")}", _logFilePath);
						}

						#endregion

						#region Proccess File

						if (shipperData != null && (shipperData.ShipperQRCode_Data == null || shipperData.ShipperQRCode_Data.Count() == 0))
							error += $"Shipper QR Code Data missing." + System.Environment.NewLine;

						if (string.IsNullOrEmpty(error) && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
						{
							if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")) &&
								shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("add")))
							{
								// Both add and delete found
								for (int i = 0; i < shipperData.ShipperQRCode_Data.Count(); i++)
									if (shipperData.ShipperQRCode_Data[i].Action.ToLower() == "add")
										shipperData.ShipperQRCode_Data[i].Status = "r";
							}

							#region Delete Shipper

							if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
							{
								var loaded_ShipperQRCode = new List<string>();

								var len = 0;

								while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
								{
									dt = DataContextService.ExecuteQuery_SQL($"SELECT SHIPPER_QR_CODE FROM mda_loading WHERE PLANT_ID = {_plantId} AND SHIPPER_QR_CODE IN ("
										+ string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete") && !string.IsNullOrEmpty(x.ShipperQRCode)).ToList()
										.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ") ");

									if (dt != null && dt.Rows.Count > 0)
										loaded_ShipperQRCode.AddRange(dt.AsEnumerable().Select(row => row["SHIPPER_QR_CODE"].ToString()).ToList());
									//else if (dt == null) loaded_ShipperQRCode.AddRange(shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete") && !string.IsNullOrEmpty(x.ShipperQRCode)).ToList()
									//																					.Skip(len).Take(500).Select(x => x.ShipperQRCode).ToList());

									len += 500;
								}

								if (loaded_ShipperQRCode != null && loaded_ShipperQRCode.Where(x => !string.IsNullOrEmpty(x)).Count() > 0)
									listShipperQRCode_Duplicate.Add((string.Join(", ", loaded_ShipperQRCode), "", "NOT_DELETE"));

								shipperData.ShipperQRCode_Data.RemoveAll(x => x.Action.ToLower().Contains("delete") && loaded_ShipperQRCode.Any(z => z == x.ShipperQRCode));
							}

							if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
							{
								var len = 0;

								while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
								{
									bool IsDelete = DataContextService.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + _plantId + " " +
										"AND (plant_id, shipper_qrcode_sysId) IN " +
										"(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + _plantId + " AND LOWER(action) = 'add' " +
										" AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
																						.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

									IsDelete = DataContextService.ExecuteNonQuery_SQL("DELETE FROM shipper_qrcode WHERE plant_id = " + _plantId + " " +
										"AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
																						.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

									IsDelete = DataContextService.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + _plantId + " " +
										"AND (plant_id, shipper_qrcode_sysId) IN " +
										"(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + _plantId + " AND LOWER(action) = 'add' " +
										" AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
																						.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

									IsDelete = DataContextService.ExecuteNonQuery("DELETE FROM shipper_qrcode WHERE plant_id = " + _plantId + " " +
										"AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
																						.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

									len += 500;
								}
							}

							#endregion

							#region Save Shipper

							if (shipperData != null && shipperData.ShipperQRCode_Data != null
								&& shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).Count() > 0)
							{
								shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).ToList();

								var listShipperQRCode = shipperData.ShipperQRCode_Data
														.GroupBy(s => new { ShipperQRCode = s.ShipperQRCode, Action = s.Action, BottleQRCode_Len = s.BottleQRCode != null ? s.BottleQRCode.Count() : 0 })
														.Select(x =>
														{
															return new { ShipperQRCode = x.Key.ShipperQRCode, Action = x.Key.Action, Count = x.Count(), Length = x.Key.BottleQRCode_Len };
														}).ToList();

								if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Count() > 0)
									listShipperQRCode_Duplicate.Add((string.Join(",", listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Select(x => x.ShipperQRCode).ToArray()), "", "DUP_SHIPPER"));

								if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Count() > 0)
									listShipperQRCode_Duplicate.Add((string.Join(",", listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Select(x => x.ShipperQRCode).ToArray()), "", "BOTTLE_CNT_SHIPPER"));

								if (listShipperQRCode != null && listShipperQRCode.Count() > 0)
								{
									var len = 0;

									while (len <= listShipperQRCode.Count())
									{
										dt = DataContextService.ExecuteQuery_SQL("SELECT shipper_qrcode FROM SHIPPER_QRCODE " +
											"WHERE LOWER(action) = 'add' AND shipper_qrcode IN (" + string.Join(", ", listShipperQRCode.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

										if (dt != null && dt.Rows.Count > 0) listShipperQRCode_Duplicate.Add((string.Join(",", dt.AsEnumerable().Select(row => row[0].ToString()).ToArray()), "", "DUP_SHIPPER"));

										len += 500;
									}
								}

								// Duplicate Bottle QR code Check Start

								var listBottleQRCode = shipperData.ShipperQRCode_Data//.SelectMany(x => x.BottleQRCode)
																.SelectMany(parent => parent.BottleQRCode.Select(bottleQRCode => new { parent.ShipperQRCode, BottleQRCode = bottleQRCode }))
																.GroupBy(item => item.BottleQRCode)
																.Select(qrCode =>
																{
																	int startIndex = qrCode.Key.IndexOf(")", qrCode.Key.IndexOf(")", 0) + 1);

																	if (startIndex >= 0) return new
																	{
																		ShipperQRCode = qrCode.First().ShipperQRCode,
																		BottleQRCode = qrCode.Key,
																		Count = qrCode.Count(),
																		Length = qrCode.Key.Substring(startIndex + 1, qrCode.Key.Length - startIndex - 1).Length
																	};
																	else return new { ShipperQRCode = qrCode.First().ShipperQRCode, BottleQRCode = qrCode.Key, Count = qrCode.Count(), Length = 0 };
																}).ToList();

								if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Count > 1).Count() > 0)
									foreach (var shipper in listBottleQRCode.Where(qrCode => qrCode.Count > 1).Select(x => x.ShipperQRCode).Distinct().ToList())
									{
										listShipperQRCode_Duplicate.Add((shipper, string.Join(",", listBottleQRCode.Where(qrCode => qrCode.ShipperQRCode == shipper && qrCode.Count > 1)
														.Select((x, index) => $"{(index + 1).ToString().PadLeft(4, ' ')}. {x.BottleQRCode}").ToArray()), "DUP_BOTTLE"));
									}


								if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Length < 12).Count() > 0)
									foreach (var shipper in listBottleQRCode.Where(qrCode => qrCode.Length < 12).Select(x => x.ShipperQRCode).Distinct().ToList())
									{
										listShipperQRCode_Duplicate.Add((shipper, string.Join(",", listBottleQRCode.Where(qrCode => qrCode.ShipperQRCode == shipper && qrCode.Length < 12)
														.Select((x, index) => $"{(index + 1).ToString().PadLeft(4, ' ')}. {x.BottleQRCode}").ToArray()), "LEN_BOTTLE"));
									}

								if (listBottleQRCode != null && listBottleQRCode.Count() > 0)
								{
									// Split the list into smaller chunks of 10
									var shippers = listBottleQRCode.GroupBy(item => item.ShipperQRCode).Select(x => x.Key).ToList();

									for (int i = 0; i < shippers.Count; i += 20)
									{
										var currentBatch = shippers.Skip(i).Take(20).ToList();

										// Create a task for each batch
										//var task = Task.Run(() =>
										//{
										var groupedResult = listBottleQRCode.Where(x => currentBatch.Any(z => x.ShipperQRCode == z))
										.Select(x => new { ShipperQRCode = x.ShipperQRCode, BottleQRCode = x.BottleQRCode }).ToList();

										var query = string.Join(", ", groupedResult.Select(x => "'" + x.BottleQRCode + "'").ToArray());
										var dtBottleQRCode_ = DataContextService.ExecuteQuery_SQL("SELECT bottle_qrcode FROM bottle_qrcode WHERE bottle_qrcode IN (" + query + ")");

										if (dtBottleQRCode_ != null && dtBottleQRCode_.Rows.Count > 0)
										{
											var result = groupedResult
												.Where(item => dtBottleQRCode_.AsEnumerable().Any(row => row.Field<string>("bottle_qrcode") == item.BottleQRCode))
												.GroupBy(item => item.ShipperQRCode)  // Group by ShipperQRCode
												.Select(group => (group.Key, string.Join(",", group.Select(item => item.BottleQRCode).Distinct()), "DUP_BOTTLE"))
												.ToList();

											if (result != null && result.Count > 0)
												lock (listShipperQRCode_Duplicate) { listShipperQRCode_Duplicate.AddRange(result); }
										}

										//});

										//tasks.Add(task); // Add the task to the list
									}

									//// Wait for all tasks to complete
									//Task.WhenAll(tasks).Wait();

								}

								shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(x.ShipperQRCode))).ToList();

								if (shipperData.ShipperQRCode_Data != null && shipperData.ShipperQRCode_Data.Count() > 0)
								{
									DataTable dtAvailable = new DataTable();
									DataTable dtShipperQrCode = new DataTable();
									DataTable dtBottleQrCode = new DataTable();

									if (string.IsNullOrEmpty(shipperData.PlantCd) || (shipperData.PlantCd.ToLower() == "none" || shipperData.PlantCd.ToLower() == "null"))
										shipperData.PlantCd = _plantCode;

									var sqlQuery = "";
									bool IsSuccess = false;
									Int64 shipper_Api_Id = 0;

									dt = DataContextService.ExecuteQuery_SQL($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

									if (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) > 0)
									{
										dt = DataContextService.ExecuteQuery_SQL($"SELECT SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

										if (dt != null && dt.Rows.Count > 0)
										{
											shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

											IsSuccess = true;
										}
									}
									else
									{
										dt = DataContextService.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
											$"WHERE LOWER(TABLE_SCHEMA) = '{DataContextService.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode_api') " +
											", TBL_T AS (SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 ID FROM shipper_qrcode_api) " +
											"SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
											"FROM TBL_AI X, TBL_T Z");

										if (dt != null && dt.Rows.Count > 0)
											shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

										sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (   SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
														",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
														", MARKETEDBY, MANUFACTUREDBY, IS_SYNCED, IS_SYNCED_DATETIME) " +
														"VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "' " +
														", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
														", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
														", NOW(), " + _plantId + ", 1, NOW(), " + shipperData.ShipperQRCode_Data.Count() + "" +
														",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "', 1, NOW());";

										IsSuccess = DataContextService.ExecuteNonQuery_SQL(sqlQuery);
									}

									if (IsSuccess == true)
									{
										Int64 shipper_QrCode_Id = 0;
										Int64 shipper_QrCode_Id_Old = 0;

										dt = DataContextService.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
											$"WHERE LOWER(TABLE_SCHEMA) = '{DataContextService.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode') " +
											", TBL_T AS (SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 ID FROM SHIPPER_QRCODE) " +
											"SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
											"FROM TBL_AI X, TBL_T Z");

										if (dt != null && dt.Rows.Count > 0)
											shipper_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

										//dtShipperQrCode = DataContextService.ExecuteQuery_SQL("SELECT * FROM SHIPPER_QRCODE LIMIT 0");

										dtShipperQrCode = new DataTable("SHIPPER_QRCODE");

										dtShipperQrCode.Columns.Add("SHIPPER_QRCODE_SYSID", typeof(long));
										dtShipperQrCode.Columns.Add("SHIPPER_QRCODE", typeof(string));
										dtShipperQrCode.Columns.Add("TOTAL_BOTTLES_QTY", typeof(int));
										dtShipperQrCode.Columns.Add("STATUS", typeof(string));
										dtShipperQrCode.Columns.Add("ACTION", typeof(string));
										dtShipperQrCode.Columns.Add("OLD_SHIPPER_QRCODE_SYSID", typeof(long));
										dtShipperQrCode.Columns.Add("SHIPPER_QRCODE_API_SYSID", typeof(long));
										dtShipperQrCode.Columns.Add("PALLET_QRCODE_API_SYSID", typeof(long));
										dtShipperQrCode.Columns.Add("EVENTTIME", typeof(string));

										for (int i = 0; i < shipperData.ShipperQRCode_Data.Count(); i++)
										{
											shipper_QrCode_Id_Old = 0;

											if (!string.IsNullOrEmpty(shipperData.ShipperQRCode_Data[i].OldShipperQRCode))
											{
												var dt_0 = DataContextService.ExecuteQuery_SQL("SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = '" + shipperData.ShipperQRCode_Data[i].OldShipperQRCode + "' AND PLANT_ID = " + _plantId + " LIMIT 1");

												if (dt_0 != null && dt_0.Rows.Count > 0)
													shipper_QrCode_Id_Old = (dt_0.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt_0.Rows[0][0]) : 0);

											}

											DataRow newRow = dtShipperQrCode.NewRow();

											shipperData.ShipperQRCode_Data[i].Id = shipper_QrCode_Id + i;

											newRow["SHIPPER_QRCODE_SYSID"] = shipperData.ShipperQRCode_Data[i].Id;
											newRow["SHIPPER_QRCODE"] = shipperData.ShipperQRCode_Data[i].ShipperQRCode;
											newRow["TOTAL_BOTTLES_QTY"] = shipperData.ShipperQRCode_Data[i].BottleQRCode.Count();
											newRow["STATUS"] = shipperData.ShipperQRCode_Data[i].Status;
											newRow["ACTION"] = shipperData.ShipperQRCode_Data[i].Action;
											newRow["OLD_SHIPPER_QRCODE_SYSID"] = shipper_QrCode_Id_Old;
											newRow["SHIPPER_QRCODE_API_SYSID"] = shipper_Api_Id;
											newRow["PALLET_QRCODE_API_SYSID"] = 0;
											newRow["EVENTTIME"] = DateTime.ParseExact(shipperData.ShipperQRCode_Data[i].EventTime.ToString(), "yyyy-MM-dd'T'HH:mm:ss.ffffff'Z'", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.AssumeUniversal).ToString();

											dtShipperQrCode.Rows.Add(newRow);
										}


										Int64 bottle_QrCode_Id = 0;

										dt = DataContextService.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
											$"WHERE LOWER(TABLE_SCHEMA) = '{DataContextService.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'bottle_qrcode') " +
											", TBL_T AS (SELECT IFNULL(MAX(bottle_qrcode_sysId), 0) + 1 ID FROM bottle_qrcode) " +
											"SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
											"FROM TBL_AI X, TBL_T Z");

										if (dt != null && dt.Rows.Count > 0)
											bottle_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);


										//dtBottleQrCode = DataContextService.ExecuteQuery_SQL("SELECT * FROM BOTTLE_QRCODE LIMIT 0");

										dtBottleQrCode = new DataTable("BOTTLE_QRCODE");

										dtBottleQrCode.Columns.Add("BOTTLE_QRCODE_SYSID", typeof(long));
										dtBottleQrCode.Columns.Add("BOTTLE_QRCODE", typeof(string));
										dtBottleQrCode.Columns.Add("PRODUCT_ID", typeof(long));
										dtBottleQrCode.Columns.Add("STATUS", typeof(string));
										dtBottleQrCode.Columns.Add("SHIPPER_QRCODE_SYSID", typeof(long));

										for (int x = 0; x < shipperData.ShipperQRCode_Data.Count(); x++)
										{
											long productId = 0;

											for (int i = 0; i < shipperData.ShipperQRCode_Data[x].BottleQRCode.Count(); i++)
											{
												if (productId == 0)
													productId = listProduct.Where(y => shipperData.ShipperQRCode_Data[x].BottleQRCode[i].Contains(y.GTIN)).Select(y => y.Id).FirstOrDefault();

												DataRow newRow = dtBottleQrCode.NewRow();

												newRow["BOTTLE_QRCODE_SYSID"] = bottle_QrCode_Id;
												newRow["BOTTLE_QRCODE"] = shipperData.ShipperQRCode_Data[x].BottleQRCode[i];
												newRow["PRODUCT_ID"] = productId;
												newRow["STATUS"] = shipperData.ShipperQRCode_Data[x].Status;
												newRow["SHIPPER_QRCODE_SYSID"] = shipperData.ShipperQRCode_Data[x].Id;
												
												dtBottleQrCode.Rows.Add(newRow);

												bottle_QrCode_Id = bottle_QrCode_Id + 1;
											}
										}


										// Insert Shipper QR Code in SQL Database

										if (dtShipperQrCode != null && dtShipperQrCode.Rows.Count > 0)
										{
											dtAvailable = DataContextService.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
															$"WHERE PLANT_ID = {_plantId} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}");

											int startIndex = 0;

											while (startIndex < dtShipperQrCode.Rows.Count)
											{
												DataTable nextBatch = dtShipperQrCode.AsEnumerable().Skip(startIndex).Take(1000).CopyToDataTable();

												var table_RowsInSqlNotInOracle = dtShipperQrCode.Clone();

												var rowsInSqlNotInOracle = from row2 in nextBatch.AsEnumerable()
																		   join row1 in dtAvailable.AsEnumerable()
																		   on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE") }
																		   equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE") }
																		   into gj
																		   from subRow in gj.DefaultIfEmpty()
																		   where subRow == null
																		   select row2;

												foreach (var row in rowsInSqlNotInOracle)
													table_RowsInSqlNotInOracle.ImportRow(row);

												if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
												{
													sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME, IS_SYNCED, IS_SYNCED_DATETIME) ";

													var sqlQuery_Select = "";

													foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
													{
														if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
														{
															sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
																$", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
																$", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
																$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
																$", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
																$", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
																$", {_plantId} PLANT_ID" +
																$", {1} CREATED_BY" +
																$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME" +
																$", STR_TO_DATE('{(dr["EVENTTIME"] != DBNull.Value ? Convert.ToDateTime(dr["EVENTTIME"]) : DateTime.MinValue).ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') EVENTTIME" +
																$", 1, NOW() " +
																$" FROM DUAL UNION ";
														}
													}

													if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
														sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

													sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

													IsSuccess = DataContextService.ExecuteNonQuery_SQL(sqlQuery + sqlQuery_Select);
												}

												startIndex += 1000;
											}

										}


										// Insert Shipper QR Code in SQL Database

										if (dtBottleQrCode != null && dtBottleQrCode.Rows.Count > 0)
										{
											dtAvailable = DataContextService.ExecuteQuery_SQL("SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
														$"WHERE PLANT_ID = {_plantId} AND SHIPPER_QRCODE_SYSID " +
														$"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
														$"WHERE PLANT_ID = {_plantId} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})");

											const int chunkSize = 5000;
											const int subChunkSize = 1000;

											int numberOfChunks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);
											var chunkTasks = new List<Task>();

											for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++)
											{
												int chunkStartIndex = chunkIndex * chunkSize;
												DataTable chunkDataTable = dtBottleQrCode.AsEnumerable().Skip(chunkStartIndex).Take(chunkSize).CopyToDataTable();

												var subChunkTasks = new List<Task>();

												int numberOfSubChunks = (int)Math.Ceiling((double)chunkDataTable.Rows.Count / subChunkSize);

												for (int subChunkIndex = 0; subChunkIndex < numberOfSubChunks; subChunkIndex++)
												{
													int subChunkStartIndex = subChunkIndex * subChunkSize;

													DataTable subChunk = chunkDataTable.AsEnumerable().Skip(subChunkStartIndex).Take(subChunkSize).CopyToDataTable();

													var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

													var rowsInSqlNotInOracle = from row2 in subChunk.AsEnumerable()
																			   join row1 in dtAvailable.AsEnumerable()
																			   on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
																			   equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
																			   into gj
																			   from subRow in gj.DefaultIfEmpty()
																			   where subRow == null
																			   select row2;

													foreach (var row in rowsInSqlNotInOracle)
														table_RowsInSqlNotInOracle.ImportRow(row);

													var task = Task.Run(() =>
													{
														if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
														{
															var sqlQuery_Insert = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, IS_SYNCED, IS_SYNCED_DATETIME) ";

															var sqlQuery_Select = "";

															foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
															{
																if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
																{
																	sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
																		$", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
																		$", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
																		$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
																		$", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
																		$", {_plantId} PLANT_ID" +
																		$", {1} CREATED_BY" +
																		$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME " +
																		$", 1, NOW() " +
																		$" FROM DUAL UNION ";
																}
															}

															if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
																sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

															sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

															IsSuccess = DataContextService.ExecuteNonQuery_SQL(sqlQuery_Insert + sqlQuery_Select);
														}
													});

													subChunkTasks.Add(task);
												}

												var chunkTask = Task.WhenAll(subChunkTasks);
												chunkTasks.Add(chunkTask);
											}

											Task.WhenAll(chunkTasks).Wait();
										}

									}

									if (IsSuccess == true)
									{
										dt = DataContextService.ExecuteQuery($"SELECT SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {_plantId} AND BATCH_NO = '{shipperData.Batch_no}'");

										if (dt == null || dt.Rows.Count == 0 || (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) != shipper_Api_Id))
										{
											sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
													",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
													", MARKETEDBY, MANUFACTUREDBY) " +
													"VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "'" +
													", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
													", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
													", SYSDATE, " + _plantId + ", 1, SYSDATE, " + shipperData.ShipperQRCode_Data.Count() + "" +
													",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' )";

											IsSuccess = DataContextService.ExecuteNonQuery(sqlQuery);
										}


										dtAvailable = DataContextService.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
														$"WHERE PLANT_ID = {_plantId} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}");

										int startIndex = 0;

										while (startIndex < dtShipperQrCode.Rows.Count)
										{
											DataTable nextBatch = dtShipperQrCode.AsEnumerable().Skip(startIndex).Take(1000).CopyToDataTable();

											var table_RowsInSqlNotInOracle_Shipper = dtShipperQrCode.Clone();

											var rowsInSqlNotInOracle_Shipper = from row2 in nextBatch.AsEnumerable()
																			   join row1 in dtAvailable.AsEnumerable()
																			   on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE") }
																			   equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE") }
																			   into gj
																			   from subRow in gj.DefaultIfEmpty()
																			   where subRow == null
																			   select row2;

											foreach (var row in rowsInSqlNotInOracle_Shipper)
												table_RowsInSqlNotInOracle_Shipper.ImportRow(row);

											if (table_RowsInSqlNotInOracle_Shipper != null && table_RowsInSqlNotInOracle_Shipper.Rows.Count > 0)
											{
												sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

												var sqlQuery_Select = "";

												foreach (DataRow dr in table_RowsInSqlNotInOracle_Shipper.Rows)
												{
													if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
													{
														sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
															$", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
															$", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
															$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
															$", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
															$", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
															$", {_plantId} PLANT_ID" +
															$", {1} CREATED_BY" +
															$", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME" +
															$", TO_DATE('{(dr["EVENTTIME"] != DBNull.Value ? Convert.ToDateTime(dr["EVENTTIME"]) : DateTime.MinValue).ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') EVENTTIME " +
															$" FROM DUAL UNION ";
													}
												}

												if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
													sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

												sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

												IsSuccess = DataContextService.ExecuteNonQuery(sqlQuery + sqlQuery_Select);
											}

											startIndex += 1000;

										}

										dtAvailable = DataContextService.ExecuteQuery("SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
													$"WHERE PLANT_ID = {_plantId} AND SHIPPER_QRCODE_SYSID " +
													$"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
													$"WHERE PLANT_ID = {_plantId} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})");


										const int chunkSize = 5000;
										const int subChunkSize = 1000;

										int numberOfChunks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);
										var chunkTasks = new List<Task>();

										for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++)
										{
											int chunkStartIndex = chunkIndex * chunkSize;
											DataTable chunkDataTable = dtBottleQrCode.AsEnumerable().Skip(chunkStartIndex).Take(chunkSize).CopyToDataTable();

											var subChunkTasks = new List<Task>();

											int numberOfSubChunks = (int)Math.Ceiling((double)chunkDataTable.Rows.Count / subChunkSize);

											for (int subChunkIndex = 0; subChunkIndex < numberOfSubChunks; subChunkIndex++)
											{
												int subChunkStartIndex = subChunkIndex * subChunkSize;

												DataTable subChunk = chunkDataTable.AsEnumerable().Skip(subChunkStartIndex).Take(subChunkSize).CopyToDataTable();

												var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

												var rowsInSqlNotInOracle = from row2 in subChunk.AsEnumerable()
																		   join row1 in dtAvailable.AsEnumerable()
																		   on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
																		   equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
																		   into gj
																		   from subRow in gj.DefaultIfEmpty()
																		   where subRow == null
																		   select row2;

												foreach (var row in rowsInSqlNotInOracle)
													table_RowsInSqlNotInOracle.ImportRow(row);

												var task = Task.Run(() =>
												{
													if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
													{
														var sqlQuery_Insert = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

														var sqlQuery_Select = "";

														foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
														{
															if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
															{
																sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
																	$", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
																	$", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
																	$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
																	$", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
																	$", {_plantId} PLANT_ID" +
																	$", {1} CREATED_BY" +
																	$", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME " +
																	$" FROM DUAL UNION ";
															}
														}

														if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
															sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

														sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

														IsSuccess = DataContextService.ExecuteNonQuery(sqlQuery_Insert + sqlQuery_Select);
													}
												});

												subChunkTasks.Add(task);
											}

											var chunkTask = Task.WhenAll(subChunkTasks);
											chunkTasks.Add(chunkTask);
										}

										Task.WhenAll(chunkTasks).Wait();

									}

								}
							}

							#endregion
						}

						#endregion

						#region Update Shipper QR Code API - Total Shipper Qty

						if (shipperData != null && !string.IsNullOrEmpty(shipperData.Batch_no))
						{
							var sqlQuery = "UPDATE SHIPPER_QRCODE_API API JOIN ( SELECT SHIPPER_QRCODE_API_SYSID, IFNULL(COUNT(*), 0) AS CNT " +
								$"FROM SHIPPER_QRCODE WHERE (PLANT_ID, SHIPPER_QRCODE_API_SYSID) " +
								$"IN ( SELECT DISTINCT PLANT_ID, SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API " +
								$"WHERE PLANT_ID = {_plantId} AND BATCH_NO = '{shipperData.Batch_no}' ) " +
								"GROUP BY SHIPPER_QRCODE_API_SYSID) QC ON API.SHIPPER_QRCODE_API_SYSID = QC.SHIPPER_QRCODE_API_SYSID " +
								"SET API.total_shipper_qty = IFNULL(QC.CNT, 0) " +
								$"WHERE API.PLANT_ID = {_plantId} AND API.BATCH_NO = '{shipperData.Batch_no}' ";

							var IsSuccess = DataContextService.ExecuteNonQuery_SQL(sqlQuery);

							sqlQuery = "UPDATE SHIPPER_QRCODE_API API SET API.TOTAL_SHIPPER_QTY = ( SELECT NVL(COUNT(*), 0) " +
								"FROM SHIPPER_QRCODE QC WHERE (QC.PLANT_ID, QC.SHIPPER_QRCODE_API_SYSID) " +
								"IN ( SELECT DISTINCT SQA.PLANT_ID, SQA.SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API SQA " +
								$"WHERE SQA.PLANT_ID = {_plantId} AND SQA.BATCH_NO = '{shipperData.Batch_no}' ) " +
								"AND QC.SHIPPER_QRCODE_API_SYSID = API.SHIPPER_QRCODE_API_SYSID) " +
								$"WHERE API.PLANT_ID = {_plantId} AND API.BATCH_NO = '{shipperData.Batch_no}' ";

							IsSuccess = DataContextService.ExecuteNonQuery(sqlQuery);
						}

						#endregion

						#region File Move

						if (string.IsNullOrEmpty(error))
						{
							(string fileName, string fileUploadStatus) = (Path.GetFileName(sourceFilePath), "Error");

							List<JToken> shipperQRCodeData_Success = new List<JToken>();

							List<JToken> shipperQRCodeData_Duplicate = new List<JToken>();

							fileUploadStatus = "Completed";

							string destinationFilePath = Path.Combine(_destinationFolderPath, fileName);
							string errorFilePath = Path.Combine(_errorFolderPath, fileName);

							if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
							{
								string fileContent_Str = Convert.ToString(fileContent);

								fileContent_Str = Regex.Replace(fileContent_Str, @"//.*?$", string.Empty, RegexOptions.Multiline);

								fileContent_Str = Regex.Replace(fileContent_Str, @"/\*.*?\*/", string.Empty, RegexOptions.Singleline);

								JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

								var filteredShipperData = obj.ToObject<JObject>();

								//List<JToken> shipperQRCodeData_Success = filteredShipperData["ShipperQRCode_Data"]
								//						.Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(Convert.ToString(x["ShipperQRCode"])))).ToList<JToken>();

								//List<JToken> shipperQRCodeData_Duplicate = filteredShipperData["ShipperQRCode_Data"]
								//						.Where(x => listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(Convert.ToString(x["ShipperQRCode"])))).ToList<JToken>();

								if (listShipperQRCode_Duplicate != null && listShipperQRCode_Duplicate.Count > 0)
								{
									shipperQRCodeData_Success = filteredShipperData["ShipperQRCode_Data"]
															.Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(Convert.ToString(x["ShipperQRCode"])))).ToList<JToken>();

									shipperQRCodeData_Duplicate = filteredShipperData["ShipperQRCode_Data"]
															.Where(x => listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(Convert.ToString(x["ShipperQRCode"])))).ToList<JToken>();
								}
								else shipperQRCodeData_Success = filteredShipperData["ShipperQRCode_Data"].ToList<JToken>();

								try
								{
									string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
									string fileExtension = Path.GetExtension(sourceFilePath);
									int counter = 1;
									while (System.IO.File.Exists(destinationFilePath))
									{
										string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

										destinationFilePath = Path.Combine(_destinationFolderPath, newFileName);
										counter++;
									}

									fileNameWithoutExtension = Path.GetFileNameWithoutExtension(destinationFilePath);
									fileExtension = Path.GetExtension(destinationFilePath);

									destinationFilePath = Path.Combine(_destinationFolderPath, $"{fileNameWithoutExtension}_{DateTime.Now.ToString("yyyyMMdd_HHmmsss")}{fileExtension}");
									errorFilePath = Path.Combine(_errorFolderPath, $"{fileNameWithoutExtension}_{DateTime.Now.ToString("yyyyMMdd_HHmmsss")}_Error{fileExtension}");

									var fileDelete = true;

									if (shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0)
										try
										{
											if (!System.IO.File.Exists(destinationFilePath))
												try { fileDelete = false; System.IO.File.Create(_destinationFolderPath).Dispose(); fileDelete = true; }
												catch { fileDelete = false; System.IO.File.Copy(sourceFilePath, destinationFilePath); fileDelete = true; }

											filteredShipperData["ShipperQRCode_Data"] = JArray.FromObject(shipperQRCodeData_Success);

											string updatedJson = filteredShipperData.ToString(Formatting.Indented); /*JsonConvert.SerializeObject(shipperData, Formatting.Indented);*/

											System.IO.File.WriteAllText(destinationFilePath, updatedJson);

											Write_Log(fileName + " => " + destinationFilePath, _logFilePath);

											fileDelete = true;
										}
										catch (Exception ex)
										{
											fileDelete = false;

											Write_Log(Environment.NewLine + $"{fileName} => {destinationFilePath} => File Not Created." + Environment.NewLine, _logFilePath);
										}

									var fileDelete_ = true;

									if (shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0)
										try
										{
											if (!System.IO.File.Exists(errorFilePath))
												try { fileDelete_ = false; System.IO.File.Create(errorFilePath).Dispose(); fileDelete_ = true; }
												catch { fileDelete_ = false; System.IO.File.Copy(sourceFilePath, errorFilePath); fileDelete_ = true; }

											filteredShipperData["ShipperQRCode_Data"] = JArray.FromObject(shipperQRCodeData_Duplicate);

											string updatedJson = filteredShipperData.ToString(Formatting.Indented); /*JsonConvert.SerializeObject(shipperData_Error, Formatting.Indented);*/

											System.IO.File.WriteAllText(errorFilePath, updatedJson);

											Write_Log(fileName + " => " + errorFilePath, _logFilePath);

											fileDelete_ = true;
										}
										catch (Exception ex)
										{
											fileDelete_ = false;

											Write_Log(Environment.NewLine + $"{fileName} => {errorFilePath} => File Not Created." + Environment.NewLine, _logFilePath);
										}

									if (fileDelete == true && fileDelete_ == true) System.IO.File.Delete(sourceFilePath);

								}
								catch (Exception ex) { }
							}

							shipperQRCodeData_Success.RemoveAll(x => !((string)x["Action"]).ToLower().Contains("add"));
							shipperQRCodeData_Duplicate.RemoveAll(x => !((string)x["Action"]).ToLower().Contains("add"));

							//listShipperQRCode_Duplicate.RemoveAll(x => !shipperQRCodeData_Duplicate.Any(z => (string)z["ShipperQRCode"] == x.QRCode));

							if (listShipperQRCode_Duplicate != null && listShipperQRCode_Duplicate.Where(x => !string.IsNullOrEmpty(x.QRCode)).Count() > 0)
							{
								error += " | SUMMARY : ";

								if (listShipperQRCode_Duplicate.Any(x => !string.IsNullOrEmpty(x.QRCode) && x.Type != "DUP_SHIPPER" && x.Type != "DUP_BOTTLE"))
								{
									error += $" | Rejected Shipper QR Code : {string.Join(",", listShipperQRCode_Duplicate.Where(x => !string.IsNullOrEmpty(x.QRCode) && x.Type != "DUP_SHIPPER" && x.Type != "DUP_BOTTLE").Select(x => "<S>" + x.QRCode).ToArray())} ";
								}

								if (listShipperQRCode_Duplicate.Any(x => !string.IsNullOrEmpty(x.QRCode) && x.Type == "DUP_SHIPPER"))
								{
									error += $" | Duplicate Shipper QR Code : {string.Join(",", listShipperQRCode_Duplicate.Where(x => !string.IsNullOrEmpty(x.QRCode) && x.Type == "DUP_SHIPPER").Select(x => "<S>" + x.QRCode).ToArray())} ";
								}

								if (listShipperQRCode_Duplicate.Any(x => !string.IsNullOrEmpty(x.QRCode) && x.Type == "DUP_BOTTLE"))
								{
									//error += $" | Duplicate Bottle QR Code : {string.Join(",", listShipperQRCode_Duplicate.Where(x => !string.IsNullOrEmpty(x.QRCode) && x.Type == "DUP_BOTTLE").Select(x => "<S>" + x.QRCode + " - " + x.BottleQRCodes.Split(',').Count()).ToArray())} ";
									error += $" | Duplicate Bottle QR Code : {string.Join(",", listShipperQRCode_Duplicate.Where(x => !string.IsNullOrEmpty(x.QRCode) && x.Type == "DUP_BOTTLE").Select(x => "<S>" + x.QRCode + "<B>" + x.BottleQRCodes).ToArray())} ";
								}

							}

							if (!string.IsNullOrEmpty(error))
							{
								fileUploadStatus = "Error";

								Write_Log(fileName + " => " + error, _logFilePath);
								_result.Errors.Add(fileName + " => " + error);
							}

							listShipperQRCode_Duplicate.RemoveAll(x => x.Type == "NOT_DELETE");

							if (string.IsNullOrEmpty(error) || (listShipperQRCode_Duplicate != null && listShipperQRCode_Duplicate.Count() == 0)) fileUploadStatus = "Completed";

							shipperQRCodeData_Duplicate.RemoveAll(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode == (string)x["ShipperQRCode"]));

							try
							{
								var query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, TOTAL_SHIPPER_QTY, ACCEPTED_SHIPPER_QTY, REJECTED_SHIPPER_QTY, FILESTATUS, REMARK) " +
															$"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
															$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
															$", STR_TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
															//$", {(shipperData.ShipperQRCode_Data.Count() * 24)}" +
															//$", {(shipperData.ShipperQRCode_Data.Count())}" +
															$", {(((shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0 ? shipperQRCodeData_Success.Count() : 0) + (shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0 ? shipperQRCodeData_Duplicate.Count() : 0)) * 24)}" +
															$", {((shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0 ? shipperQRCodeData_Success.Count() : 0) + (shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0 ? shipperQRCodeData_Duplicate.Count() : 0))}" +
														   $", {(shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0 ? shipperQRCodeData_Success.Count() : 0)}" +
														   $", {(shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0 ? shipperQRCodeData_Duplicate.Count() : 0)}" +
														   $", '{fileUploadStatus}', '{error}' );";

								var result = DataContextService.ExecuteNonQuery_SQL(query_File);

								if (string.IsNullOrEmpty(error) || (listShipperQRCode_Duplicate != null && listShipperQRCode_Duplicate.Count() == 0))
								{
									query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, TOTAL_SHIPPER_QTY, ACCEPTED_SHIPPER_QTY, REJECTED_SHIPPER_QTY, FILESTATUS, PLANTCODE, REMARK) " +
									   $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
									   $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
									   $", TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
									   //$", {(shipperData.ShipperQRCode_Data.Count() * 24)}" +
									   //$", {(shipperData.ShipperQRCode_Data.Count())}" +
									   $", {(((shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0 ? shipperQRCodeData_Success.Count() : 0) + (shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0 ? shipperQRCodeData_Duplicate.Count() : 0)) * 24)}" +
									   $", {((shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0 ? shipperQRCodeData_Success.Count() : 0) + (shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0 ? shipperQRCodeData_Duplicate.Count() : 0))}" +
									   $", {(shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0 ? shipperQRCodeData_Success.Count() : 0)}" +
									   $", {(shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0 ? shipperQRCodeData_Duplicate.Count() : 0)}" +
									   $", '{fileUploadStatus}', '{_plantCode}', '{error}' )";

									result = DataContextService.ExecuteNonQuery(query_File);
								}
							}
							catch { }

							error = "";

						}

						#endregion

					}
					catch (JsonReaderException jex)
					{
						error = "Unable to parse JSON. Please check the format of the data.";
						
						if (jex != null)
						{
							var _error = "Error : " + jex.Message.ToString() + Environment.NewLine;

							if (jex.InnerException != null)
							{
								try { _error = _error + " | InnerException: " + jex.InnerException.ToString().Substring(0, (jex.InnerException.ToString().Length > 1000 ? 1000 : jex.InnerException.ToString().Length)); } catch { _error = _error + "InnerException: " + jex.InnerException?.ToString(); }
							}
							if (jex.StackTrace != null)
							{
								try { _error = _error + " | StackTrace: " + jex.StackTrace.ToString().Substring(0, (jex.StackTrace.ToString().Length > 1000 ? 1000 : jex.StackTrace.ToString().Length)); } catch { _error = _error + "InnerException: " + jex.StackTrace?.ToString(); }
							}
							if (jex.Source != null)
							{
								try { _error = _error + " | Source: " + jex.Source.ToString().Substring(0, (jex.Source.ToString().Length > 1000 ? 1000 : jex.Source.ToString().Length)); } catch { _error = _error + "InnerException: " + jex.Source?.ToString(); }
							}
							if (jex.StackTrace == null && jex.Source == null)
							{
								try { _error = _error + " | Exception: " + jex.ToString().Substring(0, (jex.Source.ToString().Length > 3000 ? 3000 : jex.Source.ToString().Length)); } catch { _error = _error + "Exception: " + jex?.ToString(); }
							}

							Write_Log($"File(s) Error at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")} : {_error + Environment.NewLine}", _logFilePath);

						}
					}
					catch (Exception ex)
					{						
						error = (string.IsNullOrEmpty(error) ? "Data not Convert Json to List." : error);

						if (ex != null)
						{
							var _error = "Error : " + ex.Message.ToString() + Environment.NewLine;

							if (ex.InnerException != null)
							{
								try { _error = _error + " | InnerException: " + ex.InnerException.ToString().Substring(0, (ex.InnerException.ToString().Length > 1000 ? 1000 : ex.InnerException.ToString().Length)); } catch { _error = _error + "InnerException: " + ex.InnerException?.ToString(); }
							}
							if (ex.StackTrace != null)
							{
								try { _error = _error + " | StackTrace: " + ex.StackTrace.ToString().Substring(0, (ex.StackTrace.ToString().Length > 1000 ? 1000 : ex.StackTrace.ToString().Length)); } catch { _error = _error + "InnerException: " + ex.StackTrace?.ToString(); }
							}
							if (ex.Source != null)
							{
								try { _error = _error + " | Source: " + ex.Source.ToString().Substring(0, (ex.Source.ToString().Length > 1000 ? 1000 : ex.Source.ToString().Length)); } catch { _error = _error + "InnerException: " + ex.Source?.ToString(); }
							}
							if (ex.StackTrace == null && ex.Source == null)
							{
								try { _error = _error + " | Exception: " + ex.ToString().Substring(0, (ex.Source.ToString().Length > 3000 ? 3000 : ex.Source.ToString().Length)); } catch { _error = _error + "Exception: " + ex?.ToString(); }
							}

							Write_Log($"File(s) Error at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")} : {_error + Environment.NewLine}", _logFilePath);

						}
					}

					if (!string.IsNullOrEmpty(error))
					{
						string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
						string fileExtension = Path.GetExtension(sourceFilePath);

						string errorFilePath = Path.Combine(_errorFolderPath, fileNameWithoutExtension + "." + fileExtension);

						try
						{
							int counter = 1;
							while (System.IO.File.Exists(errorFilePath))
							{
								string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

								errorFilePath = Path.Combine(_destinationFolderPath, newFileName);
								counter++;
							}

							fileNameWithoutExtension = Path.GetFileNameWithoutExtension(errorFilePath);
							fileExtension = Path.GetExtension(errorFilePath);

							errorFilePath = Path.Combine(_errorFolderPath, $"{fileNameWithoutExtension}_{DateTime.Now.ToString("yyyyMMdd_HHmmsss")}_Error{fileExtension}");

							string updatedJson = System.IO.File.ReadAllText(sourceFilePath);

							if (!System.IO.File.Exists(errorFilePath))
								try { System.IO.File.Create(errorFilePath).Dispose(); }
								catch { System.IO.File.Copy(sourceFilePath, errorFilePath); }

							System.IO.File.WriteAllText(errorFilePath, updatedJson);
							System.IO.File.Delete(sourceFilePath);
						}
						catch { }

						try
						{
							Write_Log(sourceFilePath + " => " + errorFilePath, _logFilePath);

							(string fileName, string fileUploadStatus) = (Path.GetFileName(sourceFilePath), "Error");

							var query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, TOTAL_SHIPPER_QTY, ACCEPTED_SHIPPER_QTY, REJECTED_SHIPPER_QTY, FILESTATUS, REMARK) " +
														$"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
														$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
														$", STR_TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i'), 0, 0, 0, 0, '{fileUploadStatus}', '{error}' );";

							var result = DataContextService.ExecuteNonQuery_SQL(query_File);

						}
						catch (Exception) { }
					}

					Write_Log((string.IsNullOrEmpty(error) ? "" : "Error : " + error + Environment.NewLine) + Environment.NewLine + $"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
						$"Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}", _logFilePath);
				}
			}
			else
			{
				_result.Errors.Add("No any file(s) to upload data");

				Write_Log(Environment.NewLine + $"No any file(s) to upload data." + Environment.NewLine, _logFilePath);
			}

			Write_Log(Environment.NewLine + $"File(s) Processing Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}" + Environment.NewLine, _logFilePath);

			_result.IsSuccess = true;
			_result.Message = "Batch file(s) update soon.";

			return _result;
		}


		private void Write_Log(string text, string filePath)
		{
			if (!string.IsNullOrEmpty(text))
			{
				filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd"));
				filePath = filePath.Replace("<HH>", DateTime.Now.ToString("HH"));
				filePath = filePath.Replace("<TT>", DateTime.Now.ToString("tt"));

				if (!System.IO.Directory.Exists(Path.GetDirectoryName(filePath)))
					System.IO.Directory.CreateDirectory(Path.GetDirectoryName(filePath));

				if (!System.IO.File.Exists(filePath))
					System.IO.File.Create(filePath).Dispose();

				if (!System.IO.Directory.Exists(Path.GetDirectoryName(filePath)))
					System.IO.Directory.CreateDirectory(Path.GetDirectoryName(filePath));

				if (!System.IO.File.Exists(filePath))
					System.IO.File.Create(filePath).Dispose();

				using (StreamWriter sw = System.IO.File.AppendText(filePath))
					sw.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text + System.Environment.NewLine);

			}
		}


	}


	public class ShipperData
	{
		[JsonIgnore]
		public decimal Id { get; set; }
		public string ServiceID { get; set; }
		public string Token { get; set; }
		public string PlantCd { get; set; }
		public string Batch_no { get; set; }
		public string Mfg_Date { get; set; }
		public string Expiry_Date { get; set; }
		public string ManufacturedBy { get; set; }
		public string MarketedBy { get; set; }

		public List<ShipperEvent> ShipperQRCode_Data { get; set; }
	}

	public class ShipperEvent
	{
		[JsonIgnore]
		public decimal Id { get; set; }
		[JsonIgnore]
		public decimal ShipperId { get; set; }
		public string EventTime { get; set; }
		public string ShipperQRCode { get; set; }
		public string OldShipperQRCode { get; set; }
		public string Action { get; set; }
		public string BottlesQuantity { get; set; }
		[JsonIgnore] public string Status { get; set; }

		public List<string> BottleQRCode { get; set; }
	}

	public class ShipperBottle
	{
		public decimal Id { get; set; }
		[JsonIgnore]
		public decimal ShipperEventId { get; set; }
		public string BottleQRCode { get; set; }
	}

	public class ShipperBatch
	{
		public Int64 SrNo { get; set; }
		public long Id { get; set; }
		public string ShipperQRCode { get; set; }
		public string Batch_no { get; set; }
		public string mfg_dt { get; set; }
		public string expiry_dt { get; set; }
		public string QR_Codes { get; set; }
		public string Reject_Reason { get; set; }
		public string Status { get; set; }

	}


	public class CustomFileOrderComparer : IComparer<string>
	{
		public int Compare(string x, string y)
		{
			// Customize the comparison logic based on your requirements
			if (x.EndsWith("_Delete.json") && !y.EndsWith("_Delete.json"))
			{
				return 1; // x comes after y
			}
			else if (!x.EndsWith("_Delete.json") && y.EndsWith("_Delete.json"))
			{
				return -1; // x comes before y
			}
			else
			{
				// If neither ends with "_Delete.json", or both do, use default string comparison
				return string.Compare(x, y);
			}
		}
	}
}
