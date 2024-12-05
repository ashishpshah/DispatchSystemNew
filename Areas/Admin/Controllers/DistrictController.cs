using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class DistrictController : BaseController<ResponseModel<District>>
    {
        #region Loading
        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<District>();

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = -1 });
                    oParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = -1 });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = -1 });
                    oParams.Add(new MySqlParameter("P_STATE_ID", MySqlDbType.Int64) { Value = -1 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_DISTRICT_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                        CommonViewModel.ListObj.Add(new District()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            District_Name = dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "",
                            Code = dr["CODE"] != DBNull.Value ? Convert.ToString(dr["CODE"]) : "",
                            CountryId = dr["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dr["COUNTRY_ID"]) : 0,
                            State_Id = dr["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dr["STATE_ID"]) : 0,
                            State_Name = dr["STATE_NAME"] != DBNull.Value ? Convert.ToString(dr["STATE_NAME"]) : "",
                            Country_Name = dr["COUNTRY_NAME"] != DBNull.Value ? Convert.ToString(dr["COUNTRY_NAME"]) : "",
                            IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false
                        });
                }
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return View(CommonViewModel);
        }

        #endregion

        #region Methods
        public JsonResult GetStatelist(string Country_Id)
        {
            var obj = new List<SelectListItem>();

            try
            {
                CommonViewModel.ListObj = new List<District>();

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = Country_Id });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_STATE_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = Country_Id });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_STATE_GET", oParams, true);
                }

                obj = ValidateField.ToSelectList(dt, "ID", "NAME");

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(obj);
        }

        [HttpGet]
        public IActionResult Partial_AddEditForm(int id, int StateId, int CountryId)
        {
            var obj = new District();

            var list = new List<SelectListItem_Custom>();

            var dt = new DataTable();

            if (AppHttpContextAccessor.IsCloudDBActive)
            {
                try
                {
                    if (id > 0)
                    {
                        List<OracleParameter> oParams2 = new List<OracleParameter>();

                        oParams2.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                        oParams2.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = CountryId });
                        oParams2.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = StateId });
                        oParams2.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams2.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams2.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams2.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams2.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams2, true);

                        if (dt != null && dt.Rows.Count > 0)
                        {
                            obj = new District()
                            {
                                Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
                                State_Id = dt.Rows[0]["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["STATE_ID"]) : 0,
                                CountryId = dt.Rows[0]["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["COUNTRY_ID"]) : 0,
                                District_Name = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "",
                                Country_Name = dt.Rows[0]["COUNTRY_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["COUNTRY_NAME"]) : "",
                                State_Name = dt.Rows[0]["STATE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["STATE_NAME"]) : "",
                                IsActive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false
                            };
                        }

                    }
                    else
                    {
                        obj.State_Id = StateId;
                    }

                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                if (list == null) list = new List<SelectListItem_Custom>();

                list.Add(new SelectListItem_Custom("0", "-- Select --", "C"));
                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));

                if (list == null) list = new List<SelectListItem_Custom>();

                oParams.Insert(1, new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = (obj != null ? obj.CountryId : 0) });

                list.Add(new SelectListItem_Custom("0", "-- Select --", "S"));
                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_STATE_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));
            }
            else
            {
                try
                {
                    if (id > 0)
                    {
                        List<MySqlParameter> oParams2 = new List<MySqlParameter>();

                        oParams2.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
                        oParams2.Add(new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = CountryId });
                        oParams2.Add(new MySqlParameter("P_STATE_ID", MySqlDbType.Int64) { Value = StateId });
                        oParams2.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                        oParams2.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams2.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams2.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams2.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_DISTRICT_GET", oParams2, true);

                        if (dt != null && dt.Rows.Count > 0)
                        {
                            obj = new District()
                            {
                                Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
                                State_Id = dt.Rows[0]["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["STATE_ID"]) : 0,
                                CountryId = dt.Rows[0]["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["COUNTRY_ID"]) : 0,
                                District_Name = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "",
                                Country_Name = dt.Rows[0]["COUNTRY_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["COUNTRY_NAME"]) : "",
                                State_Name = dt.Rows[0]["STATE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["STATE_NAME"]) : "",
                                IsActive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false
                            };
                        }

                    }
                    else
                    {
                        obj.State_Id = StateId;
                    }

                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

                var oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                if (list == null) list = new List<SelectListItem_Custom>();

                list.Add(new SelectListItem_Custom("0", "-- Select --", "C"));
                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_COUNTRY_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));

                if (list == null) list = new List<SelectListItem_Custom>();

                oParams.Insert(1, new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = (obj != null ? obj.CountryId : 0) });

                list.Add(new SelectListItem_Custom("0", "-- Select --", "S"));
                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_STATE_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

            }

            CommonViewModel.SelectListItems = list;

            CommonViewModel.Obj = obj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);

        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(District obj)
        {
            try
            {
                if (obj == null)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter District details";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }



                if (string.IsNullOrEmpty(obj.District_Name))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter District_Name";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = obj.Id });
                    oParams.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2) { Value = obj.Code });
                    oParams.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = obj.District_Name });
                    oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = obj.CountryId });
                    oParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = obj.State_Id });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = obj.IsActive ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_DISTRICT_SAVE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = obj.Id });
                    oParams.Add(new MySqlParameter("P_CODE", MySqlDbType.VarString) { Value = obj.Code });
                    oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarString) { Value = obj.District_Name });
                    oParams.Add(new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = obj.CountryId });
                    oParams.Add(new MySqlParameter("P_STATE_ID", MySqlDbType.Int64) { Value = obj.State_Id });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = obj.IsActive ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_DISTRICT_SAVE", oParams, true);
                }

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = IsSuccess;
                CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                CommonViewModel.Message = response;

                CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

                return Json(CommonViewModel);
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

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_DISTRICT_DELETE", oParams, true);
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

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_DISTRICT_DELETE", oParams, true);
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
