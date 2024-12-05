using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;
using System.Security.Policy;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class LOVController : BaseController<ResponseModel<LOV>>
    {
        #region Loading

        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<LOV>();

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        CommonViewModel.ListObj.Add(new LOV()
                        {
                            Lov_Column = dr["Lov_Column"] != DBNull.Value ? Convert.ToString(dr["Lov_Column"]) : "",
                            Lov_Code = dr["Lov_Code"] != DBNull.Value ? Convert.ToString(dr["Lov_Code"]) : "",
                            Lov_Desc = dr["Lov_Desc"] != DBNull.Value ? Convert.ToString(dr["Lov_Desc"]) : "",
                            IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false
                        });
                    }
                }
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return View(CommonViewModel);
        }

        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Partial_AddEditForm(string lov_column)
        {
            var obj = new LOV();
            CommonViewModel.ListObj = new List<LOV>();
            try
            {
                if (!string.IsNullOrEmpty(lov_column))
                {
                    var dt = new DataTable();

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = lov_column });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams, true);
                    }
                    else
                    {
                        List<MySqlParameter> oParams = new List<MySqlParameter>();

                        oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = lov_column });
                        oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);
                    }

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        obj = new LOV()
                        {
                            Lov_Column = dt.Rows[0]["Lov_Column"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Column"]) : "",
                            Lov_Code = dt.Rows[0]["Lov_Code"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Code"]) : "",
                            Lov_Desc = dt.Rows[0]["Lov_Desc"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Desc"]) : "",
                            IsActive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false
                        };

                        foreach (DataRow dr in dt.Rows)
                        {
                            CommonViewModel.ListObj.Add(new LOV()
                            {
                                Lov_Column = dr["Lov_Column"] != DBNull.Value ? Convert.ToString(dr["Lov_Column"]) : "",
                                Lov_Code = dr["Lov_Code"] != DBNull.Value ? Convert.ToString(dr["Lov_Code"]) : "",
                                Lov_Desc = dr["Lov_Desc"] != DBNull.Value ? Convert.ToString(dr["Lov_Desc"]) : "",
                                IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false
                            });
                        }
                    }
                }



            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.Obj = obj;

            obj.listLov = CommonViewModel.ListObj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);

        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(LOV viewModel)
        {
            try
            {
                if (viewModel.listLov != null && viewModel.listLov.Count() > 0)
                    viewModel.Lovs = string.Join("<#>", viewModel.listLov.Select(x => x.Lov_Code + "|" + x.Lov_Desc + "|" + (x.IsActive ? "Y" : "N") + "|" + x.Display_Seq_No).ToArray());

                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = viewModel.Lov_Column });
                    oParams.Add(new OracleParameter("P_LOVS", OracleDbType.Varchar2) { Value = viewModel.Lovs });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_LOV_SAVE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = viewModel.Lov_Column });
                    oParams.Add(new MySqlParameter("P_LOVS", MySqlDbType.VarString) { Value = viewModel.Lovs });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_LOV_SAVE", oParams, true);
                }

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = IsSuccess;
                CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                CommonViewModel.Message = response;

                CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

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
        public JsonResult DeleteConfirmed(string lov_column)
        {
            try
            {
                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = lov_column });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_LOV_DELETE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = lov_column });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_LOV_DELETE", oParams, true);
                }

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = IsSuccess;
                CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                CommonViewModel.Message = response;

                CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

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