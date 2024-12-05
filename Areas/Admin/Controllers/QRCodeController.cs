
using ClosedXML.Excel;
using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Wordprocessing;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Data;
using System.Text;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class QRCodeController : BaseController<ResponseModel<QRCodeGeneration>>
	{
		#region Loading

		public IActionResult Index()
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

				//oParams = new List<OracleParameter>();

				//oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				//oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
				//oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
				//oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				//oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				//oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				//oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				//oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				//oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				//oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				//dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);

				//if (dt != null && dt.Rows.Count > 0)
				//	foreach (DataRow dr in dt.Rows)
				//		list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["Organization_Name"] != DBNull.Value ? Convert.ToString(dr["Organization_Name"]) : "", "V"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return View(CommonViewModel);
		}

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

		public IActionResult Receipt()
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

		#endregion

		#region Methods

		public ActionResult GetData_PoDetails(JqueryDatatableParam param)
		{
			string RequestNo = HttpContext.Request.Query["RequestNo"];
			string PoNo = HttpContext.Request.Query["PoNo"];
			string VendorCode = HttpContext.Request.Query["VendorCode"];
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
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
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
                        VendorEmail = ds.Tables[0].Rows[0]["VENDOR_EMAIL"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_EMAIL"]) : "",
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

		[HttpGet]
		public IActionResult Partial_AddEditForm_Dispatch(long Id = 0)
		{
			var obj = new QRCodeGeneration();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
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
			var obj = new QRCodeGeneration();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
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

				foreach (DataRow row in dt.Rows)
					list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString()));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return PartialView("_Partial_AddEditForm_Print", CommonViewModel);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_Receipt(long Id = 0)
		{
			var obj = new QRCodeGeneration();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
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
						PO_Date_Text = ds.Tables[0].Rows[0]["PO_Date_Text"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_Date_Text"]) : null,
						RequestNo = ds.Tables[0].Rows[0]["REQUEST_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_NO"]) : null,
						RequestDate_Text = ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
						//ExpectedDate_Text = ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_DATE_TEXT"]) : "",
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
						ConsignmentNo = ds.Tables[0].Rows[0]["CONSIGNMENT_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["CONSIGNMENT_NO"]) : null,
						ConsignmentDate_Text = ds.Tables[0].Rows[0]["CONSIGNMENT_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["CONSIGNMENT_DATE_TEXT"]) : null,
						ExpectedDate_Text = ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"]) : null,
						ModeofDispatch = ds.Tables[0].Rows[0]["MODE_OF_DISPATCH"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["MODE_OF_DISPATCH"]) : null,
						EstimateDate_Text = ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["EXPECTED_DATE_TEXT"]) : null,
						Shipmentdetail = ds.Tables[0].Rows[0]["SHIPMENT_DETAILS"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["SHIPMENT_DETAILS"]) : null,
						PrintNotes = ds.Tables[0].Rows[0]["PRINT_NOTES"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PRINT_NOTES"]) : null,
					};

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (obj != null && string.IsNullOrEmpty(obj.EstimateDate_Text))
				obj.EstimateDate_Text = DateTime.Now.ToString("dd/MM/yyyy").Replace("-", "/");

			if (obj != null && string.IsNullOrEmpty(obj.EstimateDate_Text))
				obj.EstimateDate_Text = DateTime.Now.ToString("dd/MM/yyyy").Replace("-", "/");

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

				foreach (DataRow row in dt.Rows)
					list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString()));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return PartialView("_Partial_AddEditForm_Receipt", CommonViewModel);
		}

		#endregion

		#region Events

		[HttpPost]
		public JsonResult Save(QRCodeGeneration viewModel)
		{
			try
			{
				string objList_JSON = "";

				if (viewModel.listSerial != null && viewModel.listSerial.Count() > 0)
					objList_JSON = string.Join("<#>", viewModel.listSerial.Select(x => x.Id + "|" + (x.IsLock ? 1 : 0)).ToArray());

				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new OracleParameter("P_PO_ID", OracleDbType.Int64) { Value = viewModel.VPO_Id });
				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new OracleParameter("P_EXPECTED_DATE", OracleDbType.Varchar2) { Value = viewModel.ExpectedDate_Text });
				oParams.Add(new OracleParameter("P_RECEIVE_BY", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.Varchar2) { Value = objList_JSON });
				oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "SEARCH" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
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

				//if (files != null && files.Count > 0)
				//	if (files[0] != null && files[0].ContentType.ToLower().Contains("pdf"))
				//	{
				//		var memoryStream = new MemoryStream();
				//		files[0].CopyTo(memoryStream);


				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new OracleParameter("P_PO_ID", OracleDbType.Int64) { Value = viewModel.VPO_Id });
				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new OracleParameter("P_EXPECTED_DATE", OracleDbType.Varchar2) { Value = null });
				oParams.Add(new OracleParameter("P_RECEIVE_BY", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "DISPATCH" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
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
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
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
		public JsonResult Save_Receipt(List<QRCodeGeneration> viewModel)
		{
			try
			{
				string objList_JSON = "";

				if (viewModel != null && viewModel.Count() > 0)
				{
					objList_JSON = string.Join("<#>", viewModel.Select(x => x.Id + "|" + x.PlantId + "|" + x.VPO_Id + "|" + x.VendorId + "|" + x.EstimateDate_Text + "|" + x.RequestQty).ToArray());

					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Select(x => x.Id).FirstOrDefault() });
					oParams.Add(new OracleParameter("P_PO_ID", OracleDbType.Int64) { Value = 0 });
					oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = 0 });
					oParams.Add(new OracleParameter("P_EXPECTED_DATE", OracleDbType.Varchar2) { Value = "" });
					oParams.Add(new OracleParameter("P_RECEIVE_BY", OracleDbType.Varchar2) { Value = viewModel.Select(x => x.ReceivedBy).FirstOrDefault() });
					oParams.Add(new OracleParameter("P_DTLS", OracleDbType.Varchar2) { Value = objList_JSON });
					oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "RECEIPT" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_QR_CODE_REQ_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Receipt";
				}
				else
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					CommonViewModel.Message = ResponseStatusMessage.Error;
				}
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
								return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "QR_Codes_" + filename + ".xlsx");
							}
						}
					}

				}
			}
			catch (Exception ex) { }

			return null;
		}

		[HttpGet]
		public JsonResult Send_Email_QR(long id = 0, long po_id = 0, long vendor_id = 0, string cc_Email = null)
		{
			try
			{
				if (id > 0 && po_id > 0 && vendor_id > 0)
                {
                    if (cc_Email != null && !ValidateField.IsValidEmail(cc_Email))
                    {
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.Message = "Please enter valid email id";
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;

                        return Json(CommonViewModel);
                    }
                    var obj = new QRCodeGeneration();

					var listFile = new List<(Stream contentStream, string contentType, string? fileDownloadName)>();

					DataTable dt = new DataTable("QR Codes");

					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
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
							Password = ds.Tables[0].Rows[0]["PASSWORD"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PASSWORD"]) : "",
							VendorEmail = ds.Tables[0].Rows[0]["VENDOR_EMAIL"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_EMAIL"]) : "",
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

					oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
					oParams.Add(new OracleParameter("P_SRL_ID", OracleDbType.Int64) { Value = 0 });
					oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = vendor_id });

					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
					oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

					ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_SERIAL_NO_GET", oParams);

					//if (ds != null && ds.Tables.Count > 1)
					//{
					//	foreach (DataRow dr in ds.Tables[0].Rows)
					//	{
					//		var filename = Convert.ToString(dr["FILE_NAME"]);

					//		DataView dv = new DataView(ds.Tables[1]);
					//		dv.RowFilter = "QR_GEN_ID = " + id + " AND VENDOR_ID = " + vendor_id + " AND QR_SRL_ID = " + Convert.ToString(dr["ID"]);

					//		dt = dv.ToTable();

					//		for (int i = dt.Columns.Count - 1; i >= 2; i--)
					//			dt.Columns.RemoveAt(i);

					//		dt.Columns[0].ColumnName = "QR Code";

					//		using (XLWorkbook wb = new XLWorkbook())
					//		{
					//			wb.Worksheets.Add(dt);
					//			using (MemoryStream stream = new MemoryStream())
					//			{
					//				listFile.Add((stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", filename + ".xlsx"));
					//				//wb.SaveAs(stream);
					//				//return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "QR_Codes_" + filename + ".xlsx");
					//			}
					//		}
					//	}
					//}

					//if (listFile != null && listFile.Count > 0)
					//{


					if (obj != null && !string.IsNullOrEmpty(obj.VendorEmail))
					{
						var textBody = $"Dear {obj.VendorName}";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + $@"We would like to place a printing request for QR code labels associated with Request ID: {obj.RequestNo}.";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + "Please download the necessary files from our system for printing. Once the labels are printed, kindly update the printing status and provide the dispatch details in our system.";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + "The download information is as follows:";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + $"User ID: {obj.VendorCode}";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + $"Password: {Common.Decrypt(obj.Password)}";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + $"URL: {AppHttpContextAccessor.Vendor_Portal_Url}";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + "Thank you for your cooperation.";

						textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

						textBody = textBody + "Best regards,";

						textBody = textBody + System.Environment.NewLine;

						textBody = textBody + "Indian Farmers Fertilizer Co-Operative Ltd.";

                        oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                        oParams.Add(new OracleParameter("P_FROM_LIST", OracleDbType.Varchar2) { Value = AppHttpContextAccessor.AdminFromMail });
                        oParams.Add(new OracleParameter("P_TO_LIST", OracleDbType.Varchar2) { Value = obj.VendorEmail });
                        oParams.Add(new OracleParameter("P_CC_LIST", OracleDbType.Varchar2) { Value = cc_Email });
                        oParams.Add(new OracleParameter("P_BCC_LIST", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_SUBJ", OracleDbType.Varchar2) { Value = "QR Code Generation Requests No " + obj.RequestNo });
                        oParams.Add(new OracleParameter("P_BODY", OracleDbType.Varchar2) { Value = textBody });
                        oParams.Add(new OracleParameter("P_REPLY_TO", OracleDbType.Varchar2) { Value = "" });

                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SEND_EMAIL_UPDATE_STATUS", oParams, false);
                        //var numberOfSpaces = 0;

                        //if (ds != null && ds.Tables.Count > 1)
                        //	for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        //	{
                        //		textBody = textBody + (i + 1) + "\t\t\t" + Convert.ToString(ds.Tables[0].Rows[i]["FILE_NAME"]) + "\t\t\t" + Convert.ToString(ds.Tables[0].Rows[i]["QTY"]);

                        //		textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                        //		if (Convert.ToString(ds.Tables[0].Rows[i]["FILE_NAME"]).Length > numberOfSpaces)
                        //			numberOfSpaces = Convert.ToString(ds.Tables[0].Rows[i]["FILE_NAME"]).Length;
                        //	}

                        //StringBuilder sb = new StringBuilder();
                        //for (int i = 0; i < numberOfSpaces; i++) sb.Append(" ");

                        //textBody = textBody.Replace("<#>", sb.ToString());

                        //textBody = textBody + System.Environment.NewLine + System.Environment.NewLine + @"Kindly download all the files from our system for printing.Once printed, we kindly request you to update the printing status and provide dispatch details in our system."; ;

                        //var response = 
                        //Common.SendEmail("QR Code Generation Requests No " + obj.RequestNo, textBody, obj.VendorEmail.Replace(" ", "").Replace(";", ",").Split(",").ToArray(), listFile, false);

                        //if (response.IsSuccess == false)
                        //	LogService.LogInsert(GetCurrentAction(), response.Message);

                        //CommonViewModel.IsConfirm = true;
                        //CommonViewModel.IsSuccess = response.IsSuccess;
                        //CommonViewModel.StatusCode = response.IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                        //CommonViewModel.Message = response.Message;
                        ////CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

                        CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = "E-Mail Sending.....";

						CommonViewModel.Data1 = id;

						return Json(CommonViewModel);
					}

				}

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.NotFound;
				//CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

				CommonViewModel.Data1 = id;
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

		#endregion
	}
}

