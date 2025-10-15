
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class MdaStatusController : BaseController<ResponseModel<MDA>>
    {
        public IActionResult Index()
        {
            var list = new List<SelectListItem_Custom>();

            CommonViewModel.Obj = new MDA();

            return View(CommonViewModel);
        }


        public ActionResult GetData_MdaStatus(JqueryDatatableParam param)
        {   
            string MdaNo = HttpContext.Request.Query["MdaNo"];
            string TruckNo = HttpContext.Request.Query["TruckNo"];
            string InvoiceQrCode = HttpContext.Request.Query["InvoiceQrCode"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = MdaNo });
            oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            oParams.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.Varchar2) { Value = TruckNo });
            oParams.Add(new OracleParameter("P_INVOICE_QR_CODE", OracleDbType.Varchar2) { Value = InvoiceQrCode });
            oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
            oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_MDA_STATUS_REPORT", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                        MDAStatus = dr["MDA_STATUS"] != DBNull.Value ? Convert.ToString(dr["MDA_STATUS"]) : "",
                        MDAReceiveDate = dr["MDA_REC_DATE"] != DBNull.Value ? Convert.ToString(dr["MDA_REC_DATE"]) : "",
                        TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                        DriverName = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) :"",
                        CustomerName = dr["CUST_NAME"] != DBNull.Value ? Convert.ToString(dr["CUST_NAME"]) : "",
                        SKUCode = dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "",
                        SkuDesc = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
                        Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
                        LoadingInDateTimePrintedFrom = dr["LOADING_IN_DATETIME"] != DBNull.Value ? Convert.ToString(dr["LOADING_IN_DATETIME"]) : "",
                        LoadingOutDateTimePrintedFrom = dr["LOADING_OUT_DATETIME"] != DBNull.Value ? Convert.ToString(dr["LOADING_OUT_DATETIME"]) : "",
                        LoadingBayPrintedTo = dr["LOADING_BAY"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY"]) : "",
                        LoadingBayOperatorTo = dr["LOADING_BAY_OPERATOR"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY_OPERATOR"]) : "",
                        MDAQty = dr["MDA_QTY_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["MDA_QTY_SHIPPER"]) : 0,
                        MDAUpdateQty = dr["MDA_UPDATED_QTY_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["MDA_UPDATED_QTY_SHIPPER"]) : 0,
                        LoadedQty = dr["LOADED_QTY_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_QTY_SHIPPER"]) : 0,
                        DispatchDateTime = dr["DISP_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["DISP_DATE_TIME"]) : "",
                        InvoiceQrCode = dr["INVOICE_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["INVOICE_QR_CODE"]) : "",
                    });
            }

            return Json(new
            {
                param.sEcho,
                iTotalRecords = result.Count(),
                iTotalDisplayRecords = dt != null && dt.Rows.Count > 0 ? Convert.ToInt32(dt.Rows[0]["COUNT_ROW"]?.ToString()) : 0,
                aaData = result
            });

        }

        [HttpGet]
        public IActionResult GetData(string Truck_No, string From_Date, string To_Date, string Mda_No, string Invoice_Qr_Code, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<MDA_Status>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = Mda_No ?? "" });
                oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.Varchar2) { Value = Truck_No ?? "" });
                oParams.Add(new OracleParameter("P_INVOICE_QR_CODE", OracleDbType.Varchar2) { Value = Invoice_Qr_Code ?? "" });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = From_Date ?? "" });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = To_Date ?? "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_MDA_STATUS_REPORT_NEW", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new MDA_Status
                        {
                            SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToString(dr["RNUM"]) : "",
                            MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                            MDAStatus = dr["MDA_STATUS"] != DBNull.Value ? Convert.ToString(dr["MDA_STATUS"]) : "",
                            MDAReceiveDate = dr["MDA_REC_DATE"] != DBNull.Value ? Convert.ToString(dr["MDA_REC_DATE"]) : "",
                            TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                            DriverName = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "",
                            CustomerName = dr["CUST_NAME"] != DBNull.Value ? Convert.ToString(dr["CUST_NAME"]) : "",
                            SKUCode = dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "",
                            SkuDesc = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
                            Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
                            LoadingInDateTimePrintedFrom = dr["LOADING_IN_DATETIME"] != DBNull.Value ? Convert.ToString(dr["LOADING_IN_DATETIME"]) : "",
                            LoadingOutDateTimePrintedFrom = dr["LOADING_OUT_DATETIME"] != DBNull.Value ? Convert.ToString(dr["LOADING_OUT_DATETIME"]) : "",
                            LoadingBayPrintedTo = dr["LOADING_BAY"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY"]) : "",
                            LoadingBayOperatorTo = dr["LOADING_BAY_OPERATOR"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY_OPERATOR"]) : "",
                            MDAQty = dr["MDA_QTY_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["MDA_QTY_SHIPPER"]) : 0,
                            MDAUpdateQty = dr["MDA_UPDATED_QTY_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["MDA_UPDATED_QTY_SHIPPER"]) : 0,
                            LoadedQty = dr["LOADED_QTY_SHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["LOADED_QTY_SHIPPER"]) : 0,
                            DispatchDateTime = dr["DISP_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["DISP_DATE_TIME"]) : "",
                            InvoiceQrCode = dr["INVOICE_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["INVOICE_QR_CODE"]) : "",
                        });

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            if (!string.IsNullOrEmpty(Mda_No))
                PageTitle_Secondary += "Mda No. : " + Mda_No.ToUpper();
            
            if (!string.IsNullOrEmpty(Invoice_Qr_Code))
                PageTitle_Secondary += " Invoice Qr Code. : " + Invoice_Qr_Code.ToUpper();
            
            if (!string.IsNullOrEmpty(Truck_No))
                PageTitle_Secondary += " Truck No. : " + Truck_No.ToUpper();

            if (!string.IsNullOrEmpty(From_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {From_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(To_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {To_Date.ToUpper()}";

            dynamic objFilter = new { Mda_No = Mda_No, Invoice_Qr_Code = Invoice_Qr_Code, Truck_No = Truck_No, From_Date = From_Date, To_Date = To_Date };

            if (isPrint == true)
                return View("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
            else
                return PartialView("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
        }
    }
}
