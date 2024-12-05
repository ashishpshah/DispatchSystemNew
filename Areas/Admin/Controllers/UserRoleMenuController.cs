using BaseStructure_47.Services;
using Dispatch_System.Controllers;
using Dispatch_System.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using static System.Net.Mime.MediaTypeNames;


namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class UserRoleMenuController : BaseController<ResponseModel<UserRoleMenu>>
    {
        #region Loading
        public IActionResult Index()
        {
            try
            {
                var list = new List<SelectListItem_Custom>();

                var PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);
                var parameters = new SqlParameter[] { new SqlParameter("@Plant_Id", PLANT_ID) };

                DataTable dt1 = DataContext.ExecuteStoredProcedure_DataTable("SP_Role_Combo", parameters);
               
                list.Add(new SelectListItem_Custom("0", "-- Select --"));
                if (dt1 != null && dt1.Rows.Count > 0)
                    foreach (DataRow dr in dt1.Rows)
                        list.Add(new SelectListItem_Custom(dr["Id"] != DBNull.Value ? Convert.ToString(dr["Id"]) : "",
                            dr["Role_Name"] != DBNull.Value ? Convert.ToString(dr["Role_Name"]) : ""));

                CommonViewModel.SelectList = list;
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            return View(CommonViewModel);
        }
        #endregion

        #region Methods
        public JsonResult getchklist(long Role_Id = 0)
        {
            var list = new List<UserRoleMenu>();
            try
            {
                var parameters_country = new SqlParameter[] { new SqlParameter("@Role_Id", SqlDbType.BigInt) { Value = Role_Id, Direction = ParameterDirection.Input } };
               
                DataTable dt = DataContext.ExecuteStoredProcedure_DataTable("SP_MenuList_Combo", parameters_country);
                
                if (dt != null && dt.Rows.Count > 0)
                {
                    list = (from DataRow dr in dt.Rows
                            select new UserRoleMenu()
                            {
                                Menu_Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
                                Menu_Name = dr["Menu_Name"] != DBNull.Value ? Convert.ToString(dr["Menu_Name"]) : "",
                                Isselected = dr["Isselected"] != DBNull.Value ? Convert.ToString(dr["Isselected"]) : "",
                            }).ToList();
                }
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(list);
        }
        public DataTable createtable()
        {
            DataTable tblitem = new DataTable();
            try
            {
                tblitem.Columns.Add("SR_NO", typeof(int));
                tblitem.Columns.Add("Menu_Id", typeof(int));
                tblitem.Columns.Add("Menu_Name", typeof(string));
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            return tblitem;
        }
        #endregion

        #region Events
        public JsonResult AddMenuSave(List<UserRoleMenu> objViewData, UserRoleMenu objData)
        {
            DataTable dtitems = createtable();

            try
            {
                if (objViewData.Count > 0)
                {
                    DataRow dr;
                    var i = 1;
                    foreach (var item in objViewData)
                    {
                        dr = dtitems.NewRow();
                        dr["SR_NO"] = i;
                        dr["Menu_Id"] = item.Menu_Id;
                        dr["Menu_Name"] = item.Menu_Name;
                        if (item.IsAddAllMenu == true)
                        {
                            dtitems.Rows.Add(dr);
                            i = i + 1;
                        }

                    }
                    var PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);

                    SqlParameter[] spCol = new SqlParameter[] {
                    new SqlParameter("@Id",0),
                    new SqlParameter("@UserId",""),
                    new SqlParameter("@RoleId",objData.Role_Id),
                    new SqlParameter("@Plant_Id",PLANT_ID),
                    new SqlParameter("@Add_User_role_menu_Type", dtitems),
                    new SqlParameter("@Action","INSERT"),
                    new SqlParameter("@response", SqlDbType.NVarChar, 100) { Direction = ParameterDirection.Output }
                    };

                    var response = DataContext.ExecuteStoredProcedure("SP_Add_User_role_menu", spCol);

                    string[] strmsg = response.Split('|');
                    var msgtype = strmsg[0];
                    var message = strmsg[1].Replace("\"", "");

                    if (msgtype.Contains("E"))
                    {
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = message;

                        return Json(CommonViewModel);
                    }

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = message;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

                    return Json(CommonViewModel);
                }
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
