using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class MenuController : BaseController<ResponseModel<Menu1>>
    {
        #region Loading
        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<Menu1>();

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

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_MENU_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_MENU_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        CommonViewModel.ListObj.Add(new Menu1()
                        {
                            Sr_No = dr["SR_NO"] != DBNull.Value ? Convert.ToInt32(dr["SR_NO"]) : 0,
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            Parent_Id = dr["PARENT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PARENT_ID"]) : 0,
                            Parent_Menu_Name = dr["PARENT_MENU_NAME"] != DBNull.Value ? Convert.ToString(dr["PARENT_MENU_NAME"]) : "",
                            Area = dr["AREA"] != DBNull.Value ? Convert.ToString(dr["AREA"]) : "",
                            Controller = dr["CONTROLLER"] != DBNull.Value ? Convert.ToString(dr["CONTROLLER"]) : "",
                            Display_Name = dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "",
                            Url = dr["URL"] != DBNull.Value ? Convert.ToString(dr["URL"]) : "",
                            DisplayOrder = dr["DISPLAYORDER"] != DBNull.Value ? Convert.ToInt32(dr["DISPLAYORDER"]) : 0,
                            IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : true,
                            IsAdmin = dr["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(dr["ISADMIN"]) : true,

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
            var obj = new Menu1();

            var list_Menu = new List<Menu1>();

            try
            {
                list_Menu = new List<Menu1>();

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

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_MENU_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_MENU_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        list_Menu.Add(new Menu1()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            Parent_Id = dr["PARENT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PARENT_ID"]) : 0,
                            Parent_Menu_Name = dr["PARENT_MENU_NAME"] != DBNull.Value ? Convert.ToString(dr["PARENT_MENU_NAME"]) : "",
                            Area = dr["AREA"] != DBNull.Value ? Convert.ToString(dr["AREA"]) : "",
                            Controller = dr["CONTROLLER"] != DBNull.Value ? Convert.ToString(dr["CONTROLLER"]) : "",
                            Display_Name = dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "",
                            Url = dr["URL"] != DBNull.Value ? Convert.ToString(dr["URL"]) : "",
                            DisplayOrder = dr["DISPLAYORDER"] != DBNull.Value ? Convert.ToInt32(dr["DISPLAYORDER"]) : 0,
                            IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : true,
                            IsAdmin = dr["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(dr["ISADMIN"]) : true,

                        });
                    }
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            if (id > 0)
                obj = list_Menu.Where(x => x.Id == id).FirstOrDefault();


            var list = new List<SelectListItem_Custom>();

            if (list_Menu != null && list_Menu.Count > 0)
                foreach (var item in list_Menu.Where(x => x.IsActive == true))
                    list.Add(new SelectListItem_Custom(item.Id.ToString(), item.Display_Name));

            list.Insert(0, new SelectListItem_Custom("", "--- Select ---"));

            CommonViewModel.SelectListItems = list;

            CommonViewModel.Obj = obj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);
        }

        #endregion

        #region Events
        [HttpPost]
        public JsonResult Save(Menu1 viewModel)
        {
            try
            {
                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new OracleParameter("P_PARENT_ID", OracleDbType.Int64) { Value = viewModel.Parent_Id });
                    oParams.Add(new OracleParameter("P_AREA", OracleDbType.Varchar2) { Value = viewModel.Area });
                    oParams.Add(new OracleParameter("P_CONTROLLER", OracleDbType.Varchar2) { Value = viewModel.Controller });
                    oParams.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = viewModel.Display_Name });
                    oParams.Add(new OracleParameter("P_URL", OracleDbType.Varchar2) { Value = viewModel.Url });
                    oParams.Add(new OracleParameter("P_DISPLAYORDER", OracleDbType.Int64) { Value = viewModel.DisplayOrder });
                    oParams.Add(new OracleParameter("P_ISADMIN", OracleDbType.Varchar2) { Value = viewModel.IsAdmin ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_MENU_SAVE", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new MySqlParameter("P_PARENT_ID", MySqlDbType.Int64) { Value = viewModel.Parent_Id });
                    oParams.Add(new MySqlParameter("P_AREA", MySqlDbType.VarString) { Value = viewModel.Area });
                    oParams.Add(new MySqlParameter("P_CONTROLLER", MySqlDbType.VarString) { Value = viewModel.Controller });
                    oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarString) { Value = viewModel.Display_Name });
                    oParams.Add(new MySqlParameter("P_URL", MySqlDbType.VarString) { Value = viewModel.Url });
                    oParams.Add(new MySqlParameter("P_DISPLAYORDER", MySqlDbType.Int64) { Value = viewModel.DisplayOrder });
                    oParams.Add(new MySqlParameter("P_ISADMIN", MySqlDbType.VarString) { Value = viewModel.IsAdmin ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.IsActive ? "Y" : "N" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MENU_SAVE", oParams, true);
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
