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
    public class CountryController : BaseController<ResponseModel<Country>>
    {
        #region Loading

        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<Country>();

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

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);
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

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_COUNTRY_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        CommonViewModel.ListObj.Add(new Country()
                        {
                            CountryId = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            Country_Name = dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "",
                            Code = dr["CODE"] != DBNull.Value ? Convert.ToString(dr["CODE"]) : "",
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
        public IActionResult Partial_AddEditForm(int id)
        {
            var obj = new Country();

            try
            {
                if (id > 0)
                {
                    var dt = new DataTable();

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);
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

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_COUNTRY_GET", oParams, true);
                    }

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        obj = new Country()
                        {
                            CountryId = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
                            Country_Name = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "",
                            Code = dt.Rows[0]["CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CODE"]) : "",
                            IsActive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false
                        };
                    }
                }

            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.Obj = obj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);

        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(Country viewModel)
        {
            try
            {
                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.CountryId });
                    oParams.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2) { Value = viewModel.Code });
                    oParams.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = viewModel.Country_Name });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_COUNTRY_SAVE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.CountryId });
                    oParams.Add(new MySqlParameter("P_CODE", MySqlDbType.VarString) { Value = viewModel.Code });
                    oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarString) { Value = viewModel.Country_Name });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_COUNTRY_SAVE", oParams, true);
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

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_COUNTRY_DELETE", oParams, true);
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

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_COUNTRY_DELETE", oParams, true);
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