
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Collections.Generic;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class UserController : BaseController<ResponseModel<User>>
    {
        #region Loading
        public IActionResult Index()
        {
            var list = new List<User>();

            try
            {
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

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_USER_GET", oParams, true);
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

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_USER_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        list.Add(new User()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            Plant_Id = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PLANT_ID"]) : 0,
                            Role_Id = dr["ROLE_ID"] != DBNull.Value ? Convert.ToInt32(dr["ROLE_ID"]) : 0,
                            First_Name = dr["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dr["FIRST_NAME"]) : "",
                            Last_Name = dr["LAST_NAME"] != DBNull.Value ? Convert.ToString(dr["LAST_NAME"]) : "",
                            Username = dr["USER_NAME"] != DBNull.Value ? Convert.ToString(dr["USER_NAME"]) : "",
                            Plant_Name = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
                            Role_Name = dr["ROLE_NAME"] != DBNull.Value ? Convert.ToString(dr["ROLE_NAME"]) : "",
                            Is_Active = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
                            Is_Lock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dr["IS_LOCK"]) : false,
                            MobileNo = dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "",
                            Email_Id = dr["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dr["EMAIL_ID"]) : "",
                        });
                    }
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.ListObj = list;

            return View(CommonViewModel);
        }
        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Partial_AddEditForm(long id)
        {
            var obj = new User();

            var list = new List<SelectListItem_Custom>();

            var dt = new DataTable();

            if (id > 0)
            {
                try
                {
                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_USER_GET", oParams, true);
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

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_USER_GET", oParams, true);
                    }

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        obj = new User()
                        {
                            Id = dt.Rows[0]["Id"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["Id"]) : 0,
                            Plant_Id = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
                            Plant_Name = dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "",
                            Role_Id = dt.Rows[0]["ROLE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ROLE_ID"]) : 0,
                            Role_Name = dt.Rows[0]["ROLE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ROLE_NAME"]) : "",
                            Username = dt.Rows[0]["USER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["USER_NAME"]) : "",
                            First_Name = dt.Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FIRST_NAME"]) : "",
                            Middle_Name = dt.Rows[0]["MIDDLE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MIDDLE_NAME"]) : "",
                            Last_Name = dt.Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["LAST_NAME"]) : "",
                            MobileNo = dt.Rows[0]["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MOBILE_NO"]) : "",
                            Alt_Mobile_No = dt.Rows[0]["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_MOBILE_NO"]) : "",
                            Email_Id = dt.Rows[0]["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EMAIL_ID"]) : "",
                            Alt_Email_Id = dt.Rows[0]["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_EMAIL_ID"]) : "",
                            Full_Address = dt.Rows[0]["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FULL_ADDRESS"]) : "",
                            City = dt.Rows[0]["CITY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CITY"]) : "",
                            Postal_Code = dt.Rows[0]["POSTAL_CODE"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["POSTAL_CODE"]) : 0,
                            Is_Active = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false,
                            Is_Lock = dt.Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_LOCK"]) : false,
                            Country_Id = dt.Rows[0]["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["COUNTRY_ID"]) : 0,
                            State_Id = dt.Rows[0]["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["STATE_ID"]) : 0,
                            District_Id = dt.Rows[0]["DISTRICT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["DISTRICT_ID"]) : 0,
                            Plant_Role = dt.Rows[0]["PLANT_ROLE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_ROLE"]) : "",
                            Default_Plant = dt.Rows[0]["DEFAULT_PLANT"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["DEFAULT_PLANT"]) : 0,
                        };
                    }

                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            }


            list = new List<SelectListItem_Custom>();
            dt = new DataTable();

            if (AppHttpContextAccessor.IsCloudDBActive)
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PLANT_GET", oParams, true);

                list.Insert(0, new SelectListItem_Custom("0", "-- Select --", "P"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "P"));

                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "R"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "R"));


                if (list == null) list = new List<SelectListItem_Custom>();

                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "C"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));

                //if (list == null) list = new List<SelectListItem_Custom>();

                oParams.Insert(1, new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = (obj != null ? obj.Country_Id : 0) });

                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_STATE_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "S"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

                //if (list == null) list = new List<SelectListItem_Custom>();

                oParams.Insert(2, new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = (obj != null ? obj.State_Id : 0) });

                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "D"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));

                if (obj != null && string.IsNullOrEmpty(obj.Plant_Role))
                    obj.Plant_Role = Common.Get_Session_Int(SessionKey.PLANT_ID) + "|" + (list.Where(x => x.Group == "R").Select(x => x.Value).FirstOrDefault());

                if (obj != null && obj.Default_Plant <= 0)
                    obj.Default_Plant = Common.Get_Session_Int(SessionKey.PLANT_ID);

            }
            else
            {
                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PLANT_GET", oParams, true);

                list.Insert(0, new SelectListItem_Custom("0", "-- Select --", "P"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "P"));

                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_ROLE_GET", oParams, true);

                list.Insert(0, new SelectListItem_Custom("0", "-- Select --", "R"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "R"));


                if (list == null) list = new List<SelectListItem_Custom>();

                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_COUNTRY_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "C"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));

                //if (list == null) list = new List<SelectListItem_Custom>();

                oParams.Insert(1, new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = (obj != null ? obj.Country_Id : 0) });

                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_STATE_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "S"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

                //if (list == null) list = new List<SelectListItem_Custom>();

                oParams.Insert(2, new MySqlParameter("P_STATE_ID", MySqlDbType.Int64) { Value = (obj != null ? obj.State_Id : 0) });

                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_DISTRICT_GET", oParams, true);

                list.Add(new SelectListItem_Custom("0", "-- Select --", "D"));

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));

                if (obj != null && string.IsNullOrEmpty(obj.Plant_Role))
                    obj.Plant_Role = Common.Get_Session_Int(SessionKey.PLANT_ID) + "|" + (list.Where(x => x.Group == "R").Select(x => x.Value).FirstOrDefault());

                if (obj != null && obj.Default_Plant <= 0)
                    obj.Default_Plant = Common.Get_Session_Int(SessionKey.PLANT_ID);

            }

            CommonViewModel.SelectListItems = list;

            CommonViewModel.Obj = obj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);
        }

        [HttpGet]
        public IActionResult Show_Menu(long RoleId = 0)
        {
            if (RoleId > 0)
                try
                {
                    var dt = new DataTable();

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = RoleId });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", oParams, true);
                    }
                    else
                    {
                        List<MySqlParameter> oParams = new List<MySqlParameter>();

                        oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = RoleId });
                        oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                        //oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_ROLE_GET", oParams, false);
                    }


                    if (dt != null && dt.Rows.Count > 0)
                    {
                        var SelectedMenu = dt.Rows[0]["MENUS_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MENUS_NAME"]) : "";

                        var strHTML = "<div class=\"row col-12 w-100\"><table id=\"table_Common\" class=\"table table-bordered table-striped w-100 table_Common\"><thead><tr><th width=\"5%\">Sr. No.</th><th>Name</th></tr></thead><tbody>#</tbody></table></div>";

                        var rows = "";

                        var i = 0;
                        if (!string.IsNullOrEmpty(SelectedMenu) && SelectedMenu.Contains("||"))
                            foreach (string item in SelectedMenu.Split("||"))
                                rows = rows + $"<tr><td>{++i}</td><td>{item}</td></tr>";
                        else if (!string.IsNullOrEmpty(SelectedMenu))
                            rows = rows + $"<tr><td>{++i}</td><td>{SelectedMenu}</td></tr>";

                        strHTML = strHTML.Replace("#", rows);

                        return Json(strHTML);
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            return Json(null);
        }

        [HttpPost]
        public JsonResult GetStateList(long Country_Id = 0)
        {
            var list = new List<SelectListItem_Custom>();
            try
            {
                list.Add(new SelectListItem_Custom("0", "-- Select --", ""));

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = Country_Id });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
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
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_STATE_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(list);
        }

        [HttpPost]
        public JsonResult GetDistrictList(long State_Id = 0)
        {
            var list = new List<SelectListItem_Custom>();
            try
            {
                list.Add(new SelectListItem_Custom("0", "-- Select --", ""));

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = -1 });
                    oParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = State_Id });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
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
                    oParams.Add(new MySqlParameter("P_STATE_ID", MySqlDbType.Int64) { Value = State_Id });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_DISTRICT_GET", oParams);
                }

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(list);
        }

        [HttpPost]
        public JsonResult GetRoleByPlant(long plant_Id = 0)
        {
            var list = new List<SelectListItem_Custom>();
            try
            {
                list.Add(new SelectListItem_Custom("0", "-- Select --", ""));

                var dt = new DataTable();

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_ROLE_GET", oParams);
                }

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "R"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(list);
        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(User viewModel)
        {
            try
            {
                if (viewModel == null)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter user details";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Username))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter user name";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Password) && viewModel.Id == 0)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter password";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.First_Name))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter first name";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Last_Name))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter last name";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                //////////////////////////////////////////////////

                if (string.IsNullOrEmpty(viewModel.MobileNo))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter mobile no.";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                if (string.IsNullOrEmpty(viewModel.Email_Id))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter email id";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Full_Address))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter full address";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                //////////////////////////////////////////////////

                if (viewModel.MobileNo != null && !ValidateField.IsValidMobileNo(viewModel.MobileNo))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid mobile No.";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                if (viewModel.Alt_Mobile_No != null && !ValidateField.IsValidMobileNo(viewModel.Alt_Mobile_No))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid alt mobile No.";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                if (viewModel.Email_Id != null && !ValidateField.IsValidEmail(viewModel.Email_Id))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid email id";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                if (viewModel.Alt_Email_Id != null && !ValidateField.IsValidEmail(viewModel.Alt_Email_Id))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid alt email id";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    return Json(CommonViewModel);
                }
                if (viewModel.IsPassword_Reset == true)
                    viewModel.Password = "12345";

                if (viewModel != null && viewModel.Default_Plant <= 0)
                    viewModel.Default_Plant = Common.Get_Session_Int(SessionKey.PLANT_ID);

                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();


                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new OracleParameter("P_USER_NAME", OracleDbType.Varchar2) { Value = viewModel.Username });
                    oParams.Add(new OracleParameter("P_USER_PASSWORD", OracleDbType.Varchar2) { Value = Common.Encrypt(viewModel.Password) });
                    oParams.Add(new OracleParameter("P_FIRST_NAME", OracleDbType.Varchar2) { Value = viewModel.First_Name });
                    oParams.Add(new OracleParameter("P_MIDDLE_NAME", OracleDbType.Varchar2) { Value = viewModel.Middle_Name });
                    oParams.Add(new OracleParameter("P_LAST_NAME", OracleDbType.Varchar2) { Value = viewModel.Last_Name });
                    oParams.Add(new OracleParameter("P_MOBILE_NO", OracleDbType.Varchar2) { Value = viewModel.MobileNo });
                    oParams.Add(new OracleParameter("P_ALT_MOBILE_NO", OracleDbType.Varchar2) { Value = viewModel.Alt_Mobile_No });
                    oParams.Add(new OracleParameter("P_EMAIL_ID", OracleDbType.Varchar2) { Value = viewModel.Email_Id });
                    oParams.Add(new OracleParameter("P_ALT_EMAIL_ID", OracleDbType.Varchar2) { Value = viewModel.Alt_Email_Id });
                    oParams.Add(new OracleParameter("P_FULL_ADDRESS", OracleDbType.Varchar2) { Value = viewModel.Full_Address });
                    oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = viewModel.Country_Id });
                    oParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = viewModel.State_Id });
                    oParams.Add(new OracleParameter("P_DISTRICT_ID", OracleDbType.Int64) { Value = viewModel.District_Id });
                    oParams.Add(new OracleParameter("P_CITY", OracleDbType.Varchar2) { Value = viewModel.City });
                    oParams.Add(new OracleParameter("P_POSTAL_CODE", OracleDbType.Varchar2) { Value = viewModel.Postal_Code });
                    oParams.Add(new OracleParameter("P_EMP_CODE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_EMP_DESIGNATION_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_EMP_WORK_SHIFT_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_EMP_WORK_STATION_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_IS_LOCK", OracleDbType.Varchar2) { Value = viewModel.Is_Lock ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_NOTE_FEEDBACK", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.Is_Active ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ROLE", OracleDbType.Varchar2) { Value = viewModel.Plant_Role ?? "" });
                    oParams.Add(new OracleParameter("P_DEFAULT_PLANT", OracleDbType.Int64) { Value = viewModel.Default_Plant });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_USER_SAVE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new MySqlParameter("P_USER_NAME", MySqlDbType.VarString) { Value = viewModel.Username });
                    oParams.Add(new MySqlParameter("P_USER_PASSWORD", MySqlDbType.VarString) { Value = Common.Encrypt(viewModel.Password) });
                    oParams.Add(new MySqlParameter("P_FIRST_NAME", MySqlDbType.VarString) { Value = viewModel.First_Name });
                    oParams.Add(new MySqlParameter("P_MIDDLE_NAME", MySqlDbType.VarString) { Value = viewModel.Middle_Name });
                    oParams.Add(new MySqlParameter("P_LAST_NAME", MySqlDbType.VarString) { Value = viewModel.Last_Name });
                    oParams.Add(new MySqlParameter("P_MOBILE_NO", MySqlDbType.VarString) { Value = viewModel.MobileNo });
                    oParams.Add(new MySqlParameter("P_ALT_MOBILE_NO", MySqlDbType.VarString) { Value = viewModel.Alt_Mobile_No });
                    oParams.Add(new MySqlParameter("P_EMAIL_ID", MySqlDbType.VarString) { Value = viewModel.Email_Id });
                    oParams.Add(new MySqlParameter("P_ALT_EMAIL_ID", MySqlDbType.VarString) { Value = viewModel.Alt_Email_Id });
                    oParams.Add(new MySqlParameter("P_FULL_ADDRESS", MySqlDbType.VarString) { Value = viewModel.Full_Address });
                    oParams.Add(new MySqlParameter("P_COUNTRY_ID", MySqlDbType.Int64) { Value = viewModel.Country_Id });
                    oParams.Add(new MySqlParameter("P_STATE_ID", MySqlDbType.Int64) { Value = viewModel.State_Id });
                    oParams.Add(new MySqlParameter("P_DISTRICT_ID", MySqlDbType.Int64) { Value = viewModel.District_Id });
                    oParams.Add(new MySqlParameter("P_CITY", MySqlDbType.VarString) { Value = viewModel.City });
                    oParams.Add(new MySqlParameter("P_POSTAL_CODE", MySqlDbType.VarString) { Value = viewModel.Postal_Code });
                    oParams.Add(new MySqlParameter("P_EMP_CODE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_EMP_DESIGNATION_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_EMP_WORK_SHIFT_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_EMP_WORK_STATION_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_IS_LOCK", MySqlDbType.VarString) { Value = viewModel.Is_Lock ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_NOTE_FEEDBACK", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.Is_Active ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_PLANT_ROLE", MySqlDbType.VarString) { Value = viewModel.Plant_Role ?? "" });
                    oParams.Add(new MySqlParameter("P_DEFAULT_PLANT", MySqlDbType.Int64) { Value = viewModel.Default_Plant });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_USER_SAVE", oParams, true);
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

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_USER_DELETE", oParams, true);
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

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_USER_DELETE", oParams, true);
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
