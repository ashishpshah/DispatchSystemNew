using ClosedXML.Excel;
using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System
{
	[Area("Vendor")]
	public class VenderController : BaseController<ResponseModel<QRCodeGeneration>>
	{
		public IActionResult Index()
		{
			List<QRCodeGeneration> listQRCodeGeneration = new List<QRCodeGeneration>();

			List<(string status, string status_text, int request_cnt, int file_cnt, int file_download_cnt, int file_not_download_cnt)>
				list = new List<(string status, string status_text, int request_cnt, int file_cnt, int file_download_cnt, int file_not_download_cnt)>();

			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.SITE_ID) });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_REQUEST", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_DASHBOARD_DATA", oParams);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
				{
					foreach (DataRow dr in ds.Tables[0].Rows)
					{
						list.Add((dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "",
							dr["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS_TEXT"]) : "",
							dr["REQUEST_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["REQUEST_COUNT"]) : 0,
							dr["FILE_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["FILE_COUNT"]) : 0,
							dr["DOWNLOADED_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["DOWNLOADED_COUNT"]) : 0,
							dr["NOT_DOWNLOADED_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["NOT_DOWNLOADED_COUNT"]) : 0));
					}
				}

				CommonViewModel.Data1 = new
				{
					Pending_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("pending")) ? list.Where(x => x.status_text.ToLower().Contains("pending")).Select(x => x.request_cnt).FirstOrDefault() : 0),
					Pending_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("pending")) ? list.Where(x => x.status_text.ToLower().Contains("pending")).Select(x => x.file_cnt).FirstOrDefault() : 0),
					Download_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("email")) ? list.Where(x => x.status_text.ToLower().Contains("email")).Select(x => x.request_cnt).FirstOrDefault() : 0),
					Download_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("email")) ? list.Where(x => x.status_text.ToLower().Contains("email")).Select(x => x.file_cnt).FirstOrDefault() : 0),
					Download_file_not_download_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("email")) ? list.Where(x => x.status_text.ToLower().Contains("email")).Select(x => x.file_not_download_cnt).FirstOrDefault() : 0),
					Print_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("print")) ? list.Where(x => x.status_text.ToLower().Contains("print")).Select(x => x.request_cnt).FirstOrDefault() : 0),
					Print_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("print")) ? list.Where(x => x.status_text.ToLower().Contains("print")).Select(x => x.file_cnt).FirstOrDefault() : 0),
					Dispatch_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("dispatch")) ? list.Where(x => x.status_text.ToLower().Contains("dispatch")).Select(x => x.request_cnt).FirstOrDefault() : 0),
					Dispatch_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("dispatch")) ? list.Where(x => x.status_text.ToLower().Contains("dispatch")).Select(x => x.file_cnt).FirstOrDefault() : 0),
				};


				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
				{
					foreach (DataRow dr in ds.Tables[1].Rows)
					{
						listQRCodeGeneration.Add(new QRCodeGeneration()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
							RequestNo = dr["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dr["REQUEST_NO"]) : "",
							RequestDate = dr["REQUEST_DATE"] != DBNull.Value ? Convert.ToDateTime(dr["REQUEST_DATE"]) : null,
							LineItemDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
							TotalQty = dr["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_QTY"]) : 0,
							RequestQty = dr["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUEST_QTY"]) : 0,
							RemainQty = dr["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAIN_QTY"]) : 0,
							IsFileEmail = dr["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt64(dr["IS_FILE_EMAIL"]) > 0 : false,
							RequestStatus = dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "",
							PO_Number = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : "",
							SelectedPlants = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
							SkuDesc = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
						});
					}
				}

			}

			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.ListObj = listQRCodeGeneration;
            //var checkPassword = Common.Get_Session("CheckPassword");
            var LoginFlag = Common.Get_Session("LoginFlag");
            //ViewBag.CheckPassword = checkPassword;
            ViewBag.LoginFlag = LoginFlag;

            return View(CommonViewModel);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm(long Id = 0)
		{
			var obj = new QRCodeGeneration();

			var dt = new DataTable();

			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id });
				oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
				//oParams.Add(new OracleParameter("P_REQUEST_PLANT", OracleDbType.Int64) { Value = -1 });
				oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = null });
				oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_GET", oParams);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
					obj = new QRCodeGeneration()
					{
						Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["ID"]) : 0,
						PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
						VendorId = ds.Tables[0].Rows[0]["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_ID"]) : 0,
						VendorCode = ds.Tables[0].Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_CODE"]) : 0,
						VendorName = ds.Tables[0].Rows[0]["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_NAME"]) : "",
						VendorSiteName = ds.Tables[0].Rows[0]["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_SITE"]) : "",
						VPO_Id = ds.Tables[0].Rows[0]["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VPO_SYS_ID"]) : 0,
						PO_Number = ds.Tables[0].Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_NO"]) : null,
						PO_Date_Text = ds.Tables[0].Rows[0]["PO_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DATE_TEXT"]) : null,
						RequestNo = ds.Tables[0].Rows[0]["REQUEST_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_NO"]) : null,
						RequestDate_Text = ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
						ExpectedDate_Text = ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"]) : "",
						RequestStatus = ds.Tables[0].Rows[0]["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_STATUS_TEXT"]) : "",
						LineItemNo = ds.Tables[0].Rows[0]["LINE_ITEM_NO"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["LINE_ITEM_NO"]) : 0,
						LineItemDesc = ds.Tables[0].Rows[0]["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LINE_ITEM_DESC"]) : "",
						SkuDesc = ds.Tables[0].Rows[0]["SKU_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["SKU_DESC"]) : "",
						UOM = ds.Tables[0].Rows[0]["UMO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["UMO"]) : "",
						TotalQty = ds.Tables[0].Rows[0]["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["TOTAL_QTY"]) : 0,
						RequestQty = ds.Tables[0].Rows[0]["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["REQUEST_QTY"]) : 0,
						RemainQty = ds.Tables[0].Rows[0]["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["REMAIN_QTY"]) : 0,
						FileEmailSend = ds.Tables[0].Rows[0]["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FILE_EMAIL_SEND"]) : "",
						IsFileEmail = ds.Tables[0].Rows[0]["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_FILE_EMAIL"]) > 0 : false,
						IsLock = ds.Tables[0].Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_LOCK"]) > 0 : false,
						IsPrintFinish = ds.Tables[0].Rows[0]["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_PRINT_FINISHED"]) > 0 : false,
						Nooffiles = (ds != null && ds.Tables.Count > 1) ? ds.Tables[1].Rows.Count : 0
					};

				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
				{
					obj.listSerial = new List<QR_Code_Serial>();

					foreach (DataRow dr in ds.Tables[1].Rows)
						obj.listSerial.Add(new QR_Code_Serial()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
							QR_Code_GenId = dr["QR_CODE_GEN_ID"] != DBNull.Value ? Convert.ToInt64(dr["QR_CODE_GEN_ID"]) : 0,
							RequestQty = dr["QTY"] != DBNull.Value ? Convert.ToInt64(dr["QTY"]) : 0,
							FileName = dr["FILE_NAME"] != DBNull.Value ? Convert.ToString(dr["FILE_NAME"]) : "",
							IsDownload = dr["IS_DOWNLOADED"] != DBNull.Value ? Convert.ToInt32(dr["IS_DOWNLOADED"]) > 0 : false,
							IsLock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(dr["IS_LOCK"]) > 0 : false,
							Status_FileDownload = dr["STATUS_DOWNLOAD"] != DBNull.Value ? Convert.ToString(dr["STATUS_DOWNLOAD"]) : ""
						});
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return PartialView("_Partial_AddEditForm", obj);
		}

		//[HttpGet]
		//public IActionResult Partial_AddEditForm(string requestNo)
		//{
		//	var obj = new QRCodeGeneration();
		//	try
		//	{
		//		if (!string.IsNullOrEmpty(requestNo))
		//		{
		//			List<OracleParameter> oParams = new List<OracleParameter>();

		//			oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = requestNo });
		//			oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.SITE_ID) });
		//			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
		//			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
		//			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
		//			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

		//			var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_DASH_DETAIL", oParams, true);

		//			if (dt != null && dt.Rows.Count > 0)
		//			{
		//				obj.RequestNo = dt.Rows[0]["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["REQUEST_NO"]) : "";
		//				obj.RequestDate = dt.Rows[0]["REQUEST_DATE"] != DBNull.Value ? Convert.ToDateTime(dt.Rows[0]["REQUEST_DATE"]) : null;
		//				obj.LineItemDesc = dt.Rows[0]["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["LINE_ITEM_DESC"]) : "";
		//				obj.TotalQty = dt.Rows[0]["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["TOTAL_QTY"]) : 0;
		//				obj.RequestQty = dt.Rows[0]["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["REQUEST_QTY"]) : 0;
		//				obj.RemainQty = dt.Rows[0]["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["REMAIN_QTY"]) : 0;
		//				obj.IsFileEmail = dt.Rows[0]["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["IS_FILE_EMAIL"]) > 0 : false;
		//				obj.RequestStatus = dt.Rows[0]["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["REQUEST_STATUS"]) : "";
		//				obj.PO_Number = dt.Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PO_NO"]) : "";
		//				obj.SelectedPlants = dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "";
		//				obj.SkuDesc = dt.Rows[0]["SKU_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SKU_NAME"]) : "";
		//			}
		//		}

		//	}

		//	catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


		//	//CommonViewModel.Obj = obj;
		//	ViewBag.QRCodeGeneration = obj;
		//	//obj.listLov = CommonViewModel.ListObj;

		//	return PartialView("_Partial_AddEditForm", CommonViewModel);

		//}


		public IActionResult Dispatch()
		{
			var list = new List<SelectListItem_Custom>();

			list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "", "P"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return View(CommonViewModel);
		}

		public IActionResult Print()
		{
			var list = new List<SelectListItem_Custom>();

			list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "", "P"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return View(CommonViewModel);
		}


		public ActionResult GetData_PoDetails(JqueryDatatableParam param)
		{
			string RequestNo = HttpContext.Request.Query["RequestNo"];
			string PoNo = HttpContext.Request.Query["PoNo"];
			string VendorCode = Common.Get_Session_Int(SessionKey.VENDOR_CODE).ToString();
			string ProductId = HttpContext.Request.Query["ProductId"];
			string FromDate = HttpContext.Request.Query["FromDate"];
			string ToDate = HttpContext.Request.Query["ToDate"];
			string ConsignmentNo = HttpContext.Request.Query["ConsignmentNo"];
			string Type = HttpContext.Request.Query["Type"];

			List<QRCodeGeneration> result = new List<QRCodeGeneration>();

			List<OracleParameter> oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = RequestNo });
			//oParams.Add(new OracleParameter("P_REQUEST_PLANT", OracleDbType.Int64) { Value = -1 });
			oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = PoNo });
			oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = VendorCode ?? "" });
			oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = string.IsNullOrEmpty(ProductId) ? null : Convert.ToInt64(ProductId) });
			oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
			oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
			oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = ConsignmentNo });
			oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = Type });
			oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });
			oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
			oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
			oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
			oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
			oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

			var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_GET", oParams);

			if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
			{
				foreach (DataRow dr in ds.Tables[0].Rows)
					result.Add(new QRCodeGeneration()
					{
						SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToInt64(dr["RNUM"]) : 0,
						Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
						PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
						PlantName = (dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) + " - " : "") + (dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : ""),
						VendorId = dr["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_ID"]) : 0,
						VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : 0,
						VendorName = dr["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(dr["VENDOR_NAME"]) : "",
						VendorSiteName = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
						VPO_Id = dr["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VPO_SYS_ID"]) : 0,
						PO_Number = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : null,
						RequestNo = dr["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dr["REQUEST_NO"]) : null,
						RequestDate_Text = dr["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_DATE_TEXT"]) : "",
						RequestStatus = dr["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS_TEXT"]) : "",
						LineItemDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
						SkuDesc = dr["SKU_DESC"] != DBNull.Value ? Convert.ToString(dr["SKU_DESC"]) : "",
						TotalQty = dr["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_QTY"]) : 0,
						RequestQty = dr["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUEST_QTY"]) : 0,
						RemainQty = dr["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAIN_QTY"]) : 0,
						FileEmailSend = dr["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(dr["FILE_EMAIL_SEND"]) : "",
						IsFileEmail = dr["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(dr["IS_FILE_EMAIL"]) > 0 : false,
						IsLock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(dr["IS_LOCK"]) > 0 : false,
						IsPrintFinish = dr["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(dr["IS_PRINT_FINISHED"]) > 0 : false,
						Nooffiles = dr["NO_OF_FILES"] != DBNull.Value ? Convert.ToInt64(dr["NO_OF_FILES"]) : 0,
						ConsignmentNo = dr["CONSIGNMENT_NO"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_NO"]) : null,
						ConsignmentDate_Text = dr["CONSIGNMENT_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_DATE_TEXT"]) : null,
						ExpectedDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
						ModeofDispatch = dr["MODE_OF_DISPATCH"] != DBNull.Value ? Convert.ToString(dr["MODE_OF_DISPATCH"]) : null,
						EstimateDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
						Shipmentdetail = dr["SHIPMENT_DETAILS"] != DBNull.Value ? Convert.ToString(dr["SHIPMENT_DETAILS"]) : null,
						PrintNotes = dr["PRINT_NOTES"] != DBNull.Value ? Convert.ToString(dr["PRINT_NOTES"]) : null
					});
			}

			return Json(new
			{
				param.sEcho,
				iTotalRecords = result.Count(),
				iTotalDisplayRecords = ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 ? Convert.ToInt32(ds.Tables[0].Rows[0]["COUNT_ROW"]?.ToString()) : 0,
				aaData = result
			});

		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_Dispatch(long Id = 0)
		{
			string VendorCode = Common.Get_Session_Int(SessionKey.VENDOR_CODE).ToString();

			var obj = new QRCodeGeneration();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id });
				oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
				//oParams.Add(new OracleParameter("P_REQUEST_PLANT", OracleDbType.Int64) { Value = -1 });
				oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = VendorCode });
				oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = null });
				oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_GET", oParams);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
					obj = new QRCodeGeneration()
					{
						Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["ID"]) : 0,
						PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
						VendorId = ds.Tables[0].Rows[0]["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_ID"]) : 0,
						VendorCode = ds.Tables[0].Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_CODE"]) : 0,
						VendorName = ds.Tables[0].Rows[0]["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_NAME"]) : "",
						VendorSiteName = ds.Tables[0].Rows[0]["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_SITE"]) : "",
						VPO_Id = ds.Tables[0].Rows[0]["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VPO_SYS_ID"]) : 0,
						PO_Number = ds.Tables[0].Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_NO"]) : null,
						PO_Date_Text = ds.Tables[0].Rows[0]["PO_Date_Text"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_Date_Text"]) : null,
						RequestNo = ds.Tables[0].Rows[0]["REQUEST_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_NO"]) : null,
						RequestDate_Text = ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
						ExpectedDate_Text = ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
						RequestStatus = ds.Tables[0].Rows[0]["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"]) : "",
						LineItemNo = ds.Tables[0].Rows[0]["LINE_ITEM_NO"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["LINE_ITEM_NO"]) : 0,
						LineItemDesc = ds.Tables[0].Rows[0]["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LINE_ITEM_DESC"]) : "",
						SkuDesc = ds.Tables[0].Rows[0]["SKU_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["SKU_DESC"]) : "",
						TotalQty = ds.Tables[0].Rows[0]["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["TOTAL_QTY"]) : 0,
						RequestQty = ds.Tables[0].Rows[0]["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["REQUEST_QTY"]) : 0,
						RemainQty = ds.Tables[0].Rows[0]["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["REMAIN_QTY"]) : 0,
						FileEmailSend = ds.Tables[0].Rows[0]["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FILE_EMAIL_SEND"]) : "",
						IsFileEmail = ds.Tables[0].Rows[0]["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_FILE_EMAIL"]) > 0 : false,
						IsLock = ds.Tables[0].Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_LOCK"]) > 0 : false,
						IsPrintFinish = ds.Tables[0].Rows[0]["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_PRINT_FINISHED"]) > 0 : false,
					};

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.Obj = obj;

			var list = new List<SelectListItem_Custom>();

			list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

			try
			{
				oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = "DISPATCH_MODE " });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow row in dt.Rows)
						list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString()));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return PartialView("_Partial_AddEditForm_Dispatch", CommonViewModel);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_Print(long Id = 0)
		{
			string VendorCode = Common.Get_Session_Int(SessionKey.VENDOR_CODE).ToString();

			var obj = new QRCodeGeneration();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id });
				oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
				//oParams.Add(new OracleParameter("P_REQUEST_PLANT", OracleDbType.Int64) { Value = -1 });
				oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = VendorCode });
				oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = null });
				oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_GET", oParams);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
					obj = new QRCodeGeneration()
					{
						Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["ID"]) : 0,
						PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
						VendorId = ds.Tables[0].Rows[0]["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_ID"]) : 0,
						VendorCode = ds.Tables[0].Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_CODE"]) : 0,
						VendorName = ds.Tables[0].Rows[0]["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_NAME"]) : "",
						VendorSiteName = ds.Tables[0].Rows[0]["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_SITE"]) : "",
						VPO_Id = ds.Tables[0].Rows[0]["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VPO_SYS_ID"]) : 0,
						PO_Number = ds.Tables[0].Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_NO"]) : null,
						PO_Date_Text = ds.Tables[0].Rows[0]["PO_Date_Text"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_Date_Text"]) : null,
						RequestNo = ds.Tables[0].Rows[0]["REQUEST_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_NO"]) : null,
						RequestDate_Text = ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
						ExpectedDate_Text = ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
						RequestStatus = ds.Tables[0].Rows[0]["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"]) : "",
						LineItemNo = ds.Tables[0].Rows[0]["LINE_ITEM_NO"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["LINE_ITEM_NO"]) : 0,
						LineItemDesc = ds.Tables[0].Rows[0]["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LINE_ITEM_DESC"]) : "",
						SkuDesc = ds.Tables[0].Rows[0]["SKU_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["SKU_DESC"]) : "",
						TotalQty = ds.Tables[0].Rows[0]["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["TOTAL_QTY"]) : 0,
						RequestQty = ds.Tables[0].Rows[0]["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["REQUEST_QTY"]) : 0,
						RemainQty = ds.Tables[0].Rows[0]["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["REMAIN_QTY"]) : 0,
						FileEmailSend = ds.Tables[0].Rows[0]["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FILE_EMAIL_SEND"]) : "",
						IsFileEmail = ds.Tables[0].Rows[0]["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_FILE_EMAIL"]) > 0 : false,
						IsLock = ds.Tables[0].Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_LOCK"]) > 0 : false,
						IsPrintFinish = ds.Tables[0].Rows[0]["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_PRINT_FINISHED"]) > 0 : false,
					};

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.Data1 = obj;

			var list = new List<SelectListItem_Custom>();

			list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

			try
			{
				oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = "DISPATCH_MODE " });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams);

				foreach (DataRow row in dt.Rows)
					list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString()));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return PartialView("_Partial_AddEditForm_Print", CommonViewModel);
		}


		[HttpPost]
		public JsonResult Save_Print(QRCodeGeneration viewModel)
		{
			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new OracleParameter("P_PO_ID", OracleDbType.Int64) { Value = viewModel.VPO_Id });
				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new OracleParameter("P_EXPECTED_DATE", OracleDbType.Varchar2) { Value = null });
				oParams.Add(new OracleParameter("P_RECEIVE_BY", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "PRINT" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_QR_CODE_REQ_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;
				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}
			return Json(CommonViewModel);
		}


		[HttpPost]
		public JsonResult Save_Dispatch(QRCodeGeneration viewModel)
		{
			try
			{
				List<IFormFile>? files = HttpContext.Request.Form.Files != null && HttpContext.Request.Form.Files.Count > 0 ? HttpContext.Request.Form.Files.ToList() : null;

				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new OracleParameter("P_PO_ID", OracleDbType.Int64) { Value = viewModel.VPO_Id });
				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = viewModel.ConsignmentNo });
				oParams.Add(new OracleParameter("P_CONSIGNMENT_DATE", OracleDbType.Varchar2) { Value = viewModel.ConsignmentDate_Text });
				oParams.Add(new OracleParameter("P_MODE_OF_DISPATCH", OracleDbType.Varchar2) { Value = viewModel.ModeofDispatch });
				oParams.Add(new OracleParameter("P_ESTIMATE_DATE", OracleDbType.Varchar2) { Value = viewModel.EstimateDate_Text });
				oParams.Add(new OracleParameter("P_SHIPMENT_DETAILS", OracleDbType.Varchar2) { Value = viewModel.Shipmentdetail });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_QR_CODE_REQ_DISPATCH_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;
				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}
			return Json(CommonViewModel);
		}


		public IActionResult Export_QRCode(long Id = 0, long Srl_Id = 0, long Vendor_Id = 0)
		{
			try
			{
				if (Id > 0 && Srl_Id > 0 && Vendor_Id > 0)
				{
					DataTable dt = new DataTable("QR Codes");

					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id });
					oParams.Add(new OracleParameter("P_SRL_ID", OracleDbType.Int64) { Value = Srl_Id });
					oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = Vendor_Id });

					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
					oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

					var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_SERIAL_NO_GET", oParams);

					if (ds != null && ds.Tables.Count > 1 && Convert.ToInt32(ds.Tables[0].Rows[0]["IS_LOCK"]) == 0)
					{
						var filename = Convert.ToString(ds.Tables[0].Rows[0]["FILE_NAME"]);

						dt = ds.Tables[1];

						for (int i = dt.Columns.Count - 1; i >= 2; i--)
							dt.Columns.RemoveAt(i);

						dt.Columns[0].ColumnName = "QR Code";

						using (XLWorkbook wb = new XLWorkbook())
						{
							wb.Worksheets.Add(dt);
							using (MemoryStream stream = new MemoryStream())
							{
								wb.SaveAs(stream);
								return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", filename + ".xlsx");
							}
						}
					}

				}
			}
			catch (Exception ex) { }

			return null;
		}

	}
}
