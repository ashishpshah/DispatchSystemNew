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
    public class AssignUserRoleController : BaseController<ResponseModel<AssignUserRole>>
    {
        #region Loading

        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<AssignUserRole>();

                var parameters = new SqlParameter[] { new SqlParameter("Id", SqlDbType.BigInt) { Value = 0, Direction = ParameterDirection.Input } };
                var dt = DataContext.ExecuteStoredProcedure_DataTable("SP_User_Role_Get", parameters);

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        CommonViewModel.ListObj.Add(new AssignUserRole()
                        {
                            Id = dr["Id"] != DBNull.Value ? Convert.ToInt32(dr["Id"]) : 0,
                            User_Id = dr["User_Id"] != DBNull.Value ? Convert.ToInt32(dr["User_Id"]) : 0,
                            User_Name = dr["User_Name"] != DBNull.Value ? Convert.ToString(dr["User_Name"]) : "",
                            Role_Id = dr["Role_Id"] != DBNull.Value ? Convert.ToInt32(dr["Role_Id"]) : 0,
                            Role_Name = dr["Role_Name"] != DBNull.Value ? Convert.ToString(dr["Role_Name"]) : "",
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
        public IActionResult Partial_AddEditForm(long id = 0)
        {
            try
            {
                var obj = new AssignUserRole();
                var list = new List<SelectListItem_Custom>();
                var list1 = new List<SelectListItem_Custom>();

                var Plant_Id = Common.Get_Session_Int(SessionKey.PLANT_ID);
                var parameters_user = new SqlParameter[] { new SqlParameter("@Plant_Id", SqlDbType.BigInt) { Value = Plant_Id, Direction = ParameterDirection.Input }, };

                DataTable dt1 = DataContext.ExecuteStoredProcedure_DataTable("SP_User_Combo", parameters_user);

                list.Add(new SelectListItem_Custom("0", "-- Select --"));
                if (dt1 != null && dt1.Rows.Count > 0)
                    foreach (DataRow dr in dt1.Rows)
                        list.Add(new SelectListItem_Custom(dr["Id"] != DBNull.Value ? Convert.ToString(dr["Id"]) : "",
                            dr["User_Code"] != DBNull.Value ? Convert.ToString(dr["User_Code"]) : ""));

                var parameters_Role = new SqlParameter[] { new SqlParameter("@Plant_Id", Plant_Id) };

                DataTable dt2 = DataContext.ExecuteStoredProcedure_DataTable("SP_Role_Combo", parameters_Role);

                list1.Add(new SelectListItem_Custom("0", "-- Select --"));
                if (dt2 != null && dt2.Rows.Count > 0)
                    foreach (DataRow dr in dt2.Rows)
                        list1.Add(new SelectListItem_Custom(dr["Id"] != DBNull.Value ? Convert.ToString(dr["Id"]) : "",
                            dr["Role_Name"] != DBNull.Value ? Convert.ToString(dr["Role_Name"]) : ""));

                ViewBag.Rolelist = list1;
                ViewBag.Statelist = "";
                ViewBag.Districtlist = "";

                var dt = new DataTable();

                if (id > 0)
                {
                    var parameters = new SqlParameter[] { new SqlParameter("Id", SqlDbType.BigInt) { Value = id, Direction = ParameterDirection.Input } };
                    dt = DataContext.ExecuteStoredProcedure_DataTable("SP_User_Role_Get", parameters);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        obj = new AssignUserRole()
                        {
                            Id = dt.Rows[0]["Id"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["Id"]) : 0,
                            User_Id = dt.Rows[0]["User_Id"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["User_Id"]) : 0,
                            User_Name = dt.Rows[0]["User_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["User_Name"]) : "",
                            Role_Id = dt.Rows[0]["Role_Id"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["Role_Id"]) : 0,
                            Role_Name = dt.Rows[0]["Role_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Role_Name"]) : "",

                        };
                    }
                }

                CommonViewModel.SelectList = list;
                CommonViewModel.Obj = obj;

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return PartialView("_Partial_AddEditForm", CommonViewModel);
        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(AssignUserRole obj, IFormFileCollection files)
        {
            try
            {
                if (obj == null)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please select user details";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                else if (obj.User_Id <= 0)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please select user name";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }
                else if (obj.Role_Id <= 0)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please select role";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                SqlParameter[] spCol = new SqlParameter[] {
                    new SqlParameter("@Id",SqlDbType.BigInt) { Value = obj.Id, Direction = ParameterDirection.Input },
                    new SqlParameter("@Plant_Id",SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID), Direction = ParameterDirection.Input },
                    new SqlParameter("@Role_Id",SqlDbType.BigInt) { Value = obj.Role_Id, Direction = ParameterDirection.Input },
                    new SqlParameter("@User_Id",SqlDbType.BigInt) { Value = obj.User_Id , Direction = ParameterDirection.Input },
                    new SqlParameter("@Operated_By",SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.USER_ID), Direction = ParameterDirection.Input },
                    new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
                };

                var response = DataContext.ExecuteStoredProcedure("SP_UserRole_Insert_Update", spCol);

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
                CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Area"].ToString() + "/"+ this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

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
                if (id > 0)
                {
                    SqlParameter[] spCol = new SqlParameter[] {
                        new SqlParameter("Id", SqlDbType.BigInt) { Value = id, Direction = ParameterDirection.Input },
                        new SqlParameter("Operated_By", SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.USER_ID), Direction = ParameterDirection.Input },
                        new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
                    };

                    var returnCode = DataContext.ExecuteStoredProcedure("SP_User_Role_Delete", spCol);

                    string[] strmsg = returnCode.ToString().Split('|');
                    string msgtype = strmsg[0];
                    string message = strmsg[1].Replace("\"", "");

                    CommonViewModel.IsConfirm = (msgtype.Contains("S") ? true : false);
                    CommonViewModel.IsSuccess = (msgtype.Contains("S") ? true : false);
                    CommonViewModel.Message = message;
                    CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Area"].ToString() + "/" + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/Index";
                    CommonViewModel.StatusCode = (msgtype.Contains("S") ? ResponseStatusCode.Success : ResponseStatusCode.Error);

                    return Json(CommonViewModel);
                }
                CommonViewModel.IsSuccess = false;
                CommonViewModel.Message = ResponseStatusMessage.NotFound;
                CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
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
