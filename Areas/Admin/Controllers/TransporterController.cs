using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class TransporterController : BaseController<ResponseModel<Transport>>
    {
        #region Loading
        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<Transport>();

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_TRANSPORTER_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                        CommonViewModel.ListObj.Add(new Transport()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            tptr_cd = dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) : "",
                            IS_ENTRY_MANUAL = dr["IS_ENTRY_MANUAL"] != DBNull.Value ? Convert.ToBoolean(dr["IS_ENTRY_MANUAL"]) : false,
                            tptr_name = dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "",
                            IsActive = dr["IS_ACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["IS_ACTIVE"]) : false,
                        });
                }
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return View(CommonViewModel);
        }

        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Partial_AddEditForm(int Id)
        {
            var obj = new Transport();

            try
            {
                if (Id > 0)
                {
                    var dt = new DataTable();

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_TRANSPORTER_GET", oParams, true);
                    }
                    else
                    {
                        List<MySqlParameter> oParams = new List<MySqlParameter>();

                        oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Id });
                        oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);
                    }

                    if (dt != null && dt.Rows.Count > 0)
                        obj = new Transport()
                        {
                            Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
                            tptr_cd = dt.Rows[0]["TPTR_CD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TPTR_CD"]) : "",
                            IS_ENTRY_MANUAL = dt.Rows[0]["IS_ENTRY_MANUAL"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_ENTRY_MANUAL"]) : false,
                            tptr_name = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "",
                            IsActive = dt.Rows[0]["IS_ACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_ACTIVE"]) : false,
                        };
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.Obj = obj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);

        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(Transport viewModel)
        {
            try
            {
                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2) { Value = viewModel.tptr_cd });
                    oParams.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = viewModel.tptr_name });
                    oParams.Add(new OracleParameter("P_IS_ENTRY_MANUAL", OracleDbType.Varchar2) { Value = viewModel.IS_ENTRY_MANUAL ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_TRANSPORTER_SAVE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new MySqlParameter("P_CODE", MySqlDbType.VarString) { Value = viewModel.tptr_cd });
                    oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarString) { Value = viewModel.tptr_name });
                    oParams.Add(new MySqlParameter("P_IS_ENTRY_MANUAL", MySqlDbType.VarString) { Value = viewModel.IS_ENTRY_MANUAL ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_TRANSPORTER_SAVE", oParams, true);
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
        public JsonResult DeleteConfirmed(long id = 0)
        {
            try
            {
                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_TRANSPORTER_DELETE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_TRANSPORTER_DELETE", oParams, true);
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

