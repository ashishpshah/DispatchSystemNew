using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Bibliography;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class QRGenerationController : BaseController<ResponseModel<QRCodeGeneration>>
	{
		#region Loading

		public IActionResult Index()
		{
			try
			{
				return View(CommonViewModel);
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Search_VendorPO(string searchTerm = "", long id = 0, string type = "S")
		{
			var list = new List<VendorPO>();

			var dt = new DataTable();

			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = -1 });
				oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = searchTerm ?? "" });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_YEAR", OracleDbType.Int16) { Value = 0 });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				if (type == "V")
				{
					dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_PO_GET", oParams);

					if (dt != null && dt.Rows.Count > 0)
					{
						foreach (DataRow dr in dt.Rows)
							list.Add(new VendorPO()
							{
								SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToInt64(dr["RNUM"]) : 0,
								Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
								PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
								SiteId = dr["SITE_ID"] != DBNull.Value ? Convert.ToInt64(dr["SITE_ID"]) : 0,
								VendorId = dr["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_ID"]) : null,
								VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
								VendorName = dr["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(dr["VENDOR_NAME"]) : "",
								VendorSite = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
								PoNo = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : null,
								PoDate = dr["PO_DATE"] != DBNull.Value ? Convert.ToDateTime(dr["PO_DATE"]) : nullDateTime,
								PoDate_Text = dr["PO_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["PO_DATE_TEXT"]) : "",
								PoDesc = dr["PO_DESC"] != DBNull.Value ? Convert.ToString(dr["PO_DESC"]) : "",
                                Remaining_Qty = dr["REMAINING_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAINING_QTY"]) : 0,
                                //Print_Label_Qty = dr["PRINT_LABEL_QTY"] != DBNull.Value ? Convert.ToInt32(dr["PRINT_LABEL_QTY"]) : 0,
                                //IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
                            });
					}

				}
				else
				{
					if (id > 0)
					{
						oParams[0].Value = id;
						oParams[1].Value = "";
					}
					else oParams[0].Value = 0;

					var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_PO_GET", oParams);

					if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
						list.Add(new VendorPO()
						{
							Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["ID"]) : 0,
							PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
							SiteId = ds.Tables[0].Rows[0]["SITE_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["SITE_ID"]) : 0,
							VendorId = ds.Tables[0].Rows[0]["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_ID"]) : null,
							VendorCode = ds.Tables[0].Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_CODE"]) : null,
							VendorName = ds.Tables[0].Rows[0]["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_NAME"]) : "",
							VendorSite = ds.Tables[0].Rows[0]["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VENDOR_SITE"]) : "",
							PoNo = ds.Tables[0].Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_NO"]) : null,
							PoDate = ds.Tables[0].Rows[0]["PO_DATE"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[0]["PO_DATE"]) : nullDateTime,
							PoDate_Text = ds.Tables[0].Rows[0]["PO_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DATE_TEXT"]) : "",
							PoDesc = ds.Tables[0].Rows[0]["PO_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DESC"]) : "",
							Print_Label_Qty = ds.Tables[0].Rows[0]["PRINT_LABEL_QTY"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["PRINT_LABEL_QTY"]) : 0,
                            //IsActive = ds.Tables[0].Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISACTIVE"]) : false,
                        });

					if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
					{
						list[0].listVendorPoDtls = new List<VendorPoDtls>();

						foreach (DataRow dr in ds.Tables[1].Rows)
							list[0].listVendorPoDtls.Add(new VendorPoDtls()
							{
								Id = dr["ID_DTL"] != DBNull.Value ? Convert.ToInt64(dr["ID_DTL"]) : 0,
								VPO_Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
								PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
								LineNo = dr["LINE_ITEM_NO"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_NO"]) : "",
								LineDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
								LineQty = dr["LINE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LINE_QTY"]) : 0,
								Requested_Qty = dr["REQUESTED_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUESTED_QTY"]) : 0,
								Remaining_Qty = dr["REMAINING_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAINING_QTY"]) : 0,
								UOM = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : "",
								//IsPosted = dr["ISPOSTED"] != DBNull.Value ? Convert.ToBoolean(dr["ISPOSTED"]) : false,
								//IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
							});
					}

				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (type == "V")
				return PartialView("_Partial_VendorPO", list);
			else
				return Json(list);

		}



		[HttpPost]
		public JsonResult GetProductList()
		{
			var list = new List<SelectListItem_Custom>();
			//list.Add(new SelectListItem_Custom("0", "-- Select --"));

			var list_Poroduct = new List<Product>();

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
						list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : ""));

				//if (dt != null && dt.Rows.Count > 0)
				//	foreach (DataRow dr in dt.Rows)
				//		list_Poroduct.Add(new Product()
				//		{
				//			Sku_code = dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "",
				//			Sku_name = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
				//		});

				//list_Poroduct = list_Poroduct.GroupBy(x => new { x.Sku_code, x.Sku_name }).Select(x => new Product() { Sku_code = x.Key.Sku_code, Sku_name = x.Key.Sku_name }).ToList();

				//list = list_Poroduct.Select(x => new SelectListItem_Custom(x.Sku_code, x.Sku_name)).ToList();

			}

			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return Json(list);
		}

		#endregion

		#region Events

		[HttpPost]
		public JsonResult Save(QRCodeGeneration viewModel)
		{
			try
			{
				//var sqlQuery = "SELECT TEMP_NUM_QR_GEN_ID, PLANT_CODE, 'REQ'||PLANT_CODE|| LPAD(TEMP_NUM_QR_GEN_ID, 10, 0) REQUEST_NO " +
				//				"FROM (SELECT TEMP_NUM_QR_GEN_ID, (SELECT PLANTCODE  FROM PLANT_MASTER WHERE PLANTID = " + Common.Get_Session_Int(SessionKey.PLANT_ID) + " AND ROWNUM = 1)PLANT_CODE  " +
				//				"FROM(SELECT  (NVL(MAX(QR_CODE_SYS_ID), 0) + 1) TEMP_NUM_QR_GEN_ID FROM QR_CODE_GENERATION X));     " +
				//				"SELECT  SKU_NAME SKU_DESC, GTIN FROM PRODUCT_MASTER WHERE PROD_SYS_ID = " + viewModel.Prodsysid + "; " +
				//				"SELECT  PRINT_LABEL_QTY FILE_QUANTITY FROM VENDOR_MASTER WHERE VENDOR_SYS_ID = " + viewModel.VendorId + "; " +
				//				"SELECT Y.LINE_QTY TOTAL_QTY, Y.LINE_ITEM_DESC,UMO FROM VENDOR_PO_HDR X, VENDOR_PO_DTL Y WHERE X.VPO_SYS_ID = " + viewModel.VPO_Id + " AND Y.VPO_SYS_ID_DTL = " + viewModel.VPO_Dtls_Id + " AND Y.LINE_ITEM_NO = " + viewModel.LineItemNo + " AND X.VENDER_ID = " + viewModel.VendorId + " AND X.VPO_SYS_ID = Y.VPO_SYS_ID AND X.PLANT_ID = " + Common.Get_Session_Int(SessionKey.PLANT_ID) + " ; " +
				//				"SELECT NVL(SUM(REQUEST_QTY), 0)  TOTAL_REQUESTED_QTY  FROM QR_CODE_GENERATION WHERE VPO_SYS_ID = " + viewModel.VPO_Id + " AND VENDER_ID = " + viewModel.VendorId + " AND PLANT_ID = " + Common.Get_Session_Int(SessionKey.PLANT_ID) + " ;";

				//var ds = DataContext.ExecuteQuery_DataSet(sqlQuery);

				//var qr_gen_id = ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["TEMP_NUM_QR_GEN_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["TEMP_NUM_QR_GEN_ID"]) : 0;
				//var plant_code = ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["PLANT_CODE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_CODE"]) : "";
				//var request_no = ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["REQUEST_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["REQUEST_NO"]) : "";

				//var sku_desc = ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0 && ds.Tables[1].Rows[0]["SKU_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["SKU_DESC"]) : "";
				//var gtin = ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0 && ds.Tables[1].Rows[0]["GTIN"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["GTIN"]) : "";

				//var file_quantity = ds != null && ds.Tables.Count > 2 && ds.Tables[2].Rows.Count > 0 && ds.Tables[2].Rows[0]["FILE_QUANTITY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[2].Rows[0]["FILE_QUANTITY"]) : 0;

				//var total_qty = ds != null && ds.Tables.Count > 3 && ds.Tables[3].Rows.Count > 0 && ds.Tables[3].Rows[0]["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(ds.Tables[3].Rows[0]["TOTAL_QTY"]) : 0;
				//var line_item_desc = ds != null && ds.Tables.Count > 3 && ds.Tables[3].Rows.Count > 0 && ds.Tables[3].Rows[0]["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[3].Rows[0]["LINE_ITEM_DESC"]) : "";


				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_PO_ID", OracleDbType.Int64) { Value = viewModel.VPO_Id });
				oParams.Add(new OracleParameter("P_PO_DTLS_ID", OracleDbType.Int64) { Value = viewModel.VPO_Dtls_Id });
				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new OracleParameter("P_LINE_ITEM_NO", OracleDbType.Int64) { Value = viewModel.LineItemNo });
				oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = viewModel.Prodsysid });
				oParams.Add(new OracleParameter("P_REQUEST_QTY", OracleDbType.Decimal) { Value = viewModel.RequestQty });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_QR_CODE_GENERATION_SAVE", oParams, true);

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



		#endregion
	}
}

