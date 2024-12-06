using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using QRCoder;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.Text;

namespace Dispatch_System.Controllers
{
	[Area("Dispatch")]
	public class LoadBatchController : BaseController<ResponseModel<LoginViewModel>>
	{
		#region Loading
		public LoadBatchController() { }

		public IActionResult Index()
		{
			try
			{
				if (!Common.IsUserLogged())
					return RedirectToAction("Login", "Home", new { Area = "" });

				string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Source_Folder_Path").Value ?? "");
				string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Destination_Folder_Path").Value ?? "");

				CommonViewModel.Data1 = sourceFolderPath;
			}

			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			return View(CommonViewModel);
		}
		#endregion

		#region Methods

		[HttpPost]
		public IActionResult GetUpdate()
		{
			try
			{
				string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Source_Folder_Path").Value ?? "");
				string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Destination_Folder_Path").Value ?? "");

				string[] sourceFilePaths =  Directory.GetFiles(sourceFolderPath, "*.json", SearchOption.AllDirectories);
				string[] destinationFilePaths = Directory.GetFiles(destinationFolderPath, "*.json", SearchOption.AllDirectories);

				if (destinationFilePaths == null)
					destinationFilePaths = new string[] { "" };

				List<string> errors = new List<string>();

				if (sourceFilePaths != null && sourceFilePaths.Length > 0)
				{
					var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

					foreach (var sourceFilePath in orderedFilePaths.Where(x => !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
					{
						var error = "";

						var shipperData = new ShipperData();

						StringBuilder sb = new StringBuilder();
						using (StreamReader sr = new StreamReader(sourceFilePath)) { sb.Append(sr.ReadToEnd()); }

						try
						{
							if (!string.IsNullOrEmpty(Convert.ToString(sb)))
							{
								JToken obj = JObject.Parse(Convert.ToString(sb));

								shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());
							}

							if (shipperData != null && shipperData.ShipperQRCode_Data.Count > 0)
							{
								var dt = new DataTable();

								dt.Columns.AddRange(new DataColumn[6] {
									new DataColumn("Id", typeof(long)),
									new DataColumn("EventTime", typeof(string)),
									new DataColumn("ShipperQRCode", typeof(string)),
									new DataColumn("Action", typeof(string)),
									new DataColumn("BottlesQuantity", typeof(string)),
									new DataColumn("BottleQRCode", typeof(string)) });

								for (int i = 0; i < shipperData.ShipperQRCode_Data.Count; i++)
									dt.Rows.Add(i + 1, shipperData.ShipperQRCode_Data[i].EventTime, shipperData.ShipperQRCode_Data[i].ShipperQRCode, shipperData.ShipperQRCode_Data[i].Action
										, shipperData.ShipperQRCode_Data[i].BottlesQuantity, (shipperData.ShipperQRCode_Data[i].BottleQRCode.Count > 0 ? string.Join("|", shipperData.ShipperQRCode_Data[i].BottleQRCode) : ""));

								List<MySqlParameter> spCol = new List<MySqlParameter>();

								spCol.Add(new MySqlParameter("ServiceID", MySqlDbType.VarChar) { Value = shipperData.ServiceID });
								spCol.Add(new MySqlParameter("Token", MySqlDbType.VarChar) { Value = shipperData.Token });
								spCol.Add(new MySqlParameter("PlantCd", MySqlDbType.VarChar) { Value = shipperData.PlantCd });
								spCol.Add(new MySqlParameter("Batch_no", MySqlDbType.VarChar) { Value = shipperData.Batch_no });
								spCol.Add(new MySqlParameter("Mfg_Date", MySqlDbType.VarChar) { Value = DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") });
								spCol.Add(new MySqlParameter("Expiry_Date", MySqlDbType.VarChar) { Value = DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") });
								spCol.Add(new MySqlParameter("ManufacturedBy", MySqlDbType.VarChar) { Value = shipperData.ManufacturedBy });
								spCol.Add(new MySqlParameter("MarketedBy", MySqlDbType.VarChar) { Value = shipperData.MarketedBy });
								//spCol.Add(new MySqlParameter("ShipperQRCode_Data", MySqlDbType.Structured) { Value = dt, TypeName = "dbo.Type_ShipperQRCode_Bottle" });
								spCol.Add(new MySqlParameter("Operated_By", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
								//spCol.Add(new MySqlParameter("response", MySqlDbType.VarChar, 1000) { Direction = ParameterDirection.Output });

								var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("SP_ShipperData_Insert", spCol, true);

								CommonViewModel.IsConfirm = true;
								CommonViewModel.IsSuccess = IsSuccess;
								CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
								CommonViewModel.Message = response;

								//                        string[] strmsg = response.Split('|');
								//var msgtype = strmsg[0];
								//var message = strmsg[1].Replace("\"", "");

								if (CommonViewModel.IsSuccess == false)
									error = response;
								else
								{
									if (!System.IO.Directory.Exists(destinationFolderPath))
										System.IO.Directory.CreateDirectory(destinationFolderPath);

									if (System.IO.File.Exists(sourceFilePath))
									{
										string destinationFilePath = Path.Combine(destinationFolderPath, Path.GetFileName(sourceFilePath));

										// Check if the destination file already exists
										int counter = 1;
										while (System.IO.File.Exists(destinationFilePath))
										{
											// If the file exists, append a number to the file name
											string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
											string fileExtension = Path.GetExtension(sourceFilePath);
											string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

											destinationFilePath = Path.Combine(destinationFolderPath, newFileName);
											counter++;
										}
										// Copy the file to the destination folder
										System.IO.File.Copy(sourceFilePath, destinationFilePath);

										// Delete the original file
										System.IO.File.Delete(sourceFilePath);
									}
								}
							}
						}
						catch (Exception ex) { error = "Filename : " + sourceFilePath + " || " + (string.IsNullOrEmpty(error) ? "Data not Convert Json to List." : error); }

						if (!string.IsNullOrEmpty(error))
							errors.Add(error);
					}
				}
				else
				{
					errors.Add("No any file(s) to upload data");
				}

				if (errors == null || errors.Count() == 0)
				{
					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = "Record updated successfully !..."; ;

					CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

					return Json(CommonViewModel);
				}
				else
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					CommonViewModel.Message = "Opps!... Something went wrong. " + (errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}


		[HttpPost]
		public IActionResult GenerateQRCode()
		{
			try
			{
				string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Source_Folder_Path_QRCode").Value ?? "");
				string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Destination_Folder_Path_QRCode").Value ?? "");

				var fileKey = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("FileKey").Value ?? "");

				string[] sourceFilePaths = new string[] { };
				string[] destinationFilePaths = new string[] { };

				try
				{
					sourceFilePaths = Directory.GetFiles(sourceFolderPath, "*.*", SearchOption.AllDirectories);
					destinationFilePaths = Directory.GetFiles(destinationFolderPath, "*.*", SearchOption.AllDirectories);
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

				if (destinationFilePaths == null)
					destinationFilePaths = new string[] { "" };

				List<string> errors = new List<string>();

				if (sourceFilePaths != null && sourceFilePaths.Length > 0)
				{
					var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

					foreach (var sourceFilePath in orderedFilePaths.Where(x => !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
					{
						var error = "";

						DataTable dt = Common.ReadExcel(sourceFilePath, null);

						if (dt != null && dt.Rows.Count > 0)
						{
							foreach (DataRow dr in dt.Rows)
							{
								try
								{
									var strQR = Convert.ToString(dr[0]).Replace("/", "_").Replace("(", "_").Replace(")", "_");
									strQR = strQR.StartsWith("_") ? strQR.Substring(1) : strQR;
									strQR = strQR.EndsWith("_") ? strQR.Substring(0, strQR.Length - 2) : strQR;


									QRCodeGenerator qrGenerator = new QRCodeGenerator();
									QRCodeData qrCodeData = qrGenerator.CreateQrCode(strQR, QRCodeGenerator.ECCLevel.Q);

									BitmapByteQRCode qrCode = new BitmapByteQRCode(qrCodeData);
									byte[] qrCodeAsBitmapByteArr = qrCode.GetGraphic(20);

									Bitmap qrCodeImage;
									using (var ms = new MemoryStream(qrCodeAsBitmapByteArr)) { qrCodeImage = new Bitmap(ms); }

									string fileName = Path.Combine(destinationFolderPath, strQR + ".png");

									if (!System.IO.File.Exists(fileName)) System.IO.File.Delete(fileName);

									using (System.Drawing.Image image = System.Drawing.Image.FromStream(new MemoryStream(qrCodeAsBitmapByteArr))) { image.Save(fileName, ImageFormat.Png); }

								}
								catch (Exception ex1) { error = "Text : " + Convert.ToString(dr[0]) + " || " + (string.IsNullOrEmpty(error) ? "" : error); continue; }
							}
						}

						if (!string.IsNullOrEmpty(error))
							errors.Add(error);
					}
				}
				else
					errors.Add("No any file(s) to upload data");

				if (errors == null || errors.Count() == 0)
				{
					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = "Record updated successfully !..."; ;

					CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

					return Json(CommonViewModel);
				}
				else
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					CommonViewModel.Message = "Opps!... Something went wrong. " + (errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

					return Json(CommonViewModel);
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		#endregion

	}
}