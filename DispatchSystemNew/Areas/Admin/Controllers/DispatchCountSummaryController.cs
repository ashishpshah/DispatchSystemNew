
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class DispatchCountSummaryController : BaseController<ResponseModel<MDA_Status>>
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


        public ActionResult GetData_DispatchCountSummary(JqueryDatatableParam param)
        {
            string MdaNo = HttpContext.Request.Query["MdaNo"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = MdaNo });
            oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
            oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
            //oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_Dispatch_Count_Summary_REPORT", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                        MDAReceiveDate = dr["MDA_DATE"] != DBNull.Value ? Convert.ToString(dr["MDA_DATE"]) : "",
                        TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                        MDAQty = dr["MDA_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SHIPPER_QTY"]) : 0,
                        DispatchedQtyKL = dr["MDA_BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["MDA_BOTTLE_QTY"]) : 0,
                        SKUCode = dr["PRODUCT_SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_SKU_CODE"]) : "",
                        SkuDesc = dr["PRODUT_SKU_DESC"] != DBNull.Value ? Convert.ToString(dr["PRODUT_SKU_DESC"]) : "",
                        Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
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
        public IActionResult GetData(string Mda_No, string From_Date, string To_Date, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<MDA_Status>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = Mda_No ?? "" });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = From_Date ?? "" });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = To_Date ?? "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_Dispatch_Count_Summary_REPORT_NEW", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new MDA_Status
                        {
                            //MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                            //MDAReceiveDate = dr["MDA_DATE"] != DBNull.Value ? Convert.ToString(dr["MDA_DATE"]) : "",
                            //TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                            //MDAQty = dr["MDA_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SHIPPER_QTY"]) : 0,
                            //DispatchedQtyKL = dr["MDA_BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["MDA_BOTTLE_QTY"]) : 0,
                            //SKUCode = dr["PRODUCT_SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_SKU_CODE"]) : "",
                            //SkuDesc = dr["PRODUT_SKU_DESC"] != DBNull.Value ? Convert.ToString(dr["PRODUT_SKU_DESC"]) : "",
                            //Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
                            SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToString(dr["SR_NO"]) : "",
                            MDAReceiveDate = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : "",
                            TruckNo = dr["COUNT_TRUCK"] != DBNull.Value ? Convert.ToString(dr["COUNT_TRUCK"]) : "",
                            MDANo = dr["COUNT_MDA"] != DBNull.Value ? Convert.ToString(dr["COUNT_MDA"]) : "",
                            TotalShipperQTY = dr["SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QTY"]) : 0,
                            DispatchedQtyKL = dr["BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QTY"]) : 0,
                            //PlantName = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
                            SkuDesc = dr["PRODUCT_NAME"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_NAME"]) : ""
                        });
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            if (!string.IsNullOrEmpty(Mda_No))
                PageTitle_Secondary = "Mda No. : " + Mda_No.ToUpper();

            if (!string.IsNullOrEmpty(From_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {From_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(To_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {To_Date.ToUpper()}";

            dynamic objFilter = new { Mda_No = Mda_No, From_Date = From_Date, To_Date = To_Date };

            if (isPrint == true)
                return View("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
            else
                return PartialView("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
        }
    }
}
