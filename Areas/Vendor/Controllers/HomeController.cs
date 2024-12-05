using Dispatch_System;
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace VendorQRGeneration.Areas.Vendor.Controllers
{
    [Area("Vendor")]
    public class HomeController : BaseController<ResponseModel<QRCodeGeneration>>
    {
        public IActionResult Index()
        {
            if (!Common.IsUserLogged())
                return RedirectToAction("Login", "Home", new { Area = "Vendor" });

            List<QRCodeGeneration> listQRCodeGeneration = new List<QRCodeGeneration>();

            List<(string status, string status_text, int request_cnt, int file_cnt, int file_download_cnt, int file_not_download_cnt)>
                list = new List<(string status, string status_text, int request_cnt, int file_cnt, int file_download_cnt, int file_not_download_cnt)>();

            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.SITE_ID) });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_REQUEST", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_DASHBOARD_DATA", oParams);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        list.Add((dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "",
                            dr["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS_TEXT"]) : "",
                            dr["REQUEST_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["REQUEST_COUNT"]) : 0,
                            dr["FILE_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["FILE_COUNT"]) : 0,
                            dr["DOWNLOADED_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["DOWNLOADED_COUNT"]) : 0,
                            dr["NOT_DOWNLOADED_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["NOT_DOWNLOADED_COUNT"]) : 0));
                    }
                }

                CommonViewModel.Data1 = new
                {
                    Pending_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("pending")) ? list.Where(x => x.status_text.ToLower().Contains("pending")).Select(x => x.request_cnt).FirstOrDefault() : 0),
                    Pending_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("pending")) ? list.Where(x => x.status_text.ToLower().Contains("pending")).Select(x => x.file_cnt).FirstOrDefault() : 0),
                    Download_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("email")) ? list.Where(x => x.status_text.ToLower().Contains("email")).Select(x => x.request_cnt).FirstOrDefault() : 0),
                    Download_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("email")) ? list.Where(x => x.status_text.ToLower().Contains("email")).Select(x => x.file_cnt).FirstOrDefault() : 0),
                    Download_file_not_download_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("email")) ? list.Where(x => x.status_text.ToLower().Contains("email")).Select(x => x.file_not_download_cnt).FirstOrDefault() : 0),
                    Print_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("print")) ? list.Where(x => x.status_text.ToLower().Contains("print")).Select(x => x.request_cnt).FirstOrDefault() : 0),
                    Print_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("print")) ? list.Where(x => x.status_text.ToLower().Contains("print")).Select(x => x.file_cnt).FirstOrDefault() : 0),
                    Dispatch_request_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("dispatch")) ? list.Where(x => x.status_text.ToLower().Contains("dispatch")).Select(x => x.request_cnt).FirstOrDefault() : 0),
                    Dispatch_file_cnt = (list != null && list.Any(x => x.status_text.ToLower().Contains("dispatch")) ? list.Where(x => x.status_text.ToLower().Contains("dispatch")).Select(x => x.file_cnt).FirstOrDefault() : 0),
                };


                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                    {
                        listQRCodeGeneration.Add(new QRCodeGeneration()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                            RequestNo = dr["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dr["REQUEST_NO"]) : "",
                            RequestDate = dr["REQUEST_DATE"] != DBNull.Value ? Convert.ToDateTime(dr["REQUEST_DATE"]) : null,
                            LineItemDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
                            TotalQty = dr["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_QTY"]) : 0,
                            RequestQty = dr["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUEST_QTY"]) : 0,
                            RemainQty = dr["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAIN_QTY"]) : 0,
                            IsFileEmail = dr["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt64(dr["IS_FILE_EMAIL"]) > 0 : false,
                            RequestStatus = dr["REQUEST_STATUS"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS"]) : "",
                            PO_Number = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : "",
                            SelectedPlants = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
                            SkuDesc = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
                        });
                    }
                }

            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.ListObj = listQRCodeGeneration;

            return View(CommonViewModel);
        }

        public IActionResult Login()
        {
            Common.Clear_Session();

            return View(new ResponseModel<VendorLoginViewModel>());
        }

        [HttpPost]
        public IActionResult Login(VendorLoginViewModel viewModel)
        {
            try
            {
                DataSet ds = new DataSet();

                if (!string.IsNullOrEmpty(viewModel.VendorCode) && viewModel.VendorCode.Length > 0)
                {
                    viewModel.Password = Common.Encrypt(viewModel.Password);

                    Dispatch_System.Vendor vendor = null;

                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = viewModel.SiteId });
                    oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = viewModel.VendorCode });
                    oParams.Add(new OracleParameter("P_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.Password });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_USER_ACCESS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_PLANTS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_LOGIN_AUTH", oParams);

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        vendor = new Dispatch_System.Vendor();

                        vendor.Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["ID"]) : 0;
                        vendor.PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0;
                        vendor.First_Name = ds.Tables[0].Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FIRST_NAME"]) : "";
                        vendor.Last_Name = ds.Tables[0].Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LAST_NAME"]) : "";
                        vendor.Organization_Name = ds.Tables[0].Rows[0]["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["ORGANIZATION_NAME"]) : "";
                        vendor.Last_Name = ds.Tables[0].Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LAST_NAME"]) : "";
                        vendor.VendorCode = ds.Tables[0].Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_CODE"]) : 0;
                        vendor.Is_Active = ds.Tables[0].Rows[0]["IS_ACTIVE"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_ACTIVE"]) == 1 ? true : false : false;
                    }


                    if (vendor == null)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = ResponseStatusMessage.NotFound;

                        return Json(CommonViewModel);
                    }
                    else if (vendor != null && vendor.Is_Active == false)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Your account is deactive. Please contact administration.";

                        return Json(CommonViewModel);
                    }
                    else if (vendor != null && vendor.Is_Active == true)
                    {
                        Common.Set_Session_Int(SessionKey.USER_ID, vendor.Id);
                        //Common.Set_Session_Int(SessionKey.VENDOR_ID, vendor.Id);
                        Common.Set_Session_Int(SessionKey.VENDOR_CODE, vendor.VendorCode ?? 0);
                        Common.Set_Session(SessionKey.PLANT_ID, vendor.PlantId.ToString());
                        Common.Set_Session(SessionKey.SITE_ID, viewModel.SiteId.ToString());
                        Common.Set_Session(SessionKey.ROLE_ID, "1");
                        Common.Set_Session(SessionKey.MENU_ID, "1");
                        Common.Set_Session(SessionKey.USER_NAME, vendor.Fullname);
                        //Common.Set_Session(SessionKey.ROLE_NAME, vendor.Role_Name);
                        //Common.Set_Session_Int(SessionKey.ROLE_ADMIN, (vendor.Is_Admin ? 1 : 0));


                        List<Menu> menus = new List<Menu>();

                        if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            foreach (DataRow dr in ds.Tables[1].Rows)
                                menus.Add(new Menu()
                                {
                                    Id = dr["MENU_ID"] != DBNull.Value ? Convert.ToInt32(dr["MENU_ID"]) : 0,
                                    Parent_Id = dr["PARENT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PARENT_ID"]) : 0,
                                    Menu_Name = dr["DISPLAY_NAME"] != DBNull.Value ? Convert.ToString(dr["DISPLAY_NAME"]) : "",
                                    Area = dr["AREA"] != DBNull.Value ? Convert.ToString(dr["AREA"]) : "",
                                    Controller = dr["CONTROLLER"] != DBNull.Value ? Convert.ToString(dr["CONTROLLER"]) : "",
                                    Display_Name = dr["DISPLAY_NAME"] != DBNull.Value ? Convert.ToString(dr["DISPLAY_NAME"]) : "",
                                    Url = dr["URL"] != DBNull.Value ? Convert.ToString(dr["URL"]) : "",
                                    DisplayOrder = dr["DISPLAYORDER"] != DBNull.Value ? Convert.ToInt32(dr["DISPLAYORDER"]) : 0
                                });

                        Common.Configure_UserMenuAccess(menus.Where(x => x.Area.ToLower() == "vendor").ToList());

                        List<Plant> plants = new List<Plant>();

                        if (ds != null && ds.Tables.Count > 2 && ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
                            foreach (DataRow dr in ds.Tables[2].Rows)
                                plants.Add(new Plant()
                                {
                                    PlantID = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PLANT_ID"]) : 0,
                                    Plant_Name = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : ""
                                });

                        Common.Configure_UserPlantAccess(plants);


                        CommonViewModel.IsSuccess = true;
                        CommonViewModel.StatusCode = ResponseStatusCode.Success;
                        CommonViewModel.Message = ResponseStatusMessage.Success;
                        CommonViewModel.RedirectURL = Url.Content("~/") + "Vendor/" + this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

                        return Json(CommonViewModel);
                    }
                }

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = "Vendor Code and Password is incorrect.";

            }
            catch (Exception ex)
            {
                LogService.LogInsert(GetCurrentAction(), "", ex);

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.Error;
            }

            return Json(CommonViewModel);
        }

        [HttpPost]
        public JsonResult VendorChangePassword(string Newpassword, string ConfirmPassword)
        {
            try
            {
                string Oldpassword = Common.Get_Session("CheckPassword");

                string EnyNewpassword = Common.Encrypt(Newpassword);
                string EnyConfirmPassword = Common.Encrypt(ConfirmPassword);

                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Varchar2) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_OLD_PASSWORD", OracleDbType.Varchar2) { Value = Oldpassword });
                oParams.Add(new OracleParameter("P_CONFIRM_PASSWORD", OracleDbType.Varchar2) { Value = EnyNewpassword });
                oParams.Add(new OracleParameter("P_NEW_PASSWORD", OracleDbType.Varchar2) { Value = EnyConfirmPassword });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                //List<MySqlParameter> oParams = new List<MySqlParameter>();

                //oParams.Add(new MySqlParameter("P_VENDOR_ID", MySqlDbType.VarChar) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                //oParams.Add(new MySqlParameter("P_OLD_PASSWORD", MySqlDbType.VarChar) { Value = Oldpassword });
                //oParams.Add(new MySqlParameter("P_CONFIRM_PASSWORD", MySqlDbType.VarChar) { Value = EnyNewpassword });
                //oParams.Add(new MySqlParameter("P_NEW_PASSWORD", MySqlDbType.VarChar) { Value = EnyConfirmPassword });
                //oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                //oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                //oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                //oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });


                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_CHANGEPASSWORD", oParams, true);

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = IsSuccess;
                CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                CommonViewModel.Message = response;
                Common.Clear_Session();
                CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Login" : "";

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

        public IActionResult VendorForgotPass()
        {
            return View(new ResponseModel<VendorLoginViewModel>());
        }

        [HttpPost]
        public JsonResult GetVendorSitelist(long Vendor_Id = 0)
        {
            var list2 = new List<SelectListItem_Custom>();
            try
            {
                var dt = DataContext.ExecuteQuery("SELECT DISTINCT Y.SITE_ID, Y.SITE_NAME || ' (' || Y.SITE_CODE || ')' SITE_NAME FROM VENDOR_MASTER X, SITE_MASTER Y, SITE_MASTER_PLANT Z WHERE X.VENDOR_SYS_ID = Y.VENDER_ID AND Y.SITE_ID = Z.SITE_ID AND (X.VENDOR_CODE = " + Vendor_Id + " OR X.VENDOR_CODE_TEMP = " + Vendor_Id + ")");

                if (dt != null && dt.Rows.Count > 0)
                {
                    list2.Insert(0, new SelectListItem_Custom("", "--Select Site--", "S"));
                    foreach (DataRow row in dt.Rows)
                        list2.Add(new SelectListItem_Custom(row["SITE_ID"].ToString(), row["SITE_NAME"].ToString(), "S"));
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(list2);
        }

    }
}
