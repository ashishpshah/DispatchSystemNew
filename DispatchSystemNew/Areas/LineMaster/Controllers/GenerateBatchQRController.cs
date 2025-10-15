using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Drawing;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using PuppeteerSharp;
using QRCoder;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Runtime.Intrinsics.Arm;

namespace Dispatch_System.Areas.LineMaster.Controllers
{
	[Area("LineMaster")]
	public class GenerateBatchQRController : BaseController<ResponseModel<GenerateBatchQR>>
	{
		public IActionResult Index()
		{
			CommonViewModel.Obj = new GenerateBatchQR();

			var list = new List<SelectListItem_Custom>();

			var oParams = new List<MySqlParameter>();

			try
			{
				list.Add(new SelectListItem_Custom("KL1", "NAP1", "PLANT"));
				list.Add(new SelectListItem_Custom("KL2", "NAP2", "PLANT"));

				//oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				//oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				//oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				//oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				//oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				//oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				//var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PLANT_GET", oParams, true);

				//if (dt != null && dt.Rows.Count > 0)
				//    foreach (DataRow dr in dt.Rows)
				//        list.Add(new SelectListItem_Custom(Convert.ToString(dr["CODE"]), Convert.ToString(dr["NAME"]), "PLANT"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			try
			{
				list.Add(new SelectListItem_Custom("DP", "NANO DAP", "PRODUCT"));
				list.Add(new SelectListItem_Custom("UP", "NANO UREA PLUS", "PRODUCT"));

				//var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PRODUCT_GET", oParams, true);

				//if (dt != null && dt.Rows.Count > 0)
				//    foreach (DataRow dr in dt.Rows)
				//        list.Add(new SelectListItem_Custom(Convert.ToString(dr["PRD_CD"]), Convert.ToString(dr["PRD_DESC"]), "PRODUCT"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			try
			{
				oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_PROD_CODE", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_BATCH_GET", oParams, true);

				CommonViewModel.ListObj = new List<GenerateBatchQR>();

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow row in dt.Rows)
					{
						byte[] imageBytes = row["Qr_Code_Image"] != DBNull.Value ? (byte[])row["Qr_Code_Image"] : null;
						string base64Image = imageBytes != null ? Convert.ToBase64String(imageBytes) : null;

						CommonViewModel.ListObj.Add(new GenerateBatchQR
						{
							SrNo = Convert.ToInt32(row["SR_NO"]),
							Serial_No = Convert.ToInt32(row["Serial_No"]),
							Batch_No = row["Batch_No"]?.ToString(),
							MFG_Date = row["Mfg_Date"]?.ToString(),
							Plant_Code = row["Plant_Code"]?.ToString(),
							Prod_Code = row["Product_Code"]?.ToString(),
							Current_Year = Convert.ToInt32(row["Current_Year"]),
							Julian_Day = Convert.ToInt32(row["Julian_Day"]),
							QrCodeImage = "data:image/png;base64," + base64Image
						});
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return View(CommonViewModel);
		}

		[HttpGet]
		public IActionResult GetSerialNo(string MFG_Date, string Prod_Code = null, string Plant_Code = null, int Id = -1)
		{
			var imageBase64 = "";

			CommonViewModel.Obj = new GenerateBatchQR();

			var oParams = new List<MySqlParameter>();

			try
			{
				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Id });
				oParams.Add(new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = Plant_Code ?? "" });
				oParams.Add(new MySqlParameter("P_PROD_CODE", MySqlDbType.VarString) { Value = Prod_Code ?? "" });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_BATCH_GET", oParams, true);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && Id < 0)
					CommonViewModel.Obj.Serial_No = Convert.ToInt64(ds.Tables[0].Rows[0][0]);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && Id > 0)
				{
					byte[] imageBytes = ds.Tables[0].Rows[0]["Qr_Code_Image"] != DBNull.Value ? (byte[])ds.Tables[0].Rows[0]["Qr_Code_Image"] : null;
					string base64Image = imageBytes != null ? Convert.ToBase64String(imageBytes) : null;

					CommonViewModel.Obj = new GenerateBatchQR
					{
						SrNo = Convert.ToInt32(ds.Tables[0].Rows[0]["SR_NO"]),
						Serial_No = Convert.ToInt32(ds.Tables[0].Rows[0]["Serial_No"]),
						Batch_No = ds.Tables[0].Rows[0]["Batch_No"]?.ToString(),
						MFG_Date = ds.Tables[0].Rows[0]["Mfg_Date"]?.ToString(),
						Plant_Code = ds.Tables[0].Rows[0]["Plant_Code"]?.ToString(),
						Prod_Code = ds.Tables[0].Rows[0]["Product_Code"]?.ToString(),
						Current_Year = Convert.ToInt32(ds.Tables[0].Rows[0]["Current_Year"]),
						Julian_Day = Convert.ToInt32(ds.Tables[0].Rows[0]["Julian_Day"]),
						QrCodeText = Convert.ToString(ds.Tables[0].Rows[0]["Qr_Code_Text"]),
						QrCodeImage = "data:image/png;base64," + base64Image
					};

				}

				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
				{
					CommonViewModel.Obj.APID1_Val = Convert.ToString(ds.Tables[1].Rows[0][1]);
					CommonViewModel.Obj.APID2_Val = Convert.ToString(ds.Tables[1].Rows[0][3]);
				}

				CommonViewModel.IsConfirm = false;
				CommonViewModel.IsSuccess = true;
				CommonViewModel.StatusCode = ResponseStatusCode.Success;
				CommonViewModel.Message = null;

			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);

				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error;
			}

			return Json(CommonViewModel);
		}

		[HttpGet]
		public IActionResult Generate_QRCode(string Batch_No, string MFG_Date, string APID1_Val, string APID2_Val, string Plant_Code, string Prod_Code)
		{
			try
			{
				var date = DateTime.ParseExact(MFG_Date, "dd/MM/yyyy", CultureInfo.InvariantCulture);

				MFG_Date = date.ToString("yyyyMMdd");

				var imageBase64 = "";

				var strText = $"[{APID1_Val}]{Batch_No}[{APID2_Val}]{MFG_Date}";

				QRCodeGenerator qrGenerator = new QRCodeGenerator();
				QRCodeData qrCodeData = qrGenerator.CreateQrCode(strText, QRCodeGenerator.ECCLevel.Q);

				BitmapByteQRCode qrCode = new BitmapByteQRCode(qrCodeData);
				byte[] qrCodeAsBitmapByteArr = qrCode.GetGraphic(20);

				byte[] byteArray = null;
				//Bitmap qrCodeImage = null;
				using (var ms = new MemoryStream(qrCodeAsBitmapByteArr))
				{
					//qrCodeImage = new Bitmap(ms);

					//qrCodeImage.Save($"{APID1_Val}_{Batch_No}_{APID2_Val}_{MFG_Date.Replace("/", "")}" + ".png", System.Drawing.Imaging.ImageFormat.Png);

					byteArray = ms.ToArray();

					imageBase64 = "data:image/png;base64," + Convert.ToBase64String(byteArray);

				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_BATCH_NO", MySqlDbType.VarChar) { Value = Batch_No });
				oParams.Add(new MySqlParameter("P_MFG_DATE", MySqlDbType.VarChar) { Value = date.ToString("dd/MM/yyyy").Replace("-", "/") });
				oParams.Add(new MySqlParameter("P_QR_CODE_TEXT", MySqlDbType.VarChar) { Value = strText });
				oParams.Add(new MySqlParameter("P_QR_CODE_IMAGE", MySqlDbType.LongBlob) { Value = byteArray });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_BATCH_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = IsSuccess ? "" : response;

				CommonViewModel.Data1 = IsSuccess ? imageBase64 : "";
				CommonViewModel.Data2 = IsSuccess ? strText : "";

			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);

				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error;
			}

			return Json(CommonViewModel);
		}

	}
}