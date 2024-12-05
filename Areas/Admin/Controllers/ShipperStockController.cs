
using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Wordprocessing;
using Humanizer;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class ShipperStockController : BaseController<ResponseModel<MDA_Status>>
    {
        public IActionResult Index()
        {
            var list = new List<SelectListItem_Custom>();

            CommonViewModel.Obj = new MDA_Status();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PLANT_GET", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                CommonViewModel.Obj.PlantId = Common.Get_Session_Int(SessionKey.PLANT_ID);
                CommonViewModel.Obj.PlantName = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "";
            }

            return View(CommonViewModel);
        }


        public ActionResult GetData_ShipperStock(JqueryDatatableParam param)
        {   
            string BatchNo = HttpContext.Request.Query["BatchNo"];
            string MfgFromDate = HttpContext.Request.Query["MfgFromDate"];
            string MfgToDate = HttpContext.Request.Query["MfgToDate"];
            string ExpiryFromDate = HttpContext.Request.Query["ExpiryFromDate"];
            string ExpiryToDate = HttpContext.Request.Query["ExpiryToDate"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_BATCH_NO", OracleDbType.Varchar2) { Value = BatchNo });
            oParams.Add(new OracleParameter("P_MFG_FROM_DATE", OracleDbType.Varchar2) { Value = MfgFromDate });
            oParams.Add(new OracleParameter("P_MFG_TO_DATE", OracleDbType.Varchar2) { Value = MfgToDate });
            oParams.Add(new OracleParameter("P_EXPIRY_FROM_DATE", OracleDbType.Varchar2) { Value = ExpiryFromDate });
            oParams.Add(new OracleParameter("P_EXPIRY_TO_DATE", OracleDbType.Varchar2) { Value = ExpiryToDate });
            oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_REPORT_AVAILABLE_SHIPPER_QR_CODE", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        BatchNo = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                        ManufacturingDate = dr["MFG_DATE"] != DBNull.Value ? Convert.ToString(dr["MFG_DATE"]) : "",
                        ExpiryDate = dr["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dr["EXPIRY_DATE"]) : "",
                        TotalShipperQTY = dr["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_SHIPPER_QTY"]) : 0,
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
        public IActionResult GetData(string Batch_No,string Mfg_From_Date, string Mfg_To_Date, string Expiry_From_Date, string Expiry_To_Date, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<MDA_Status>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<OracleParameter>();


                oParams.Add(new OracleParameter("P_BATCH_NO", OracleDbType.Varchar2) { Value = Batch_No });
                oParams.Add(new OracleParameter("P_MFG_FROM_DATE", OracleDbType.Varchar2) { Value = Mfg_From_Date });
                oParams.Add(new OracleParameter("P_MFG_TO_DATE", OracleDbType.Varchar2) { Value = Mfg_To_Date });
                oParams.Add(new OracleParameter("P_EXPIRY_FROM_DATE", OracleDbType.Varchar2) { Value = Expiry_From_Date });
                oParams.Add(new OracleParameter("P_EXPIRY_TO_DATE", OracleDbType.Varchar2) { Value = Expiry_To_Date });
                oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_AVAILABLE_SHIPPER_QR_CODE_NEW", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new MDA_Status
                        {
                            BatchNo = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                            ManufacturingDate = dr["MFG_DATE"] != DBNull.Value ? Convert.ToString(dr["MFG_DATE"]) : "",
                            ExpiryDate = dr["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dr["EXPIRY_DATE"]) : "",
                            TotalShipperQTY = dr["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_SHIPPER_QTY"]) : 0,
                        });

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            if (!string.IsNullOrEmpty(Batch_No))
                PageTitle_Secondary = "Batch No. : " + Batch_No.ToUpper();

            if (!string.IsNullOrEmpty(Mfg_From_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}Manufacturing From Date : {Mfg_From_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(Mfg_To_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {Mfg_To_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(Expiry_From_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}Expiry From Date : {Expiry_From_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(Expiry_To_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {Expiry_To_Date.ToUpper()}";

            dynamic objFilter = new { Batch_No = Batch_No, Mfg_From_Date = Mfg_From_Date, Mfg_To_Date = Mfg_To_Date, Expiry_From_Date = Expiry_From_Date, Expiry_To_Date = Expiry_To_Date };

            if (isPrint == true)
                return View("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
            else
                return PartialView("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
        }
    }
}
