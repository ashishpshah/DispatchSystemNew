
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class GateInCancelController : BaseController<ResponseModel<MDA_Status>>
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


        public ActionResult GetData_GateInCancel(JqueryDatatableParam param)
        {
            string TruckNo = HttpContext.Request.Query["TruckNo"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_TRUCKNO", OracleDbType.Varchar2) { Value = TruckNo });
            oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
            oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            //var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_GATE_IN_CANCEL_REPORT", oParams, true);
            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_CANCEL_GATEIN_REPORT", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                        MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                        Transporter = dr["TRANSPORTER"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER"]) : "",
                        DriverName = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "",
                        DriverContact = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "",
                        RFID = dr["RFID"] != DBNull.Value ? Convert.ToString(dr["RFID"]) : "",
                        GateInDateTime = dr["GATE_IN_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["GATE_IN_DATE_TIME"]) : "",
                        WeighOutDateTime = dr["WEIGHT_OUT_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["WEIGHT_OUT_DATE_TIME"]) : "",
                        GateOutDispatch = dr["GATE_OUT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT"]) : "",
                        Reason = dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "",
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
        public IActionResult GetData(string Truck_No, string From_Date, string To_Date, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<MDA_Status>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.Varchar2) { Value = Truck_No ?? "" });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = From_Date ?? "" });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = To_Date ?? "" });

                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_CANCEL_GATE_IN", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new MDA_Status
                        {
                            SrNo = dr["SrNo"] != DBNull.Value ? Convert.ToString(dr["SrNo"]) : "",
                            TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                            MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                            Transporter = dr["TRANSPORTER"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER"]) : "",
                            DriverName = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "",
                            DriverContact = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "",
                            RFID = dr["RFID"] != DBNull.Value ? Convert.ToString(dr["RFID"]) : "",
                            GateInDateTime = dr["GATE_IN_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["GATE_IN_DATE_TIME"]) : "",
                            WeighOutDateTime = dr["WEIGHT_OUT_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["WEIGHT_OUT_DATE_TIME"]) : "",
                            GateOutDispatch = dr["GATE_OUT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT"]) : "",
                            Reason = dr["CANCEL_GATE_REASON"] != DBNull.Value ? Convert.ToString(dr["CANCEL_GATE_REASON"]) : "",
                            Destination = dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : ""
                        });

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            if (!string.IsNullOrEmpty(Truck_No))
                PageTitle_Secondary = "Truck No. : " + Truck_No.ToUpper();

            if (!string.IsNullOrEmpty(From_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {From_Date.ToUpper()}";

            if (!string.IsNullOrEmpty(To_Date))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {To_Date.ToUpper()}";

            dynamic objFilter = new { Truck_No = Truck_No, From_Date = From_Date, To_Date = To_Date };

            if (isPrint == true)
                return View("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
            else
                return PartialView("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
        }

    }
}
