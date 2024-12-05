
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class MDAWiseDispatchSummaryController : BaseController<ResponseModel<MDA_Status>>
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


        public ActionResult GetData_MdaWiseDispatchSummary(JqueryDatatableParam param)
        {   
            string MdaNo = HttpContext.Request.Query["MdaNo"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            List<MySqlParameter> mySqlParams = new List<MySqlParameter>();

            mySqlParams.Add(new MySqlParameter("P_MDA_NO", MySqlDbType.VarChar) { Value = MdaNo });
            mySqlParams.Add(new MySqlParameter("P_FROM_DATE", MySqlDbType.VarChar) { Value = FromDate });
            mySqlParams.Add(new MySqlParameter("P_TO_DATE", MySqlDbType.VarChar) { Value = ToDate });
            //mySqlParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.VarChar) { Value = param.sSearch ?? "" });
            mySqlParams.Add(new MySqlParameter("P_DISPLAY_LENGTH", MySqlDbType.Int64) { Value = param.iDisplayLength });
            mySqlParams.Add(new MySqlParameter("P_DISPLAY_START", MySqlDbType.Int64) { Value = param.iDisplayStart });
            mySqlParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            mySqlParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            mySqlParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            mySqlParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_MDA_WISE_DISPATCH_SUMMARY_REPORT", mySqlParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                        MDAReceiveDate = dr["MDA_DT"] != DBNull.Value ? Convert.ToString(dr["MDA_DT"]) : "",
                        TruckNo = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
                        BatchNo = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                        ManufacturingDate = dr["MFG_DT"] != DBNull.Value ? Convert.ToString(dr["MFG_DT"]) : "",
                        MDAQty = dr["Shipper_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Shipper_Qty"]) : 0,
                        DispatchedQtyKL = dr["Bottle_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Bottle_Qty"]) : 0,
                        LoadingBayPrintedTo = dr["LoadingBay"] != DBNull.Value ? Convert.ToString(dr["LoadingBay"]) : "",
                        SkuDesc = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
                        CustomerName = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
                        Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
                        Reason = dr["ADDRESS"] != DBNull.Value ? Convert.ToString(dr["ADDRESS"]) : "",
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
    }
}
