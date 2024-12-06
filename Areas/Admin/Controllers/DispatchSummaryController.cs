﻿
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class DispatchSummaryController : BaseController<ResponseModel<MDA_Status>>
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


        public ActionResult GetData_DispatchSummary(JqueryDatatableParam param)
        {   
            string MdaNo = HttpContext.Request.Query["MdaNo"];
            string TruckNo = HttpContext.Request.Query["TruckNo"];
            string PartyName = HttpContext.Request.Query["PartyName"];
            string Destination = HttpContext.Request.Query["Destination"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = MdaNo });
            oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            oParams.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.Varchar2) { Value = TruckNo });
            oParams.Add(new OracleParameter("P_PARTY_NAME", OracleDbType.Varchar2) { Value = PartyName });
            oParams.Add(new OracleParameter("P_DESTINATION", OracleDbType.Varchar2) { Value = Destination });
            oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
            oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISPATCH_SUMMARY_REPORT", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                        TransactionType = dr["TRANSACTIONTYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTIONTYPE"]) : "",
                        ArticleCode = dr["ARTICLECODE"] != DBNull.Value ? Convert.ToString(dr["ARTICLECODE"]) : "",
                        ArticleName = dr["ARTICLENAME"] != DBNull.Value ? Convert.ToString(dr["ARTICLENAME"]) : "",
                        GateOutDispatch = dr["DISP_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["DISP_DATE_TIME"]) :"",
                        DispatchFromType = dr["DISPATCHFROMTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMTYPE"]) : "",
                        DispatchFromCodeAndName = dr["DISPATCHFROMCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMCODENAME"]) : "",
                        DispatchToType = dr["DISPATCHTOTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOTYPE"]) : "",
                        DispatchToCodeAndName = dr["DISPATCHTOCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOCODENAME"]) : "",
                        DispatchedQtyKL = dr["DISPATCHEDQTYKL"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYKL"]) : 0,
                        DispatchedQtyShipper = dr["DISPATCHEDQTYSHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYSHIPPER"]) : 0,
                        DispatchedQtyUnits = dr["DISPATCHEDQTYUNITS"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYUNITS"]) : 0,
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
        public IActionResult GetData(string Truck_No, string From_Date, string To_Date, string Mda_No, string Party_Name, string Destination, bool withDetail = false, bool isPrint = false)
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
                oParams.Add(new OracleParameter("P_PARTY_NAME", OracleDbType.Varchar2) { Value = Party_Name ?? "" });
                oParams.Add(new OracleParameter("P_DESTINATION", OracleDbType.Varchar2) { Value = Destination ?? "" });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = From_Date ?? "" });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = To_Date ?? "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_DISPATCH_SUMMARY_REPORT_NEW", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new MDA_Status
                        {
                            MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                            TransactionType = dr["TRANSACTIONTYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTIONTYPE"]) : "",
                            ArticleCode = dr["ARTICLECODE"] != DBNull.Value ? Convert.ToString(dr["ARTICLECODE"]) : "",
                            ArticleName = dr["ARTICLENAME"] != DBNull.Value ? Convert.ToString(dr["ARTICLENAME"]) : "",
                            GateOutDispatch = dr["DISP_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["DISP_DATE_TIME"]) : "",
                            DispatchFromType = dr["DISPATCHFROMTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMTYPE"]) : "",
                            DispatchFromCodeAndName = dr["DISPATCHFROMCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMCODENAME"]) : "",
                            DispatchToType = dr["DISPATCHTOTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOTYPE"]) : "",
                            DispatchToCodeAndName = dr["DISPATCHTOCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOCODENAME"]) : "",
                            DispatchedQtyKL = dr["DISPATCHEDQTYKL"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYKL"]) : 0,
                            DispatchedQtyShipper = dr["DISPATCHEDQTYSHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYSHIPPER"]) : 0,
                            DispatchedQtyUnits = dr["DISPATCHEDQTYUNITS"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYUNITS"]) : 0,
                        });

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            if (!string.IsNullOrEmpty(Mda_No))
                PageTitle_Secondary = "Mda No. : " + Mda_No.ToUpper();

            if (!string.IsNullOrEmpty(Party_Name))
                PageTitle_Secondary += " Party Name : " + Party_Name.ToUpper();

            if (!string.IsNullOrEmpty(Destination))
                PageTitle_Secondary += " Destination : " + Destination.ToUpper();

            if (!string.IsNullOrEmpty(Truck_No))
                PageTitle_Secondary += " Truck No. : " + Truck_No.ToUpper();

            if (!string.IsNullOrEmpty(From_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {From_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(To_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {To_Date.ToUpper()}";

            dynamic objFilter = new { Mda_No = Mda_No, Party_Name = Party_Name, Destination = Destination, Truck_No = Truck_No, From_Date = From_Date, To_Date = To_Date };

            if (isPrint == true)
                return View("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
            else
                return PartialView("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
        }
    }
}