
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class MDABatchNoListController : BaseController<ResponseModel<MDA_Status>>
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


        public ActionResult GetData_MDABatchNoList(JqueryDatatableParam param)
        {
            string MdaNo = HttpContext.Request.Query["MdaNo"];
            string Type = HttpContext.Request.Query["Type"];

            List<MDA_Status> result = new List<MDA_Status>();

            //List<OracleParameter> oParams = new List<OracleParameter>();

            //oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = MdaNo });
            //oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            //oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            //oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            //oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            //oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            //oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            //oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            List<MySqlParameter> oParams = new List<MySqlParameter>();

            // Add parameters to the list
            oParams.Add(new MySqlParameter("P_MDA_NO", MySqlDbType.VarChar) { Value = MdaNo });
            oParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.VarChar) { Value = param.sSearch ?? "" });
            oParams.Add(new MySqlParameter("P_DISPLAY_LENGTH", MySqlDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new MySqlParameter("P_DISPLAY_START", MySqlDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            //oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            //oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            //oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_MDA_BATCH_NO_LIST_REPORT", oParams, true);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new MDA_Status
                    {
                        SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToString(dr["RNUM"]) : "",
                        QRCode = dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "",
                        BatchNo = dr["batch_no"] != DBNull.Value ? Convert.ToString(dr["batch_no"]) : "",
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
