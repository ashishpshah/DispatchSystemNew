﻿using Dispatch_System.Models;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Oracle.ManagedDataAccess.Client;
using PuppeteerSharp;
using System.Data;
using System.Diagnostics;
using System.Dynamic;
using System.Globalization;
using System.Net;
using System.Net.Mail;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using VendorQRGeneration.Models;

namespace Dispatch_System.Controllers
{
    public class HomeController : BaseController<ResponseModel<LoginViewModel>>
    {

        public HomeController() { }

        #region Loading

        public IActionResult Index()
        {
            if (!Common.IsUserLogged())
                return RedirectToAction("Login", "Home", new { Area = "" });

            try
            {
                CommonViewModel.Data1 = new DashboardData();
                CommonViewModel.Data2 = new DashboardData();

                if (AppHttpContextAccessor.IsCloudDBActive == false)
                {

                    List<OracleParameter> oParams = new List<OracleParameter>();

                    //oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    //oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    //oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    //oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    //var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DASHBOARDADMIN", oParams, true);

                    //if (dt != null && dt.Rows.Count > 0)
                    //{
                    //	foreach (DataRow dr in dt.Rows)
                    //	{
                    //		CommonViewModel.ListObj.Add(new LoginViewModel()
                    //		{
                    //			ColName = dr["Colname"] != DBNull.Value ? Convert.ToString(dr["Colname"]) : "",
                    //			TodayGeneration = dr["QR_Generated"] != DBNull.Value ? Convert.ToInt32(dr["QR_Generated"]) : 0,
                    //			TodayRecevied = dr["QR_Recived"] != DBNull.Value ? Convert.ToInt32(dr["QR_Recived"]) : 0
                    //		});
                    //	}
                    //}

                    oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    oParams.Add(new OracleParameter("P_RESULT_GATE_IN_OUT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    var ds = new DataSet();

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_DASHBOARD_ADMIN_NEW", oParams);

                    if (ds != null && ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[0].Rows)
                        {
                            CommonViewModel.Data1 = new DashboardData()
                            {
                                FG_GateInCount = dr["FG_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["FG_GATE_IN_COUNT"]) : 0,
                                FG_GateInCountMonth = dr["FG_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["FG_GATE_IN_COUNT_MONTH"]) : 0,
                                FG_CancelGateInCount = dr["FG_CANCEL_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["FG_CANCEL_GATE_IN_COUNT"]) : 0,
                                FG_CancelGateInCountMonth = dr["FG_CANCEL_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["FG_CANCEL_GATE_IN_COUNT_MONTH"]) : 0,
                                FG_GateOutCount = dr["FG_GATE_OUT_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["FG_GATE_OUT_COUNT"]) : 0,
                                FG_GateOutCountMonth = dr["FG_GATE_OUT_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["FG_GATE_OUT_COUNT_MONTH"]) : 0,
                                RM_GateInCount = dr["RM_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["RM_GATE_IN_COUNT"]) : 0,
                                RM_GateInCountMonth = dr["RM_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["RM_GATE_IN_COUNT_MONTH"]) : 0,
                                RM_CancelGateInCount = dr["RM_CANCEL_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["RM_CANCEL_GATE_IN_COUNT"]) : 0,
                                RM_CancelGateInCountMonth = dr["RM_CANCEL_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["RM_CANCEL_GATE_IN_COUNT_MONTH"]) : 0,
                                RM_GateOutCount = dr["RM_GATE_OUT_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["RM_GATE_OUT_COUNT"]) : 0,
                                RM_GateOutCountMonth = dr["RM_GATE_OUT_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["RM_GATE_OUT_COUNT_MONTH"]) : 0,
                                SP_GateInCount = dr["SP_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["SP_GATE_IN_COUNT"]) : 0,
                                SP_GateInCountMonth = dr["SP_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["SP_GATE_IN_COUNT_MONTH"]) : 0,
                                SP_CancelGateInCount = dr["SP_CANCEL_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["SP_CANCEL_GATE_IN_COUNT"]) : 0,
                                SP_CancelGateInCountMonth = dr["SP_CANCEL_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["SP_CANCEL_GATE_IN_COUNT_MONTH"]) : 0,
                                SP_GateOutCount = dr["SP_GATE_OUT_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["SP_GATE_OUT_COUNT"]) : 0,
                                SP_GateOutCountMonth = dr["SP_GATE_OUT_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["SP_GATE_OUT_COUNT_MONTH"]) : 0,
                                OT_GateInCount = dr["OT_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["OT_GATE_IN_COUNT"]) : 0,
                                OT_GateInCountMonth = dr["OT_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["OT_GATE_IN_COUNT_MONTH"]) : 0,
                                OT_CancelGateInCount = dr["OT_CANCEL_GATE_IN_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["OT_CANCEL_GATE_IN_COUNT"]) : 0,
                                OT_CancelGateInCountMonth = dr["OT_CANCEL_GATE_IN_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["OT_CANCEL_GATE_IN_COUNT_MONTH"]) : 0,
                                OT_GateOutCount = dr["OT_GATE_OUT_COUNT"] != DBNull.Value ? Convert.ToInt32(dr["OT_GATE_OUT_COUNT"]) : 0,
                                OT_GateOutCountMonth = dr["OT_GATE_OUT_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["OT_GATE_OUT_COUNT_MONTH"]) : 0,
                            };
                        }
                    }

                    if (ds != null && ds.Tables[1].Rows.Count > 0)
                    {
                        CommonViewModel.Data2 = new DashboardData()
                        {
                            DsFgQtyLoadingPendingCount = ds.Tables[1].Rows[0]["DS_FG_QTY_LOADING_PENDING_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_FG_QTY_LOADING_PENDING_COUNT"]) : 0,
                            DsFgQtyLoadingPendingCountMonth = ds.Tables[1].Rows[0]["DS_FG_QTY_LOADING_PENDING_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_FG_QTY_LOADING_PENDING_COUNT_MONTH"]) : 0,
                            DsFgShipperBoxDispCount = ds.Tables[1].Rows[0]["DS_FG_SHIPPER_BOX_DISP_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_FG_SHIPPER_BOX_DISP_COUNT"]) : 0,
                            DsFgShipperBoxDispCountMonth = ds.Tables[1].Rows[0]["DS_FG_SHIPPER_BOX_DISP_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_FG_SHIPPER_BOX_DISP_COUNT_MONTH"]) : 0,
                            TgFgNoOfCount = ds.Tables[1].Rows[0]["TG_FG_NO_OF_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["TG_FG_NO_OF_COUNT"]) : 0,
                            TgFgNoOfCountMonth = ds.Tables[1].Rows[0]["TG_FG_NO_OF_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["TG_FG_NO_OF_COUNT_MONTH"]) : 0,
                            DsSpQtyLoadingPendingCount = ds.Tables[1].Rows[0]["DS_SP_QTY_LOADING_PENDING_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_SP_QTY_LOADING_PENDING_COUNT"]) : 0,
                            DsSpQtyLoadingPendingCountMonth = ds.Tables[1].Rows[0]["DS_SP_QTY_LOADING_PENDING_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_SP_QTY_LOADING_PENDING_COUNT_MONTH"]) : 0,
                            DsSpShipperBoxDispCount = ds.Tables[1].Rows[0]["DS_SP_SHIPPER_BOX_DISP_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_SP_SHIPPER_BOX_DISP_COUNT"]) : 0,
                            DsSpShipperBoxDispCountMonth = ds.Tables[1].Rows[0]["DS_SP_SHIPPER_BOX_DISP_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["DS_SP_SHIPPER_BOX_DISP_COUNT_MONTH"]) : 0,
                            TgSgNoOfCount = ds.Tables[1].Rows[0]["TG_SG_NO_OF_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["TG_SG_NO_OF_COUNT"]) : 0,
                            TgSgNoOfCountMonth = ds.Tables[1].Rows[0]["TG_SG_NO_OF_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["TG_SG_NO_OF_COUNT_MONTH"]) : 0,
                            PoSoRmCount = ds.Tables[1].Rows[0]["PO_SO_RM_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["PO_SO_RM_COUNT"]) : 0,
                            PoSoRmCountMonth = ds.Tables[1].Rows[0]["PO_SO_RM_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["PO_SO_RM_COUNT_MONTH"]) : 0,
                            RgRmNoOfCount = ds.Tables[1].Rows[0]["RG_RM_NO_OF_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["RG_RM_NO_OF_COUNT"]) : 0,
                            RgRmNoOfCountMonth = ds.Tables[1].Rows[0]["RG_RM_NO_OF_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["RG_RM_NO_OF_COUNT_MONTH"]) : 0,
                            PoSoSpCount = ds.Tables[1].Rows[0]["PO_SO_SP_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["PO_SO_SP_COUNT"]) : 0,
                            PoSoSpCountMonth = ds.Tables[1].Rows[0]["PO_SO_SP_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["PO_SO_SP_COUNT_MONTH"]) : 0,
                            SpNoOfCount = ds.Tables[1].Rows[0]["SP_NO_OF_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["SP_NO_OF_COUNT"]) : 0,
                            SpNoOfCountMonth = ds.Tables[1].Rows[0]["SP_NO_OF_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["SP_NO_OF_COUNT_MONTH"]) : 0,
                            PoSoVendorPoCount = ds.Tables[1].Rows[0]["PO_SO_VENDOR_PO_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["PO_SO_VENDOR_PO_COUNT"]) : 0,
                            PoSoVendorPoCountMonth = ds.Tables[1].Rows[0]["PO_SO_VENDOR_PO_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["PO_SO_VENDOR_PO_COUNT_MONTH"]) : 0,
                            QrGeneratedCount = ds.Tables[1].Rows[0]["QR_GENERATED_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["QR_GENERATED_COUNT"]) : 0,
                            QrGeneratedCountMonth = ds.Tables[1].Rows[0]["QR_GENERATED_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["QR_GENERATED_COUNT_MONTH"]) : 0,
                            QrReceivedCount = ds.Tables[1].Rows[0]["QR_RECEIVED_COUNT"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["QR_RECEIVED_COUNT"]) : 0,
                            QrReceivedCountMonth = ds.Tables[1].Rows[0]["QR_RECEIVED_COUNT_MONTH"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["QR_RECEIVED_COUNT_MONTH"]) : 0,
                        };
                    }
                }

                var checkPassword = Common.Get_Session("CheckPassword");
                ViewBag.CheckPassword = checkPassword;
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            return View(CommonViewModel);
        }

        public IActionResult Login()
        {
            Common.Clear_Session();

            return View();
        }

        [HttpGet("PlantLogin")]
        public IActionResult LoginNew()
        {
            Common.Clear_Session();

            return View();
        }

        public IActionResult ForgotPassword()
        {

            return View();
        }

        public IActionResult VendorForgotPass()
        {

            return View();
        }

        public IActionResult VendorLogin()
        {
            Common.Clear_Session();

            return View();
        }

        #endregion

        #region Events

        [HttpPost]
        public IActionResult Login(LoginViewModel viewModel)
        {
            try
            {
                DataSet ds = new DataSet();

                if (!string.IsNullOrEmpty(viewModel.UserName) && viewModel.UserName.Length > 0)
                {
                    viewModel.Password = Common.Encrypt(viewModel.Password);

                    User user = null;

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = 0 });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = 0 });
                        oParams.Add(new OracleParameter("P_USERNAME", OracleDbType.Varchar2) { Value = viewModel.UserName });
                        oParams.Add(new OracleParameter("P_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.Password });
                        oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                        oParams.Add(new OracleParameter("P_USER_ACCESS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                        oParams.Add(new OracleParameter("P_PLANTS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                        ds = DataContext.ExecuteStoredProcedure_DataSet("PC_LOGIN_AUTH", oParams);
                    }
                    else
                    {
                        List<MySqlParameter> oParams = new List<MySqlParameter>();

                        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = 0 });
                        oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = 0 });
                        oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = 0 });
                        oParams.Add(new MySqlParameter("P_USERNAME", MySqlDbType.VarString) { Value = viewModel.UserName });
                        oParams.Add(new MySqlParameter("P_PASSWORD", MySqlDbType.VarString) { Value = viewModel.Password });

                        ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_LOGIN_AUTH", oParams);
                    }

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        if (!AppHttpContextAccessor.IsCloudDBActive && ds.Tables[0].Rows[0]["P_RESULT"] != DBNull.Value && Convert.ToString(ds.Tables[0].Rows[0]["P_RESULT"]).Length > 0)
                        {
                            CommonViewModel.IsConfirm = true;
                            CommonViewModel.IsSuccess = false;
                            CommonViewModel.StatusCode = ResponseStatusCode.Error;
                            CommonViewModel.Message = Convert.ToString(ds.Tables[0].Rows[0]["P_RESULT"]);

                            return Json(CommonViewModel);
                        }

                        user = new User();

                        user.Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["ID"]) : 0;
                        //user.Unit_Code = ds.Tables[0].Rows[0]["UNIT_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["UNIT_CODE"]) : 0;
                        user.Plant_Id = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0;
                        user.Role_Id = ds.Tables[0].Rows[0]["ROLE_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["ROLE_ID"]) : 0;
                        user.First_Name = ds.Tables[0].Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FIRST_NAME"]) : "";
                        user.Last_Name = ds.Tables[0].Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LAST_NAME"]) : "";
                        user.Username = ds.Tables[0].Rows[0]["USER_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["USER_NAME"]) : "";
                        user.Plant_Name = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";
                        user.Role_Name = ds.Tables[0].Rows[0]["ROLE_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["ROLE_NAME"]) : "";
                        user.Is_Active = ds.Tables[0].Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISACTIVE"]) : false;
                        user.Is_Admin = ds.Tables[0].Rows[0]["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISADMIN"]) : false;
                    }

                    if (user == null)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Username not found. Please contact administration.";

                        return Json(CommonViewModel);
                    }
                    else if (user != null && user.Is_Active == false)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Your account is deactive. Please contact administration.";

                        return Json(CommonViewModel);
                    }
                    else if (user != null && user.Is_Active == true)
                    {
                        Common.Set_Session_Int(SessionKey.USER_ID, user.Id);
                        //Common.Set_Session_Int(SessionKey.UNIT_CODE, user.Unit_Code);
                        Common.Set_Session_Int(SessionKey.PLANT_ID, user.Plant_Id);
                        Common.Set_Session_Int(SessionKey.ROLE_ID, user.Role_Id);
                        Common.Set_Session(SessionKey.USER_NAME, user.Fullname);
                        Common.Set_Session(SessionKey.PLANT_NAME, user.Plant_Name);
                        Common.Set_Session(SessionKey.ROLE_NAME, user.Role_Name);
                        Common.Set_Session_Int(SessionKey.ROLE_ADMIN, (user.Is_Admin ? 1 : 0));
                        Common.Set_Session("CheckPassword", viewModel.Password ?? string.Empty);
                        Common.Set_Session("LoginFlag", "U");

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

                        Common.Configure_UserMenuAccess(menus.Where(x => x.Area.ToLower() != "vendor").ToList());

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

                        Menu menu = null;

                        if (menus != null && menus.Count() > 0 && menus.Where(x => x.Parent_Id > 0).GroupBy(x => new { x.Parent_Id, x.Id }).Select(x => x.Key).Count() == 1)
                            menu = menus.Where(x => x.Parent_Id > 0).FirstOrDefault();

                        if (menu != null && !string.IsNullOrEmpty(menu.Url))
                            CommonViewModel.RedirectURL = Url.Content("~/") + menu.Url;
                        else if (menu != null && string.IsNullOrEmpty(menu.Url))
                            CommonViewModel.RedirectURL = Url.Action("Index", menu.Controller, new { Area = menu.Area });
                        else
                            CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

                        return Json(CommonViewModel);
                    }
                }

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = "Username and Password is incorrect.";

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
        public JsonResult ChangePassword(string Newpassword, string ConfirmPassword)
        {
            try
            {
                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                string Oldpassword = Common.Get_Session("CheckPassword");

                string EnyNewpassword = Common.Encrypt(Newpassword);
                string EnyConfirmPassword = Common.Encrypt(ConfirmPassword);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_OLD_PASSWORD", OracleDbType.NVarchar2) { Value = Oldpassword });
                    oParams.Add(new OracleParameter("P_CONFIRM_PASSWORD", OracleDbType.NVarchar2) { Value = EnyNewpassword });
                    oParams.Add(new OracleParameter("P_NEW_PASSWORD", OracleDbType.NVarchar2) { Value = EnyConfirmPassword });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_CHANGEPASSWORD", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_OLD_PASSWORD", MySqlDbType.VarChar) { Value = Oldpassword });
                    oParams.Add(new MySqlParameter("P_CONFIRM_PASSWORD", MySqlDbType.VarChar) { Value = EnyNewpassword });
                    oParams.Add(new MySqlParameter("P_NEW_PASSWORD", MySqlDbType.VarChar) { Value = EnyConfirmPassword });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_CHANGEPASSWORD", oParams, true);
                }

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

        [HttpPost]
        public IActionResult VendorLogin(VendorLoginViewModel viewModel)
        {
            try
            {
                DataSet ds = new DataSet();

                if (!string.IsNullOrEmpty(viewModel.VendorCode) && viewModel.VendorCode.Length > 0)
                {
                    viewModel.Password = Common.Encrypt(viewModel.Password);

                    Vendor vendor = null;

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

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && !ds.Tables[0].Columns.Contains("MSG"))
                    {
                        vendor = new Vendor();

                        vendor.Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["ID"]) : 0;
                        vendor.PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0;
                        vendor.First_Name = ds.Tables[0].Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FIRST_NAME"]) : "";
                        vendor.Last_Name = ds.Tables[0].Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LAST_NAME"]) : "";
                        vendor.Organization_Name = ds.Tables[0].Rows[0]["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["ORGANIZATION_NAME"]) : "";
                        vendor.Last_Name = ds.Tables[0].Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LAST_NAME"]) : "";
                        vendor.VendorCode = ds.Tables[0].Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_CODE"]) : 0;
                        vendor.Is_Active = ds.Tables[0].Rows[0]["IS_ACTIVE"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["IS_ACTIVE"]) == 1 ? true : false : false;
                    }
                    else if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                        && ds.Tables[0].Rows[0]["MSG"] != DBNull.Value && Convert.ToString(ds.Tables[0].Rows[0]["MSG"]).Length > 0)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = Convert.ToString(ds.Tables[0].Rows[0]["MSG"]);

                        return Json(CommonViewModel);
                    }


                    if (vendor == null)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Vendor details not found. Please contact administration.";

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
                        //Common.Set_Session_Int(SessionKey.NEED_PASSWORD_CHANGE, string.IsNullOrEmpty(viewModel.Password) || Common.Decrypt(viewModel.Password) == "12345" ? 1 : 0);
                        Common.Set_Session("LoginFlag", "V");
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
                        //CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

                        if (string.IsNullOrEmpty(viewModel.Password) || Common.Decrypt(viewModel.Password) == "12345")
                            CommonViewModel.RedirectURL = Url.Content("~/Vendor/ChangePassword/Index");
                        else
                            CommonViewModel.RedirectURL = Url.Content("~/Vendor/Vender/Index");

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
        public IActionResult Change_Plant(long id)
        {
            try
            {
                DataSet ds = new DataSet();

                User user = null;

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = id });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_USERNAME", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PASSWORD", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_USER_ACCESS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_PLANTS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_LOGIN_AUTH", oParams);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = id });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_USERNAME", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PASSWORD", MySqlDbType.VarString) { Value = "" });

                    ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_LOGIN_AUTH", oParams);
                }


                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    user = new User();

                    user.Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["ID"]) : 0;
                    user.Unit_Code = ds.Tables[0].Rows[0]["UNIT_CODE"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["UNIT_CODE"]) : 0;
                    user.Plant_Id = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0;
                    user.Role_Id = ds.Tables[0].Rows[0]["ROLE_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[0].Rows[0]["ROLE_ID"]) : 0;
                    user.First_Name = ds.Tables[0].Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["FIRST_NAME"]) : "";
                    user.Last_Name = ds.Tables[0].Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["LAST_NAME"]) : "";
                    user.Username = ds.Tables[0].Rows[0]["USER_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["USER_NAME"]) : "";
                    user.Plant_Name = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";
                    user.Role_Name = ds.Tables[0].Rows[0]["ROLE_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["ROLE_NAME"]) : "";
                    user.Is_Active = ds.Tables[0].Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISACTIVE"]) : false;
                    user.Is_Admin = ds.Tables[0].Rows[0]["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISADMIN"]) : false;
                }

                if (user == null)
                {
                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    CommonViewModel.Message = ResponseStatusMessage.UnAuthorize;

                    return Json(CommonViewModel);
                }
                else if (user != null && user.Is_Active == false)
                {
                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    CommonViewModel.Message = "Your account is deactive. Please contact administration.";

                    return Json(CommonViewModel);
                }
                else if (user != null && user.Is_Active == true)
                {
                    Common.Set_Session_Int(SessionKey.USER_ID, user.Id);
                    Common.Set_Session_Int(SessionKey.UNIT_CODE, user.Unit_Code);
                    Common.Set_Session_Int(SessionKey.PLANT_ID, id);
                    Common.Set_Session_Int(SessionKey.ROLE_ID, user.Role_Id);
                    Common.Set_Session(SessionKey.USER_NAME, user.Fullname);
                    Common.Set_Session(SessionKey.PLANT_NAME, user.Plant_Name);
                    Common.Set_Session(SessionKey.ROLE_NAME, user.Role_Name);
                    Common.Set_Session_Int(SessionKey.ROLE_ADMIN, (user.Is_Admin ? 1 : 0));

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

                    Common.Configure_UserMenuAccess(menus.Where(x => x.Area.ToLower() != "vendor").ToList());

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
                    CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["controller"].ToString() + "/Index";

                    return Json(CommonViewModel);
                }

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.UnAuthorize;

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

        public IActionResult Logout()
        {
            Common.Clear_Session();

            return RedirectToAction("Login", "Home", new { Area = "" });
        }

        public IActionResult VendorLogout()
        {
            Common.Clear_Session();

            return RedirectToAction("VendorLogin", "Home", new { Area = "" });
        }

        public IActionResult Privacy()
        {
            return View();
        }


        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
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

        // Comment by ashish bcz // issue on 26-11-2024
        //public IActionResult Get_QR_Code_Details(string qr_prefix, string gtin, string prod_cd, string qr_postfix)
        //{
        //	CommonViewModel.Data1 = null;
        //	CommonViewModel.Data2 = null;
        //	CommonViewModel.Data3 = null;

        //	DateTime? nullDatetime = null;

        //	//List<MySqlParameter> oParams = new List<MySqlParameter>();

        //	//oParams.Add(new MySqlParameter("P_QR_PREFIX", MySqlDbType.VarString) { Value = qr_prefix });
        //	//oParams.Add(new MySqlParameter("P_GTIN", MySqlDbType.VarString) { Value = gtin });
        //	//oParams.Add(new MySqlParameter("P_PROD_CD", MySqlDbType.VarString) { Value = prod_cd });
        //	//oParams.Add(new MySqlParameter("P_QR_POSTFIX", MySqlDbType.VarString) { Value = qr_postfix });
        //	////oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
        //	////oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

        //	//var ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_PRODUCT_INFO_GET", oParams);

        //	if (!string.IsNullOrEmpty(qr_prefix) && qr_prefix.Length > 2 && qr_prefix.StartsWith("00"))
        //	{
        //		var result = new KnowYourInvoice();

        //		DataSet ds = new DataSet();

        //		if (!string.IsNullOrEmpty(qr_prefix))
        //			try
        //			{
        //				var oParams = new List<OracleParameter>();

        //				oParams.Add(new OracleParameter("P_INVOICE_QR_CODE", OracleDbType.NVarchar2) { Value = qr_prefix });
        //				oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Int64) { Value = 1 });

        //				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
        //				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
        //				oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

        //				ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_KNOW_INVOICE", oParams);

        //				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
        //				{
        //					result = new KnowYourInvoice()
        //					{
        //						InvoiceQrCode = ds.Tables[0].Rows[0]["INVOICEQRCODE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["INVOICEQRCODE"]) : "",
        //						Plant_Id = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
        //						Mda_Sys_Id = ds.Tables[0].Rows[0]["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["MDA_SYS_ID"]) : 0,
        //						Mda_No = ds.Tables[0].Rows[0]["MDA_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["MDA_NO"]) : "",
        //						Truck_No = ds.Tables[0].Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VEHICLE_NO"]) : "",
        //						Gate_In_Date = ds.Tables[0].Rows[0]["GATE_IN_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["GATE_IN_DT"]) : "",
        //						Gate_Out_Date = ds.Tables[0].Rows[0]["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["GATE_OUT_DT"]) : "",
        //						Mda_Date = ds.Tables[0].Rows[0]["MDA_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["MDA_DT"]) : "",
        //						Desp_Place = ds.Tables[0].Rows[0]["DESP_PLACE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["DESP_PLACE"]) : "",
        //						Transporter_Name = ds.Tables[0].Rows[0]["TPTR_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["TPTR_NAME"]) : "",
        //						Prod_Desc = ds.Tables[0].Rows[0]["PRD_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PRD_DESC"]) : "",
        //						NoOfBox = ds.Tables[0].Rows[0]["BAG_NOS"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["BAG_NOS"]) : 0,
        //						Required_Shipper = ds.Tables[0].Rows[0]["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["REQUIRED_SHIPPER"]) : 0,
        //						Loaded_Shipper = ds.Tables[0].Rows[0]["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["LOADED_SHIPPER"]) : 0,
        //						PlantName = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : null
        //					};
        //				}

        //				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
        //				{
        //					result.listShipperBatch = new List<ShipperBatch>();

        //					foreach (DataRow dr in ds.Tables[1].Rows)
        //						result.listShipperBatch.Add(new ShipperBatch()
        //						{
        //							SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
        //							//ShipperQRCode = dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "",
        //							Batch_no = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
        //							mfg_dt = dr["mfg_date"] != DBNull.Value ? Convert.ToString(dr["mfg_date"]) : "",
        //							expiry_dt = dr["expiry_date"] != DBNull.Value ? Convert.ToString(dr["expiry_date"]) : ""
        //						});
        //				}
        //			}
        //			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


        //		CommonViewModel.Data3 = result;

        //	}
        //	else
        //	{
        //		ProductInfo productInfo = new ProductInfo();
        //		List<ProductAttachment> productAttachments = new List<ProductAttachment>();

        //		List<OracleParameter> oParams = new List<OracleParameter>();

        //		oParams.Add(new OracleParameter("P_QR_PREFIX", OracleDbType.NVarchar2) { Value = qr_prefix });
        //		oParams.Add(new OracleParameter("P_GTIN", OracleDbType.NVarchar2) { Value = gtin });
        //		oParams.Add(new OracleParameter("P_PROD_CD", OracleDbType.NVarchar2) { Value = prod_cd });
        //		oParams.Add(new OracleParameter("P_QR_POSTFIX", OracleDbType.NVarchar2) { Value = qr_postfix });
        //		oParams.Add(new OracleParameter("P_RESULT   ", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
        //		oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

        //		var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_PRODUCT_INFO_GET", oParams);

        //		if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        //		{
        //			var dt = ds.Tables[0];

        //			var qrCode = Convert.ToString(dt.Rows[0]["QR_CODE"]);

        //			if (qrCode != "" && qrCode != null)
        //			{
        //				//if (dt != null && dt.Rows.Count > 0)
        //				productInfo = new ProductInfo()
        //				{
        //					PlantName = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "" : "",
        //					QrCode_Type = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["QR_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["QR_TYPE"]) : "" : "",
        //					QrCode = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["QR_CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["QR_CODE"]) : "" : "",
        //					BatchDesc = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["BATCH_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["BATCH_NO"]) : "" : "",
        //					RegnNo = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["REGN_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["REGN_NO"]) : "" : "",
        //					MfgDateTxt = dt != null && dt.Rows.Count > 0 && dt.Rows[0]["MFG_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["MFG_DATE"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
        //					ExpDateTxt = dt != null && dt.Rows.Count > 0 && dt.Rows[0]["EXP_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["EXP_DATE"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
        //					MfgBy = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MFG_BY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MFG_BY"]) : "" : "Indian Farmers Fertiliser Cooperative",
        //					MarketedBy = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MARKETED_BY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MARKETED_BY"]) : "" : "Indian Farmers Fertiliser Cooperative",
        //					CustomerCareNo = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["CUSTOMER_CARE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CUSTOMER_CARE_NO"]) : "" : "",
        //					Mrp = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MRP"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["MRP"]) : 0 : 0,
        //					NetWeight = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["NET_WEIGHT"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["NET_WEIGHT"]) : 0 : 0,
        //					NetContent = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["NET_CONTENT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NET_CONTENT"]) : "" : "",
        //					PromotionalLink = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PROMOTIONAL_LINK"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PROMOTIONAL_LINK"]) : "" : "",
        //					PrdDesc = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PRD_DESC"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_DESC"]) : "" : "",
        //					Status = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["Status"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Status"]) : "" : "",
        //					MDA_No = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MDA_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_NO"]) : "" : "",
        //					DispatchDate = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["DISPATCH_DATE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DISPATCH_DATE"]) : "" : "",
        //					PartyName = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PARTY_NAME"]) : "" : "",
        //					Destination = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DESP_PLACE"]) : "" : "",
        //					No_Of_Bottle = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["NO_OF_BOTTLE"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["NO_OF_BOTTLE"]) : 0 : 0,
        //					Bottle_QR_Codes = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["Bottle_QR_Codes"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Bottle_QR_Codes"]) : "" : "",
        //				};

        //				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
        //					foreach (DataRow dr in ds.Tables[1].Rows)
        //						productAttachments.Add(new ProductAttachment()
        //						{
        //							Id = dr["FILE_ATTACH_ID"] != DBNull.Value ? Convert.ToInt64(dr["FILE_ATTACH_ID"]) : 0,
        //							PrdInfoId = dr["PRD_INFO_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRD_INFO_ID"]) : 0,
        //							FileName = dr["FILE_NAME"] != DBNull.Value ? Convert.ToString(dr["FILE_NAME"]) : "",
        //							FileType = dr["FILE_TYPE"] != DBNull.Value ? Convert.ToString(dr["FILE_TYPE"]) : "",
        //							FileDisplayname = dr["FILE_DISPLAYNAME"] != DBNull.Value ? Convert.ToString(dr["FILE_DISPLAYNAME"]) : "",
        //							ContentType = dr["CONTENT_TYPE"] != DBNull.Value ? Convert.ToString(dr["CONTENT_TYPE"]) : "",
        //							Extension = dr["EXTENSION"] != DBNull.Value ? Convert.ToString(dr["EXTENSION"]) : "",
        //							FileData = dr["FILE_DATA"] != DBNull.Value ? (byte[])dr["FILE_DATA"] : null
        //						});
        //			}

        //		}

        //		CommonViewModel.Data1 = productInfo;
        //		CommonViewModel.Data2 = productAttachments;

        //	}

        //	return View(CommonViewModel);
        //}

        public IActionResult Get_QR_Code_Details(string qr_prefix, string gtin, string prod_cd, string qr_postfix, string qr_extra = null)
        {
            if (string.IsNullOrEmpty(qr_prefix))
            {
                qr_prefix = gtin;
                gtin = prod_cd;
                prod_cd = qr_postfix;
                qr_postfix = qr_extra;
            }

            CommonViewModel.Data1 = null;
            CommonViewModel.Data2 = null;
            CommonViewModel.Data3 = null;

            DateTime? nullDatetime = null;

            //List<MySqlParameter> oParams = new List<MySqlParameter>();

            //oParams.Add(new MySqlParameter("P_QR_PREFIX", MySqlDbType.VarString) { Value = qr_prefix });
            //oParams.Add(new MySqlParameter("P_GTIN", MySqlDbType.VarString) { Value = gtin });
            //oParams.Add(new MySqlParameter("P_PROD_CD", MySqlDbType.VarString) { Value = prod_cd });
            //oParams.Add(new MySqlParameter("P_QR_POSTFIX", MySqlDbType.VarString) { Value = qr_postfix });
            ////oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
            ////oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

            //var ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_PRODUCT_INFO_GET", oParams);

            if (!string.IsNullOrEmpty(qr_prefix) && qr_prefix.Length > 2 && qr_prefix.StartsWith("00"))
            {
                var result = new KnowYourInvoice();

                DataSet ds = new DataSet();

                if (!string.IsNullOrEmpty(qr_prefix))
                    try
                    {
                        var oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_INVOICE_QR_CODE", OracleDbType.NVarchar2) { Value = qr_prefix });
                        oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Int64) { Value = 1 });

                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = 0 });
                        oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                        oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                        ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_KNOW_INVOICE", oParams);

                        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                        {
                            result = new KnowYourInvoice()
                            {
                                InvoiceQrCode = ds.Tables[0].Rows[0]["INVOICEQRCODE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["INVOICEQRCODE"]) : "",
                                Plant_Id = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
                                Mda_Sys_Id = ds.Tables[0].Rows[0]["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["MDA_SYS_ID"]) : 0,
                                Mda_No = ds.Tables[0].Rows[0]["MDA_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["MDA_NO"]) : "",
                                Truck_No = ds.Tables[0].Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VEHICLE_NO"]) : "",
                                Gate_In_Date = ds.Tables[0].Rows[0]["GATE_IN_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["GATE_IN_DT"]) : "",
                                Gate_Out_Date = ds.Tables[0].Rows[0]["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["GATE_OUT_DT"]) : "",
                                Mda_Date = ds.Tables[0].Rows[0]["MDA_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["MDA_DT"]) : "",
                                Desp_Place = ds.Tables[0].Rows[0]["DESP_PLACE"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["DESP_PLACE"]) : "",
                                Transporter_Name = ds.Tables[0].Rows[0]["TPTR_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["TPTR_NAME"]) : "",
                                Prod_Desc = ds.Tables[0].Rows[0]["PRD_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PRD_DESC"]) : "",
                                NoOfBox = ds.Tables[0].Rows[0]["BAG_NOS"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["BAG_NOS"]) : 0,
                                Required_Shipper = ds.Tables[0].Rows[0]["REQUIRED_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["REQUIRED_SHIPPER"]) : 0,
                                Loaded_Shipper = ds.Tables[0].Rows[0]["LOADED_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["LOADED_SHIPPER"]) : 0,
                                PlantName = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : null
                            };
                        }

                        if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                        {
                            result.listShipperBatch = new List<ShipperBatch>();

                            foreach (DataRow dr in ds.Tables[1].Rows)
                                result.listShipperBatch.Add(new ShipperBatch()
                                {
                                    SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
                                    //ShipperQRCode = dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "",
                                    Batch_no = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                                    mfg_dt = dr["mfg_date"] != DBNull.Value ? Convert.ToString(dr["mfg_date"]) : "",
                                    expiry_dt = dr["expiry_date"] != DBNull.Value ? Convert.ToString(dr["expiry_date"]) : ""
                                });
                        }
                    }
                    catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


                CommonViewModel.Data3 = result;

            }
            else
            {
                ProductInfo productInfo = new ProductInfo();
                List<ProductAttachment> productAttachments = new List<ProductAttachment>();

                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_QR_PREFIX", OracleDbType.NVarchar2) { Value = qr_prefix });
                oParams.Add(new OracleParameter("P_GTIN", OracleDbType.NVarchar2) { Value = gtin });
                oParams.Add(new OracleParameter("P_PROD_CD", OracleDbType.NVarchar2) { Value = prod_cd });
                oParams.Add(new OracleParameter("P_QR_POSTFIX", OracleDbType.NVarchar2) { Value = qr_postfix });
                oParams.Add(new OracleParameter("P_RESULT   ", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_PRODUCT_INFO_GET", oParams);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    var dt = ds.Tables[0];

                    var qrCode = Convert.ToString(dt.Rows[0]["QR_CODE"]);

                    if (qrCode != "" && qrCode != null)
                    {
                        //if (dt != null && dt.Rows.Count > 0)
                        productInfo = new ProductInfo()
                        {
                            PlantName = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "" : "",
                            QrCode_Type = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["QR_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["QR_TYPE"]) : "" : "",
                            QrCode = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["QR_CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["QR_CODE"]) : "" : "",
                            BatchDesc = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["BATCH_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["BATCH_NO"]) : "" : "",
                            RegnNo = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["REGN_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["REGN_NO"]) : "" : "",
                            MfgDateTxt = dt != null && dt.Rows.Count > 0 && dt.Rows[0]["MFG_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["MFG_DATE"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
                            ExpDateTxt = dt != null && dt.Rows.Count > 0 && dt.Rows[0]["EXP_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["EXP_DATE"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
                            MfgBy = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MFG_BY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MFG_BY"]) : "" : "Indian Farmers Fertiliser Cooperative",
                            MarketedBy = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MARKETED_BY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MARKETED_BY"]) : "" : "Indian Farmers Fertiliser Cooperative",
                            CustomerCareNo = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["CUSTOMER_CARE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CUSTOMER_CARE_NO"]) : "" : "",
                            Mrp = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MRP"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["MRP"]) : 0 : 0,
                            NetWeight = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["NET_WEIGHT"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["NET_WEIGHT"]) : 0 : 0,
                            NetContent = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["NET_CONTENT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NET_CONTENT"]) : "" : "",
                            PromotionalLink = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PROMOTIONAL_LINK"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PROMOTIONAL_LINK"]) : "" : "",
                            PrdDesc = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PRD_DESC"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_DESC"]) : "" : "",
                            Status = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["Status"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Status"]) : "" : "",
                            MDA_No = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["MDA_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_NO"]) : "" : "",
                            DispatchDate = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["DISPATCH_DATE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DISPATCH_DATE"]) : "" : "",
                            PartyName = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PARTY_NAME"]) : "" : "",
                            Destination = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DESP_PLACE"]) : "" : "",
                            No_Of_Bottle = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["NO_OF_BOTTLE"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["NO_OF_BOTTLE"]) : 0 : 0,
                            Bottle_QR_Codes = dt != null && dt.Rows.Count > 0 ? dt.Rows[0]["Bottle_QR_Codes"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Bottle_QR_Codes"]) : "" : "",
                        };

                        if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            foreach (DataRow dr in ds.Tables[1].Rows)
                                productAttachments.Add(new ProductAttachment()
                                {
                                    Id = dr["FILE_ATTACH_ID"] != DBNull.Value ? Convert.ToInt64(dr["FILE_ATTACH_ID"]) : 0,
                                    PrdInfoId = dr["PRD_INFO_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRD_INFO_ID"]) : 0,
                                    FileName = dr["FILE_NAME"] != DBNull.Value ? Convert.ToString(dr["FILE_NAME"]) : "",
                                    FileType = dr["FILE_TYPE"] != DBNull.Value ? Convert.ToString(dr["FILE_TYPE"]) : "",
                                    FileDisplayname = dr["FILE_DISPLAYNAME"] != DBNull.Value ? Convert.ToString(dr["FILE_DISPLAYNAME"]) : "",
                                    ContentType = dr["CONTENT_TYPE"] != DBNull.Value ? Convert.ToString(dr["CONTENT_TYPE"]) : "",
                                    Extension = dr["EXTENSION"] != DBNull.Value ? Convert.ToString(dr["EXTENSION"]) : "",
                                    FileData = dr["FILE_DATA"] != DBNull.Value ? (byte[])dr["FILE_DATA"] : null
                                });
                    }

                }

                CommonViewModel.Data1 = productInfo;
                CommonViewModel.Data2 = productAttachments;

            }

            return View(CommonViewModel);
        }

        public IActionResult DownloadFile(int id)
        {
            ProductAttachment obj = new ProductAttachment();

            string sql = "SELECT ID, PRD_INFO_ID, FILE_NAME, FILE_TYPE, FILE_DISPLAYNAME, CONTENT_TYPE, EXTENSION, FILE_DATA FROM PRODUCT_ATTACHMENT WHERE ID =" + id;

            var dt = DataContext.ExecuteQuery(sql);

            if (dt != null && dt.Rows.Count > 0)
            {
                obj = new ProductAttachment()
                {
                    FileName = dt.Rows[0]["FILE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FILE_NAME"]) : "",
                    FileType = dt.Rows[0]["FILE_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FILE_TYPE"]) : "",
                    FileDisplayname = dt.Rows[0]["FILE_DISPLAYNAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FILE_DISPLAYNAME"]) : "",
                    ContentType = dt.Rows[0]["CONTENT_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CONTENT_TYPE"]) : "",
                    Extension = dt.Rows[0]["EXTENSION"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EXTENSION"]) : "",
                    FileData = dt.Rows[0]["FILE_DATA"] != DBNull.Value ? (byte[])(dt.Rows[0]["FILE_DATA"]) : null
                };
                if (obj.FileData != null)
                {
                    return File(obj.FileData, obj.ContentType, obj.FileDisplayname + "." + obj.Extension);
                }
            }
            return NotFound();
        }

        [HttpPost]
        public ActionResult SendEmail(LoginViewModel viewModel)
        {
            try
            {


                //var result = SendHtmlFormattedEmail(body);
                if (viewModel.UserName != null)
                {
                    string EmailAndPass = GetEmailId(viewModel.UserName);

                    string[] splitValues = EmailAndPass.Split('|');

                    string toEmail = splitValues[0];
                    string password = Common.Decrypt(splitValues[1]);
                    string firstName = splitValues[2];
                    string middleName = splitValues[3];
                    string lastName = splitValues[4];
                    string userName = splitValues[5];



                    //string body = this.createEmailBody(viewModel.UserName, password);


                    //var response = 
                    //Common.SendEmail("Forgot Password", body, toEmail.Replace(" ", "").Replace(";", ",").Split(",").ToArray(), null, false);

                    //if (response.IsSuccess == false)
                    //	LogService.LogInsert(GetCurrentAction(), response.Message);

                    //CommonViewModel.IsConfirm = true;
                    //CommonViewModel.IsSuccess = response.IsSuccess;
                    //CommonViewModel.StatusCode = response.IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    //CommonViewModel.Message = response.Message;
                    ////CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

                    var textBody = $"Dear {firstName} {middleName} {lastName},";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $@"Your User credential Information for Dispatch System is as below.";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"Username : {userName}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"Password: {password}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"URL: {AppHttpContextAccessor.Invoice_QR_Image_URL_Domain}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + "This is auto generated mail please do not reply on this message.";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + "Best regards,";

                    textBody = textBody + System.Environment.NewLine;

                    textBody = textBody + "Indian Farmers Fertilizer Co-Operative Ltd.";

                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_FROM_LIST", OracleDbType.Varchar2) { Value = AppHttpContextAccessor.AdminFromMail });
                    oParams.Add(new OracleParameter("P_TO_LIST", OracleDbType.Varchar2) { Value = toEmail });
                    oParams.Add(new OracleParameter("P_CC_LIST", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_BCC_LIST", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_SUBJ", OracleDbType.Varchar2) { Value = "Forgot Password" });
                    oParams.Add(new OracleParameter("P_BODY", OracleDbType.Varchar2) { Value = textBody });
                    oParams.Add(new OracleParameter("P_REPLY_TO", OracleDbType.Varchar2) { Value = "" });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SEND_EMAIL", oParams, false);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = "E-Mail Sending.....";

                    return Json(CommonViewModel);


                    ////string toEmail = AppHttpContextAccessor.AdminToMail;
                    //using (System.Net.Mail.MailMessage mailMessage = new System.Net.Mail.MailMessage())
                    //{
                    //    mailMessage.From = new System.Net.Mail.MailAddress(AppHttpContextAccessor.AdminFromMail, AppHttpContextAccessor.DisplayName);

                    //    mailMessage.Subject = AppHttpContextAccessor.Subject;

                    //    mailMessage.Body = body;

                    //    mailMessage.IsBodyHtml = true;

                    //    if (toEmail.Contains(","))
                    //    {
                    //        foreach (string item in toEmail.Split(','))
                    //        {
                    //            mailMessage.To.Add(new System.Net.Mail.MailAddress(item.Trim())); // Trim to remove leading/trailing spaces
                    //        }
                    //    }
                    //    else
                    //    {
                    //        mailMessage.To.Add(new System.Net.Mail.MailAddress(toEmail));
                    //    }

                    //    // Create and configure SMTP client
                    //    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                    //    smtp.Host = AppHttpContextAccessor.Host;
                    //    smtp.Port = AppHttpContextAccessor.Port;
                    //    smtp.EnableSsl = Convert.ToBoolean(AppHttpContextAccessor.EnableSsl);

                    //    // Provide authentication credentials
                    //    smtp.UseDefaultCredentials = false; // Set to false to specify custom credentials
                    //    smtp.Credentials = new System.Net.NetworkCredential(AppHttpContextAccessor.AdminFromMail, AppHttpContextAccessor.MailPassword);

                    //    // Send the email
                    //    smtp.Send(mailMessage);

                    //    CommonViewModel.IsConfirm = true;
                    //    CommonViewModel.IsSuccess = true;
                    //    CommonViewModel.StatusCode = true ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    //    CommonViewModel.Message = "Mail Sent Successfully!";

                    //    CommonViewModel.RedirectURL = true ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                    //}
                }
            }
            catch (Exception ex)
            {
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
            }


            return Json(CommonViewModel);
        }

        private string createEmailBody(string UserName, string Password)
        {
            //UserName = (string)HttpContext.Session["Email"];
            //Password = (string)HttpContext.Session["Password"];
            //var decryptPass = Common.Decrypt(Password);

            string body = string.Empty;
            var template = "";



            if (UserName != null && Password != null)
            {

                template = "ForgotPassTemp.cshtml";
                using (StreamReader reader = new StreamReader(System.IO.Path.Combine(AppHttpContextAccessor.WebRootPath + "/Templates", template)))
                {
                    body = reader.ReadToEnd();
                }
                body = body.Replace("{UserName}", UserName);
                body = body.Replace("{Password}", Password);

            }
            return body;
        }

        private string GetEmailId(string Username)
        {
            string Email = "";
            string Password = "";
            string firstName = "";
            string middleName = "";
            string lastName = "";
            string userName = "";
            string sqlQuery = "SELECT USER_NAME,FIRST_NAME,MIDDLE_NAME,LAST_NAME,EMAIL_ID, USER_PASSWORD FROM USER_MASTER WHERE USER_NAME = '" + Username + "'";
            var dt = DataContext.ExecuteQuery(sqlQuery);

            if (dt != null)
            {
                Email = dt.Rows[0]["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EMAIL_ID"]) : "";
                Password = dt.Rows[0]["USER_PASSWORD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["USER_PASSWORD"]) : "";
                firstName = dt.Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FIRST_NAME"]) : "";
                middleName = dt.Rows[0]["MIDDLE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MIDDLE_NAME"]) : "";
                lastName = dt.Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["LAST_NAME"]) : "";
                userName = dt.Rows[0]["USER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["USER_NAME"]) : "";
            }
            return Email + '|' + Password + '|' + firstName + '|' + middleName + '|' + lastName + '|' + userName;
        }

        [HttpPost]
        public ActionResult VendorSendEmail(VendorLoginViewModel viewModel)
        {
            try
            {
                //var result = SendHtmlFormattedEmail(body);
                if (viewModel.VendorCode != null)
                {
                    string EmailAndPass = GetVendorEmailPass(viewModel.VendorCode, viewModel.SiteId);

                    string[] splitValues = EmailAndPass.Split('|');

                    string vendorCode = splitValues[0];
                    string Email1 = splitValues[1];
                    string Email2 = splitValues[2];
                    string password = Common.Decrypt(splitValues[3]);
                    string siteName = splitValues[4];
                    string orgName = splitValues[5];

                    if (Email1 == "")
                    {
                        CommonViewModel.IsConfirm = false;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Email ID is not available!";

                        CommonViewModel.RedirectURL = true ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

                        return Json(CommonViewModel);
                    }
                    string Emails = Email2 != null ? Email1 + "," + Email2 : Email1;
                    //string body = this.createVendorEmailBody(viewModel.VendorCode, siteName, password);

                    //var response = 
                    //Common.SendEmail("Forgot Password", body, Email1.Replace(" ", "").Replace(";", ",").Split(",").ToArray(), null, false);

                    //if (response.IsSuccess == false)
                    //	LogService.LogInsert(GetCurrentAction(), response.Message);

                    //CommonViewModel.IsConfirm = true;
                    //CommonViewModel.IsSuccess = response.IsSuccess;
                    //CommonViewModel.StatusCode = response.IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    //CommonViewModel.Message = response.IsSuccess ? "Mail Sent Successfully on " + Email1 + "!" : response.Message;
                    ////CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
                    var textBody = $"Dear {orgName},";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $@"Your Vendor credential Information for QR Code Management system is as below.";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"Vendor Code : {viewModel.VendorCode}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"Vendor Site : {siteName}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"Password: {password}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + $"URL: {AppHttpContextAccessor.Vendor_Portal_Url}";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + "This is auto generated mail please do not reply on this message.";

                    textBody = textBody + System.Environment.NewLine + System.Environment.NewLine;

                    textBody = textBody + "Best regards,";

                    textBody = textBody + System.Environment.NewLine;

                    textBody = textBody + "Indian Farmers Fertilizer Co-Operative Ltd.";

                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_FROM_LIST", OracleDbType.Varchar2) { Value = AppHttpContextAccessor.AdminFromMail });
                    oParams.Add(new OracleParameter("P_TO_LIST", OracleDbType.Varchar2) { Value = Emails });
                    oParams.Add(new OracleParameter("P_CC_LIST", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_BCC_LIST", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_SUBJ", OracleDbType.Varchar2) { Value = "Forgot Password" });
                    oParams.Add(new OracleParameter("P_BODY", OracleDbType.Varchar2) { Value = textBody });
                    oParams.Add(new OracleParameter("P_REPLY_TO", OracleDbType.Varchar2) { Value = "" });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SEND_EMAIL", oParams, false);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = "E-Mail Sending.....";

                    return Json(CommonViewModel);


                    ////string toEmail = AppHttpContextAccessor.AdminToMail;
                    //using (System.Net.Mail.MailMessage mailMessage = new System.Net.Mail.MailMessage())
                    //{
                    //    mailMessage.From = new System.Net.Mail.MailAddress(AppHttpContextAccessor.AdminFromMail, AppHttpContextAccessor.DisplayName);

                    //    mailMessage.Subject = AppHttpContextAccessor.Subject;

                    //    mailMessage.Body = body;

                    //    mailMessage.IsBodyHtml = true;

                    //    if (Email1 == "")
                    //    {
                    //        CommonViewModel.IsConfirm = false;
                    //        CommonViewModel.IsSuccess = false;
                    //        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    //        CommonViewModel.Message = "Email ID is not available!";

                    //        CommonViewModel.RedirectURL = true ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                    //        return Json(CommonViewModel);
                    //    }
                    //    else if (Email1.Contains(","))
                    //    {
                    //        foreach (string item in Email1.Split(','))
                    //        {
                    //            mailMessage.To.Add(new System.Net.Mail.MailAddress(item.Trim())); // Trim to remove leading/trailing spaces
                    //        }
                    //    }
                    //    else
                    //    {
                    //        mailMessage.To.Add(new System.Net.Mail.MailAddress(Email1));
                    //    }

                    //    // Create and configure SMTP client
                    //    System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                    //    smtp.Host = AppHttpContextAccessor.Host;
                    //    smtp.Port = AppHttpContextAccessor.Port;
                    //    smtp.EnableSsl = Convert.ToBoolean(AppHttpContextAccessor.EnableSsl);

                    //    // Provide authentication credentials
                    //    smtp.UseDefaultCredentials = false; // Set to false to specify custom credentials
                    //    smtp.Credentials = new System.Net.NetworkCredential(AppHttpContextAccessor.AdminFromMail, AppHttpContextAccessor.MailPassword);

                    //    // Send the email
                    //    smtp.Send(mailMessage);

                    //    CommonViewModel.IsConfirm = true;
                    //    CommonViewModel.IsSuccess = true;
                    //    CommonViewModel.StatusCode = true ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    //    CommonViewModel.Message = "Mail Sent Successfully on " + Email1 + "!";

                    //    CommonViewModel.RedirectURL = true ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                    //}
                }


                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.NotFound;
                //CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

            }
            catch (Exception ex)
            {
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
            }

            return Json(CommonViewModel);
        }

        private string GetVendorEmailPass(string vendorCode, long siteId)
        {
            string VendorCode = "";
            string VenMasterEmail = "";
            string SiteMasterEmail = "";
            string Password = "";
            string SiteName = "";
            string OrgName = "";

            string sqlQuery = "SELECT X.ORGANIZATION_NAME,X.VENDOR_CODE, Y.PASSWORD,Y.SITE_NAME, X.PRIMARY_EMAIL VENDOR_MASTER_EMAIL,Y.PRIMARY_EMAIL  SITE_MASTER_EMAIL  FROM VENDOR_MASTER X, SITE_MASTER Y WHERE X.VENDOR_CODE = '" + vendorCode + "' AND Y.SITE_ID = " + siteId;
            var dt = DataContext.ExecuteQuery(sqlQuery);

            if (dt != null)
            {
                VendorCode = dt.Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VENDOR_CODE"]) : "";
                VenMasterEmail = dt.Rows[0]["VENDOR_MASTER_EMAIL"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VENDOR_MASTER_EMAIL"]) : "";
                SiteMasterEmail = dt.Rows[0]["SITE_MASTER_EMAIL"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SITE_MASTER_EMAIL"]) : "";
                Password = dt.Rows[0]["PASSWORD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PASSWORD"]) : "";
                SiteName = dt.Rows[0]["SITE_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SITE_NAME"]) : "";
                OrgName = dt.Rows[0]["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ORGANIZATION_NAME"]) : "";
            }
            return VendorCode + '|' + VenMasterEmail + '|' + SiteMasterEmail + '|' + Password + '|' + SiteName + '|' + OrgName;
        }

        private string createVendorEmailBody(string UserName, string siteName, string Password)
        {
            //UserName = (string)HttpContext.Session["Email"];
            //Password = (string)HttpContext.Session["Password"];
            //var decryptPass = Common.Decrypt(Password);

            string body = string.Empty;
            var template = "";



            if (UserName != null && Password != null)
            {

                template = "VendorForgotPassTemp.cshtml";
                using (StreamReader reader = new StreamReader(System.IO.Path.Combine(AppHttpContextAccessor.WebRootPath + "/Templates", template)))
                {
                    body = reader.ReadToEnd();
                }
                body = body.Replace("{VendorCode}", UserName);
                body = body.Replace("{VendorSite}", siteName);
                body = body.Replace("{Password}", Password);

            }
            return body;
        }

        #endregion

        public IActionResult SyncData()
        {
            if (!Common.IsUserLogged())
                return RedirectToAction("Login", "Home", new { Area = "" });

            return View(CommonViewModel);
        }

        //[HttpPost]
        public IActionResult SyncMDA(string FromDate = null, string ToDate = null)
        {
            List<string> listMDA = new List<string>();

            JArray objArray = null;

            string strlistMDA_NO = "";

            bool IsNewAPI = true;

            var user_id = Common.Get_Session_Int(SessionKey.USER_ID);
            var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);
            plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

            try
            {
                string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

                var fromDate = !string.IsNullOrEmpty(FromDate) ? DateTime.ParseExact(FromDate.Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture) : DateTime.Now.AddDays(-10);
                var toDate = !string.IsNullOrEmpty(ToDate) ? DateTime.ParseExact(ToDate.Replace("-", "/"), "dd/MM/yyyy", CultureInfo.InvariantCulture) : DateTime.Now;

                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);
                ////StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"31001\", " +
                ////        "\"fromDt\" : \"" + fromDate.ToString("dd-MMM-yyyy").ToUpper() + "\", " +
                ////        "\"toDt\" : \"" + toDate.ToString("dd-MMM-yyyy").ToUpper() + "\",\"plantCd\" : \""+ AppHttpContextAccessor.PlantCode + "\"}", null, "application/json");
                ///
                //StringContent? content = content = new StringContent("{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31001\"," +
                //										"\"inParameters\" : [{ \"label\" : \"fromDt\", \"value\" : \"" + fromDate.ToString("dd-MMM-yyyy").ToUpper() + "\" }," +
                //															"{ \"label\" : \"toDt\", \"value\" : \"" + toDate.ToString("dd-MMM-yyyy").ToUpper() + "\" }," +
                //															"{ \"label\" : \"plantCd\", \"value\" : \"" + plantCode + "\" }" +
                //										"]}", null, "application/json");

                StringContent? content = new StringContent("{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31001\"" +
                    ",\"inParameters\" : [{ \"label\" : \"fromDt\", \"value\" : \"" + fromDate.ToString("dd-MMM-yyyy").ToUpper() + "\" }" +
                                        ",{ \"label\" : \"toDt\", \"value\" : \"" + toDate.ToString("dd-MMM-yyyy").ToUpper() + "\" }" +
                                        ",{ \"label\" : \"plantCd\", \"value\" : \"" + plantCode + "\" }" +
                                        "]}\n\n", null, "application/json");

                request.Content = content;

                request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

                HttpResponseMessage responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                if (responseBody != null && responseBody.IsSuccessStatusCode)
                {
                    IsNewAPI = true;

                    var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    if (!string.IsNullOrEmpty(responseContent))
                    {
                        objArray = JArray.Parse(responseContent.Replace("00:00:00.0", ""));

                        if (objArray != null && objArray.Count() > 0)
                            strlistMDA_NO = string.Join("|", objArray.Select(x => Convert.ToString(((JValue)x["MDA_NO"]).Value).Trim()).ToArray());
                    }
                }
                else if (responseBody == null || responseBody.StatusCode != System.Net.HttpStatusCode.OK)
                {
                    IsNewAPI = false;

                    request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

                    content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"31001\", " +
                            "\"fromDt\" : \"" + fromDate.ToString("dd-MMM-yyyy").ToUpper() + "\", " +
                            "\"toDt\" : \"" + toDate.ToString("dd-MMM-yyyy").ToUpper() + "\",\"plantCd\" : \"" + AppHttpContextAccessor.PlantCode + "\"}", null, "application/json");

                    request.Content = content;

                    responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                    if (responseBody.IsSuccessStatusCode)
                    {
                        var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                        if (!string.IsNullOrEmpty(responseContent)
                            && JObject.Parse(responseContent)["GetRoadMdaList"] != null && (JObject.Parse(responseContent)["GetRoadMdaList"]).Count() > 0)
                        {
                            objArray = JArray.Parse((JObject.Parse(responseContent.Replace("00:00:00.0", ""))["GetRoadMdaList"]).ToString());

                            if (objArray != null && objArray.Count() > 0)
                                strlistMDA_NO = string.Join("|", objArray.Select(x => Convert.ToString(((JValue)x["mda_no"]).Value).Trim()).ToArray());
                        }
                    }
                    else if (responseBody.StatusCode != System.Net.HttpStatusCode.OK)
                    {
                        CommonViewModel.IsConfirm = true;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
                        CommonViewModel.Message = "Can not fetch data from GDPS System. Please contact the system administrator.";

                        return Json(CommonViewModel);
                    }
                }

                if (!string.IsNullOrEmpty(strlistMDA_NO))
                {
                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.LongText) { Value = strlistMDA_NO });

                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_CHECK", oParams, true);

                    if (!string.IsNullOrEmpty(response))
                    {
                        string[] arrayMDA = response.Split("<#>");

                        if (IsNewAPI && arrayMDA != null && arrayMDA.Where(x => !string.IsNullOrEmpty(x)).Count() > 0)
                            objArray = new JArray(objArray.Where(x => arrayMDA.Where(z => !string.IsNullOrEmpty(z)).Contains(Convert.ToString(((JValue)x["MDA_NO"]).Value).Trim())));
                        else if (!IsNewAPI && arrayMDA != null && arrayMDA.Where(x => !string.IsNullOrEmpty(x)).Count() > 0)
                            objArray = new JArray(objArray.Where(x => arrayMDA.Where(z => !string.IsNullOrEmpty(z)).Contains(Convert.ToString(((JValue)x["mda_no"]).Value).Trim())));

                    }
                    else objArray = null;

                }
                else objArray = null;

                // Save MDA information Header and detail in database
                if (objArray != null && objArray.Count > 0)
                {
                    foreach (JToken objMDA_Header in objArray)
                    {
                        try
                        {
                            var strMDA = "";

                            if (IsNewAPI && objMDA_Header["MDA_NO"] != null && Convert.ToString(((JValue)objMDA_Header["MDA_NO"]).Value).Trim().Length > 0)
                            {
                                strMDA = (objMDA_Header["MDA_NO"] != null && ((JValue)objMDA_Header["MDA_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["MDA_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["DI_NO"] != null && ((JValue)objMDA_Header["DI_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DI_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["PLANT_CD"] != null && ((JValue)objMDA_Header["PLANT_CD"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["PLANT_CD"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["GR_NO"] != null && ((JValue)objMDA_Header["GR_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["GR_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["GR_DT"] != null && ((JValue)objMDA_Header["GR_DT"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["GR_DT"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
                                        (objMDA_Header["MDA_DT"] != null && ((JValue)objMDA_Header["MDA_DT"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["MDA_DT"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
                                        (objMDA_Header["TPTR_CD"] != null && ((JValue)objMDA_Header["TPTR_CD"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["TPTR_CD"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["TPTR_NAME"] != null && ((JValue)objMDA_Header["TPTR_NAME"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["TPTR_NAME"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["WH_CD"] != null && ((JValue)objMDA_Header["WH_CD"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["WH_CD"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["PARTY_NAME"] != null && ((JValue)objMDA_Header["PARTY_NAME"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["PARTY_NAME"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["DRIVER"] != null && ((JValue)objMDA_Header["DRIVER"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DRIVER"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["VEHICLE_NO"] != null && ((JValue)objMDA_Header["VEHICLE_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["VEHICLE_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["MOBILE_NO"] != null && ((JValue)objMDA_Header["MOBILE_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["MOBILE_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["DIST"] != null && ((JValue)objMDA_Header["DIST"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DIST"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["BAG_NOS"] != null && ((JValue)objMDA_Header["BAG_NOS"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["BAG_NOS"]).Value).ToString().Trim() : "=") + "|" +
                                        (objMDA_Header["NETT_QTY"] != null && ((JValue)objMDA_Header["NETT_QTY"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["NETT_QTY"]).Value).ToString().Trim() : "=") + "|" +
                                        (objMDA_Header["GROSS_QTY"] != null && ((JValue)objMDA_Header["GROSS_QTY"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["GROSS_QTY"]).Value).ToString().Trim() : "=") + "|" +
                                        (objMDA_Header["ECHIT_NO"] != null && ((JValue)objMDA_Header["ECHIT_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["ECHIT_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["GST_NO"] != null && ((JValue)objMDA_Header["GST_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["GST_NO"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["OUT_TIME"] != null && ((JValue)objMDA_Header["OUT_TIME"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["OUT_TIME"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
                                        (objMDA_Header["DESP_PLACE"] != null && ((JValue)objMDA_Header["DESP_PLACE"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DESP_PLACE"]).Value).Trim() : "=");

                            }
                            else if (!IsNewAPI && objMDA_Header["mda_no"] != null && Convert.ToString(((JValue)objMDA_Header["mda_no"]).Value).Trim().Length > 0)
                            {
                                strMDA = (objMDA_Header["mda_no"] != null && ((JValue)objMDA_Header["mda_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["mda_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["di_no"] != null && ((JValue)objMDA_Header["di_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["di_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["plant_cd"] != null && ((JValue)objMDA_Header["plant_cd"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["plant_cd"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["gr_no"] != null && ((JValue)objMDA_Header["gr_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["gr_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["gr_dt"] != null && ((JValue)objMDA_Header["gr_dt"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["gr_dt"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
                                        (objMDA_Header["mda_dt"] != null && ((JValue)objMDA_Header["mda_dt"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["mda_dt"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
                                        (objMDA_Header["tptr_cd"] != null && ((JValue)objMDA_Header["tptr_cd"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["tptr_cd"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["tptr_name"] != null && ((JValue)objMDA_Header["tptr_name"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["tptr_name"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["wh_cd"] != null && ((JValue)objMDA_Header["wh_cd"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["wh_cd"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["party_name"] != null && ((JValue)objMDA_Header["party_name"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["party_name"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["driver"] != null && ((JValue)objMDA_Header["driver"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["driver"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["vehicle_no"] != null && ((JValue)objMDA_Header["vehicle_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["vehicle_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["mobile_no"] != null && ((JValue)objMDA_Header["mobile_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["mobile_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["dist"] != null && ((JValue)objMDA_Header["dist"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["dist"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["bag_nos"] != null && ((JValue)objMDA_Header["bag_nos"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["bag_nos"]).Value).ToString().Trim() : "=") + "|" +
                                        (objMDA_Header["nett_qty"] != null && ((JValue)objMDA_Header["nett_qty"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["nett_qty"]).Value).ToString().Trim() : "=") + "|" +
                                        (objMDA_Header["gross_qty"] != null && ((JValue)objMDA_Header["gross_qty"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["gross_qty"]).Value).ToString().Trim() : "=") + "|" +
                                        (objMDA_Header["echit_no"] != null && ((JValue)objMDA_Header["echit_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["echit_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["gst_no"] != null && ((JValue)objMDA_Header["gst_no"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["gst_no"]).Value).Trim() : "=") + "|" +
                                        (objMDA_Header["out_time"] != null && ((JValue)objMDA_Header["out_time"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["out_time"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
                                        (objMDA_Header["desp_place"] != null && ((JValue)objMDA_Header["desp_place"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["desp_place"]).Value).Trim() : "=");

                            }


                            if (!string.IsNullOrEmpty(strMDA) && strMDA.Length > 0)
                            {
                                strMDA = strMDA + "$$";

                                // MDA DETAIL
                                // Fetch MDA Detail data from API

                                if (IsNewAPI)
                                {
                                    request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

                                    content = content = new StringContent("{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31003\"," +
                                                                            "\"inParameters\" : [{ \"label\" : \"mdaNo\", \"value\" : \"" + Convert.ToString(((JValue)objMDA_Header["MDA_NO"]).Value).Trim() + "\" }," +
                                                                                                "{ \"label\" : \"plantCd\", \"value\" : \"" + Convert.ToString(((JValue)objMDA_Header["PLANT_CD"]).Value).Trim() + "\" }" +
                                                                            "]}", null, "application/json");

                                    request.Content = content;

                                    request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

                                    responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                                    if (!responseBody.IsSuccessStatusCode) continue;
                                }
                                else
                                {
                                    request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

                                    content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"31003\", " +
                                        "\"mdaNo\" : \"" + Convert.ToString(((JValue)objMDA_Header["mda_no"]).Value).Trim() + "\"," +
                                        "\"plantCd\" : \"" + Convert.ToString(((JValue)objMDA_Header["plant_cd"]).Value).Trim() + "\"}", null, "application/json");

                                    request.Content = content;

                                    responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                                    if (!responseBody.IsSuccessStatusCode) continue;
                                };

                                var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                                if (string.IsNullOrEmpty(responseContent)) continue;

                                JArray listMDA_Dtls = null;

                                if (IsNewAPI)
                                    listMDA_Dtls = JArray.Parse(responseContent);
                                else if (!IsNewAPI && JObject.Parse(responseContent)["GetRoadMdaDetail"] != null && (JObject.Parse(responseContent)["GetRoadMdaDetail"]).Count() > 0)
                                    listMDA_Dtls = JArray.Parse((JObject.Parse(responseContent.Replace("00:00:00.0", ""))["GetRoadMdaDetail"]).ToString());

                                if (listMDA_Dtls != null)
                                    for (int i = 0; i < listMDA_Dtls.Count(); i++)
                                        try
                                        {
                                            if (IsNewAPI)
                                                strMDA = strMDA + (listMDA_Dtls[i]["PROD_SNO"] != null && ((JValue)listMDA_Dtls[i]["PROD_SNO"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["PROD_SNO"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["SKU_CODE"] != null && ((JValue)listMDA_Dtls[i]["SKU_CODE"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["SKU_CODE"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["PRD_CD"] != null && ((JValue)listMDA_Dtls[i]["PRD_CD"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["PRD_CD"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["SHIPMENT_NO"] != null && ((JValue)listMDA_Dtls[i]["SHIPMENT_NO"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["SHIPMENT_NO"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["BAG_NOS"] != null && ((JValue)listMDA_Dtls[i]["BAG_NOS"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls[i]["BAG_NOS"]).Value).ToString().Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["NETT_QTY"] != null && ((JValue)listMDA_Dtls[i]["NETT_QTY"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls[i]["NETT_QTY"]).Value).ToString().Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["GROSS_QTY"] != null && ((JValue)listMDA_Dtls[i]["GROSS_QTY"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls[i]["GROSS_QTY"]).Value).ToString().Trim() : "=") + "@@";
                                            else if (!IsNewAPI)
                                                strMDA = strMDA + (listMDA_Dtls[i]["prod_sno"] != null && ((JValue)listMDA_Dtls[i]["prod_sno"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["prod_sno"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["sku_code"] != null && ((JValue)listMDA_Dtls[i]["sku_code"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["sku_code"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["prd_cd"] != null && ((JValue)listMDA_Dtls[i]["prd_cd"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["prd_cd"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["shipment_no"] != null && ((JValue)listMDA_Dtls[i]["shipment_no"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls[i]["shipment_no"]).Value).Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["bag_nos"] != null && ((JValue)listMDA_Dtls[i]["bag_nos"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls[i]["bag_nos"]).Value).ToString().Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["nett_qty"] != null && ((JValue)listMDA_Dtls[i]["nett_qty"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls[i]["nett_qty"]).Value).ToString().Trim() : "=") + "|" +
                                                (listMDA_Dtls[i]["gross_qty"] != null && ((JValue)listMDA_Dtls[i]["gross_qty"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls[i]["gross_qty"]).Value).ToString().Trim() : "=") + "@@";
                                        }
                                        catch (Exception ex) { continue; }
                                else strMDA = strMDA;
                            }

                            if (!string.IsNullOrEmpty(strMDA) && strMDA.Length > 0)
                            {
                                listMDA.Add(strMDA);
                            }
                        }
                        catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); continue; }
                    }
                }

                // Multiple MDA and its Details in List of String format and join by ## String and in database Separated by ## 

                //if (dt != null && dt.Rows.Count > 0)
                if (listMDA != null && listMDA.Count() > 0)
                {
                    var objList_JSON = string.Join("##", listMDA.ToArray());

                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });

                    oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.LongText) { Value = objList_JSON });

                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_SAVE", oParams, true);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = "Process of Sync MDA Done";
                    //CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/SyncData";

                    return Json(CommonViewModel);
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
            CommonViewModel.Message = ResponseStatusMessage.NotFound;

            return Json(CommonViewModel);
        }

        public IActionResult SyncPlant()
        {
            var list = new List<PlantAPI>();

            string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

            var user_id = Common.Get_Session_Int(SessionKey.USER_ID);

            var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

            plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;
            user_id = user_id <= 0 ? 1 : user_id;

            try
            {
                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);
                StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"7003\"}", null, "application/json");

                request.Content = content;

                var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                if (responseBody.IsSuccessStatusCode)
                {
                    var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    if (!string.IsNullOrEmpty(responseContent))
                    {
                        JToken obj = JObject.Parse(responseContent.Replace("00:00:00.0", ""));

                        list = JsonConvert.DeserializeObject<List<PlantAPI>>(((Newtonsoft.Json.Linq.JArray)((Newtonsoft.Json.Linq.JProperty)obj.First).Value).ToString());

                    }
                }

                if (list != null && list.Count() > 0)
                {
                    var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, (long)0);

                    for (int i = 0; i < list.Count; i++)
                    {
                        List<OracleParameter> parameters = new List<OracleParameter>();

                        parameters.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2) { Value = list[i].plant_cd });
                        parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = list[i].plant_name });
                        parameters.Add(new OracleParameter("P_ADDRESS", OracleDbType.Varchar2) { Value = list[i].state_cd });
                        parameters.Add(new OracleParameter("P_UNIT_CODE", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        parameters.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        parameters.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        parameters.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_PLANT_SAVE", parameters, true);

                        list[i].plant_id = Id;
                    }


                    var objList_JSON = string.Join("<#>", list.Select(x => (x.plant_cd ?? "=") + "|" + (x.plant_name ?? "=") + "|" + (x.plant_name_h ?? "=") + "|" + (x.state_cd ?? "=") + "|" + (x.extra1 ?? "=") + "|" + x.plant_id).ToArray());

                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.VarString) { Value = objList_JSON });

                    oParams.Add(new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = plantCode });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SYNC_PLANT_SAVE", oParams, true);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = response;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/SyncData";

                    return Json(CommonViewModel);
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
            CommonViewModel.Message = ResponseStatusMessage.NotFound;

            return Json(CommonViewModel);
        }

        public IActionResult SyncWarehouse()
        {
            var list = new List<WarehouseAPI>();

            string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

            try
            {
                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);
                StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"7005\",\"P_STATE_CD\" : \"UP\",\"P_DISTT_CD\" : \"\"}", null, "application/json");

                request.Content = content;

                var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                if (responseBody.IsSuccessStatusCode)
                {
                    var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    if (!string.IsNullOrEmpty(responseContent))
                    {
                        JToken obj = JObject.Parse(responseContent.Replace("00:00:00.0", ""));

                        list = JsonConvert.DeserializeObject<List<WarehouseAPI>>(((Newtonsoft.Json.Linq.JArray)((Newtonsoft.Json.Linq.JProperty)obj.First).Value).ToString());

                    }
                }

                if (list != null && list.Count() > 0)
                {
                    int batchSize = 2000;
                    int totalBatches = (int)Math.Ceiling((double)list.Count() / batchSize);
                    bool isOverallSuccess = true;
                    string overallMessage = string.Empty;

                    for (int batchIndex = 0; batchIndex < totalBatches; batchIndex++)
                    {
                        var currentBatch = list.Skip(batchIndex * batchSize).Take(batchSize);

                        var objList_JSON = string.Join("<#>", currentBatch.Select(x =>
                            (x.party_cd ?? "=") + "|" +
                            (x.party_name ?? "=") + "|" +
                            (x.addr1 ?? "=") + "|" +
                            (x.tehsil_cd ?? "=") + "|" +
                            (x.party_name_h ?? "=") + "|" +
                            (x.pin_cd ?? "=") + "|" +
                            (x.tin_no ?? "=") + "|" +
                            (x.email ?? "=") + "|" +
                            (x.warehousing ?? "=") + "|" +
                            (x.handling ?? "=") + "|" +
                            (x.sales ?? "=") + "|" +
                            (x.tptn ?? "=") + "|" +
                            (x.inv ?? "=") + "|" +
                            (x.agency_cd ?? "=") + "|" +
                            (x.distt_cd ?? "=") + "|" +
                            (x.state_cd ?? "=") + "|" +
                            (x.wh_capacity ?? "=") + "|" +
                            (x.consignee ?? "=") + "|" +
                            (x.party_fas_cd ?? "=") + "|" +
                            (x.fsc ?? "=") + "|" +
                            (x.port_wh ?? "=") + "|" +
                            (x.active ?? "=") + "|" +
                            (x.retailer_license_no ?? "=") + "|" +
                            (x.dealer_type ?? "=") + "|" +
                            (x.dealer_nature ?? "=") + "|" +
                            (x.wholesales_license_no ?? "=") + "|" +
                            (x.pan_no ?? "=") + "|" +
                            (x.mobile_no ?? "=") + "|" +
                            (x.panchayat ?? "=") + "|" +
                            (x.urban_name ?? "=") + "|" +
                            (x.ward_name ?? "=") + "|" +
                            (x.village_name ?? "=") + "|" +
                            (x.tin_no_effective_dt ?? "=") + "|" +
                            (x.rkvy ?? "=") + "|" +
                            (x.fertiliser_lecence_validity ?? "=") + "|" +
                            (x.virtual_entity ?? "=") + "|" +
                            (x.gstin ?? "=") + "|" +
                            (x.gstin_effective_dt ?? "=") + "|" +
                            (x.longitude ?? "=") + "|" +
                            (x.latitude ?? "=") + "|" +
                            (x.stocking_point_flag ?? "=") + "|" +
                            (x.speciality_fertiliser_activist ?? "=")).ToArray());

                        var oParams = new List<MySqlParameter>
                        {
                            new MySqlParameter("P_JSON_LIST", MySqlDbType.LongText) { Value = objList_JSON },
                            new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = plantCode },
                            new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) },
                            new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) }
                        };

                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SYNC_WAREHOUSE_SAVE", oParams, true);

                        if (!isOverallSuccess)
                        {
                            isOverallSuccess = false;
                            overallMessage = response;
                            break; // Optionally, stop processing further batches if an error occurs
                        }
                    }

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = isOverallSuccess;
                    CommonViewModel.StatusCode = isOverallSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = overallMessage;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/SyncData";

                    return Json(CommonViewModel);
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
            CommonViewModel.Message = ResponseStatusMessage.NotFound;

            return Json(CommonViewModel);
        }


        public IActionResult SyncWholesaler()
        {
            var list = new List<WholesalerAPI>();

            string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

            try
            {
                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);
                StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"7006\",\"P_STATE_CD\" : \"UP\",\"P_DISTT_CD\" : \"CUFZ01\"}", null, "application/json");

                request.Content = content;

                var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                if (responseBody.IsSuccessStatusCode)
                {
                    var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    if (!string.IsNullOrEmpty(responseContent))
                    {
                        JToken obj = JObject.Parse(responseContent.Replace("00:00:00.0", ""));

                        list = JsonConvert.DeserializeObject<List<WholesalerAPI>>(((Newtonsoft.Json.Linq.JArray)((Newtonsoft.Json.Linq.JProperty)obj.First).Value).ToString());

                    }
                }

                if (list != null && list.Count() > 0)
                {
                    //var objList_JSON = string.Join("<#>", list.Select(x => (x.plant_cd ?? "=") + "|" + (x.plant_name ?? "=") + "|" + (x.plant_name_h ?? "=") + "|" + (x.state_cd ?? "=") + "|" + (x.extra1 ?? "=")).ToArray());

                    string objList_JSON = string.Join("<#>", list.Select(x =>
                                            (x.party_cd ?? "=") + "|" +
                                            (x.party_name ?? "=") + "|" +
                                            (x.addr1 ?? "=") + "|" +
                                            (x.tehsil_cd ?? "=") + "|" +
                                            (x.pin_cd ?? "=") + "|" +
                                            (x.phone_no_1 ?? "=") + "|" +
                                            (x.tin_no ?? "=") + "|" +
                                            (x.email ?? "=") + "|" +
                                            (x.warehousing ?? "=") + "|" +
                                            (x.handling ?? "=") + "|" +
                                            (x.sales ?? "=") + "|" +
                                            (x.tptn ?? "=") + "|" +
                                            (x.inv ?? "=") + "|" +
                                            (x.agency_cd ?? "=") + "|" +
                                            (x.distt_cd ?? "=") + "|" +
                                            (x.state_cd ?? "=") + "|" +
                                            (x.wh_capacity ?? "=") + "|" +
                                            (x.consignee ?? "=") + "|" +
                                            (x.fsc ?? "=") + "|" +
                                            (x.port_wh ?? "=") + "|" +
                                            (x.active ?? "=") + "|" +
                                            (x.dealer_type ?? "=") + "|" +
                                            (x.dealer_nature ?? "=") + "|" +
                                            (x.wholesales_license_no ?? "=") + "|" +
                                            (x.pan_no ?? "=") + "|" +
                                            (x.mobile_no ?? "=") + "|" +
                                            (x.panchayat ?? "=") + "|" +
                                            (x.village_cd ?? "=") + "|" +
                                            (x.village_name ?? "=") + "|" +
                                            (x.nic_village_cd ?? "=") + "|" +
                                            (x.text ?? "=") + "|" +
                                            (x.mfms_id_wholesaler ?? "=") + "|" +
                                            (x.tin_no_effective_dt ?? "=") + "|" +
                                            (x.rkvy ?? "=") + "|" +
                                            (x.fertiliser_lecence_validity ?? "=") + "|" +
                                            (x.virtual_entity ?? "=") + "|" +
                                            (x.gstin ?? "=") + "|" +
                                            (x.gstin_effective_dt ?? "=") + "|" +
                                            (x.speciality_fertiliser_activist ?? "=")
                                        ).ToArray());


                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.LongText) { Value = objList_JSON });
                    oParams.Add(new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = plantCode });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SYNC_WHOLESALER_SAVE", oParams, true);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = response;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/SyncData";

                    return Json(CommonViewModel);
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
            CommonViewModel.Message = ResponseStatusMessage.NotFound;

            return Json(CommonViewModel);
        }

        public IActionResult SyncRetailer()
        {
            var list = new List<RetailerAPI>();

            string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

            try
            {
                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);
                StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"7007\",\"P_STATE_CD\" : \"UP\",\"P_DISTT_CD\" : \"CUFZ01\"}", null, "application/json");

                request.Content = content;

                var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                if (responseBody.IsSuccessStatusCode)
                {
                    var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    if (!string.IsNullOrEmpty(responseContent))
                    {
                        JToken obj = JObject.Parse(responseContent.Replace("00:00:00.0", ""));

                        list = JsonConvert.DeserializeObject<List<RetailerAPI>>(((Newtonsoft.Json.Linq.JArray)((Newtonsoft.Json.Linq.JProperty)obj.First).Value).ToString());

                    }
                }

                if (list != null && list.Count() > 0)
                {
                    var objList_JSON = string.Join("<#>", list.Select(x =>
                                    (x.party_cd ?? "=") + "|" +
                                    (x.party_name ?? "=") + "|" +
                                    (x.addr1 ?? "=") + "|" +
                                    (x.tehsil_cd ?? "=") + "|" +
                                    (x.party_name_h ?? "=") + "|" +
                                    (x.pin_cd ?? "=") + "|" +
                                    (x.tin_no ?? "=") + "|" +
                                    (x.credit_limit ?? "=") + "|" +
                                    (x.warehousing ?? "=") + "|" +
                                    (x.handling ?? "=") + "|" +
                                    (x.sales ?? "=") + "|" +
                                    (x.tptn ?? "=") + "|" +
                                    (x.inv ?? "=") + "|" +
                                    (x.agency_cd ?? "=") + "|" +
                                    (x.distt_cd ?? "=") + "|" +
                                    (x.state_cd ?? "=") + "|" +
                                    (x.wh_capacity ?? "=") + "|" +
                                    (x.reserved_by_iffco ?? "=") + "|" +
                                    (x.consignee ?? "=") + "|" +
                                    (x.addr2 ?? "=") + "|" +
                                    (x.fsc ?? "=") + "|" +
                                    (x.port_wh ?? "=") + "|" +
                                    (x.active ?? "=") + "|" +
                                    (x.retailer_license_no ?? "=") + "|" +
                                    (x.dealer_type ?? "=") + "|" +
                                    (x.dealer_nature ?? "=") + "|" +
                                    (x.pan_no ?? "=") + "|" +
                                    (x.mobile_no ?? "=") + "|" +
                                    (x.panchayat ?? "=") + "|" +
                                    (x.village_cd ?? "=") + "|" +
                                    (x.village_name ?? "=") + "|" +
                                    (x.nic_village_cd ?? "=") + "|" +
                                    (x.text ?? "=") + "|" +
                                    (x.mfms_id ?? "=") + "|" +
                                    (x.tin_no_effective_dt ?? "=") + "|" +
                                    (x.rkvy ?? "=") + "|" +
                                    (x.fertiliser_lecence_validity ?? "=") + "|" +
                                    (x.virtual_entity ?? "=") + "|" +
                                    (x.contact_person ?? "=") + "|" +
                                    (x.gstin ?? "=") + "|" +
                                    (x.gstin_effective_dt ?? "=") + "|" +
                                    (x.gstin_effective_to_dt ?? "=")
                                ).ToArray());


                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.LongText) { Value = objList_JSON });

                    oParams.Add(new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = plantCode });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SYNC_RETAILER_SAVE", oParams, true);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = response;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/SyncData";

                    return Json(CommonViewModel);
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
            CommonViewModel.Message = ResponseStatusMessage.NotFound;

            return Json(CommonViewModel);
        }

        public IActionResult SyncProduct()
        {
            var list = new List<ProductAPI>();

            string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

            var user_id = Common.Get_Session_Int(SessionKey.USER_ID);

            var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

            plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;
            user_id = user_id <= 0 ? 1 : user_id;

            try
            {
                var client = new HttpClient();
                var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);
                StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"7004\"}", null, "application/json");

                request.Content = content;

                var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                if (responseBody.IsSuccessStatusCode)
                {
                    var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    if (!string.IsNullOrEmpty(responseContent))
                    {
                        JToken obj = JObject.Parse(responseContent.Replace("00:00:00.0", ""));

                        list = JsonConvert.DeserializeObject<List<ProductAPI>>(((Newtonsoft.Json.Linq.JArray)((Newtonsoft.Json.Linq.JProperty)obj.First).Value).ToString());

                        if (list != null && list.Where(x => x.plant_cd == plantCode).Count() > 0)
                            list = list.Where(x => x.plant_cd == plantCode).ToList();
                    }
                }

                if (list != null && list.Count() > 0)
                {
                    var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, (long)0);

                    for (int i = 0; i < list.Count; i++)
                    {
                        List<OracleParameter> parameters = new List<OracleParameter>();

                        //(x.prd_cd ?? "=") + "|" + (x.prd_desc ?? "=") + "|" + (x.prd_desc_h ?? "=") + "|" + (x.plant_cd ?? "=") + "|" + x.print_order + "|" + (x.prd_desc_short ?? "=") + "|" + (x.extra1 ?? "=") + "|" + (x.extra2 ?? "=") + "|" + (x.extra3 ?? "=") + "|" + (x.prd_type ?? "=") + "|" + (x.sub_plant_cd ?? "=") + "|" + (x.prd_category ?? "=") + "|" + (x.active ?? "=") + "|" + x.hsn_code + "|" + (x.uom ?? "=") + "|" + x.conv_factor + "|" + (x.uom_evikas ?? "=") + "|" + (x.prd_cd_group_app ?? "=")

                        parameters.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = list[i].prd_desc });
                        parameters.Add(new OracleParameter("P_SKU_CODE", OracleDbType.Varchar2) { Value = list[i].prd_cd });
                        parameters.Add(new OracleParameter("P_SKU_NAME", OracleDbType.Varchar2) { Value = list[i].prd_desc });
                        parameters.Add(new OracleParameter("P_PRD_CD", OracleDbType.Varchar2) { Value = list[i].prd_cd });
                        parameters.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = 1 });
                        parameters.Add(new OracleParameter("P_PRD_WT_FILL", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_SHIP_WT_FILL", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_PROD_PER_SHIPPER", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_TOLERANCE_PER", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_PAL_WT_FILL", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_SHIP_PER_PALLET", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_NOTE", OracleDbType.Varchar2) { Value = "" });
                        parameters.Add(new OracleParameter("P_PRD_DESC_H", OracleDbType.Varchar2) { Value = list[i].prd_desc_h });
                        parameters.Add(new OracleParameter("P_PRINT_ORDER", OracleDbType.Varchar2) { Value = list[i].print_order });
                        parameters.Add(new OracleParameter("P_PRD_DESC_SHORT", OracleDbType.Varchar2) { Value = list[i].prd_desc_short });
                        parameters.Add(new OracleParameter("P_EXTRA1", OracleDbType.Varchar2) { Value = list[i].extra1 });
                        parameters.Add(new OracleParameter("P_EXTRA2", OracleDbType.Varchar2) { Value = list[i].extra2 });
                        parameters.Add(new OracleParameter("P_EXTRA3", OracleDbType.Varchar2) { Value = list[i].extra3 });
                        parameters.Add(new OracleParameter("P_PRD_TYPE", OracleDbType.Varchar2) { Value = list[i].prd_type });
                        parameters.Add(new OracleParameter("P_SUB_PLANT_CD", OracleDbType.Varchar2) { Value = list[i].sub_plant_cd });
                        parameters.Add(new OracleParameter("P_PRD_CATEGORY", OracleDbType.Varchar2) { Value = list[i].prd_category });
                        parameters.Add(new OracleParameter("P_ACTIVE", OracleDbType.Varchar2) { Value = list[i].active });
                        parameters.Add(new OracleParameter("P_HSN_CODE", OracleDbType.Varchar2) { Value = list[i].hsn_code });
                        parameters.Add(new OracleParameter("P_PRD_CD_GROUP_APP", OracleDbType.Varchar2) { Value = list[i].prd_cd_group_app });
                        parameters.Add(new OracleParameter("P_UOM", OracleDbType.Varchar2) { Value = list[i].uom });
                        parameters.Add(new OracleParameter("P_CONV_FACTOR", OracleDbType.Int64) { Value = list[i].conv_factor });
                        parameters.Add(new OracleParameter("P_UOM_EVIKAS", OracleDbType.Varchar2) { Value = list[i].uom_evikas });
                        parameters.Add(new OracleParameter("P_GTIN", OracleDbType.Varchar2) { Value = "" });
                        parameters.Add(new OracleParameter("P_VALID_MONTH", OracleDbType.Int64) { Value = 0 });
                        parameters.Add(new OracleParameter("P_QR_LAST_SERIAL_NO", OracleDbType.Varchar2) { Value = "" });
                        parameters.Add(new OracleParameter("P_BPEX", OracleDbType.Varchar2) { Value = "" });
                        parameters.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });

                        parameters.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = plant_id });
                        parameters.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        parameters.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        parameters.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_Product_SAVE", parameters, true);

                        list[i].prd_id = Id;
                    }

                    var objList_JSON = string.Join("<#>", list.Where(x => x.prd_id > 0).Select(x => (x.prd_cd ?? "=") + "|" + (x.prd_desc ?? "=") + "|" + (x.prd_desc_h ?? "=") + "|" + (x.plant_cd ?? "=") + "|" + x.print_order + "|" + (x.prd_desc_short ?? "=") + "|" + (x.extra1 ?? "=") + "|" + (x.extra2 ?? "=") + "|" + (x.extra3 ?? "=") + "|" + (x.prd_type ?? "=") + "|" + (x.sub_plant_cd ?? "=") + "|" + (x.prd_category ?? "=") + "|" + (x.active ?? "=") + "|" + x.hsn_code + "|" + (x.uom ?? "=") + "|" + x.conv_factor + "|" + (x.uom_evikas ?? "=") + "|" + (x.prd_cd_group_app ?? "=") + "|" + x.prd_id).ToArray());

                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.VarString) { Value = objList_JSON });

                    oParams.Add(new MySqlParameter("P_PLANT_CODE", MySqlDbType.VarString) { Value = plantCode });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SYNC_PRODUCT_SAVE", oParams, true);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = response;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/SyncData";

                    return Json(CommonViewModel);
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
            CommonViewModel.Message = ResponseStatusMessage.NotFound;

            return Json(CommonViewModel);
        }

        private void Write_Log(string text, string filePath)
        {
            if (!string.IsNullOrEmpty(text))
            {
                filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd"));
                filePath = filePath.Replace("<HH>", DateTime.Now.ToString("HH"));
                filePath = filePath.Replace("<TT>", DateTime.Now.ToString("tt"));

                if (!System.IO.Directory.Exists(Path.GetDirectoryName(filePath)))
                    System.IO.Directory.CreateDirectory(Path.GetDirectoryName(filePath));

                if (!System.IO.File.Exists(filePath))
                    System.IO.File.Create(filePath).Dispose();

                if (!System.IO.Directory.Exists(Path.GetDirectoryName(filePath)))
                    System.IO.Directory.CreateDirectory(Path.GetDirectoryName(filePath));

                if (!System.IO.File.Exists(filePath))
                    System.IO.File.Create(filePath).Dispose();

                using (StreamWriter sw = System.IO.File.AppendText(filePath))
                    //sw.WriteLine(text);
                    sw.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text + System.Environment.NewLine);

            }
        }


        public IActionResult SyncData_LocalToCloud(string tableName = null)
        {
            try
            {
                //DataContext.SyncData_LocalToCloud(tableName, null, null);

                Task.Run(async () => await DataContext.SyncData_LocalToCloud(tableName, null, null));

                //"FG_GATE_IN_OUT","FG_WEIGHMENT_DETAIL","MDA_HEADER","MDA_DETAIL","MDA_LOADING","MDA_REQUISITION_DATA","MDA_SEQUENCE","MDA_INVOICE_QR","MDA_ADD_QTY_REQUEST"

                //DataTable dtSql = DataContext.ExecuteQuery_SQL("SELECT GATE_SYS_ID, GATE_IN_DT, GATE_OUT_DT, INWARD_SYS_ID, MDA_SYS_ID, TRUCK_NO" +
                //	", DRIVER_ID_TYPE, DRIVER_ID_NUMBER, DRIVER_NAME, DRIVER_CONTACT, DRIVER_CHANGED, DRIVER_NAME_NEW, DRIVER_CONTACT_NEW, TRUCK_VALIDATION" +
                //	", RFSYSID, VERIFIED_DOCUMENTS, RFID_RECEIVE, VERIFIED_OFFICER_ID, CANCEL_GATE_IN, CANCEL_GATE_REASON, GATE_SYS_ID_OLD" +
                //	", IS_GOODS_TRANSFER, STATION_ID, PLANT_ID, CREATED_BY_ID, CREATED_DATETIME, IS_POSTED " +
                //	"FROM FG_GATE_IN_OUT WHERE IFNULL(IS_POSTED,0) = 0");

                //if (dtSql != null && dtSql.Rows.Count > 0)
                //{
                //	long[] idsToFilter = dtSql.AsEnumerable().Select(row => Convert.ToInt64($"{row["GATE_SYS_ID"]}")).ToArray();
                //	string idParameterList = string.Join(", ", idsToFilter);

                //	DataTable dtOracle = DataContext.ExecuteQuery($"SELECT DISTINCT GATE_SYS_ID FROM FG_GATE_IN_OUT WHERE GATE_SYS_ID IN ({idParameterList})");

                //	DataTable filteredDataTable = dtSql.AsEnumerable()
                //		.Where(row => (dtOracle != null && dtOracle.Rows.Count > 0) ? !idsToFilter.Any(x => x == Convert.ToInt64(row["GATE_SYS_ID"])) : true)
                //		.CopyToDataTable();

                //	if (filteredDataTable != null && filteredDataTable.Rows.Count > 0)
                //	{
                //		DataContext.OracleBulkCopy("FG_GATE_IN_OUT", filteredDataTable);

                //		idParameterList = string.Join(", ", filteredDataTable.AsEnumerable().Select(row => $"{row["GATE_SYS_ID"]}"));
                //		string query = $"UPDATE FG_GATE_IN_OUT SET IS_POSTED = 1 WHERE GATE_SYS_ID IN ({idParameterList})";

                //		DataContext.ExecuteNonQuery_SQL(query);
                //	}
                //}


                CommonViewModel.IsSuccess = true;
                CommonViewModel.StatusCode = ResponseStatusCode.Success;
                CommonViewModel.Message = tableName + " : Record updated successfully.";

                return Json(CommonViewModel);
            }
            catch (Exception ex)
            {
                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = "Error : " + JsonConvert.SerializeObject(ex);

                return Json(CommonViewModel);
            }
        }


        public IActionResult SyncBatch_New(string searchTerm = null)
        {
            try
            {
                string logFilePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Log_File_Path").Value ?? "");

                string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Source_Folder_Path").Value ?? "");
                string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Destination_Folder_Path").Value ?? "");
                string errorFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Error_Folder_Path").Value ?? "");

                if (!System.IO.Directory.Exists(sourceFolderPath))
                    System.IO.Directory.CreateDirectory(sourceFolderPath);

                if (!System.IO.Directory.Exists(destinationFolderPath))
                    System.IO.Directory.CreateDirectory(destinationFolderPath);

                if (!System.IO.Directory.Exists(errorFolderPath))
                    System.IO.Directory.CreateDirectory(errorFolderPath);


                string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

                List<string> sourceFilePaths = Directory.GetFiles(sourceFolderPath, "*.json", SearchOption.AllDirectories).ToList();
                List<string> destinationFilePaths = Directory.GetFiles(destinationFolderPath, "*.json", SearchOption.AllDirectories).ToList();

                if (destinationFilePaths == null)
                    destinationFilePaths = new List<string>() { "" };

                var dt = new DataTable();

                List<string> errors = new List<string>();

                var user_id = Common.Get_Session_Int(SessionKey.USER_ID);

                var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

                plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;
                user_id = user_id <= 0 ? 1 : user_id;

                Write_Log($"File(s) Processing Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}", logFilePath);

                if (!string.IsNullOrEmpty(searchTerm))
                {
                    if (sourceFilePaths == null) sourceFilePaths = new List<string>() { "" };

                    List<string> sourceFilePaths_ = Directory.GetFiles(errorFolderPath, "*.json", SearchOption.AllDirectories).ToList();

                    if (sourceFilePaths_ != null && sourceFilePaths_.Count() > 0 && sourceFilePaths_.Any(x => x.Contains(searchTerm)))
                        sourceFilePaths.AddRange(sourceFilePaths_.Where(x => x.Contains(searchTerm)).ToList());

                    if (sourceFilePaths != null && sourceFilePaths.Count() > 0 && sourceFilePaths.Any(x => x.Contains(searchTerm)))
                        sourceFilePaths = sourceFilePaths.Where(x => x.Contains(searchTerm)).ToList();

                    destinationFilePaths = new List<string>() { "" };
                }

                if (sourceFilePaths != null && sourceFilePaths.Count() > 0)
                {
                    List<(long Id, string GTIN, int ExpireInMonth)> listProduct = new List<(long Id, string GTIN, int ExpireInMonth)>();

                    dt = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PROD_SYS_ID, GTIN, VALIDITY_MONTH FROM PRODUCT_MASTER WHERE IFNULL(GTIN, '') != '' ");

                    if (dt != null && dt.Rows.Count > 0)
                        listProduct = (from DataRow dr in dt.Rows
                                       select (Id: (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)
                                       , GSTIN: (dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "")
                                       , ExpireInMonth: (dr["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["VALIDITY_MONTH"]) : 0))).ToList();

                    var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

                    foreach (var sourceFilePath in orderedFilePaths.Where(x => !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
                    {
                        if (!System.IO.File.Exists(sourceFilePath)) continue;

                        var currentDateTime = DateTime.Now;

                        Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
                            $"Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}", logFilePath);

                        List<(string QRCode, string Type)> listShipperQRCode_Duplicate = new List<(string QRCode, string Type)>();

                        List<(string QRCode, string Type)> listBottleQRCode_Duplicate = new List<(string QRCode, string Type)>();

                        var error = "";

                        var shipperData = new ShipperData();

                        StringBuilder fileContent = new StringBuilder();
                        using (StreamReader sr = new StreamReader(sourceFilePath)) { fileContent.Append(sr.ReadToEnd()); }

                        dt = new DataTable();

                        try
                        {
                            if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
                            {
                                string fileContent_Str = Convert.ToString(fileContent);

                                fileContent_Str = Regex.Replace(fileContent_Str, @"//.*?$", string.Empty, RegexOptions.Multiline);

                                fileContent_Str = Regex.Replace(fileContent_Str, @"/\*.*?\*/", string.Empty, RegexOptions.Singleline);

                                JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

                                shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());
                            }

                            if (shipperData == null)
                                error += $"Invalid data.";

                            if (shipperData != null && string.IsNullOrEmpty(shipperData.Batch_no))
                                error += $"Batch No is not null." + System.Environment.NewLine;

                            if (shipperData != null && (string.IsNullOrEmpty(shipperData.ManufacturedBy) || shipperData.ManufacturedBy.ToLower() == "none"))
                                shipperData.ManufacturedBy = "Indian Farmers Fertiliser Cooperative";

                            if (shipperData != null && (string.IsNullOrEmpty(shipperData.MarketedBy) || shipperData.MarketedBy.ToLower() == "none"))
                                shipperData.MarketedBy = "Indian Farmers Fertiliser Cooperative";

                            var Mfg_Date = DateTime.MinValue;
                            if (shipperData != null && (string.IsNullOrEmpty(shipperData.Mfg_Date) || !DateTime.TryParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Mfg_Date)))
                                error += $"Invalid Manufacture Date.";

                            int manufacture_Date_Before = -1;
                            int manufacture_Date_After = 1;

                            try { manufacture_Date_Before = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Manufacture_Date_Before").Value); } catch { }
                            try { manufacture_Date_After = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Manufacture_Date_After").Value); } catch { }

                            if (Mfg_Date != DateTime.MinValue && (Mfg_Date.Date.Ticks < DateTime.Now.AddMonths(manufacture_Date_Before).AddDays(1).Date.Ticks || Mfg_Date.Date.Ticks > DateTime.Now.AddMonths(manufacture_Date_After).AddDays(-1).Date.Ticks))
                                error += $"Manufacturing date cannot be more than 1 month old and must not be greater than 1 month from current date." + System.Environment.NewLine;

                            int ExpireInMonth = listProduct != null && shipperData != null
                                && shipperData.ShipperQRCode_Data != null && shipperData.ShipperQRCode_Data.Count() > 0
                                && shipperData.ShipperQRCode_Data[0].BottleQRCode != null && shipperData.ShipperQRCode_Data[0].BottleQRCode.Count() > 0
                                && listProduct.Any(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)) ?
                                listProduct.Where(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)).Select(y => y.ExpireInMonth).FirstOrDefault() : 0;

                            if (ExpireInMonth == 0)
                                error += $"Product's Expire In Month not available.";
                            else
                            {
                                shipperData.Expiry_Date = Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("yyMMdd");

                                Write_Log($"Manufacture date : {Mfg_Date.ToString("ddMMyyyy")}  ExpiryDate : {Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("ddMMyyyy")}", logFilePath);
                            }

                            if (string.IsNullOrEmpty(error) && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
                            {
                                if (shipperData != null && (shipperData.ShipperQRCode_Data == null || shipperData.ShipperQRCode_Data.Count() == 0))
                                    error += $"Shipper QR Code Data missing." + System.Environment.NewLine;

                                if (string.IsNullOrEmpty(error))
                                {
                                    if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
                                    {
                                        var error_QR = new List<string>();

                                        var len = 0;

                                        while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
                                        {
                                            dt = DataContext.ExecuteQuery_SQL($"SELECT SHIPPER_QR_CODE FROM mda_loading WHERE PLANT_ID = {plant_id} AND SHIPPER_QR_CODE IN ("
                                                + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ") X ");

                                            if (dt != null && dt.Rows.Count > 0)
                                            {
                                                error_QR.AddRange(dt.AsEnumerable().Select(row => row["SHIPPER_QR_CODE"].ToString()).ToList());
                                                break;
                                            }

                                            len += 500;
                                        }

                                        if (error_QR != null && error_QR.Count() > 0)
                                            error += "Delete operation not perform because Shipper QR Code(s) already loaded. Loaded Shipper QR Code(s) : "
                                                + string.Join(", ", error_QR);

                                        shipperData.ShipperQRCode_Data.RemoveAll(x => x.Action.ToLower().Contains("delete") && error_QR.Any(z => z == x.ShipperQRCode));

                                    }


                                    if (string.IsNullOrEmpty(error) && shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
                                    {
                                        var len = 0;

                                        while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
                                        {
                                            bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND (plant_id, shipper_qrcode_sysId) IN " +
                                                "(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' " +
                                                " AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

                                            IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                            IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND (plant_id, shipper_qrcode_sysId) IN " +
                                                "(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' " +
                                                " AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

                                            IsDelete = DataContext.ExecuteNonQuery("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                            len += 500;
                                        }

                                    }


                                    if (string.IsNullOrEmpty(error) && shipperData != null && shipperData.ShipperQRCode_Data != null
                                        && shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).Count() > 0)
                                    {
                                        shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).ToList();

                                        var listShipperQRCode = shipperData.ShipperQRCode_Data
                                                                .GroupBy(s => new { ShipperQRCode = s.ShipperQRCode, Action = s.Action, BottleQRCode_Len = s.BottleQRCode != null ? s.BottleQRCode.Count() : 0 })
                                                                .Select(x =>
                                                                {
                                                                    return new { ShipperQRCode = x.Key.ShipperQRCode, Action = x.Key.Action, Count = x.Count(), Length = x.Key.BottleQRCode_Len };
                                                                })
                                                                //.Where(g => g.Count > 1 || g.Length != 24)
                                                                .ToList();

                                        if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Count() > 0)
                                            //error += $"Duplicates Shipper QR Code found in file => {string.Join(", ", listShipperQRCode.Where(g => g.Count > 1).Select(x => x.ShipperQRCode + (x.Count > 1 ? " | Count : " + x.Count : "")).ToArray())}" + System.Environment.NewLine;
                                            listShipperQRCode_Duplicate.Add((string.Join(",", listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Select(x => x.ShipperQRCode).ToArray()), "DUP_FILE"));

                                        if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Count() > 0)
                                            //error += $"Bottles count is not 24 in Shipper QR Code => {string.Join(", ", listShipperQRCode.Where(g => g.Length != 24).Select(x => x.ShipperQRCode + (x.Length != 24 ? " | Bottles Count : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;
                                            listShipperQRCode_Duplicate.Add((string.Join(",", listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Select(x => x.ShipperQRCode).ToArray()), "NOT_24"));

                                        if (listShipperQRCode != null && listShipperQRCode.Count() > 0)
                                        {
                                            var len = 0;

                                            while (len <= listShipperQRCode.Count())
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("SELECT shipper_qrcode FROM SHIPPER_QRCODE " +
                                                    "WHERE LOWER(action) = 'add' AND shipper_qrcode IN (" + string.Join(", ", listShipperQRCode.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    //foreach (DataRow dr in dt.Rows)
                                                    //	error += $"Duplicates Shipper QR Code found in Database => " + (dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : "") + System.Environment.NewLine;
                                                    listShipperQRCode_Duplicate.Add((string.Join(",", dt.AsEnumerable().Select(row => row[0].ToString()).ToArray()), "DUP_DB"));

                                                len += 500;
                                            }
                                        }

                                        // Duplicate Bottle QR code Check Start

                                        var listBottleQRCode = shipperData.ShipperQRCode_Data.SelectMany(x => x.BottleQRCode)
                                                                        .GroupBy(qrCode => qrCode)
                                                                        .Select(qrCode =>
                                                                        {
                                                                            int startIndex = qrCode.Key.IndexOf(")", qrCode.Key.IndexOf(")", 0) + 1);

                                                                            if (startIndex >= 0) return new
                                                                            {
                                                                                BottleQRCode = qrCode.Key,
                                                                                Count = qrCode.Count(),
                                                                                Length = qrCode.Key.Substring(startIndex + 1, qrCode.Key.Length - startIndex - 1).Length
                                                                            };
                                                                            else return new { BottleQRCode = qrCode.Key, Count = qrCode.Count(), Length = 0 };
                                                                        })
                                                                        //.Where(qrCode => qrCode.Count > 1 || qrCode.Length != 14)
                                                                        .ToList();

                                        //if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Count > 1 || qrCode.Length < 12).Count() > 0)
                                        //	error += $"Duplicates Bottle QR Code found in file : {string.Join(", ", listBottleQRCode.Where(qrCode => qrCode.Count > 1 || qrCode.Length < 12).Select(x => x.BottleQRCode + (x.Count > 1 ? " Count : " + x.Count : "") + (x.Length > 0 ? " Length : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;

                                        if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Count > 1).Count() > 0)
                                            listBottleQRCode_Duplicate.Add((string.Join(",", listBottleQRCode.Where(qrCode => qrCode.Count > 1).Select(x => x.BottleQRCode).ToArray()), "DUP_FILE"));

                                        if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Length < 12).Count() > 0)
                                            listBottleQRCode_Duplicate.Add((string.Join(",", listBottleQRCode.Where(qrCode => qrCode.Length < 12).Select(x => x.BottleQRCode).ToArray()), "NOT_24"));


                                        if (listBottleQRCode != null && listBottleQRCode.Count() > 0)
                                        {
                                            var len = 0;

                                            while (len <= listBottleQRCode.Count())
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("SELECT bottle_qrcode FROM bottle_qrcode " +
                                                    "WHERE bottle_qrcode IN (" + string.Join(", ", listBottleQRCode.Skip(len).Take(300).Select(x => "'" + x.BottleQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    //foreach (DataRow dr in dt.Rows)
                                                    //	error += $"Duplicate Bottle QRCode in Database : " + (dr["bottle_qrcode"] != DBNull.Value ? Convert.ToString(dr["bottle_qrcode"]) : "") + System.Environment.NewLine;
                                                    listBottleQRCode_Duplicate.Add((string.Join(",", dt.AsEnumerable().Select(row => row[0].ToString()).ToArray()), "DUP_DB"));


                                                len += 300;
                                            }
                                        }

                                        // Duplicate Bottle QR code Check end

                                        //var listTargetBottleQRCode = shipperData.ShipperQRCode_Data
                                        //        .Where(shipment => shipment.BottleQRCode.Any(bottle => listBottleQRCode_Duplicate.Any(x => x.QRCode.Contains(bottle))))
                                        //        .SelectMany(shipment => shipment.BottleQRCode
                                        //            .Where(bottle => listBottleQRCode_Duplicate.Any(x => x.QRCode.Contains(bottle)))
                                        //            .Select(bottle => (QRCode: shipment.ShipperQRCode, Type: "BOT_ISSUE")))
                                        //        .ToList();

                                        foreach (var item in listBottleQRCode_Duplicate)
                                        {
                                            var listQRCode = new List<string>() { item.QRCode };

                                            if (item.QRCode.Contains(','))
                                                listQRCode = item.QRCode.Split(',').ToList();

                                            var listTargetBottleQRCode = shipperData.ShipperQRCode_Data
                                                .Where(shipment => shipment.BottleQRCode.Any(bottle => listQRCode.Any(x => x == bottle)))
                                                .Select(shipment => (QRCode: shipment.ShipperQRCode, Type: "BOT_ISSUE"))
                                                .ToList();

                                            listTargetBottleQRCode = listTargetBottleQRCode.Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(x.QRCode))).ToList();

                                            if (listTargetBottleQRCode != null && listTargetBottleQRCode.Count() > 0)
                                                listShipperQRCode_Duplicate.Add((string.Join(",", listTargetBottleQRCode.Select(x => x.QRCode).ToArray()), "BOT_ISSUE"));
                                        }



                                        if (string.IsNullOrEmpty(error))
                                        {
                                            shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(x.ShipperQRCode))).ToList();

                                            DataTable dtAvailable = new DataTable();
                                            DataTable dtShipperQrCode = new DataTable();
                                            DataTable dtBottleQrCode = new DataTable();

                                            if (string.IsNullOrEmpty(shipperData.PlantCd) || (shipperData.PlantCd.ToLower() == "none" || shipperData.PlantCd.ToLower() == "null"))
                                                shipperData.PlantCd = plantCode;

                                            var sqlQuery = "";
                                            bool IsSuccess = false;
                                            Int64 shipper_Api_Id = 0;

                                            dt = DataContext.ExecuteQuery_SQL($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

                                            if (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) > 0)
                                            {
                                                dt = DataContext.ExecuteQuery_SQL($"SELECT SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

                                                if (dt != null && dt.Rows.Count > 0)
                                                {
                                                    shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                    IsSuccess = true;
                                                }
                                            }
                                            else
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
                                                    $"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode_api') " +
                                                    ", TBL_T AS (SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 ID FROM shipper_qrcode_api) " +
                                                    "SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
                                                    "FROM TBL_AI X, TBL_T Z");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (   SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                                                ",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                                                ", MARKETEDBY, MANUFACTUREDBY, IS_SYNCED, IS_SYNCED_DATETIME) " +
                                                                "VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "' " +
                                                                ", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
                                                                ", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
                                                                ", NOW(), " + plant_id + ", 1, NOW(), " + shipperData.ShipperQRCode_Data.Count() + "" +
                                                                ",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "', 1, NOW());";

                                                IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery);

                                            }

                                            if (IsSuccess == true)
                                            {
                                                Int64 shipper_QrCode_Id = 0;
                                                Int64 shipper_QrCode_Id_Old = 0;

                                                dt = DataContext.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
                                                    $"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode') " +
                                                    ", TBL_T AS (SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 ID FROM SHIPPER_QRCODE) " +
                                                    "SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
                                                    "FROM TBL_AI X, TBL_T Z");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    shipper_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                dtShipperQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM SHIPPER_QRCODE LIMIT 0");

                                                for (int i = 0; i < shipperData.ShipperQRCode_Data.Count(); i++)
                                                {
                                                    shipper_QrCode_Id_Old = 0;

                                                    if (!string.IsNullOrEmpty(shipperData.ShipperQRCode_Data[i].OldShipperQRCode))
                                                    {
                                                        var dt_0 = DataContext.ExecuteQuery_SQL("SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = '" + shipperData.ShipperQRCode_Data[i].OldShipperQRCode + "' AND PLANT_ID = " + plant_id + " LIMIT 1");

                                                        if (dt_0 != null && dt_0.Rows.Count > 0)
                                                            shipper_QrCode_Id_Old = (dt_0.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt_0.Rows[0][0]) : 0);

                                                    }

                                                    DataRow newRow = dtShipperQrCode.NewRow();

                                                    shipperData.ShipperQRCode_Data[i].Id = shipper_QrCode_Id + i;

                                                    newRow[0] = shipperData.ShipperQRCode_Data[i].Id;
                                                    newRow[1] = shipperData.ShipperQRCode_Data[i].ShipperQRCode;
                                                    newRow[2] = shipperData.ShipperQRCode_Data[i].BottleQRCode.Count();
                                                    newRow[3] = "a";
                                                    newRow[4] = shipperData.ShipperQRCode_Data[i].Action;
                                                    newRow[5] = shipper_QrCode_Id_Old;
                                                    newRow[6] = shipper_Api_Id;
                                                    newRow[7] = 0;
                                                    newRow[8] = plant_id;
                                                    newRow[9] = user_id;
                                                    newRow[10] = currentDateTime.ToString();
                                                    newRow[11] = null;
                                                    newRow[12] = 0;
                                                    newRow[13] = 0;
                                                    newRow[14] = currentDateTime.ToString();
                                                    newRow[15] = currentDateTime.ToString();

                                                    dtShipperQrCode.Rows.Add(newRow);
                                                }


                                                Int64 bottle_QrCode_Id = 0;

                                                dt = DataContext.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
                                                    $"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'bottle_qrcode') " +
                                                    ", TBL_T AS (SELECT IFNULL(MAX(bottle_qrcode_sysId), 0) + 1 ID FROM bottle_qrcode) " +
                                                    "SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
                                                    "FROM TBL_AI X, TBL_T Z");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    bottle_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);


                                                dtBottleQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM BOTTLE_QRCODE LIMIT 0");

                                                for (int x = 0; x < shipperData.ShipperQRCode_Data.Count(); x++)
                                                {
                                                    long productId = 0;

                                                    for (int i = 0; i < shipperData.ShipperQRCode_Data[x].BottleQRCode.Count(); i++)
                                                    {
                                                        if (productId == 0)
                                                            productId = listProduct.Where(y => shipperData.ShipperQRCode_Data[x].BottleQRCode[i].Contains(y.GTIN)).Select(y => y.Id).FirstOrDefault();

                                                        DataRow newRow = dtBottleQrCode.NewRow();

                                                        newRow[0] = bottle_QrCode_Id;
                                                        newRow[1] = shipperData.ShipperQRCode_Data[x].BottleQRCode[i];
                                                        newRow[2] = productId;
                                                        newRow[3] = "a";
                                                        newRow[4] = shipperData.ShipperQRCode_Data[x].Id;
                                                        newRow[5] = plant_id;
                                                        newRow[6] = user_id;
                                                        newRow[7] = currentDateTime.ToString();
                                                        newRow[8] = 0;
                                                        newRow[9] = "t";
                                                        newRow[10] = "t";
                                                        newRow[11] = 0;

                                                        dtBottleQrCode.Rows.Add(newRow);

                                                        bottle_QrCode_Id = bottle_QrCode_Id + 1;
                                                    }

                                                }


                                                // Insert Shipper QR Code in SQL Database

                                                if (dtShipperQrCode != null && dtShipperQrCode.Rows.Count > 0)
                                                {
                                                    dtAvailable = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}");

                                                    int startIndex = 0;

                                                    while (startIndex < dtShipperQrCode.Rows.Count)
                                                    {
                                                        // Select the next 1000 rows using LINQ
                                                        DataTable nextBatch = dtShipperQrCode.AsEnumerable()
                                                            .Skip(startIndex)
                                                            .Take(1000)
                                                            .CopyToDataTable();

                                                        var table_RowsInSqlNotInOracle = dtShipperQrCode.Clone();

                                                        var rowsInSqlNotInOracle = from row2 in nextBatch.AsEnumerable()
                                                                                   join row1 in dtAvailable.AsEnumerable()
                                                                                   on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE") }
                                                                                   equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE") }
                                                                                   into gj
                                                                                   from subRow in gj.DefaultIfEmpty()
                                                                                   where subRow == null
                                                                                   select row2;

                                                        foreach (var row in rowsInSqlNotInOracle)
                                                            table_RowsInSqlNotInOracle.ImportRow(row);

                                                        if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                                                        {
                                                            sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME, IS_SYNCED, IS_SYNCED_DATETIME) ";

                                                            var sqlQuery_Select = "";

                                                            foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
                                                            {
                                                                if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
                                                                {
                                                                    sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                        $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
                                                                        $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
                                                                        $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                        $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
                                                                        $", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
                                                                        $", {plant_id} PLANT_ID" +
                                                                        $", {user_id} CREATED_BY" +
                                                                        $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME" +
                                                                        $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') EVENTTIME" +
                                                                        $", 1, NOW() " +
                                                                        $" FROM DUAL UNION ";
                                                                }
                                                            }

                                                            if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                            sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";// +
                                                                                                                           //"WHERE (X.PLANT_ID, X.SHIPPER_QRCODE) NOT IN " +
                                                                                                                           //"(SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                                                                           //	$"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})";

                                                            IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery + sqlQuery_Select);
                                                        }

                                                        startIndex += 1000;
                                                    }

                                                }


                                                // Insert Shipper QR Code in SQL Database

                                                if (dtBottleQrCode != null && dtBottleQrCode.Rows.Count > 0)
                                                {
                                                    dtAvailable = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                                $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                                $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                                $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})");

                                                    const int chunkSize = 5000;
                                                    const int subChunkSize = 1000; // Size of smaller tasks within each chunk

                                                    // Calculate the number of large chunks
                                                    int numberOfChunks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);
                                                    var chunkTasks = new List<Task>();

                                                    for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++)
                                                    {
                                                        int chunkStartIndex = chunkIndex * chunkSize;
                                                        DataTable chunkDataTable = dtBottleQrCode.AsEnumerable()
                                                            .Skip(chunkStartIndex)
                                                            .Take(chunkSize)
                                                            .CopyToDataTable();

                                                        var subChunkTasks = new List<Task>();

                                                        int numberOfSubChunks = (int)Math.Ceiling((double)chunkDataTable.Rows.Count / subChunkSize);

                                                        for (int subChunkIndex = 0; subChunkIndex < numberOfSubChunks; subChunkIndex++)
                                                        {
                                                            int subChunkStartIndex = subChunkIndex * subChunkSize;

                                                            DataTable subChunk = chunkDataTable.AsEnumerable()
                                                                .Skip(subChunkStartIndex)
                                                                .Take(subChunkSize)
                                                                .CopyToDataTable();

                                                            var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

                                                            var rowsInSqlNotInOracle = from row2 in subChunk.AsEnumerable()
                                                                                       join row1 in dtAvailable.AsEnumerable()
                                                                                       on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                                                                       equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                                                                       into gj
                                                                                       from subRow in gj.DefaultIfEmpty()
                                                                                       where subRow == null
                                                                                       select row2;

                                                            foreach (var row in rowsInSqlNotInOracle)
                                                                table_RowsInSqlNotInOracle.ImportRow(row);

                                                            var task = Task.Run(() =>
                                                            {
                                                                if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                                                                {
                                                                    var sqlQuery_Insert = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, IS_SYNCED, IS_SYNCED_DATETIME) ";

                                                                    var sqlQuery_Select = "";

                                                                    foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
                                                                    {
                                                                        if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
                                                                        {
                                                                            sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
                                                                                $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
                                                                                $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
                                                                                $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                                $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                                $", {plant_id} PLANT_ID" +
                                                                                $", {user_id} CREATED_BY" +
                                                                                $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME " +
                                                                                $", 1, NOW() " +
                                                                                $" FROM DUAL UNION ";
                                                                        }
                                                                    }

                                                                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                                    sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X "; //+
                                                                                                                                    //"WHERE (X.PLANT_ID, X.BOTTLE_QRCODE) NOT IN " +
                                                                                                                                    //"(SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                                                                                                    //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                                                                                                    //    $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                                                                                                    //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}))";

                                                                    IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery_Insert + sqlQuery_Select);
                                                                }
                                                            });

                                                            subChunkTasks.Add(task);
                                                        }

                                                        var chunkTask = Task.WhenAll(subChunkTasks);
                                                        chunkTasks.Add(chunkTask);
                                                    }

                                                    // Wait for all chunk tasks to complete
                                                    Task.WhenAll(chunkTasks).Wait();
                                                }

                                            }

                                            if (IsSuccess == true)
                                            {
                                                try { user_id = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch_CreatedBy_Demo").Value) ? 0 : user_id; }
                                                catch { }

                                                dt = DataContext.ExecuteQuery($"SELECT SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{shipperData.Batch_no}'");

                                                if (dt == null || dt.Rows.Count == 0 || (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) != shipper_Api_Id))
                                                {
                                                    sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                                            ",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                                            ", MARKETEDBY, MANUFACTUREDBY) " +
                                                            "VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "'" +
                                                            ", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
                                                            ", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
                                                            ", SYSDATE, " + plant_id + ", " + user_id + ", SYSDATE, " + shipperData.ShipperQRCode_Data.Count() + "" +
                                                            ",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' )";

                                                    IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);
                                                }


                                                dtAvailable = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}");

                                                int startIndex = 0;

                                                while (startIndex < dtShipperQrCode.Rows.Count)
                                                {
                                                    // Select the next 1000 rows using LINQ
                                                    DataTable nextBatch = dtShipperQrCode.AsEnumerable()
                                                        .Skip(startIndex)
                                                        .Take(1000)
                                                        .CopyToDataTable();

                                                    var table_RowsInSqlNotInOracle_Shipper = dtShipperQrCode.Clone();

                                                    var rowsInSqlNotInOracle_Shipper = from row2 in nextBatch.AsEnumerable()
                                                                                       join row1 in dtAvailable.AsEnumerable()
                                                                                       on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE") }
                                                                                       equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE") }
                                                                                       into gj
                                                                                       from subRow in gj.DefaultIfEmpty()
                                                                                       where subRow == null
                                                                                       select row2;

                                                    foreach (var row in rowsInSqlNotInOracle_Shipper)
                                                        table_RowsInSqlNotInOracle_Shipper.ImportRow(row);

                                                    if (table_RowsInSqlNotInOracle_Shipper != null && table_RowsInSqlNotInOracle_Shipper.Rows.Count > 0)
                                                    {
                                                        sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

                                                        var sqlQuery_Select = "";

                                                        foreach (DataRow dr in table_RowsInSqlNotInOracle_Shipper.Rows)
                                                        {
                                                            if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
                                                            {
                                                                sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                    $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
                                                                    $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
                                                                    $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                    $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
                                                                    $", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
                                                                    $", {plant_id} PLANT_ID" +
                                                                    $", {user_id} CREATED_BY" +
                                                                    $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME" +
                                                                    $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') EVENTTIME " +
                                                                    $" FROM DUAL UNION ";
                                                            }
                                                        }

                                                        if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                            sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                        sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X "; //+
                                                                                                                        //"WHERE (X.PLANT_ID, X.SHIPPER_QRCODE) NOT IN " +
                                                                                                                        //"(SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                                                                        //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})";

                                                        IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);
                                                    }

                                                    startIndex += 1000;

                                                }

                                                dtAvailable = DataContext.ExecuteQuery("SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                            $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                            $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                            $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})");


                                                const int chunkSize = 5000;
                                                const int subChunkSize = 1000; // Size of smaller tasks within each chunk

                                                // Calculate the number of large chunks
                                                int numberOfChunks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);
                                                var chunkTasks = new List<Task>();

                                                for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++)
                                                {
                                                    int chunkStartIndex = chunkIndex * chunkSize;
                                                    DataTable chunkDataTable = dtBottleQrCode.AsEnumerable()
                                                        .Skip(chunkStartIndex)
                                                        .Take(chunkSize)
                                                        .CopyToDataTable();

                                                    var subChunkTasks = new List<Task>();

                                                    int numberOfSubChunks = (int)Math.Ceiling((double)chunkDataTable.Rows.Count / subChunkSize);

                                                    for (int subChunkIndex = 0; subChunkIndex < numberOfSubChunks; subChunkIndex++)
                                                    {
                                                        int subChunkStartIndex = subChunkIndex * subChunkSize;

                                                        DataTable subChunk = chunkDataTable.AsEnumerable()
                                                            .Skip(subChunkStartIndex)
                                                            .Take(subChunkSize)
                                                            .CopyToDataTable();

                                                        var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

                                                        var rowsInSqlNotInOracle = from row2 in subChunk.AsEnumerable()
                                                                                   join row1 in dtAvailable.AsEnumerable()
                                                                                   on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                                                                   equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                                                                   into gj
                                                                                   from subRow in gj.DefaultIfEmpty()
                                                                                   where subRow == null
                                                                                   select row2;

                                                        foreach (var row in rowsInSqlNotInOracle)
                                                            table_RowsInSqlNotInOracle.ImportRow(row);

                                                        var task = Task.Run(() =>
                                                        {
                                                            if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                                                            {
                                                                var sqlQuery_Insert = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

                                                                var sqlQuery_Select = "";

                                                                foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
                                                                {
                                                                    if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
                                                                    {
                                                                        sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
                                                                            $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
                                                                            $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
                                                                            $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                            $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                            $", {plant_id} PLANT_ID" +
                                                                            $", {user_id} CREATED_BY" +
                                                                            $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME " +
                                                                            $" FROM DUAL UNION ";
                                                                    }
                                                                }

                                                                if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                    sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                                sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X "; //+
                                                                                                                                //"WHERE (X.PLANT_ID, X.BOTTLE_QRCODE) NOT IN " +
                                                                                                                                //"(SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                                                                                                //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                                                                                                //    $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                                                                                                //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}))";

                                                                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery_Insert + sqlQuery_Select);
                                                            }
                                                        });

                                                        subChunkTasks.Add(task);
                                                    }

                                                    var chunkTask = Task.WhenAll(subChunkTasks);
                                                    chunkTasks.Add(chunkTask);
                                                }

                                                // Wait for all chunk tasks to complete
                                                Task.WhenAll(chunkTasks).Wait();

                                            }


                                            if (shipperData != null && !string.IsNullOrEmpty(shipperData.Batch_no))
                                            {
                                                sqlQuery = "UPDATE SHIPPER_QRCODE_API API JOIN ( SELECT SHIPPER_QRCODE_API_SYSID, IFNULL(COUNT(*), 0) AS CNT " +
                                                    $"FROM SHIPPER_QRCODE WHERE (PLANT_ID, SHIPPER_QRCODE_API_SYSID) " +
                                                    $"IN ( SELECT DISTINCT PLANT_ID, SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API " +
                                                    $"WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{shipperData.Batch_no}' ) " +
                                                    "GROUP BY SHIPPER_QRCODE_API_SYSID) QC ON API.SHIPPER_QRCODE_API_SYSID = QC.SHIPPER_QRCODE_API_SYSID " +
                                                    "SET API.total_shipper_qty = IFNULL(QC.CNT, 0) " +
                                                    $"WHERE API.PLANT_ID = {plant_id} AND API.BATCH_NO = '{shipperData.Batch_no}' ";

                                                IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery);

                                                sqlQuery = "UPDATE SHIPPER_QRCODE_API API SET API.TOTAL_SHIPPER_QTY = ( SELECT NVL(COUNT(*), 0) " +
                                                    "FROM SHIPPER_QRCODE QC WHERE (QC.PLANT_ID, QC.SHIPPER_QRCODE_API_SYSID) " +
                                                    "IN ( SELECT DISTINCT SQA.PLANT_ID, SQA.SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API SQA " +
                                                    $"WHERE SQA.PLANT_ID = {plant_id} AND SQA.BATCH_NO = '{shipperData.Batch_no}' ) " +
                                                    "AND QC.SHIPPER_QRCODE_API_SYSID = API.SHIPPER_QRCODE_API_SYSID) " +
                                                    $"WHERE API.PLANT_ID = {plant_id} AND API.BATCH_NO = '{shipperData.Batch_no}' ";

                                                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);

                                            }
                                        }
                                    }
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            error = (string.IsNullOrEmpty(error) ? "Data not Convert Json to List." : error);

                            //bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                            //	"AND shipper_qrcode_sysId IN (SELECT shipper_qrcode_sysId FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'))");

                            //IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "')");

                            //IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'");

                            //IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                            //	"AND shipper_qrcode_sysId IN (SELECT shipper_qrcode_sysId FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'))");

                            //IsDelete = DataContext.ExecuteNonQuery("DELETE FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "')");

                            //IsDelete = DataContext.ExecuteNonQuery("DELETE FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'");

                        }


                        (string fileName, string fileUploadStatus) = (Path.GetFileName(sourceFilePath), "Completed");

                        if (listShipperQRCode_Duplicate != null && listShipperQRCode_Duplicate.Count > 0)
                        {
                            if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
                            {
                                string fileContent_Str = Convert.ToString(fileContent);

                                fileContent_Str = Regex.Replace(fileContent_Str, @"//.*?$", string.Empty, RegexOptions.Multiline);

                                fileContent_Str = Regex.Replace(fileContent_Str, @"/\*.*?\*/", string.Empty, RegexOptions.Singleline);

                                JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

                                var filteredShipperData = obj.ToObject<JObject>();

                                var shipperQRCodeData_Success = filteredShipperData["ShipperQRCode_Data"]
                                                        .Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(Convert.ToString(x["ShipperQRCode"])))).ToList<JToken>();

                                var shipperQRCodeData_Duplicate = filteredShipperData["ShipperQRCode_Data"]
                                                        .Where(x => listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(Convert.ToString(x["ShipperQRCode"])))).ToList<JToken>();

                                //shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());

                                //var shipperData_Error = new ShipperData()
                                //{
                                //    ServiceID = shipperData.ServiceID,
                                //    Token = shipperData.Token,
                                //    PlantCd = shipperData.PlantCd,
                                //    Batch_no = shipperData.Batch_no,
                                //    Mfg_Date = shipperData.Mfg_Date,
                                //    Expiry_Date = shipperData.Expiry_Date,
                                //    ManufacturedBy = shipperData.ManufacturedBy,
                                //    MarketedBy = shipperData.MarketedBy,
                                //    ShipperQRCode_Data = new List<ShipperEvent>()
                                //};

                                //shipperData_Error.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(x.ShipperQRCode))).ToList();

                                //shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => !listShipperQRCode_Duplicate.Any(z => z.QRCode.Contains(x.ShipperQRCode))).ToList();

                                try
                                {
                                    string errorFilePath = Path.Combine(errorFolderPath, Path.GetFileName(sourceFilePath));
                                    string destinationFilePath = Path.Combine(destinationFolderPath, fileName);

                                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                    string fileExtension = Path.GetExtension(sourceFilePath);
                                    int counter = 1;

                                    while (System.IO.File.Exists(destinationFilePath))
                                    {
                                        string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                        destinationFilePath = Path.Combine(destinationFolderPath, newFileName);
                                        counter++;
                                    }

                                    System.IO.File.Copy(sourceFilePath, destinationFilePath);
                                    System.IO.File.Delete(sourceFilePath);


                                    fileNameWithoutExtension = Path.GetFileNameWithoutExtension(destinationFilePath);
                                    fileExtension = Path.GetExtension(destinationFilePath);

                                    destinationFilePath = Path.Combine(destinationFolderPath, $"{fileNameWithoutExtension}_Success{fileExtension}");
                                    errorFilePath = Path.Combine(errorFolderPath, $"{fileNameWithoutExtension}_Error{fileExtension}");

                                    if (shipperQRCodeData_Success != null && shipperQRCodeData_Success.Count() > 0)
                                        Task.Run(() =>
                                        {
                                            try
                                            {
                                                filteredShipperData["ShipperQRCode_Data"] = JArray.FromObject(shipperQRCodeData_Success);

                                                string updatedJson = filteredShipperData.ToString(Formatting.Indented);/*JsonConvert.SerializeObject(shipperData, Formatting.Indented);*/

                                                System.IO.File.WriteAllText(destinationFilePath, updatedJson);

                                                Write_Log(fileName + " => " + destinationFilePath, logFilePath);
                                            }
                                            catch { }
                                        });

                                    if (shipperQRCodeData_Duplicate != null && shipperQRCodeData_Duplicate.Count() > 0)
                                        Task.Run(() =>
                                        {
                                            try
                                            {
                                                filteredShipperData["ShipperQRCode_Data"] = JArray.FromObject(shipperQRCodeData_Duplicate);

                                                string updatedJson = filteredShipperData.ToString(Formatting.Indented); /*JsonConvert.SerializeObject(shipperData_Error, Formatting.Indented);*/
                                                System.IO.File.WriteAllText(errorFilePath, updatedJson);

                                                Write_Log(fileName + " => " + errorFilePath, logFilePath);
                                            }
                                            catch { }
                                        });
                                }
                                catch (Exception ex) { }
                            }
                        }


                        if (string.IsNullOrEmpty(error))
                        {
                            if (!System.IO.Directory.Exists(destinationFolderPath))
                                System.IO.Directory.CreateDirectory(destinationFolderPath);

                            string destinationFilePath = Path.Combine(destinationFolderPath, fileName);

                            // Check if the destination file already exists
                            int counter = 1;
                            while (System.IO.File.Exists(destinationFilePath))
                            {
                                // If the file exists, append a number to the file name
                                string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                string fileExtension = Path.GetExtension(sourceFilePath);
                                string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                destinationFilePath = Path.Combine(destinationFolderPath, newFileName);
                                counter++;
                            }
                            // Copy the file to the destination folder
                            System.IO.File.Copy(sourceFilePath, destinationFilePath);

                            // Delete the original file
                            System.IO.File.Delete(sourceFilePath);

                            Write_Log(fileName + " => " + destinationFilePath, logFilePath);
                        }
                        else
                        {
                            fileUploadStatus = "Error";

                            Write_Log(fileName + " => " + error, logFilePath);
                            errors.Add(fileName + " => " + error);

                            if (!System.IO.Directory.Exists(errorFolderPath))
                                System.IO.Directory.CreateDirectory(errorFolderPath);

                            string errorFilePath = Path.Combine(errorFolderPath, Path.GetFileName(sourceFilePath));

                            // Check if the error file already exists
                            int counter = 1;
                            while (System.IO.File.Exists(errorFilePath))
                            {
                                // If the file exists, append a number to the file name
                                string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                string fileExtension = Path.GetExtension(sourceFilePath);
                                string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                errorFilePath = Path.Combine(errorFolderPath, newFileName);
                                counter++;
                            }
                            // Copy the file to the error folder
                            System.IO.File.Copy(sourceFilePath, errorFilePath);

                            // Delete the original file
                            System.IO.File.Delete(sourceFilePath);

                            Write_Log(fileName + " => " + errorFilePath, logFilePath);

                        }


                        try
                        {
                            var query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, REMARK) " +
                                                $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
                                                $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
                                                $", STR_TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
                                                $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
                                                $", '{error}' );";

                            var result = DataContext.ExecuteNonQuery_SQL(query_File);

                            if (string.IsNullOrEmpty(error))
                            {
                                query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, PLANTCODE, REMARK) " +
                                   $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
                                   $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
                                   $", TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
                                   $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
                                   $", '{plantCode}', '{error}' )";

                                result = DataContext.ExecuteNonQuery(query_File);
                            }
                        }
                        catch { }

                        //if (errors != null && errors.Count() > 0)
                        //    Write_Log(errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

                        Write_Log(Environment.NewLine + $"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
                            $"Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}", logFilePath);

                    }
                }
                else
                {
                    errors.Add("No any file(s) to upload data");

                    Write_Log(Environment.NewLine + $"No any file(s) to upload data." + Environment.NewLine, logFilePath);

                }

                Write_Log(Environment.NewLine + $"File(s) Processing Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}" + Environment.NewLine, logFilePath);

                if (errors == null || errors.Count() == 0)
                {
                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = "Record updated successfully !..."; ;

                    return Json(CommonViewModel);
                }
                else
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    CommonViewModel.Message = "Some JSON file was not processed. Please check error log." +
                        "" + System.Environment.NewLine + (errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

                    return Json(CommonViewModel);
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.IsConfirm = true;
            CommonViewModel.IsSuccess = true;
            CommonViewModel.StatusCode = ResponseStatusCode.Success;
            CommonViewModel.Message = "Batch file(s) update soon.";

            return Json(CommonViewModel);
        }


        public IActionResult SyncBatch()
        {
            try
            {
                string logFilePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Log_File_Path").Value ?? "");

                string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Source_Folder_Path").Value ?? "");
                string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Destination_Folder_Path").Value ?? "");
                string errorFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Error_Folder_Path").Value ?? "");

                if (!System.IO.Directory.Exists(sourceFolderPath))
                    System.IO.Directory.CreateDirectory(sourceFolderPath);

                if (!System.IO.Directory.Exists(destinationFolderPath))
                    System.IO.Directory.CreateDirectory(destinationFolderPath);

                if (!System.IO.Directory.Exists(errorFolderPath))
                    System.IO.Directory.CreateDirectory(errorFolderPath);


                string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

                string[] sourceFilePaths = Directory.GetFiles(sourceFolderPath, "*.json", SearchOption.AllDirectories);
                string[] destinationFilePaths = Directory.GetFiles(destinationFolderPath, "*.json", SearchOption.AllDirectories);

                if (destinationFilePaths == null)
                    destinationFilePaths = new string[] { "" };

                var dt = new DataTable();

                List<string> errors = new List<string>();

                var user_id = Common.Get_Session_Int(SessionKey.USER_ID);

                var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

                plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;
                user_id = user_id <= 0 ? 1 : user_id;

                Write_Log($"File Processing Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}", logFilePath);

                if (sourceFilePaths != null && sourceFilePaths.Length > 0)
                {
                    List<(long Id, string GTIN, int ExpireInMonth)> listProduct = new List<(long Id, string GTIN, int ExpireInMonth)>();

                    dt = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PROD_SYS_ID, GTIN, VALIDITY_MONTH FROM PRODUCT_MASTER WHERE IFNULL(GTIN, '') != '' ");

                    if (dt != null && dt.Rows.Count > 0)
                        listProduct = (from DataRow dr in dt.Rows
                                       select (Id: (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)
                                       , GSTIN: (dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "")
                                       , ExpireInMonth: (dr["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["VALIDITY_MONTH"]) : 0))).ToList();

                    var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

                    foreach (var sourceFilePath in orderedFilePaths.Where(x => !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
                    {
                        if (!System.IO.File.Exists(sourceFilePath)) continue;

                        var currentDateTime = DateTime.Now;

                        Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
                            $"Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}" + Environment.NewLine, logFilePath);

                        var error = "";

                        var shipperData = new ShipperData();

                        StringBuilder fileContent = new StringBuilder();
                        using (StreamReader sr = new StreamReader(sourceFilePath)) { fileContent.Append(sr.ReadToEnd()); }

                        dt = new DataTable();

                        try
                        {
                            if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
                            {
                                JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

                                shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());
                            }

                            if (shipperData == null)
                                error += $"Invalid data.";

                            if (shipperData != null && string.IsNullOrEmpty(shipperData.Batch_no))
                                error += $"Batch No is not null." + System.Environment.NewLine;

                            //if (shipperData != null && string.IsNullOrEmpty(shipperData.ManufacturedBy))
                            //	error += $"Manufactured By is not null." + System.Environment.NewLine;

                            //if (shipperData != null && string.IsNullOrEmpty(shipperData.MarketedBy))
                            //	error += $"MarketedBy By is not null." + System.Environment.NewLine;

                            if (shipperData != null && (string.IsNullOrEmpty(shipperData.ManufacturedBy) || shipperData.ManufacturedBy.ToLower() == "none"))
                                shipperData.ManufacturedBy = "Indian Farmers Fertiliser Cooperative";

                            if (shipperData != null && (string.IsNullOrEmpty(shipperData.MarketedBy) || shipperData.MarketedBy.ToLower() == "none"))
                                shipperData.MarketedBy = "Indian Farmers Fertiliser Cooperative";

                            var Mfg_Date = DateTime.MinValue;
                            if (shipperData != null && (string.IsNullOrEmpty(shipperData.Mfg_Date) || !DateTime.TryParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Mfg_Date)))
                                error += $"Invalid Manufacture Date.";


                            int manufacture_Date_Before = -1;
                            int manufacture_Date_After = 1;

                            try { manufacture_Date_Before = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Manufacture_Date_Before").Value); } catch { }
                            try { manufacture_Date_After = Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Manufacture_Date_After").Value); } catch { }

                            if (Mfg_Date != DateTime.MinValue && (Mfg_Date.Date.Ticks < DateTime.Now.AddMonths(manufacture_Date_Before).AddDays(1).Date.Ticks || Mfg_Date.Date.Ticks > DateTime.Now.AddMonths(manufacture_Date_After).AddDays(-1).Date.Ticks))
                                error += $"Manufacturing date cannot be more than 1 month old and must not be greater than 1 month from current date." + System.Environment.NewLine;

                            int ExpireInMonth = listProduct != null && shipperData != null
                                && shipperData.ShipperQRCode_Data != null && shipperData.ShipperQRCode_Data.Count() > 0
                                && shipperData.ShipperQRCode_Data[0].BottleQRCode != null && shipperData.ShipperQRCode_Data[0].BottleQRCode.Count() > 0
                                && listProduct.Any(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)) ?
                                listProduct.Where(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)).Select(y => y.ExpireInMonth).FirstOrDefault() : 0;

                            if (ExpireInMonth == 0)
                                error += $"Product's Expire In Month not available.";
                            else
                            {
                                shipperData.Expiry_Date = Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("yyMMdd");

                                Write_Log($"Manufacture date : {Mfg_Date.ToString("ddMMyyyy")}  ExpiryDate : {Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("ddMMyyyy")}", logFilePath);
                            }

                            if (string.IsNullOrEmpty(error) && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
                            {
                                if (shipperData != null && (shipperData.ShipperQRCode_Data == null || shipperData.ShipperQRCode_Data.Count() == 0))
                                    error += $"Shipper QR Code Data missing." + System.Environment.NewLine;

                                if (string.IsNullOrEmpty(error))
                                {
                                    if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
                                    {
                                        var error_QR = new List<string>();

                                        var len = 0;

                                        while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
                                        {
                                            dt = DataContext.ExecuteQuery_SQL($"SELECT SHIPPER_QR_CODE FROM mda_loading WHERE PLANT_ID = {plant_id} AND SHIPPER_QR_CODE IN ("
                                                + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ") X ");

                                            if (dt != null && dt.Rows.Count > 0)
                                            {
                                                error_QR.AddRange(dt.AsEnumerable().Select(row => row["SHIPPER_QR_CODE"].ToString()).ToList());
                                                break;
                                            }

                                            len += 500;
                                        }

                                        if (error_QR != null && error_QR.Count() > 0)
                                            error += "Delete operation not perform because Shipper QR Code(s) already loaded. Loaded Shipper QR Code(s) : "
                                                + string.Join(", ", error_QR);

                                    }

                                    if (string.IsNullOrEmpty(error) && shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
                                    {
                                        var len = 0;

                                        while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
                                        {
                                            bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND (plant_id, shipper_qrcode_sysId) IN " +
                                                "(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' " +
                                                " AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

                                            IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                            IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND (plant_id, shipper_qrcode_sysId) IN " +
                                                "(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' " +
                                                " AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

                                            IsDelete = DataContext.ExecuteNonQuery("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
                                                "AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
                                                                                                .Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                            len += 500;
                                        }

                                    }


                                    if (string.IsNullOrEmpty(error) && shipperData != null && shipperData.ShipperQRCode_Data != null
                                        && shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).Count() > 0)
                                    {
                                        shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).ToList();

                                        var listShipperQRCode = shipperData.ShipperQRCode_Data
                                                                .GroupBy(s => new { ShipperQRCode = s.ShipperQRCode, Action = s.Action, BottleQRCode_Len = s.BottleQRCode != null ? s.BottleQRCode.Count() : 0 })
                                                                .Select(x =>
                                                                {
                                                                    return new { ShipperQRCode = x.Key.ShipperQRCode, Action = x.Key.Action, Count = x.Count(), Length = x.Key.BottleQRCode_Len };
                                                                })
                                                                //.Where(g => g.Count > 1 || g.Length != 24)
                                                                .ToList();

                                        if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Count() > 0)
                                            error += $"Duplicates Shipper QR Code found in file => {string.Join(", ", listShipperQRCode.Where(g => g.Count > 1).Select(x => x.ShipperQRCode + (x.Count > 1 ? " | Count : " + x.Count : "")).ToArray())}" + System.Environment.NewLine;

                                        if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Count() > 0)
                                            error += $"Bottles count is not 24 in Shipper QR Code => {string.Join(", ", listShipperQRCode.Where(g => g.Length != 24).Select(x => x.ShipperQRCode + (x.Length != 24 ? " | Bottles Count : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;

                                        if (listShipperQRCode != null && listShipperQRCode.Count() > 0)
                                        {
                                            var len = 0;

                                            while (len <= listShipperQRCode.Count())
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("SELECT shipper_qrcode FROM SHIPPER_QRCODE " +
                                                    "WHERE LOWER(action) = 'add' AND shipper_qrcode IN (" + string.Join(", ", listShipperQRCode.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    foreach (DataRow dr in dt.Rows)
                                                        error += $"Duplicates Shipper QR Code found in MySQL Database => " + (dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : "") + System.Environment.NewLine;

                                                dt = DataContext.ExecuteQuery("SELECT shipper_qrcode FROM SHIPPER_QRCODE " +
                                                    "WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' AND shipper_qrcode IN (" + string.Join(", ", listShipperQRCode.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    foreach (DataRow dr in dt.Rows)
                                                        error += $"Duplicates Shipper QR Code found in Oracle Database => " + (dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : "") + System.Environment.NewLine;

                                                len += 500;
                                            }
                                        }

                                        // Duplicate Bottle QR code Check Start

                                        var listBottleQRCode = shipperData.ShipperQRCode_Data.SelectMany(x => x.BottleQRCode)
                                                                        .GroupBy(qrCode => qrCode)
                                                                        .Select(qrCode =>
                                                                        {
                                                                            int startIndex = qrCode.Key.IndexOf(")", qrCode.Key.IndexOf(")", 0) + 1);

                                                                            if (startIndex >= 0) return new
                                                                            {
                                                                                BottleQRCode = qrCode.Key,
                                                                                Count = qrCode.Count(),
                                                                                Length = qrCode.Key.Substring(startIndex + 1, qrCode.Key.Length - startIndex - 1).Length
                                                                            };
                                                                            else return new { BottleQRCode = qrCode.Key, Count = qrCode.Count(), Length = 0 };
                                                                        })
                                                                        //.Where(qrCode => qrCode.Count > 1 || qrCode.Length != 14)
                                                                        .ToList();

                                        if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Count > 1 || qrCode.Length < 12).Count() > 0)
                                            error += $"Duplicates Bottle QR Code found in file : {string.Join(", ", listBottleQRCode.Where(qrCode => qrCode.Count > 1 || qrCode.Length < 12).Select(x => x.BottleQRCode + (x.Count > 1 ? " Count : " + x.Count : "") + (x.Length > 0 ? " Length : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;


                                        if (listBottleQRCode != null && listBottleQRCode.Count() > 0)
                                        {
                                            var len = 0;

                                            while (len <= listBottleQRCode.Count())
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("SELECT bottle_qrcode FROM bottle_qrcode " +
                                                    "WHERE bottle_qrcode IN (" + string.Join(", ", listBottleQRCode.Skip(len).Take(300).Select(x => "'" + x.BottleQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    foreach (DataRow dr in dt.Rows)
                                                        error += $"Duplicate Bottle QRCode in MySQL Database : " + (dr["bottle_qrcode"] != DBNull.Value ? Convert.ToString(dr["bottle_qrcode"]) : "") + System.Environment.NewLine;

                                                dt = DataContext.ExecuteQuery_SQL("SELECT bottle_qrcode FROM bottle_qrcode " +
                                                    "WHERE plant_id = " + plant_id + " AND bottle_qrcode IN (" + string.Join(", ", listBottleQRCode.Skip(len).Take(300).Select(x => "'" + x.BottleQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    foreach (DataRow dr in dt.Rows)
                                                        error += $"Duplicates Shipper QR Code found in Oracle Database => " + (dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : "") + System.Environment.NewLine;

                                                len += 300;
                                            }
                                        }

                                        // Duplicate Bottle QR code Check end

                                        if (string.IsNullOrEmpty(error))
                                        {
                                            DataTable dtAvailable = new DataTable();
                                            DataTable dtShipperQrCode = new DataTable();
                                            DataTable dtBottleQrCode = new DataTable();

                                            if (string.IsNullOrEmpty(shipperData.PlantCd) || (shipperData.PlantCd.ToLower() == "none" || shipperData.PlantCd.ToLower() == "null"))
                                                shipperData.PlantCd = plantCode;

                                            var sqlQuery = "";
                                            bool IsSuccess = false;
                                            Int64 shipper_Api_Id = 0;

                                            dt = DataContext.ExecuteQuery_SQL($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

                                            if (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) > 0)
                                            {
                                                dt = DataContext.ExecuteQuery_SQL($"SELECT SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

                                                if (dt != null && dt.Rows.Count > 0)
                                                {
                                                    shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                    IsSuccess = true;
                                                }
                                            }
                                            else
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
                                                    $"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode_api') " +
                                                    ", TBL_T AS (SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 ID FROM shipper_qrcode_api) " +
                                                    "SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
                                                    "FROM TBL_AI X, TBL_T Z");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (   SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                                                ",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                                                ", MARKETEDBY, MANUFACTUREDBY, IS_SYNCED, IS_SYNCED_DATETIME) " +
                                                                "VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "' " +
                                                                ", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
                                                                ", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
                                                                ", NOW(), " + plant_id + ", 1, NOW(), " + shipperData.ShipperQRCode_Data.Count() + "" +
                                                                ",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "', 1, NOW());";

                                                IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery);

                                            }

                                            if (IsSuccess == true)
                                            {
                                                Int64 shipper_QrCode_Id = 0;
                                                Int64 shipper_QrCode_Id_Old = 0;

                                                dt = DataContext.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
                                                    $"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode') " +
                                                    ", TBL_T AS (SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 ID FROM SHIPPER_QRCODE) " +
                                                    "SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
                                                    "FROM TBL_AI X, TBL_T Z");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    shipper_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                dtShipperQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM SHIPPER_QRCODE LIMIT 0");

                                                for (int i = 0; i < shipperData.ShipperQRCode_Data.Count(); i++)
                                                {
                                                    shipper_QrCode_Id_Old = 0;

                                                    if (!string.IsNullOrEmpty(shipperData.ShipperQRCode_Data[i].OldShipperQRCode))
                                                    {
                                                        var dt_0 = DataContext.ExecuteQuery_SQL("SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = '" + shipperData.ShipperQRCode_Data[i].OldShipperQRCode + "' AND PLANT_ID = " + plant_id + " LIMIT 1");

                                                        if (dt_0 != null && dt_0.Rows.Count > 0)
                                                            shipper_QrCode_Id_Old = (dt_0.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt_0.Rows[0][0]) : 0);

                                                    }

                                                    DataRow newRow = dtShipperQrCode.NewRow();

                                                    shipperData.ShipperQRCode_Data[i].Id = shipper_QrCode_Id + i;

                                                    newRow[0] = shipperData.ShipperQRCode_Data[i].Id;
                                                    newRow[1] = shipperData.ShipperQRCode_Data[i].ShipperQRCode;
                                                    newRow[2] = shipperData.ShipperQRCode_Data[i].BottleQRCode.Count();
                                                    newRow[3] = "a";
                                                    newRow[4] = shipperData.ShipperQRCode_Data[i].Action;
                                                    newRow[5] = shipper_QrCode_Id_Old;
                                                    newRow[6] = shipper_Api_Id;
                                                    newRow[7] = 0;
                                                    newRow[8] = plant_id;
                                                    newRow[9] = user_id;
                                                    newRow[10] = currentDateTime.ToString();
                                                    newRow[11] = null;
                                                    newRow[12] = 0;
                                                    newRow[13] = 0;
                                                    newRow[14] = currentDateTime.ToString();
                                                    newRow[15] = currentDateTime.ToString();

                                                    dtShipperQrCode.Rows.Add(newRow);
                                                }


                                                Int64 bottle_QrCode_Id = 0;

                                                dt = DataContext.ExecuteQuery_SQL("WITH TBL_AI AS (SELECT `AUTO_INCREMENT` ID FROM  INFORMATION_SCHEMA.TABLES " +
                                                    $"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'bottle_qrcode') " +
                                                    ", TBL_T AS (SELECT IFNULL(MAX(bottle_qrcode_sysId), 0) + 1 ID FROM bottle_qrcode) " +
                                                    "SELECT IF(X.ID > Z.ID, X.ID, Z.ID) ID " +
                                                    "FROM TBL_AI X, TBL_T Z");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    bottle_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);


                                                dtBottleQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM BOTTLE_QRCODE LIMIT 0");

                                                for (int x = 0; x < shipperData.ShipperQRCode_Data.Count(); x++)
                                                {
                                                    long productId = 0;

                                                    for (int i = 0; i < shipperData.ShipperQRCode_Data[x].BottleQRCode.Count(); i++)
                                                    {
                                                        if (productId == 0)
                                                            productId = listProduct.Where(y => shipperData.ShipperQRCode_Data[x].BottleQRCode[i].Contains(y.GTIN)).Select(y => y.Id).FirstOrDefault();

                                                        DataRow newRow = dtBottleQrCode.NewRow();

                                                        newRow[0] = bottle_QrCode_Id;
                                                        newRow[1] = shipperData.ShipperQRCode_Data[x].BottleQRCode[i];
                                                        newRow[2] = productId;
                                                        newRow[3] = "a";
                                                        newRow[4] = shipperData.ShipperQRCode_Data[x].Id;
                                                        newRow[5] = plant_id;
                                                        newRow[6] = user_id;
                                                        newRow[7] = currentDateTime.ToString();
                                                        newRow[8] = 0;
                                                        newRow[9] = "t";
                                                        newRow[10] = "t";
                                                        newRow[11] = 0;

                                                        dtBottleQrCode.Rows.Add(newRow);

                                                        bottle_QrCode_Id = bottle_QrCode_Id + 1;
                                                    }

                                                }


                                                // Insert Shipper QR Code in SQL Database

                                                if (dtShipperQrCode != null && dtShipperQrCode.Rows.Count > 0)
                                                {
                                                    dtAvailable = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}");

                                                    int startIndex = 0;

                                                    while (startIndex < dtShipperQrCode.Rows.Count)
                                                    {
                                                        // Select the next 1000 rows using LINQ
                                                        DataTable nextBatch = dtShipperQrCode.AsEnumerable()
                                                            .Skip(startIndex)
                                                            .Take(1000)
                                                            .CopyToDataTable();

                                                        var table_RowsInSqlNotInOracle = dtShipperQrCode.Clone();

                                                        var rowsInSqlNotInOracle = from row2 in nextBatch.AsEnumerable()
                                                                                   join row1 in dtAvailable.AsEnumerable()
                                                                                   on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE") }
                                                                                   equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE") }
                                                                                   into gj
                                                                                   from subRow in gj.DefaultIfEmpty()
                                                                                   where subRow == null
                                                                                   select row2;

                                                        foreach (var row in rowsInSqlNotInOracle)
                                                            table_RowsInSqlNotInOracle.ImportRow(row);

                                                        if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                                                        {
                                                            sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME, IS_SYNCED, IS_SYNCED_DATETIME) ";

                                                            var sqlQuery_Select = "";

                                                            foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
                                                            {
                                                                if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
                                                                {
                                                                    sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                        $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
                                                                        $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
                                                                        $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                        $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
                                                                        $", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
                                                                        $", {plant_id} PLANT_ID" +
                                                                        $", {user_id} CREATED_BY" +
                                                                        $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME" +
                                                                        $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') EVENTTIME" +
                                                                        $", 1, NOW() " +
                                                                        $" FROM DUAL UNION ";
                                                                }
                                                            }

                                                            if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                            sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";// +
                                                                                                                           //"WHERE (X.PLANT_ID, X.SHIPPER_QRCODE) NOT IN " +
                                                                                                                           //"(SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                                                                           //	$"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})";

                                                            IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery + sqlQuery_Select);
                                                        }

                                                        startIndex += 1000;
                                                    }

                                                }


                                                // Insert Shipper QR Code in SQL Database

                                                if (dtBottleQrCode != null && dtBottleQrCode.Rows.Count > 0)
                                                {
                                                    dtAvailable = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                                $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                                $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                                $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})");

                                                    const int chunkSize = 5000;
                                                    const int subChunkSize = 1000; // Size of smaller tasks within each chunk

                                                    // Calculate the number of large chunks
                                                    int numberOfChunks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);
                                                    var chunkTasks = new List<Task>();

                                                    for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++)
                                                    {
                                                        int chunkStartIndex = chunkIndex * chunkSize;
                                                        DataTable chunkDataTable = dtBottleQrCode.AsEnumerable()
                                                            .Skip(chunkStartIndex)
                                                            .Take(chunkSize)
                                                            .CopyToDataTable();

                                                        var subChunkTasks = new List<Task>();

                                                        int numberOfSubChunks = (int)Math.Ceiling((double)chunkDataTable.Rows.Count / subChunkSize);

                                                        for (int subChunkIndex = 0; subChunkIndex < numberOfSubChunks; subChunkIndex++)
                                                        {
                                                            int subChunkStartIndex = subChunkIndex * subChunkSize;

                                                            DataTable subChunk = chunkDataTable.AsEnumerable()
                                                                .Skip(subChunkStartIndex)
                                                                .Take(subChunkSize)
                                                                .CopyToDataTable();

                                                            var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

                                                            var rowsInSqlNotInOracle = from row2 in subChunk.AsEnumerable()
                                                                                       join row1 in dtAvailable.AsEnumerable()
                                                                                       on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                                                                       equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                                                                       into gj
                                                                                       from subRow in gj.DefaultIfEmpty()
                                                                                       where subRow == null
                                                                                       select row2;

                                                            foreach (var row in rowsInSqlNotInOracle)
                                                                table_RowsInSqlNotInOracle.ImportRow(row);

                                                            var task = Task.Run(() =>
                                                            {
                                                                if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                                                                {
                                                                    var sqlQuery_Insert = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, IS_SYNCED, IS_SYNCED_DATETIME) ";

                                                                    var sqlQuery_Select = "";

                                                                    foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
                                                                    {
                                                                        if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
                                                                        {
                                                                            sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
                                                                                $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
                                                                                $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
                                                                                $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                                $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                                $", {plant_id} PLANT_ID" +
                                                                                $", {user_id} CREATED_BY" +
                                                                                $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME " +
                                                                                $", 1, NOW() " +
                                                                                $" FROM DUAL UNION ";
                                                                        }
                                                                    }

                                                                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                                    sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X "; //+
                                                                                                                                    //"WHERE (X.PLANT_ID, X.BOTTLE_QRCODE) NOT IN " +
                                                                                                                                    //"(SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                                                                                                    //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                                                                                                    //    $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                                                                                                    //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}))";

                                                                    IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery_Insert + sqlQuery_Select);
                                                                }
                                                            });

                                                            subChunkTasks.Add(task);
                                                        }

                                                        var chunkTask = Task.WhenAll(subChunkTasks);
                                                        chunkTasks.Add(chunkTask);
                                                    }

                                                    // Wait for all chunk tasks to complete
                                                    Task.WhenAll(chunkTasks).Wait();
                                                }

                                            }

                                            if (IsSuccess == true)
                                            {
                                                try { user_id = Convert.ToBoolean(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch_CreatedBy_Demo").Value) ? 0 : user_id; }
                                                catch { }

                                                dt = DataContext.ExecuteQuery($"SELECT SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{shipperData.Batch_no}'");

                                                if (dt == null || dt.Rows.Count == 0 || (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) != shipper_Api_Id))
                                                {
                                                    sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                                            ",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                                            ", MARKETEDBY, MANUFACTUREDBY) " +
                                                            "VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "'" +
                                                            ", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
                                                            ", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
                                                            ", SYSDATE, " + plant_id + ", " + user_id + ", SYSDATE, " + shipperData.ShipperQRCode_Data.Count() + "" +
                                                            ",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' )";

                                                    IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);
                                                }


                                                dtAvailable = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}");

                                                int startIndex = 0;

                                                while (startIndex < dtShipperQrCode.Rows.Count)
                                                {
                                                    // Select the next 1000 rows using LINQ
                                                    DataTable nextBatch = dtShipperQrCode.AsEnumerable()
                                                        .Skip(startIndex)
                                                        .Take(1000)
                                                        .CopyToDataTable();

                                                    var table_RowsInSqlNotInOracle_Shipper = dtShipperQrCode.Clone();

                                                    var rowsInSqlNotInOracle_Shipper = from row2 in nextBatch.AsEnumerable()
                                                                                       join row1 in dtAvailable.AsEnumerable()
                                                                                       on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE") }
                                                                                       equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE") }
                                                                                       into gj
                                                                                       from subRow in gj.DefaultIfEmpty()
                                                                                       where subRow == null
                                                                                       select row2;

                                                    foreach (var row in rowsInSqlNotInOracle_Shipper)
                                                        table_RowsInSqlNotInOracle_Shipper.ImportRow(row);

                                                    if (table_RowsInSqlNotInOracle_Shipper != null && table_RowsInSqlNotInOracle_Shipper.Rows.Count > 0)
                                                    {
                                                        sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

                                                        var sqlQuery_Select = "";

                                                        foreach (DataRow dr in table_RowsInSqlNotInOracle_Shipper.Rows)
                                                        {
                                                            if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
                                                            {
                                                                sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                    $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
                                                                    $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
                                                                    $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                    $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
                                                                    $", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
                                                                    $", {plant_id} PLANT_ID" +
                                                                    $", {user_id} CREATED_BY" +
                                                                    $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME" +
                                                                    $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') EVENTTIME " +
                                                                    $" FROM DUAL UNION ";
                                                            }
                                                        }

                                                        if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                            sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                        sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X "; //+
                                                                                                                        //"WHERE (X.PLANT_ID, X.SHIPPER_QRCODE) NOT IN " +
                                                                                                                        //"(SELECT PLANT_ID, SHIPPER_QRCODE FROM SHIPPER_QRCODE " +
                                                                                                                        //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})";

                                                        IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);
                                                    }

                                                    startIndex += 1000;

                                                }

                                                dtAvailable = DataContext.ExecuteQuery("SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                            $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                            $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                            $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id})");


                                                const int chunkSize = 5000;
                                                const int subChunkSize = 1000; // Size of smaller tasks within each chunk

                                                // Calculate the number of large chunks
                                                int numberOfChunks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);
                                                var chunkTasks = new List<Task>();

                                                for (int chunkIndex = 0; chunkIndex < numberOfChunks; chunkIndex++)
                                                {
                                                    int chunkStartIndex = chunkIndex * chunkSize;
                                                    DataTable chunkDataTable = dtBottleQrCode.AsEnumerable()
                                                        .Skip(chunkStartIndex)
                                                        .Take(chunkSize)
                                                        .CopyToDataTable();

                                                    var subChunkTasks = new List<Task>();

                                                    int numberOfSubChunks = (int)Math.Ceiling((double)chunkDataTable.Rows.Count / subChunkSize);

                                                    for (int subChunkIndex = 0; subChunkIndex < numberOfSubChunks; subChunkIndex++)
                                                    {
                                                        int subChunkStartIndex = subChunkIndex * subChunkSize;

                                                        DataTable subChunk = chunkDataTable.AsEnumerable()
                                                            .Skip(subChunkStartIndex)
                                                            .Take(subChunkSize)
                                                            .CopyToDataTable();

                                                        var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

                                                        var rowsInSqlNotInOracle = from row2 in subChunk.AsEnumerable()
                                                                                   join row1 in dtAvailable.AsEnumerable()
                                                                                   on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                                                                   equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                                                                   into gj
                                                                                   from subRow in gj.DefaultIfEmpty()
                                                                                   where subRow == null
                                                                                   select row2;

                                                        foreach (var row in rowsInSqlNotInOracle)
                                                            table_RowsInSqlNotInOracle.ImportRow(row);

                                                        var task = Task.Run(() =>
                                                        {
                                                            if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                                                            {
                                                                var sqlQuery_Insert = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

                                                                var sqlQuery_Select = "";

                                                                foreach (DataRow dr in table_RowsInSqlNotInOracle.Rows)
                                                                {
                                                                    if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
                                                                    {
                                                                        sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
                                                                            $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
                                                                            $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
                                                                            $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                            $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                            $", {plant_id} PLANT_ID" +
                                                                            $", {user_id} CREATED_BY" +
                                                                            $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME " +
                                                                            $" FROM DUAL UNION ";
                                                                    }
                                                                }

                                                                if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                    sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                                sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X "; //+
                                                                                                                                //"WHERE (X.PLANT_ID, X.BOTTLE_QRCODE) NOT IN " +
                                                                                                                                //"(SELECT PLANT_ID, BOTTLE_QRCODE FROM BOTTLE_QRCODE " +
                                                                                                                                //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_SYSID " +
                                                                                                                                //    $"IN (SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE " +
                                                                                                                                //    $"WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_Api_Id}))";

                                                                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery_Insert + sqlQuery_Select);
                                                            }
                                                        });

                                                        subChunkTasks.Add(task);
                                                    }

                                                    var chunkTask = Task.WhenAll(subChunkTasks);
                                                    chunkTasks.Add(chunkTask);
                                                }

                                                // Wait for all chunk tasks to complete
                                                Task.WhenAll(chunkTasks).Wait();

                                            }


                                            if (shipperData != null && !string.IsNullOrEmpty(shipperData.Batch_no))
                                            {
                                                sqlQuery = "UPDATE SHIPPER_QRCODE_API API JOIN ( SELECT SHIPPER_QRCODE_API_SYSID, IFNULL(COUNT(*), 0) AS CNT " +
                                                    $"FROM SHIPPER_QRCODE WHERE (PLANT_ID, SHIPPER_QRCODE_API_SYSID) " +
                                                    $"IN ( SELECT DISTINCT PLANT_ID, SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API " +
                                                    $"WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{shipperData.Batch_no}' ) " +
                                                    "GROUP BY SHIPPER_QRCODE_API_SYSID) QC ON API.SHIPPER_QRCODE_API_SYSID = QC.SHIPPER_QRCODE_API_SYSID " +
                                                    "SET API.total_shipper_qty = IFNULL(QC.CNT, 0) " +
                                                    $"WHERE API.PLANT_ID = {plant_id} AND API.BATCH_NO = '{shipperData.Batch_no}' ";

                                                IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery);

                                                sqlQuery = "UPDATE SHIPPER_QRCODE_API API SET API.TOTAL_SHIPPER_QTY = ( SELECT NVL(COUNT(*), 0) " +
                                                    "FROM SHIPPER_QRCODE QC WHERE (QC.PLANT_ID, QC.SHIPPER_QRCODE_API_SYSID) " +
                                                    "IN ( SELECT DISTINCT SQA.PLANT_ID, SQA.SHIPPER_QRCODE_API_SYSID FROM SHIPPER_QRCODE_API SQA " +
                                                    $"WHERE SQA.PLANT_ID = {plant_id} AND SQA.BATCH_NO = '{shipperData.Batch_no}' ) " +
                                                    "AND QC.SHIPPER_QRCODE_API_SYSID = API.SHIPPER_QRCODE_API_SYSID) " +
                                                    $"WHERE API.PLANT_ID = {plant_id} AND API.BATCH_NO = '{shipperData.Batch_no}' ";

                                                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);

                                            }
                                        }
                                    }
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            error = (string.IsNullOrEmpty(error) ? "Data not Convert Json to List." : error);

                            //bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                            //	"AND shipper_qrcode_sysId IN (SELECT shipper_qrcode_sysId FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'))");

                            //IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "')");

                            //IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'");

                            //IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
                            //	"AND shipper_qrcode_sysId IN (SELECT shipper_qrcode_sysId FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'))");

                            //IsDelete = DataContext.ExecuteNonQuery("DELETE FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
                            //			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "')");

                            //IsDelete = DataContext.ExecuteNonQuery("DELETE FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'");

                        }

                        (string fileName, string fileUploadStatus) = (Path.GetFileName(sourceFilePath), "Completed");

                        if (string.IsNullOrEmpty(error))
                        {
                            if (!System.IO.Directory.Exists(destinationFolderPath))
                                System.IO.Directory.CreateDirectory(destinationFolderPath);

                            if (System.IO.File.Exists(sourceFilePath))
                            {
                                string destinationFilePath = Path.Combine(destinationFolderPath, fileName);

                                // Check if the destination file already exists
                                int counter = 1;
                                while (System.IO.File.Exists(destinationFilePath))
                                {
                                    // If the file exists, append a number to the file name
                                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                    string fileExtension = Path.GetExtension(sourceFilePath);
                                    string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                    destinationFilePath = Path.Combine(destinationFolderPath, newFileName);
                                    counter++;
                                }
                                // Copy the file to the destination folder
                                System.IO.File.Copy(sourceFilePath, destinationFilePath);

                                // Delete the original file
                                System.IO.File.Delete(sourceFilePath);
                            }
                        }
                        else
                        {
                            fileUploadStatus = "Error";

                            Write_Log(fileName + " => " + error, logFilePath);
                            errors.Add(fileName + " => " + error);

                            if (!System.IO.Directory.Exists(errorFolderPath))
                                System.IO.Directory.CreateDirectory(errorFolderPath);

                            if (System.IO.File.Exists(sourceFilePath))
                            {
                                string errorFilePath = Path.Combine(errorFolderPath, Path.GetFileName(sourceFilePath));

                                // Check if the error file already exists
                                int counter = 1;
                                while (System.IO.File.Exists(errorFilePath))
                                {
                                    // If the file exists, append a number to the file name
                                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                    string fileExtension = Path.GetExtension(sourceFilePath);
                                    string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                    errorFilePath = Path.Combine(errorFolderPath, newFileName);
                                    counter++;
                                }
                                // Copy the file to the error folder
                                System.IO.File.Copy(sourceFilePath, errorFilePath);

                                // Delete the original file
                                System.IO.File.Delete(sourceFilePath);
                            }
                        }


                        try
                        {
                            var query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, REMARK) " +
                                                $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
                                                $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
                                                $", STR_TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
                                                $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
                                                $", '{error}' );";

                            var result = DataContext.ExecuteNonQuery_SQL(query_File);

                            if (string.IsNullOrEmpty(error))
                            {
                                query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, PLANTCODE, REMARK) " +
                                   $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
                                   $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
                                   $", TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
                                   $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
                                   $", '{plantCode}', '{error}' )";

                                result = DataContext.ExecuteNonQuery(query_File);
                            }
                        }
                        catch { }

                        //if (errors != null && errors.Count() > 0)
                        //    Write_Log(errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

                        Write_Log(Environment.NewLine + $"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
                            $"Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}", logFilePath);

                    }
                }
                else
                {
                    errors.Add("No any file(s) to upload data");

                    Write_Log(Environment.NewLine + $"No any file(s) to upload data. | {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}" + Environment.NewLine, logFilePath);

                }

                Write_Log(Environment.NewLine + $"File Processing Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}" + Environment.NewLine, logFilePath);

                if (errors == null || errors.Count() == 0)
                {
                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = "Record updated successfully !..."; ;

                    return Json(CommonViewModel);
                }
                else
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    CommonViewModel.Message = "Some JSON file was not processed. Please check error log." +
                        "" + System.Environment.NewLine + (errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

                    return Json(CommonViewModel);
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.Error;
            CommonViewModel.Message = ResponseStatusMessage.Error;

            return Json(CommonViewModel);
        }



        //public IActionResult SyncBatch()
        //{
        //	try
        //	{
        //		string logFilePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Log_File_Path").Value ?? "");

        //		string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Source_Folder_Path").Value ?? "");
        //		string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Destination_Folder_Path").Value ?? "");
        //		string errorFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Error_Folder_Path").Value ?? "");

        //		if (!System.IO.Directory.Exists(sourceFolderPath))
        //			System.IO.Directory.CreateDirectory(sourceFolderPath);

        //		if (!System.IO.Directory.Exists(destinationFolderPath))
        //			System.IO.Directory.CreateDirectory(destinationFolderPath);

        //		if (!System.IO.Directory.Exists(errorFolderPath))
        //			System.IO.Directory.CreateDirectory(errorFolderPath);


        //		string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

        //		string[] sourceFilePaths =  Directory.GetFiles(sourceFolderPath, "*.json", SearchOption.AllDirectories);
        //		string[] destinationFilePaths = Directory.GetFiles(destinationFolderPath, "*.json", SearchOption.AllDirectories);

        //		if (destinationFilePaths == null)
        //			destinationFilePaths = new string[] { "" };

        //		var dt = new DataTable();

        //		List<string> errors = new List<string>();

        //		var user_id = Common.Get_Session_Int(SessionKey.USER_ID);

        //		var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

        //		plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;
        //		user_id = user_id <= 0 ? 1 : user_id;

        //		if (sourceFilePaths != null && sourceFilePaths.Length > 0)
        //		{
        //			List<(long Id, string GTIN, int ExpireInMonth)> listProduct = new List<(long Id, string GTIN, int ExpireInMonth)>();

        //			dt = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PROD_SYS_ID, GTIN, VALIDITY_MONTH FROM PRODUCT_MASTER WHERE IFNULL(GTIN, '') != '' ");

        //			if (dt != null && dt.Rows.Count > 0)
        //				listProduct = (from DataRow dr in dt.Rows
        //							   select (Id: (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)
        //							   , GSTIN: (dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "")
        //							   , ExpireInMonth: (dr["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["VALIDITY_MONTH"]) : 0))).ToList();

        //			var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

        //			foreach (var sourceFilePath in orderedFilePaths.Where(x => !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
        //			{
        //				var currentDateTime = DateTime.Now;

        //				Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
        //					$"Started at {DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt").Replace("/", "-")}", logFilePath);

        //				var error = "";

        //				var shipperData = new ShipperData();

        //				StringBuilder fileContent = new StringBuilder();
        //				using (StreamReader sr = new StreamReader(sourceFilePath)) { fileContent.Append(sr.ReadToEnd()); }

        //				dt = new DataTable();

        //				try
        //				{
        //					if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
        //					{
        //						JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

        //						shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());
        //					}

        //					if (shipperData == null)
        //						error += $"Invalid data.";

        //					if (shipperData != null && string.IsNullOrEmpty(shipperData.Batch_no))
        //						error += $"Batch No is not null." + System.Environment.NewLine;

        //					//if (shipperData != null && string.IsNullOrEmpty(shipperData.ManufacturedBy))
        //					//	error += $"Manufactured By is not null." + System.Environment.NewLine;

        //					//if (shipperData != null && string.IsNullOrEmpty(shipperData.MarketedBy))
        //					//	error += $"MarketedBy By is not null." + System.Environment.NewLine;

        //					if (shipperData != null && (string.IsNullOrEmpty(shipperData.ManufacturedBy) || shipperData.ManufacturedBy.ToLower() == "none"))
        //						shipperData.ManufacturedBy = "Indian Farmers Fertiliser Cooperative";

        //					if (shipperData != null && (string.IsNullOrEmpty(shipperData.MarketedBy) || shipperData.MarketedBy.ToLower() == "none"))
        //						shipperData.MarketedBy = "Indian Farmers Fertiliser Cooperative";

        //					var Mfg_Date = DateTime.MinValue;
        //					if (shipperData != null && (string.IsNullOrEmpty(shipperData.Mfg_Date) || !DateTime.TryParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Mfg_Date)))
        //						error += $"Invalid Manufacture Date.";

        //					if (Mfg_Date != DateTime.MinValue && (Mfg_Date.Date.Ticks < DateTime.Now.AddMonths(-1).AddDays(1).Date.Ticks || Mfg_Date.Date.Ticks > DateTime.Now.AddMonths(1).AddDays(-1).Date.Ticks))
        //						error += $"Manufacturing date cannot be more than 1 month old and must not be greater than 1 month from current date." + System.Environment.NewLine;

        //					int ExpireInMonth = listProduct != null && shipperData != null
        //						&& shipperData.ShipperQRCode_Data != null && shipperData.ShipperQRCode_Data.Count() > 0
        //						&& shipperData.ShipperQRCode_Data[0].BottleQRCode != null && shipperData.ShipperQRCode_Data[0].BottleQRCode.Count() > 0
        //						&& listProduct.Any(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)) ?
        //						listProduct.Where(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)).Select(y => y.ExpireInMonth).FirstOrDefault() : 0;

        //					if (ExpireInMonth == 0)
        //						error += $"Product's Expire In Month not available.";
        //					else
        //					{
        //						shipperData.Expiry_Date = Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("yyMMdd");

        //						Write_Log($"Manufacture date : {Mfg_Date.ToString("ddMMyyyy")}  ExpiryDate : {Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("ddMMyyyy")}", logFilePath);
        //					}


        //					//var Expiry_Date = DateTime.MinValue;
        //					//if (shipperData != null && (string.IsNullOrEmpty(shipperData.Expiry_Date) || !DateTime.TryParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Expiry_Date)))
        //					//	error += $"Invalid Expiry Date." + System.Environment.NewLine;

        //					//if (Expiry_Date != DateTime.MinValue && (Expiry_Date.Date.Ticks < DateTime.Now.Date.Ticks))
        //					//	error += $"Expiry date cannot be less than current date." + System.Environment.NewLine;

        //					//if (Expiry_Date != DateTime.MinValue && (Expiry_Date.Date.Ticks < Mfg_Date.Date.Ticks))
        //					//	error += $"Expiry date cannot be less than Manufacturing date." + System.Environment.NewLine;

        //					if (string.IsNullOrEmpty(error) && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
        //					{
        //						if (shipperData != null && (shipperData.ShipperQRCode_Data == null || shipperData.ShipperQRCode_Data.Count() == 0))
        //							error += $"Shipper QR Code Data missing." + System.Environment.NewLine;

        //						dt = DataContext.ExecuteQuery_SQL($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

        //						if (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) > 0)
        //							error += $"Batch no {shipperData.Batch_no} is already available." + System.Environment.NewLine;

        //						if (!error.Contains(shipperData.Batch_no))
        //							dt = DataContext.ExecuteQuery($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{shipperData.Batch_no}'");

        //						if (!error.Contains(shipperData.Batch_no) && dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) > 0)
        //							error += $"Batch no {shipperData.Batch_no} is already available!" + System.Environment.NewLine;

        //						if (string.IsNullOrEmpty(error))
        //						{
        //							var listShipperQRCode = shipperData.ShipperQRCode_Data
        //													.GroupBy(s => new { ShipperQRCode = s.ShipperQRCode, Action = s.Action, BottleQRCode_Len = s.BottleQRCode != null ? s.BottleQRCode.Count() : 0 })
        //													.Select(x =>
        //													{
        //														return new { ShipperQRCode = x.Key.ShipperQRCode, Action = x.Key.Action, Count = x.Count(), Length = x.Key.BottleQRCode_Len };
        //													})
        //													//.Where(g => g.Count > 1 || g.Length != 24)
        //													.ToList();

        //							if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Count() > 0)
        //								error += $"Duplicates Shipper QR Code found in file => {string.Join(", ", listShipperQRCode.Where(g => g.Count > 1).Select(x => x.ShipperQRCode + (x.Count > 1 ? " | Count : " + x.Count : "")).ToArray())}" + System.Environment.NewLine;

        //							if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Count() > 0)
        //								error += $"Bottles count is not 24 in Shipper QR Code => {string.Join(", ", listShipperQRCode.Where(g => g.Length != 24).Select(x => x.ShipperQRCode + (x.Length != 24 ? " | Bottles Count : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;

        //							if (listShipperQRCode != null && listShipperQRCode.Count() > 0)
        //							{
        //								var len = 0;

        //								while (len <= listShipperQRCode.Count())
        //								{
        //									dt = DataContext.ExecuteQuery_SQL("SELECT shipper_qrcode FROM SHIPPER_QRCODE " +
        //										"WHERE LOWER(action) = 'add' AND shipper_qrcode IN (" + string.Join(", ", listShipperQRCode.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

        //									if (dt != null && dt.Rows.Count > 0)
        //										foreach (DataRow dr in dt.Rows)
        //											error += $"Duplicates Shipper QR Code found in Database => " + (dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : "") + System.Environment.NewLine;

        //									len += 500;
        //								}
        //							}

        //							// Duplicate Bottle QR code Check Start

        //							var listBottleQRCode = shipperData.ShipperQRCode_Data.SelectMany(x => x.BottleQRCode)
        //															.GroupBy(qrCode => qrCode)
        //															.Select(qrCode =>
        //															{
        //																int startIndex = qrCode.Key.IndexOf(")", qrCode.Key.IndexOf(")", 0) + 1);

        //																if (startIndex >= 0) return new { BottleQRCode = qrCode.Key, Count = qrCode.Count(), Length = qrCode.Key.Substring(startIndex + 1, qrCode.Key.Length - startIndex - 1).Length };
        //																else return new { BottleQRCode = qrCode.Key, Count = qrCode.Count(), Length = 0 };
        //															})
        //															//.Where(qrCode => qrCode.Count > 1 || qrCode.Length != 14)
        //															.ToList();

        //							if (listBottleQRCode != null && listBottleQRCode.Where(qrCode => qrCode.Count > 1 || qrCode.Length < 12).Count() > 0)
        //								error += $"Duplicates Bottle QR Code found in file : {string.Join(", ", listBottleQRCode.Where(qrCode => qrCode.Count > 1 || qrCode.Length < 12).Select(x => x.BottleQRCode + (x.Count > 1 ? " Count : " + x.Count : "") + (x.Length > 0 ? " Length : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;


        //							if (listBottleQRCode != null && listBottleQRCode.Count() > 0)
        //							{
        //								var len = 0;

        //								while (len <= listBottleQRCode.Count())
        //								{
        //									dt = DataContext.ExecuteQuery_SQL("SELECT bottle_qrcode FROM bottle_qrcode " +
        //										"WHERE bottle_qrcode IN (" + string.Join(", ", listBottleQRCode.Skip(len).Take(300).Select(x => "'" + x.BottleQRCode + "'").ToArray()) + ")");

        //									if (dt != null && dt.Rows.Count > 0)
        //										foreach (DataRow dr in dt.Rows)
        //											error += $"Duplicate Bottle QRCode in DB : " + (dr["bottle_qrcode"] != DBNull.Value ? Convert.ToString(dr["bottle_qrcode"]) : "") + System.Environment.NewLine;

        //									len += 300;
        //								}
        //							}

        //							// Duplicate Bottle QR code Check end

        //							if (string.IsNullOrEmpty(error) && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
        //							{
        //								if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
        //								{
        //									var error_QR = new List<string>();

        //									var len = 0;

        //									while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
        //									{
        //										dt = DataContext.ExecuteQuery_SQL("SELECT SHIPPER_QR_CODE FROM mda_loading WHERE SHIPPER_QR_CODE IN ("
        //											+ string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
        //											.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ") X ");

        //										if (dt != null && dt.Rows.Count > 0)
        //										{
        //											error_QR.AddRange(dt.AsEnumerable().Select(row => row["SHIPPER_QR_CODE"].ToString()).ToList());
        //											break;
        //										}

        //										len += 500;
        //									}

        //									if (error_QR != null && error_QR.Count() > 0)
        //										error += "Delete operation not perform because Shipper QR Code(s) already loaded. Loaded Shipper QR Code(s) : "
        //											+ string.Join(", ", error_QR);

        //								}

        //								if (string.IsNullOrEmpty(error))
        //								{
        //									if (shipperData.ShipperQRCode_Data.Any(x => x.Action.ToLower().Contains("delete")))
        //									{
        //										var len = 0;

        //										while (len <= shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList().Count())
        //										{
        //											bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
        //												"AND (plant_id, shipper_qrcode_sysId) IN " +
        //												"(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' " +
        //												" AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
        //																								.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

        //											IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
        //												"AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
        //																								.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

        //											IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
        //												"AND (plant_id, shipper_qrcode_sysId) IN " +
        //												"(SELECT plant_id, shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " AND LOWER(action) = 'add' " +
        //												" AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
        //																								.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) ");

        //											IsDelete = DataContext.ExecuteNonQuery("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
        //												"AND shipper_qrcode IN (" + string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
        //																								.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");


        //											//dt = DataContext.ExecuteQuery_SQL("SELECT GROUP_CONCAT(shipper_qrcode_sysId) " +
        //											//"FROM (SELECT shipper_qrcode_sysId FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
        //											//			"AND LOWER(action) = 'add' AND shipper_qrcode IN ("
        //											//+ string.Join(", ", shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("delete")).ToList()
        //											//.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")) X ");

        //											//if (string.IsNullOrEmpty(error) && dt != null && dt.Rows.Count > 0)
        //											//{
        //											//	bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
        //											//		"AND shipper_qrcode_sysId IN (" + Convert.ToString(dt.Rows[0][0]) + ")");

        //											//	IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
        //											//		"AND shipper_qrcode_sysId IN (" + Convert.ToString(dt.Rows[0][0]) + ")");

        //											//	//IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
        //											//	//    "AND shipper_qrcode_sysId IN (" + Convert.ToString(dt.Rows[0][0]) + ")");

        //											//	//IsDelete = DataContext.ExecuteNonQuery("DELETE FROM shipper_qrcode WHERE plant_id = " + plant_id + " " +
        //											//	//    "AND shipper_qrcode_sysId IN (" + Convert.ToString(dt.Rows[0][0]) + ")");

        //											//}

        //											len += 500;
        //										}

        //									}

        //									shipperData.ShipperQRCode_Data = shipperData.ShipperQRCode_Data.Where(x => x.Action.ToLower().Contains("add")).ToList();

        //									DataTable dtShipperQrCode = new DataTable();
        //									DataTable dtBottleQrCode = new DataTable();

        //									if (string.IsNullOrEmpty(shipperData.PlantCd) || (shipperData.PlantCd.ToLower() == "none" || shipperData.PlantCd.ToLower() == "null"))
        //										shipperData.PlantCd = plantCode;

        //									Int64 shipper_Api_Id = 0;

        //									//dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 TEMP_SHIPPER_ID FROM SHIPPER_QRCODE_API");
        //									dt = DataContext.ExecuteQuery_SQL($"SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES " +
        //										$"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode_api';");

        //									if (dt != null && dt.Rows.Count > 0)
        //										shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
        //									else
        //									{
        //										dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(SHIPPER_QRCODE_API_SYSID), 0) + 1 TEMP_SHIPPER_ID FROM SHIPPER_QRCODE_API");

        //										if (dt != null && dt.Rows.Count > 0)
        //											shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
        //									}

        //									var sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (   SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
        //													",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
        //													", MARKETEDBY, MANUFACTUREDBY) " +
        //													"VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "' " +
        //													", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
        //													", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
        //													", NOW(), " + plant_id + ", 1, NOW(), " + shipperData.ShipperQRCode_Data.Count() + "" +
        //													",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' );";

        //									bool IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery);

        //									if (IsSuccess == true)
        //									{
        //										Int64 shipper_QrCode_Id = 0;
        //										Int64 shipper_QrCode_Id_Old = 0;

        //										//dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 TEMP_SHIPPER_QRCODE_ID FROM SHIPPER_QRCODE");
        //										dt = DataContext.ExecuteQuery_SQL($"SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES " +
        //											$"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'shipper_qrcode';");

        //										if (dt != null && dt.Rows.Count > 0)
        //											shipper_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
        //										else
        //										{
        //											dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 TEMP_SHIPPER_QRCODE_ID FROM SHIPPER_QRCODE");

        //											if (dt != null && dt.Rows.Count > 0)
        //												shipper_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
        //										}

        //										dtShipperQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM SHIPPER_QRCODE LIMIT 0");

        //										for (int i = 0; i < shipperData.ShipperQRCode_Data.Count(); i++)
        //										{
        //											shipper_QrCode_Id_Old = 0;

        //											if (!string.IsNullOrEmpty(shipperData.ShipperQRCode_Data[i].OldShipperQRCode))
        //											{
        //												var dt_0 = DataContext.ExecuteQuery_SQL("SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = '" + shipperData.ShipperQRCode_Data[i].OldShipperQRCode + "' AND PLANT_ID = " + plant_id + " LIMIT 1");

        //												if (dt_0 != null && dt_0.Rows.Count > 0)
        //													shipper_QrCode_Id_Old = (dt_0.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt_0.Rows[0][0]) : 0);

        //											}

        //											DataRow newRow = dtShipperQrCode.NewRow();

        //											shipperData.ShipperQRCode_Data[i].Id = shipper_QrCode_Id + i;

        //											newRow[0] = shipperData.ShipperQRCode_Data[i].Id;
        //											newRow[1] = shipperData.ShipperQRCode_Data[i].ShipperQRCode;
        //											newRow[2] = shipperData.ShipperQRCode_Data[i].BottleQRCode.Count();
        //											newRow[3] = "a";
        //											newRow[4] = shipperData.ShipperQRCode_Data[i].Action;
        //											newRow[5] = shipper_QrCode_Id_Old;
        //											newRow[6] = shipper_Api_Id;
        //											newRow[7] = 0;
        //											newRow[8] = plant_id;
        //											newRow[9] = user_id;
        //											newRow[10] = currentDateTime.ToString();
        //											newRow[11] = null;
        //											newRow[12] = 0;
        //											newRow[13] = 0;
        //											newRow[14] = currentDateTime.ToString();
        //											newRow[15] = currentDateTime.ToString();

        //											dtShipperQrCode.Rows.Add(newRow);
        //										}

        //										//if (dtShipperQrCode != null && dtShipperQrCode.Rows.Count > 0)
        //										//	DataContext.BulkInsertMySQL(dtShipperQrCode, "SHIPPER_QRCODE");


        //										int startIndex = 0;

        //										while (startIndex < dtShipperQrCode.Rows.Count)
        //										{
        //											// Select the next 1000 rows using LINQ
        //											DataTable nextBatch = dtShipperQrCode.AsEnumerable()
        //												.Skip(startIndex)
        //												.Take(1000)
        //												.CopyToDataTable();

        //											sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

        //											var sqlQuery_Select = "";

        //											foreach (DataRow dr in nextBatch.Rows)
        //											{
        //												if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
        //												{
        //													sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
        //														$", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
        //														$", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
        //														$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
        //														$", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
        //														$", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
        //														$", {plant_id} PLANT_ID" +
        //														$", {user_id} CREATED_BY" +
        //														$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME" +
        //														$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') EVENTTIME " +
        //														$" FROM DUAL UNION ";
        //												}
        //											}

        //											if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //												sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //											sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

        //											IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery + sqlQuery_Select);

        //											startIndex += 1000;
        //										}



        //										// Bottle Qr Code
        //										Int64 bottle_QrCode_Id = 0;

        //										//dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(BOTTLE_QRCODE_SYSID), 0) + 1 TEMP_SHIPPER_QRCODE_ID FROM BOTTLE_QRCODE");
        //										dt = DataContext.ExecuteQuery_SQL($"SELECT `AUTO_INCREMENT` FROM  INFORMATION_SCHEMA.TABLES " +
        //										$"WHERE LOWER(TABLE_SCHEMA) = '{DataContext.Get_DbSchemaName_SQL().ToLower()}' AND LOWER(TABLE_NAME) = 'bottle_qrcode';");

        //										if (dt != null && dt.Rows.Count > 0)
        //											bottle_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
        //										else
        //										{
        //											dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(BOTTLE_QRCODE_SYSID), 0) + 1 TEMP_SHIPPER_QRCODE_ID FROM BOTTLE_QRCODE");

        //											if (dt != null && dt.Rows.Count > 0)
        //												bottle_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
        //										}

        //										dtBottleQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM BOTTLE_QRCODE LIMIT 0");

        //										for (int x = 0; x < shipperData.ShipperQRCode_Data.Count(); x++)
        //										{
        //											long productId = 0;

        //											for (int i = 0; i < shipperData.ShipperQRCode_Data[x].BottleQRCode.Count(); i++)
        //											{
        //												if (productId == 0)
        //													productId = listProduct.Where(y => shipperData.ShipperQRCode_Data[x].BottleQRCode[i].Contains(y.GTIN)).Select(y => y.Id).FirstOrDefault();

        //												DataRow newRow = dtBottleQrCode.NewRow();

        //												newRow[0] = bottle_QrCode_Id;
        //												newRow[1] = shipperData.ShipperQRCode_Data[x].BottleQRCode[i];
        //												newRow[2] = productId;
        //												newRow[3] = "a";
        //												newRow[4] = shipperData.ShipperQRCode_Data[x].Id;
        //												newRow[5] = plant_id;
        //												newRow[6] = user_id;
        //												newRow[7] = currentDateTime.ToString();
        //												newRow[8] = 0;
        //												newRow[9] = "t";
        //												newRow[10] = "t";
        //												newRow[11] = 0;

        //												dtBottleQrCode.Rows.Add(newRow);

        //												bottle_QrCode_Id = bottle_QrCode_Id + 1;
        //											}

        //										}


        //										//if (dtBottleQrCode != null && dtBottleQrCode.Rows.Count > 0)
        //										//	DataContext.BulkInsertMySQL(dtBottleQrCode, "BOTTLE_QRCODE");


        //										int chunkSize = 5000;

        //										int numberOfTasks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);

        //										Task[] tasks = new Task[numberOfTasks];

        //										for (int i = 0; i < numberOfTasks; i++)
        //										{
        //											int start_Index = i * chunkSize;
        //											tasks[i] = Task.Run(() =>
        //											{
        //												DataTable nextBatch = dtBottleQrCode.AsEnumerable()
        //													.Skip(start_Index)
        //													.Take(chunkSize)
        //													.CopyToDataTable();

        //												sqlQuery = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

        //												var sqlQuery_Select = "";

        //												foreach (DataRow dr in nextBatch.Rows)
        //												{
        //													if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
        //													{
        //														sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
        //															$", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
        //															$", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
        //															$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
        //															$", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
        //															$", {plant_id} PLANT_ID" +
        //															$", {user_id} CREATED_BY" +
        //															$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', '%d-%m-%Y %H:%i') CREATED_DATETIME " +
        //															$" FROM DUAL UNION ";
        //													}
        //												}

        //												if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //													sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //												sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

        //												IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery + sqlQuery_Select);

        //											});
        //										}

        //										Task.WaitAll(tasks);

        //									}

        //									if (IsSuccess == true)
        //									{
        //										sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
        //													",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
        //													", MARKETEDBY, MANUFACTUREDBY) " +
        //													"VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "'" +
        //													", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
        //													", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
        //													", SYSDATE, " + plant_id + ", " + user_id + ", SYSDATE, " + shipperData.ShipperQRCode_Data.Count() + "" +
        //													",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' )";


        //										IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);

        //										if (IsSuccess == true)
        //										{
        //											int startIndex = 0;

        //											while (startIndex < dtShipperQrCode.Rows.Count)
        //											{
        //												// Select the next 1000 rows using LINQ
        //												DataTable nextBatch = dtShipperQrCode.AsEnumerable()
        //													.Skip(startIndex)
        //													.Take(1000)
        //													.CopyToDataTable();

        //												sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

        //												var sqlQuery_Select = "";

        //												foreach (DataRow dr in nextBatch.Rows)
        //												{
        //													if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
        //													{
        //														sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
        //															$", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
        //															$", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
        //															$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
        //															$", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
        //															$", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
        //															$", {plant_id} PLANT_ID" +
        //															$", {user_id} CREATED_BY" +
        //															$", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME" +
        //															$", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') EVENTTIME " +
        //															$" FROM DUAL UNION ";
        //													}
        //												}

        //												if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //													sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //												sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

        //												IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

        //												startIndex += 1000;
        //											}

        //											int chunkSize = 5000;

        //											int numberOfTasks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);

        //											Task[] tasks = new Task[numberOfTasks];

        //											for (int i = 0; i < numberOfTasks; i++)
        //											{
        //												int start_Index = i * chunkSize;
        //												tasks[i] = Task.Run(() =>
        //												{
        //													DataTable nextBatch = dtBottleQrCode.AsEnumerable()
        //														.Skip(start_Index)
        //														.Take(chunkSize)
        //														.CopyToDataTable();

        //													sqlQuery = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

        //													var sqlQuery_Select = "";

        //													foreach (DataRow dr in nextBatch.Rows)
        //													{
        //														if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
        //														{
        //															sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
        //																$", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
        //																$", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
        //																$", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
        //																$", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
        //																$", {plant_id} PLANT_ID" +
        //																$", {user_id} CREATED_BY" +
        //																$", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME " +
        //																$" FROM DUAL UNION ";
        //														}
        //													}

        //													if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //														sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //													sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") X ";

        //													IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

        //												});
        //											}

        //											Task.WaitAll(tasks);

        //										}
        //									}
        //								}
        //							}
        //						}
        //					}

        //				}
        //				catch (Exception ex)
        //				{
        //					error = (string.IsNullOrEmpty(error) ? "Data not Convert Json to List." : error);

        //					//bool IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
        //					//	"AND shipper_qrcode_sysId IN (SELECT shipper_qrcode_sysId FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
        //					//			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'))");

        //					//IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
        //					//			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "')");

        //					//IsDelete = DataContext.ExecuteNonQuery_SQL("DELETE FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'");

        //					//IsDelete = DataContext.ExecuteNonQuery("DELETE FROM bottle_qrcode WHERE plant_id = " + plant_id + " " +
        //					//	"AND shipper_qrcode_sysId IN (SELECT shipper_qrcode_sysId FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
        //					//			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'))");

        //					//IsDelete = DataContext.ExecuteNonQuery("DELETE FROM SHIPPER_QRCODE WHERE plant_id = " + plant_id + " " +
        //					//			"AND shipper_qrcode_api_sysId IN (SELECT shipper_qrcode_api_sysId FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "')");

        //					//IsDelete = DataContext.ExecuteNonQuery("DELETE FROM SHIPPER_QRCODE_API WHERE plant_id = " + plant_id + " AND BATCH_NO = '" + shipperData.Batch_no + "'");

        //				}

        //				(string fileName, string fileUploadStatus) = (Path.GetFileName(sourceFilePath), "Completed");

        //				if (string.IsNullOrEmpty(error))
        //				{
        //					if (!System.IO.Directory.Exists(destinationFolderPath))
        //						System.IO.Directory.CreateDirectory(destinationFolderPath);

        //					if (System.IO.File.Exists(sourceFilePath))
        //					{
        //						string destinationFilePath = Path.Combine(destinationFolderPath, fileName);

        //						// Check if the destination file already exists
        //						int counter = 1;
        //						while (System.IO.File.Exists(destinationFilePath))
        //						{
        //							// If the file exists, append a number to the file name
        //							string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
        //							string fileExtension = Path.GetExtension(sourceFilePath);
        //							string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

        //							destinationFilePath = Path.Combine(destinationFolderPath, newFileName);
        //							counter++;
        //						}
        //						// Copy the file to the destination folder
        //						System.IO.File.Copy(sourceFilePath, destinationFilePath);

        //						// Delete the original file
        //						System.IO.File.Delete(sourceFilePath);
        //					}
        //				}
        //				else
        //				{
        //					fileUploadStatus = "Error";

        //					Write_Log(fileName + " => " + error, logFilePath);
        //					errors.Add(fileName + " => " + error);

        //					if (!System.IO.Directory.Exists(errorFolderPath))
        //						System.IO.Directory.CreateDirectory(errorFolderPath);

        //					if (System.IO.File.Exists(sourceFilePath))
        //					{
        //						string errorFilePath = Path.Combine(errorFolderPath, Path.GetFileName(sourceFilePath));

        //						// Check if the error file already exists
        //						int counter = 1;
        //						while (System.IO.File.Exists(errorFilePath))
        //						{
        //							// If the file exists, append a number to the file name
        //							string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
        //							string fileExtension = Path.GetExtension(sourceFilePath);
        //							string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

        //							errorFilePath = Path.Combine(errorFolderPath, newFileName);
        //							counter++;
        //						}
        //						// Copy the file to the error folder
        //						System.IO.File.Copy(sourceFilePath, errorFilePath);

        //						// Delete the original file
        //						System.IO.File.Delete(sourceFilePath);
        //					}
        //				}


        //				try
        //				{
        //					var query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, REMARK) " +
        //										$"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
        //										$", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
        //										$", STR_TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
        //										$", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
        //										$", '{error}' );";

        //					var result = DataContext.ExecuteNonQuery_SQL(query_File);

        //					if (string.IsNullOrEmpty(error))
        //					{
        //						query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, PLANTCODE, REMARK) " +
        //						   $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
        //						   $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
        //						   $", TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
        //						   $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
        //						   $", '{plantCode}', '{error}' )";

        //						result = DataContext.ExecuteNonQuery(query_File);
        //					}
        //				}
        //				catch { }

        //				//if (errors != null && errors.Count() > 0)
        //				//    Write_Log(errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

        //				Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
        //					$"Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}", logFilePath);

        //			}
        //		}
        //		else
        //		{
        //			errors.Add("No any file(s) to upload data");
        //		}

        //		if (errors == null || errors.Count() == 0)
        //		{
        //			CommonViewModel.IsConfirm = true;
        //			CommonViewModel.IsSuccess = true;
        //			CommonViewModel.StatusCode = ResponseStatusCode.Success;
        //			CommonViewModel.Message = "Record updated successfully !..."; ;

        //			return Json(CommonViewModel);
        //		}
        //		else
        //		{
        //			CommonViewModel.IsSuccess = false;
        //			CommonViewModel.StatusCode = ResponseStatusCode.Error;
        //			CommonViewModel.Message = "Some JSON file was not processed. Please check error log." +
        //				"" + System.Environment.NewLine + (errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

        //			return Json(CommonViewModel);
        //		}
        //	}
        //	catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

        //	CommonViewModel.IsSuccess = false;
        //	CommonViewModel.StatusCode = ResponseStatusCode.Error;
        //	CommonViewModel.Message = ResponseStatusMessage.Error;

        //	return Json(CommonViewModel);
        //}

        public IActionResult SyncBatch_Rework()
        {
            try
            {
                string logFilePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Log_File_Path_RW").Value ?? "");

                string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Source_Folder_Path_RW").Value ?? "");
                string destinationFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Destination_Folder_Path_RW").Value ?? "");
                string errorFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Error_Folder_Path_RW").Value ?? "");

                string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

                string[] sourceFilePaths = Directory.GetFiles(sourceFolderPath, "*.json", SearchOption.AllDirectories);
                string[] destinationFilePaths = Directory.GetFiles(destinationFolderPath, "*.json", SearchOption.AllDirectories);

                if (destinationFilePaths == null)
                    destinationFilePaths = new string[] { "" };

                var dt = new DataTable();

                List<string> errors = new List<string>();

                var user_id = Common.Get_Session_Int(SessionKey.USER_ID);

                var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

                plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;
                user_id = user_id <= 0 ? 1 : user_id;

                if (sourceFilePaths != null && sourceFilePaths.Length > 0)
                {
                    List<(long Id, string GTIN, int ExpireInMonth)> listProduct = new List<(long Id, string GTIN, int ExpireInMonth)>();

                    dt = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PROD_SYS_ID, GTIN, VALIDITY_MONTH FROM PRODUCT_MASTER WHERE IFNULL(GTIN, '') != '' ");

                    if (dt != null && dt.Rows.Count > 0)
                        listProduct = (from DataRow dr in dt.Rows
                                       select (Id: (dr["PROD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SYS_ID"]) : 0)
                                       , GSTIN: (dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "")
                                       , ExpireInMonth: (dr["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt32(dr["VALIDITY_MONTH"]) : 0))).ToList();

                    var orderedFilePaths = sourceFilePaths.OrderBy(path => path, new CustomFileOrderComparer());

                    foreach (var sourceFilePath in orderedFilePaths.Where(x => !destinationFilePaths.Any(y => y.StartsWith(x))).OrderBy(x => x).ToList())
                    {
                        var currentDateTime = DateTime.Now;

                        Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
                            $"Started at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}", logFilePath);

                        var error = "";

                        var shipperData = new ShipperData();

                        StringBuilder fileContent = new StringBuilder();
                        using (StreamReader sr = new StreamReader(sourceFilePath)) { fileContent.Append(sr.ReadToEnd()); }

                        dt = new DataTable();

                        try
                        {
                            if (!string.IsNullOrEmpty(Convert.ToString(fileContent)))
                            {
                                JToken obj = JObject.Parse(Convert.ToString(fileContent).Replace("Null", "").Replace("null", "").Replace("NULL", ""));

                                shipperData = JsonConvert.DeserializeObject<ShipperData>(obj.ToString());
                            }

                            if (shipperData == null)
                                error += $"Invalid data.";

                            if (shipperData != null && string.IsNullOrEmpty(shipperData.Batch_no))
                                error += $"Batch No is not null." + System.Environment.NewLine;


                            if (shipperData != null && !string.IsNullOrEmpty(shipperData.Batch_no))
                                dt = DataContext.ExecuteQuery_SQL($"SELECT SHIPPER_QRCODE_API_SYSID, TOTAL_SHIPPER_QTY FROM SHIPPER_QRCODE_API WHERE BATCH_NO = '{shipperData.Batch_no}'");

                            if (shipperData != null && !string.IsNullOrEmpty(shipperData.Batch_no)
                                && (dt == null || dt.Rows.Count <= 0))
                                error += $"Batch no {shipperData.Batch_no} is not available for rework." + System.Environment.NewLine;
                            else
                            {
                                Int64 shipper_Api_Id = 0;
                                Int64 total_shipper_qty = 0;

                                if (dt != null && dt.Rows.Count > 0)
                                {
                                    shipper_Api_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);
                                    total_shipper_qty = (dt.Rows[0][1] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][1]) : 0);
                                }

                                if (shipperData != null && string.IsNullOrEmpty(shipperData.ManufacturedBy))
                                    error += $"Manufactured By is not null." + System.Environment.NewLine;

                                if (shipperData != null && string.IsNullOrEmpty(shipperData.MarketedBy))
                                    error += $"MarketedBy By is not null." + System.Environment.NewLine;

                                var Mfg_Date = DateTime.MinValue;
                                if (shipperData != null && (string.IsNullOrEmpty(shipperData.Mfg_Date) || !DateTime.TryParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Mfg_Date)))
                                    error += $"Invalid Manufacture Date.";

                                if (Mfg_Date != DateTime.MinValue && (Mfg_Date.Date.Ticks < DateTime.Now.AddMonths(-8).AddDays(1).Date.Ticks || Mfg_Date.Date.Ticks > DateTime.Now.AddMonths(1).AddDays(-1).Date.Ticks))
                                    error += $"Manufacturing date cannot be more than 8 month old and must not be greater than 1 month from current date." + System.Environment.NewLine;

                                int ExpireInMonth = listProduct != null && shipperData != null
                                    && shipperData.ShipperQRCode_Data != null && shipperData.ShipperQRCode_Data.Count() > 0
                                    && shipperData.ShipperQRCode_Data[0].BottleQRCode != null && shipperData.ShipperQRCode_Data[0].BottleQRCode.Count() > 0
                                    && listProduct.Any(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)) ?
                                    listProduct.Where(y => shipperData.ShipperQRCode_Data[0].BottleQRCode[0].Contains(y.GTIN)).Select(y => y.ExpireInMonth).FirstOrDefault() : 0;

                                if (ExpireInMonth == 0)
                                    error += $"Product's Expire In Month not available.";
                                else
                                    shipperData.Expiry_Date = Mfg_Date.AddMonths(ExpireInMonth).AddDays(-1).ToString("yyMMdd");

                                if (string.IsNullOrEmpty(error) && shipper_Api_Id > 0 && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
                                {
                                    if (shipperData != null && (shipperData.ShipperQRCode_Data == null || shipperData.ShipperQRCode_Data.Count() == 0))
                                        error += $"Shipper QR Code Data missing." + System.Environment.NewLine;

                                    if (shipperData != null && (shipperData.ShipperQRCode_Data == null || shipperData.ShipperQRCode_Data.Count() == 0))
                                        error += $"Shipper QR Code Data missing." + System.Environment.NewLine;

                                    var listShipperQRCode = shipperData.ShipperQRCode_Data
                                                                .GroupBy(s => new { ShipperQRCode = s.ShipperQRCode, Action = s.Action, BottleQRCode_Len = s.BottleQRCode != null ? s.BottleQRCode.Count() : 0 })
                                                                .Select(x =>
                                                                {
                                                                    return new { ShipperQRCode = x.Key.ShipperQRCode, Action = x.Key.Action, Count = x.Count(), Length = x.Key.BottleQRCode_Len };
                                                                })
                                                                //.Where(g => g.Count > 1 || g.Length != 24)
                                                                .ToList();

                                    if (listShipperQRCode != null && listShipperQRCode.Any(g => !g.Action.ToLower().Contains("add")))
                                        error += $"Rework allow only for 'Add' action." + System.Environment.NewLine;
                                    else if (listShipperQRCode != null && listShipperQRCode.Any(g => g.Action.ToLower().Contains("add") && g.Count > 10))
                                        error += $"Rework allow only 10 or less then 10 Shippers." + System.Environment.NewLine;
                                    else
                                    {
                                        if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Count > 1).Count() > 0)
                                            error += $"Duplicates Shipper QR Code found in file => {string.Join(", ", listShipperQRCode.Where(g => g.Count > 1).Select(x => x.ShipperQRCode + (x.Count > 1 ? " | Count : " + x.Count : "")).ToArray())}" + System.Environment.NewLine;

                                        if (listShipperQRCode != null && listShipperQRCode.Where(g => g.Action.ToLower().Contains("add") && g.Length != 24).Count() > 0)
                                            error += $"Bottles count is not 24 in Shipper QR Code => {string.Join(", ", listShipperQRCode.Where(g => g.Length != 24).Select(x => x.ShipperQRCode + (x.Length != 24 ? " | Bottles Count : " + x.Length : "")).ToArray())}" + System.Environment.NewLine;

                                        if (listShipperQRCode != null && listShipperQRCode.Count() > 0)
                                        {
                                            var len = 0;

                                            while (len <= listShipperQRCode.Count())
                                            {
                                                dt = DataContext.ExecuteQuery_SQL("SELECT shipper_qrcode FROM SHIPPER_QRCODE " +
                                                    "WHERE LOWER(action) = 'add' AND shipper_qrcode IN (" + string.Join(", ", listShipperQRCode.Skip(len).Take(500).Select(x => "'" + x.ShipperQRCode + "'").ToArray()) + ")");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    foreach (DataRow dr in dt.Rows)
                                                        error += $"Duplicates Shipper QR Code found in Database => " + (dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : "") + System.Environment.NewLine;

                                                len += 500;
                                            }
                                        }

                                        if (string.IsNullOrEmpty(error) && shipper_Api_Id > 0 && shipperData != null && (shipperData.ShipperQRCode_Data != null || shipperData.ShipperQRCode_Data.Count() > 0))
                                        {
                                            DataTable dtShipperQrCode = new DataTable();
                                            DataTable dtBottleQrCode = new DataTable();

                                            if (string.IsNullOrEmpty(shipperData.PlantCd) || (shipperData.PlantCd.ToLower() == "none" || shipperData.PlantCd.ToLower() == "null"))
                                                shipperData.PlantCd = plantCode;

                                            //var sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (   SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                            //                ",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                            //                ", MARKETEDBY, MANUFACTUREDBY) " +
                                            //                "VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "' " +
                                            //                ", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
                                            //                ", STR_TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), '%d/%m/%Y')" +
                                            //                ", NOW(), " + plant_id + ", 1, NOW(), " + shipperData.ShipperQRCode_Data.Count() + "" +
                                            //                ",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' );";

                                            var sqlQuery = "UPDATE shipper_qrcode_api SET total_shipper_qty = " + (total_shipper_qty + shipperData.ShipperQRCode_Data.Count()) + " " +
                                                            "WHERE shipper_qrcode_api_sysId = " + shipper_Api_Id;

                                            bool IsSuccess = DataContext.ExecuteNonQuery_SQL(sqlQuery);

                                            if (IsSuccess == true)
                                            {
                                                Int64 shipper_QrCode_Id = 0;
                                                Int64 shipper_QrCode_Id_Old = 0;

                                                dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(SHIPPER_QRCODE_SYSID), 0) + 1 TEMP_SHIPPER_QRCODE_ID FROM SHIPPER_QRCODE");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    shipper_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                dtShipperQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM SHIPPER_QRCODE LIMIT 0");

                                                for (int i = 0; i < shipperData.ShipperQRCode_Data.Count(); i++)
                                                {
                                                    shipper_QrCode_Id_Old = 0;

                                                    if (!string.IsNullOrEmpty(shipperData.ShipperQRCode_Data[i].OldShipperQRCode))
                                                    {
                                                        var dt_0 = DataContext.ExecuteQuery_SQL("SELECT SHIPPER_QRCODE_SYSID FROM SHIPPER_QRCODE WHERE SHIPPER_QRCODE = '" + shipperData.ShipperQRCode_Data[i].OldShipperQRCode + "' AND PLANT_ID = " + plant_id + " LIMIT 1");

                                                        if (dt_0 != null && dt_0.Rows.Count > 0)
                                                            shipper_QrCode_Id_Old = (dt_0.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt_0.Rows[0][0]) : 0);

                                                    }

                                                    DataRow newRow = dtShipperQrCode.NewRow();

                                                    shipperData.ShipperQRCode_Data[i].Id = shipper_QrCode_Id + i;

                                                    newRow[0] = shipperData.ShipperQRCode_Data[i].Id;
                                                    newRow[1] = shipperData.ShipperQRCode_Data[i].ShipperQRCode;
                                                    newRow[2] = shipperData.ShipperQRCode_Data[i].BottleQRCode.Count();
                                                    newRow[3] = "a";
                                                    newRow[4] = shipperData.ShipperQRCode_Data[i].Action;
                                                    newRow[5] = shipper_QrCode_Id_Old;
                                                    newRow[6] = shipper_Api_Id;
                                                    newRow[7] = 0;
                                                    newRow[8] = plant_id;
                                                    newRow[9] = user_id;
                                                    newRow[10] = currentDateTime.ToString();
                                                    newRow[11] = null;
                                                    newRow[12] = 0;
                                                    newRow[13] = 0;
                                                    newRow[14] = currentDateTime.ToString();
                                                    newRow[15] = currentDateTime.ToString();

                                                    dtShipperQrCode.Rows.Add(newRow);
                                                }

                                                if (dtShipperQrCode != null && dtShipperQrCode.Rows.Count > 0)
                                                    DataContext.BulkInsertMySQL(dtShipperQrCode, "SHIPPER_QRCODE");

                                                // Bottle Qr Code
                                                Int64 bottle_QrCode_Id = 0;

                                                dt = DataContext.ExecuteQuery_SQL("SELECT IFNULL(MAX(BOTTLE_QRCODE_SYSID), 0) + 1 TEMP_SHIPPER_QRCODE_ID FROM BOTTLE_QRCODE");

                                                if (dt != null && dt.Rows.Count > 0)
                                                    bottle_QrCode_Id = (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt64(dt.Rows[0][0]) : 0);

                                                dtBottleQrCode = DataContext.ExecuteQuery_SQL("SELECT * FROM BOTTLE_QRCODE LIMIT 0");

                                                for (int x = 0; x < shipperData.ShipperQRCode_Data.Count(); x++)
                                                {
                                                    long productId = 0;

                                                    for (int i = 0; i < shipperData.ShipperQRCode_Data[x].BottleQRCode.Count(); i++)
                                                    {
                                                        if (productId == 0)
                                                            productId = listProduct.Where(y => shipperData.ShipperQRCode_Data[x].BottleQRCode[i].Contains(y.GTIN)).Select(y => y.Id).FirstOrDefault();

                                                        DataRow newRow = dtBottleQrCode.NewRow();

                                                        newRow[0] = bottle_QrCode_Id;
                                                        newRow[1] = shipperData.ShipperQRCode_Data[x].BottleQRCode[i];
                                                        newRow[2] = productId;
                                                        newRow[3] = "a";
                                                        newRow[4] = shipperData.ShipperQRCode_Data[x].Id;
                                                        newRow[5] = plant_id;
                                                        newRow[6] = user_id;
                                                        newRow[7] = currentDateTime.ToString();
                                                        newRow[8] = 0;
                                                        newRow[9] = "t";
                                                        newRow[10] = "t";
                                                        newRow[11] = 0;

                                                        dtBottleQrCode.Rows.Add(newRow);

                                                        bottle_QrCode_Id = bottle_QrCode_Id + 1;
                                                    }

                                                }


                                                if (dtBottleQrCode != null && dtBottleQrCode.Rows.Count > 0)
                                                    DataContext.BulkInsertMySQL(dtBottleQrCode, "BOTTLE_QRCODE");
                                                //{
                                                //                               int chunkSize = 5000;

                                                //                               int numberOfTasks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);

                                                //                               Task[] tasks = new Task[numberOfTasks];

                                                //                               for (int i = 0; i < numberOfTasks; i++)
                                                //                               {
                                                //                                   int start_Index = i * chunkSize;
                                                //                                   tasks[i] = Task.Run(() =>
                                                //                                   {
                                                //                                       DataTable nextBatch = dtBottleQrCode.AsEnumerable()
                                                //                                           .Skip(start_Index)
                                                //                                           .Take(chunkSize)
                                                //                                           .CopyToDataTable();

                                                //                                       DataContext.BulkInsertMySQL(nextBatch, "BOTTLE_QRCODE");
                                                //                                   });
                                                //                               }

                                                //                               Task.WaitAll(tasks);

                                                //                           }

                                            }

                                            if (IsSuccess == true)
                                            {
                                                //sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                                //            ",EXPIRY_DATE, EVENTTIME, PLANT_ID,  CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                                //            ", MARKETEDBY, MANUFACTUREDBY) " +
                                                //            "VALUES ( " + shipper_Api_Id + ", '" + shipperData.Batch_no + "'" +
                                                //            ", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Mfg_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
                                                //            ", TO_DATE(REPLACE('" + DateTime.ParseExact(shipperData.Expiry_Date, "yyMMdd", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") + "', '-', '/'), 'DD/MM/YYYY')" +
                                                //            ", SYSDATE, " + plant_id + ", " + user_id + ", SYSDATE, " + shipperData.ShipperQRCode_Data.Count() + "" +
                                                //            ",  '" + shipperData.MarketedBy + "', '" + shipperData.ManufacturedBy + "' )";

                                                sqlQuery = "UPDATE SHIPPER_QRCODE_API SET TOTAL_SHIPPER_QTY = " + (total_shipper_qty + shipperData.ShipperQRCode_Data.Count()) + " " +
                                                                "WHERE SHIPPER_QRCODE_API_SYSID = " + shipper_Api_Id;


                                                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);

                                                if (IsSuccess == true)
                                                {
                                                    int startIndex = 0;

                                                    while (startIndex < dtShipperQrCode.Rows.Count)
                                                    {
                                                        // Select the next 1000 rows using LINQ
                                                        DataTable nextBatch = dtShipperQrCode.AsEnumerable()
                                                            .Skip(startIndex)
                                                            .Take(1000)
                                                            .CopyToDataTable();

                                                        sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

                                                        var sqlQuery_Select = "";

                                                        foreach (DataRow dr in nextBatch.Rows)
                                                        {
                                                            if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
                                                            {
                                                                sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                    $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
                                                                    $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
                                                                    $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                    $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
                                                                    $", {shipper_Api_Id} SHIPPER_QRCODE_API_SYSID" +
                                                                    $", {plant_id} PLANT_ID" +
                                                                    $", {user_id} CREATED_BY" +
                                                                    $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME" +
                                                                    $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') EVENTTIME " +
                                                                    $" FROM DUAL UNION ";
                                                            }
                                                        }

                                                        if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                            sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                        sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

                                                        IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                                        startIndex += 1000;
                                                    }

                                                    int chunkSize = 5000;

                                                    int numberOfTasks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);

                                                    Task[] tasks = new Task[numberOfTasks];

                                                    for (int i = 0; i < numberOfTasks; i++)
                                                    {
                                                        int start_Index = i * chunkSize;
                                                        tasks[i] = Task.Run(() =>
                                                        {
                                                            DataTable nextBatch = dtBottleQrCode.AsEnumerable()
                                                                .Skip(start_Index)
                                                                .Take(chunkSize)
                                                                .CopyToDataTable();

                                                            sqlQuery = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

                                                            var sqlQuery_Select = "";

                                                            foreach (DataRow dr in nextBatch.Rows)
                                                            {
                                                                if ((dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0) > 0)
                                                                {
                                                                    sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
                                                                        $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
                                                                        $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
                                                                        $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                                                        $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                                                        $", {plant_id} PLANT_ID" +
                                                                        $", {user_id} CREATED_BY" +
                                                                        $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI') CREATED_DATETIME " +
                                                                        $" FROM DUAL UNION ";
                                                                }
                                                            }

                                                            if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                                                sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                                            sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") ";

                                                            IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                                        });
                                                    }

                                                    Task.WaitAll(tasks);

                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception ex) { error = (string.IsNullOrEmpty(error) ? "Data not Convert Json to List." : error); }

                        (string fileName, string fileUploadStatus) = (Path.GetFileName(sourceFilePath), "Completed");

                        if (string.IsNullOrEmpty(error))
                        {
                            if (!System.IO.Directory.Exists(destinationFolderPath))
                                System.IO.Directory.CreateDirectory(destinationFolderPath);

                            if (System.IO.File.Exists(sourceFilePath))
                            {
                                string destinationFilePath = Path.Combine(destinationFolderPath, fileName);

                                // Check if the destination file already exists
                                int counter = 1;
                                while (System.IO.File.Exists(destinationFilePath))
                                {
                                    // If the file exists, append a number to the file name
                                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                    string fileExtension = Path.GetExtension(sourceFilePath);
                                    string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                    destinationFilePath = Path.Combine(destinationFolderPath, newFileName);
                                    counter++;
                                }
                                // Copy the file to the destination folder
                                System.IO.File.Copy(sourceFilePath, destinationFilePath);

                                // Delete the original file
                                System.IO.File.Delete(sourceFilePath);
                            }
                        }
                        else
                        {
                            fileUploadStatus = "Error";

                            Write_Log(fileName + " => " + error, logFilePath);
                            errors.Add(fileName + " => " + error);

                            if (!System.IO.Directory.Exists(errorFolderPath))
                                System.IO.Directory.CreateDirectory(errorFolderPath);

                            if (System.IO.File.Exists(sourceFilePath))
                            {
                                string errorFilePath = Path.Combine(errorFolderPath, Path.GetFileName(sourceFilePath));

                                // Check if the error file already exists
                                int counter = 1;
                                while (System.IO.File.Exists(errorFilePath))
                                {
                                    // If the file exists, append a number to the file name
                                    string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                                    string fileExtension = Path.GetExtension(sourceFilePath);
                                    string newFileName = $"{fileNameWithoutExtension}_{counter}{fileExtension}";

                                    errorFilePath = Path.Combine(errorFolderPath, newFileName);
                                    counter++;
                                }
                                // Copy the file to the error folder
                                System.IO.File.Copy(sourceFilePath, errorFilePath);

                                // Delete the original file
                                System.IO.File.Delete(sourceFilePath);
                            }
                        }


                        try
                        {
                            var query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, REMARK, IS_REWORK) " +
                                                $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
                                                $", STR_TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
                                                $", STR_TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("-", "/")}', '%d/%m/%Y %H:%i')" +
                                                $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
                                                $", '{error}', 'Y' );";

                            var result = DataContext.ExecuteNonQuery_SQL(query_File);

                            if (string.IsNullOrEmpty(error))
                            {
                                query_File = $"INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, PLANTCODE, REMARK, IS_REWORK) " +
                                   $"VALUES ( '{fileName.Substring(0, fileName.Length - (fileName.Length - fileName.LastIndexOf('.')))}'" +
                                   $", TO_DATE('{currentDateTime.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
                                   $", TO_DATE('{DateTime.Now.ToString("dd-MM-yyyy HH:mm").Replace("/", "-")}', 'DD-MM-YYYY HH24:MI')" +
                                   $", {(shipperData.ShipperQRCode_Data.Count() * 24)}, '{fileUploadStatus}'" +
                                   $", '{plantCode}', '{error}', 'Y' )";

                                result = DataContext.ExecuteNonQuery(query_File);
                            }
                        }
                        catch { }

                        //if (errors != null && errors.Count() > 0)
                        //    Write_Log(errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

                        Write_Log($"File Processing With Out Validation {Path.GetFileName(sourceFilePath)} " +
                            $"Completed at {DateTime.Now.ToString("MM/dd/yyyy hh:mm:ss tt").Replace("-", "/")}", logFilePath);

                    }
                }
                else
                {
                    errors.Add("No any file(s) to upload data");
                }

                if (errors == null || errors.Count() == 0)
                {
                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = "Record updated successfully !..."; ;

                    return Json(CommonViewModel);
                }
                else
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    CommonViewModel.Message = "Some JSON file was not processed. Please check error log." +
                        "" + System.Environment.NewLine + (errors != null && errors.Count() > 0 ? String.Join(", ", errors.ToArray()) : "");

                    return Json(CommonViewModel);
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.Error;
            CommonViewModel.Message = ResponseStatusMessage.Error;

            return Json(CommonViewModel);
        }


        public IActionResult SyncBatch_Update(string batch_no = "")
        {
            try
            {
                string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

                DataTable dtShipperQrCodeApi = null;
                DataTable dtShipperQrCode = null;
                DataTable dtBottleQrCode = null;
                DataTable filteredDataTable = null;
                string sqlQuery = null;

                var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

                plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

                Int64 shipper_QrCode_Api_Id = 0;
                Int64 shipper_QrCode_Id = 0;
                Int64 shipper_QrCode_Id_Old = 0;
                var IsSuccess = false;

                dtShipperQrCodeApi = DataContext.ExecuteQuery_SQL($"SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, BATCH_NO" +
                    $", DATE_FORMAT(MFG_DATE, '%d/%m/%Y %H:%i:%s') AS MFG_DATE" +
                    $", DATE_FORMAT(EXPIRY_DATE, '%d/%m/%Y %H:%i:%s') AS EXPIRY_DATE" +
                    $", DATE_FORMAT(EVENTTIME, '%d/%m/%Y %H:%i:%s') AS EVENTTIME" +
                    $", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME" +
                    $", RESPONSE_STATUS, TOTAL_SHIPPER_QTY, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, MARKETEDBY, MANUFACTUREDBY " +
                    $"FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{batch_no.Trim()}'");

                if (dtShipperQrCodeApi != null && dtShipperQrCodeApi.Rows.Count > 0)
                    shipper_QrCode_Api_Id = (dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"]) : 0);

                if (shipper_QrCode_Api_Id > 0)
                {
                    try
                    {
                        IsSuccess = true;

                        var dt = DataContext.ExecuteQuery($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{batch_no.Trim()}'");

                        if (dt != null && dt.Rows.Count > 0 && (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) == 0)
                        {
                            sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
                                ", EXPIRY_DATE, EVENTTIME, PLANT_ID, CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
                                ", MARKETEDBY, MANUFACTUREDBY) " +
                                "VALUES ( " + (dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"]) : 0) + "" +
                                ", '" + (dtShipperQrCodeApi.Rows[0]["BATCH_NO"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["BATCH_NO"]) : "") + "'" +
                                ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["MFG_DATE"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["MFG_DATE"]) : 0) + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
                                ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["EXPIRY_DATE"]) : "") + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
                                ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["EVENTTIME"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["EVENTTIME"]) : "") + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
                                ", " + plant_id + ", " + (dtShipperQrCodeApi.Rows[0]["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["CREATED_BY"]) : 0) + "" +
                                ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["CREATED_DATETIME"]) : "") + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
                                ", " + (dtShipperQrCodeApi.Rows[0]["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["TOTAL_SHIPPER_QTY"]) : 0) + "" +
                                ",  '" + (dtShipperQrCodeApi.Rows[0]["MARKETEDBY"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["MARKETEDBY"]) : "") + "'" +
                                ", '" + (dtShipperQrCodeApi.Rows[0]["MANUFACTUREDBY"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["MANUFACTUREDBY"]) : "") + "' )";

                            IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);
                        }

                        if (IsSuccess == true)
                        {
                            dtShipperQrCode = DataContext.ExecuteQuery_SQL($"SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION" +
                                $", OLD_SHIPPER_QRCODE_SYSID, PALLET_QRCODE_API_SYSID" +
                                $", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME" +
                                $", CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, DATE_FORMAT(EVENTTIME, '%d/%m/%Y %H:%i:%s') AS EVENTTIME " +
                                $"FROM SHIPPER_QRCODE WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_QrCode_Api_Id} ");

                            var startIndex = 0;

                            while (startIndex < dtShipperQrCode.Rows.Count)
                            {
                                // Select the next 1000 rows using LINQ
                                DataTable nextBatch = dtShipperQrCode.AsEnumerable()
                                    .Skip(startIndex)
                                    .Take(1000)
                                    .CopyToDataTable();

                                sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

                                var sqlQuery_Select = "";

                                foreach (DataRow dr in nextBatch.Rows)
                                {
                                    if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
                                    {
                                        sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                            $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
                                            $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
                                            $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                            $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
                                            $", {(dr["SHIPPER_QRCODE_API_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_API_SYSID"]) : 0)} SHIPPER_QRCODE_API_SYSID" +
                                            $", {plant_id} PLANT_ID" +
                                            $", {(dr["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY"]) : 0)} CREATED_BY" +
                                            $", TO_DATE('" + (dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') CREATED_DATETIME" +
                                            $", TO_DATE('" + (dr["EVENTTIME"] != DBNull.Value ? Convert.ToString(dr["EVENTTIME"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') EVENTTIME " +
                                            $" FROM DUAL UNION ";
                                    }
                                }

                                if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                    sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") Z WHERE Z.SHIPPER_QRCODE NOT IN (SELECT SHIPPER_QRCODE FROM SHIPPER_QRCODE WHERE PLANT_ID = " + plant_id + " )";

                                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                if (IsSuccess == false) break;

                                startIndex += 1000;
                            }

                        }

                        if (IsSuccess == true)
                        {
                            var dtBottleQrCode_Oracle = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE_SYSID, BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE " +
                                $"FROM BOTTLE_QRCODE WHERE PLANT_ID = {plant_id} " +
                                $"AND SHIPPER_QRCODE_SYSID IN (SELECT SHIPPER_QRCODE_SYSID " +
                                            $"FROM SHIPPER_QRCODE WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_QrCode_Api_Id} ) ");

                            dtBottleQrCode = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE_SYSID, BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS" +
                                ", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME" +
                                ", QR_REQUEST_ID, QR_REQUEST_FILE_NO, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID " +
                                $"FROM BOTTLE_QRCODE WHERE PLANT_ID = {plant_id} " +
                                $"AND SHIPPER_QRCODE_SYSID IN (SELECT SHIPPER_QRCODE_SYSID " +
                                            $"FROM SHIPPER_QRCODE WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_QrCode_Api_Id} ) ");

                            var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

                            var rowsInSqlNotInOracle = from row2 in dtBottleQrCode.AsEnumerable()
                                                       join row1 in dtBottleQrCode_Oracle.AsEnumerable()
                                                       on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE"), BOTTLE_QRCODE_SYSID = Convert.ToInt64(row2.Field<Int32>("BOTTLE_QRCODE_SYSID")) }
                                                       equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE"), BOTTLE_QRCODE_SYSID = row1.Field<Int64>("BOTTLE_QRCODE_SYSID") }
                                                       into gj
                                                       from subRow in gj.DefaultIfEmpty()
                                                       where subRow == null
                                                       select row2;

                            foreach (var row in rowsInSqlNotInOracle)
                                table_RowsInSqlNotInOracle.ImportRow(row);

                            dtBottleQrCode = table_RowsInSqlNotInOracle;

                            var chunkSize = 5000;

                            var numberOfTasks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);

                            var tasks = new Task[numberOfTasks];

                            for (int i = 0; i < numberOfTasks; i++)
                            {
                                int start_Index = i * chunkSize;
                                tasks[i] = Task.Run(() =>
                                {
                                    DataTable nextBatch = dtBottleQrCode.AsEnumerable()
                                        .Skip(start_Index)
                                        .Take(chunkSize)
                                        .CopyToDataTable();

                                    sqlQuery = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

                                    var sqlQuery_Select = "";

                                    foreach (DataRow dr in nextBatch.Rows)
                                    {
                                        sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
                                            $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
                                            $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
                                            $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
                                            $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
                                            $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
                                            $", {(dr["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY"]) : 0)} CREATED_BY" +
                                            $", TO_DATE('" + (dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') CREATED_DATETIME " +
                                            $" FROM DUAL UNION ";
                                    }

                                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
                                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

                                    sqlQuery_Select = $"SELECT * FROM (" + sqlQuery_Select + ") Z ";

                                    IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

                                });
                            }

                            Task.WaitAll(tasks);


                            DataTable dtStatus = DataContext.ExecuteQuery_SQL($"SELECT FILEUPLOADNAME" +
                                $", DATE_FORMAT(STARTDATE, '%d/%m/%Y %H:%i:%s') AS STARTDATE" +
                                $", DATE_FORMAT(ENDDATE, '%d/%m/%Y %H:%i:%s') AS ENDDATE" +
                                $", QRCODECOUNT, FILESTATUS, REMARK " +
                                $"FROM SHIPPER_QR_CODE_FILE_UPLOAD_STATUS WHERE UPPER(FILESTATUS) = UPPER('Completed') AND FILEUPLOADNAME LIKE '%{batch_no.Trim()}%' ");

                            sqlQuery = "INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (PLANTCODE, FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, REMARK) ";

                            var sqlQuery_Select1 = "";

                            foreach (DataRow dr in dtStatus.Rows)
                            {
                                sqlQuery_Select1 += $"SELECT '{plantCode}' PLANTCODE" +
                                    $", '{(dr["FILEUPLOADNAME"] != DBNull.Value ? Convert.ToString(dr["FILEUPLOADNAME"]) : "")}' FILEUPLOADNAME" +
                                    $", TO_DATE('" + (dr["STARTDATE"] != DBNull.Value ? Convert.ToString(dr["STARTDATE"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') STARTDATE" +
                                    $", TO_DATE('" + (dr["ENDDATE"] != DBNull.Value ? Convert.ToString(dr["ENDDATE"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') ENDDATE " +
                                    $", {(dr["QRCODECOUNT"] != DBNull.Value ? Convert.ToInt64(dr["QRCODECOUNT"]) : 0)} QRCODECOUNT" +
                                    $", '{(dr["FILESTATUS"] != DBNull.Value ? Convert.ToString(dr["FILESTATUS"]) : "")}' FILESTATUS" +
                                    $", SUBSTR('{(dr["REMARK"] != DBNull.Value ? Convert.ToString(dr["REMARK"]) : "")}', 0, 3999) REMARK " +
                                    $" FROM DUAL UNION ";
                            }

                            if (!string.IsNullOrEmpty(sqlQuery_Select1) && sqlQuery_Select1.Contains("DUAL UNION"))
                                sqlQuery_Select1 = sqlQuery_Select1.Substring(0, (sqlQuery_Select1.Length - (sqlQuery_Select1.Length - sqlQuery_Select1.LastIndexOf("UNION"))));

                            sqlQuery_Select1 = "SELECT * FROM (" + sqlQuery_Select1 + ") Z " +
                                "WHERE (Z.PLANTCODE, Z.FILEUPLOADNAME, Z.STARTDATE, Z.ENDDATE, Z.QRCODECOUNT, UPPER(Z.FILESTATUS), Z.REMARK) " +
                                "NOT IN (SELECT PLANTCODE, FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, UPPER(FILESTATUS) FILESTATUS, REMARK " +
                                            $"FROM SHIPPER_QR_CODE_FILE_UPLOAD_STATUS WHERE PLANTCODE = '{plantCode}' ) ";

                            IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select1);

                        }
                    }
                    catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "Check Batch (" + batch_no.Trim() + ") data into Oracle.", ex); }

                    LogService.LogInsert(GetCurrentAction(), "Check Batch (" + batch_no.Trim() + ") data into Oracle.", null);
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "Sync Batch Update - " + batch_no.Trim(), ex); }

            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.Error;
            CommonViewModel.Message = ResponseStatusMessage.Error;

            return Json(CommonViewModel);
        }

        //public IActionResult SyncBatch_Update(string batch_no = "")
        //{
        //    try
        //    {
        //        string plantCode = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("PlantCode").Value ?? "");

        //        DataTable dtShipperQrCodeApi = null;
        //        DataTable dtShipperQrCode = null;
        //        DataTable dtBottleQrCode = null;
        //        DataTable filteredDataTable = null;
        //        string sqlQuery = null;

        //        var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

        //        plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

        //        Int64 shipper_QrCode_Api_Id = 0;
        //        Int64 shipper_QrCode_Id = 0;
        //        Int64 shipper_QrCode_Id_Old = 0;
        //        var IsSuccess = false;

        //        dtShipperQrCodeApi = DataContext.ExecuteQuery_SQL($"SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, BATCH_NO" +
        //            $", DATE_FORMAT(MFG_DATE, '%d/%m/%Y %H:%i:%s') AS MFG_DATE" +
        //            $", DATE_FORMAT(EXPIRY_DATE, '%d/%m/%Y %H:%i:%s') AS EXPIRY_DATE" +
        //            $", DATE_FORMAT(EVENTTIME, '%d/%m/%Y %H:%i:%s') AS EVENTTIME" +
        //            $", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME" +
        //            $", RESPONSE_STATUS, TOTAL_SHIPPER_QTY, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, MARKETEDBY, MANUFACTUREDBY " +
        //            $"FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{batch_no}'");

        //        if (dtShipperQrCodeApi != null && dtShipperQrCodeApi.Rows.Count > 0)
        //            shipper_QrCode_Api_Id = (dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"]) : 0);

        //        if (shipper_QrCode_Api_Id > 0)
        //        {
        //            try
        //            {
        //                var dt = DataContext.ExecuteQuery($"SELECT COUNT(*) FROM SHIPPER_QRCODE_API WHERE PLANT_ID = {plant_id} AND BATCH_NO = '{batch_no}'");

        //                if (dt != null && (dt.Rows.Count == 0 || (dt.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dt.Rows[0][0]) : 0) == 0))
        //                {
        //                    sqlQuery = "INSERT INTO SHIPPER_QRCODE_API (SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE" +
        //                        ", EXPIRY_DATE, EVENTTIME, PLANT_ID, CREATED_BY, CREATED_DATETIME,  TOTAL_SHIPPER_QTY" +
        //                        ", MARKETEDBY, MANUFACTUREDBY) " +
        //                        "VALUES ( " + (dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["SHIPPER_QRCODE_API_SYSID"]) : 0) + "" +
        //                        ", '" + (dtShipperQrCodeApi.Rows[0]["BATCH_NO"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["BATCH_NO"]) : "") + "'" +
        //                        ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["MFG_DATE"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["MFG_DATE"]) : 0) + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
        //                        ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["EXPIRY_DATE"]) : "") + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
        //                        ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["EVENTTIME"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["EVENTTIME"]) : "") + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
        //                        ", " + plant_id + ", " + (dtShipperQrCodeApi.Rows[0]["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["CREATED_BY"]) : 0) + "" +
        //                        ", TO_DATE(REPLACE('" + (dtShipperQrCodeApi.Rows[0]["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["CREATED_DATETIME"]) : "") + "', '-', '/'), 'DD/MM/YYYY HH24:MI:SS')" +
        //                        ", " + (dtShipperQrCodeApi.Rows[0]["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToInt64(dtShipperQrCodeApi.Rows[0]["TOTAL_SHIPPER_QTY"]) : 0) + "" +
        //                        ",  '" + (dtShipperQrCodeApi.Rows[0]["MARKETEDBY"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["MARKETEDBY"]) : "") + "'" +
        //                        ", '" + (dtShipperQrCodeApi.Rows[0]["MANUFACTUREDBY"] != DBNull.Value ? Convert.ToString(dtShipperQrCodeApi.Rows[0]["MANUFACTUREDBY"]) : "") + "' )";

        //                    IsSuccess = DataContext.ExecuteNonQuery(sqlQuery);
        //                }

        //                dtShipperQrCode = DataContext.ExecuteQuery_SQL($"SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION" +
        //                    $", OLD_SHIPPER_QRCODE_SYSID, PALLET_QRCODE_API_SYSID" +
        //                    $", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME" +
        //                    $", CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, DATE_FORMAT(EVENTTIME, '%d/%m/%Y %H:%i:%s') AS EVENTTIME " +
        //                    $"FROM SHIPPER_QRCODE WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_QrCode_Api_Id} ");

        //                var startIndex = 0;

        //                while (startIndex < dtShipperQrCode.Rows.Count)
        //                {
        //                    // Select the next 1000 rows using LINQ
        //                    DataTable nextBatch = dtShipperQrCode.AsEnumerable()
        //                        .Skip(startIndex)
        //                        .Take(1000)
        //                        .CopyToDataTable();

        //                    sqlQuery = "INSERT INTO SHIPPER_QRCODE (SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, TOTAL_BOTTLES_QTY, STATUS, ACTION, SHIPPER_QRCODE_API_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME, EVENTTIME) ";

        //                    var sqlQuery_Select = "";

        //                    foreach (DataRow dr in nextBatch.Rows)
        //                    {
        //                        if ((dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0) > 0)
        //                        {
        //                            sqlQuery_Select += $"SELECT {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
        //                                $", '{(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "")}' SHIPPER_QRCODE" +
        //                                $", {(dr["TOTAL_BOTTLES_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_BOTTLES_QTY"]) : 0)} TOTAL_BOTTLES_QTY" +
        //                                $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
        //                                $", '{(dr["ACTION"] != DBNull.Value ? Convert.ToString(dr["ACTION"]) : "")}' ACTION" +
        //                                $", {(dr["SHIPPER_QRCODE_API_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_API_SYSID"]) : 0)} SHIPPER_QRCODE_API_SYSID" +
        //                                $", {plant_id} PLANT_ID" +
        //                                $", {(dr["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY"]) : 0)} CREATED_BY" +
        //                                $", TO_DATE('" + (dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') CREATED_DATETIME" +
        //                                $", TO_DATE('" + (dr["EVENTTIME"] != DBNull.Value ? Convert.ToString(dr["EVENTTIME"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') EVENTTIME " +
        //                                $" FROM DUAL UNION ";
        //                        }
        //                    }

        //                    if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //                        sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //                    sqlQuery_Select = "SELECT * FROM (" + sqlQuery_Select + ") Z WHERE Z.SHIPPER_QRCODE NOT IN (SELECT SHIPPER_QRCODE FROM SHIPPER_QRCODE WHERE PLANT_ID = " + plant_id + " )";

        //                    IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

        //                    startIndex += 1000;
        //                }


        //                var dtBottleQrCode_Oracle = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE_SYSID, BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE " +
        //                    $"FROM BOTTLE_QRCODE WHERE PLANT_ID = {plant_id} " +
        //                    $"AND SHIPPER_QRCODE_SYSID IN (SELECT SHIPPER_QRCODE_SYSID " +
        //                                $"FROM SHIPPER_QRCODE WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_QrCode_Api_Id} ) ");

        //                dtBottleQrCode = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE_SYSID, BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS" +
        //                    ", CREATED_BY, DATE_FORMAT(CREATED_DATETIME, '%d/%m/%Y %H:%i:%s') AS CREATED_DATETIME" +
        //                    ", QR_REQUEST_ID, QR_REQUEST_FILE_NO, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID " +
        //                    $"FROM BOTTLE_QRCODE WHERE PLANT_ID = {plant_id} " +
        //                    $"AND SHIPPER_QRCODE_SYSID IN (SELECT SHIPPER_QRCODE_SYSID " +
        //                                $"FROM SHIPPER_QRCODE WHERE PLANT_ID = {plant_id} AND SHIPPER_QRCODE_API_SYSID = {shipper_QrCode_Api_Id} ) ");

        //                var table_RowsInSqlNotInOracle = dtBottleQrCode.Clone();

        //                var rowsInSqlNotInOracle = from row2 in dtBottleQrCode.AsEnumerable()
        //                                           join row1 in dtBottleQrCode_Oracle.AsEnumerable()
        //                                           on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE"), BOTTLE_QRCODE_SYSID = Convert.ToInt64(row2.Field<Int32>("BOTTLE_QRCODE_SYSID")) }
        //                                           equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE"), BOTTLE_QRCODE_SYSID = row1.Field<Int64>("BOTTLE_QRCODE_SYSID") }
        //                                           into gj
        //                                           from subRow in gj.DefaultIfEmpty()
        //                                           where subRow == null
        //                                           select row2;

        //                foreach (var row in rowsInSqlNotInOracle)
        //                    table_RowsInSqlNotInOracle.ImportRow(row);

        //                dtBottleQrCode = table_RowsInSqlNotInOracle;

        //                var chunkSize = 5000;

        //                var numberOfTasks = (int)Math.Ceiling((double)dtBottleQrCode.Rows.Count / chunkSize);

        //                var tasks = new Task[numberOfTasks];

        //                for (int i = 0; i < numberOfTasks; i++)
        //                {
        //                    int start_Index = i * chunkSize;
        //                    tasks[i] = Task.Run(() =>
        //                    {
        //                        DataTable nextBatch = dtBottleQrCode.AsEnumerable()
        //                            .Skip(start_Index)
        //                            .Take(chunkSize)
        //                            .CopyToDataTable();

        //                        sqlQuery = "INSERT INTO BOTTLE_QRCODE (BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, SHIPPER_QRCODE_SYSID, PLANT_ID, CREATED_BY, CREATED_DATETIME) ";

        //                        var sqlQuery_Select = "";

        //                        foreach (DataRow dr in nextBatch.Rows)
        //                        {
        //                            sqlQuery_Select += $"SELECT {(dr["BOTTLE_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["BOTTLE_QRCODE_SYSID"]) : 0)} BOTTLE_QRCODE_SYSID" +
        //                                $", '{(dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : "")}' BOTTLE_QRCODE" +
        //                                $", {(dr["PRODUCT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PRODUCT_ID"]) : 0)} PRODUCT_ID" +
        //                                $", '{(dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "")}' STATUS" +
        //                                $", {(dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0)} SHIPPER_QRCODE_SYSID" +
        //                                $", {(dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0)} PLANT_ID" +
        //                                $", {(dr["CREATED_BY"] != DBNull.Value ? Convert.ToInt64(dr["CREATED_BY"]) : 0)} CREATED_BY" +
        //                                $", TO_DATE('" + (dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') CREATED_DATETIME " +
        //                                $" FROM DUAL UNION ";
        //                        }

        //                        if (!string.IsNullOrEmpty(sqlQuery_Select) && sqlQuery_Select.Contains("DUAL UNION"))
        //                            sqlQuery_Select = sqlQuery_Select.Substring(0, (sqlQuery_Select.Length - (sqlQuery_Select.Length - sqlQuery_Select.LastIndexOf("UNION"))));

        //                        sqlQuery_Select = $"SELECT * FROM (" + sqlQuery_Select + ") Z ";

        //                        IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select);

        //                    });
        //                }

        //                Task.WaitAll(tasks);


        //                DataTable dtStatus = DataContext.ExecuteQuery_SQL($"SELECT FILEUPLOADNAME" +
        //                    $", DATE_FORMAT(STARTDATE, '%d/%m/%Y %H:%i:%s') AS STARTDATE" +
        //                    $", DATE_FORMAT(ENDDATE, '%d/%m/%Y %H:%i:%s') AS ENDDATE" +
        //                    $", QRCODECOUNT, FILESTATUS, REMARK " +
        //                    $"FROM SHIPPER_QR_CODE_FILE_UPLOAD_STATUS WHERE UPPER(FILESTATUS) = UPPER('Completed') AND FILEUPLOADNAME LIKE '%{batch_no}%' ");

        //                sqlQuery = "INSERT INTO SHIPPER_QR_CODE_FILE_UPLOAD_STATUS (PLANTCODE, FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, FILESTATUS, REMARK) ";

        //                var sqlQuery_Select1 = "";

        //                foreach (DataRow dr in dtStatus.Rows)
        //                {
        //                    sqlQuery_Select1 += $"SELECT '{plantCode}' PLANTCODE" +
        //                        $", '{(dr["FILEUPLOADNAME"] != DBNull.Value ? Convert.ToString(dr["FILEUPLOADNAME"]) : "")}' FILEUPLOADNAME" +
        //                        $", TO_DATE('" + (dr["STARTDATE"] != DBNull.Value ? Convert.ToString(dr["STARTDATE"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') STARTDATE" +
        //                        $", TO_DATE('" + (dr["ENDDATE"] != DBNull.Value ? Convert.ToString(dr["ENDDATE"]) : "") + "', 'DD/MM/YYYY HH24:MI:SS') ENDDATE " +
        //                        $", {(dr["QRCODECOUNT"] != DBNull.Value ? Convert.ToInt64(dr["QRCODECOUNT"]) : 0)} QRCODECOUNT" +
        //                        $", '{(dr["FILESTATUS"] != DBNull.Value ? Convert.ToString(dr["FILESTATUS"]) : "")}' FILESTATUS" +
        //                        $", SUBSTR('{(dr["REMARK"] != DBNull.Value ? Convert.ToString(dr["REMARK"]) : "")}', 0, 3999) REMARK " +
        //                        $" FROM DUAL UNION ";
        //                }

        //                if (!string.IsNullOrEmpty(sqlQuery_Select1) && sqlQuery_Select1.Contains("DUAL UNION"))
        //                    sqlQuery_Select1 = sqlQuery_Select1.Substring(0, (sqlQuery_Select1.Length - (sqlQuery_Select1.Length - sqlQuery_Select1.LastIndexOf("UNION"))));

        //                sqlQuery_Select1 = "SELECT * FROM (" + sqlQuery_Select1 + ") Z " +
        //                    "WHERE (Z.PLANTCODE, Z.FILEUPLOADNAME, Z.STARTDATE, Z.ENDDATE, Z.QRCODECOUNT, UPPER(Z.FILESTATUS), Z.REMARK) " +
        //                    "NOT IN (SELECT PLANTCODE, FILEUPLOADNAME, STARTDATE, ENDDATE, QRCODECOUNT, UPPER(FILESTATUS) FILESTATUS, REMARK " +
        //                                $"FROM SHIPPER_QR_CODE_FILE_UPLOAD_STATUS WHERE PLANTCODE = '{plantCode}' ) ";

        //                IsSuccess = DataContext.ExecuteNonQuery(sqlQuery + sqlQuery_Select1);

        //            }
        //            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "Check Batch (" + batch_no + ") data into Oracle.", ex); }

        //        }

        //    }
        //    catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "Sync Batch Update - " + batch_no, ex); }

        //    CommonViewModel.IsSuccess = false;
        //    CommonViewModel.StatusCode = ResponseStatusCode.Error;
        //    CommonViewModel.Message = ResponseStatusMessage.Error;

        //    return Json(CommonViewModel);
        //}


        public IActionResult SyncInvoice(string gateIds = null)
        {
            var plant_id = Common.Get_Session_Int(SessionKey.PLANT_ID);

            plant_id = plant_id <= 0 ? AppHttpContextAccessor.PlantId : plant_id;

            var strQuery = @$"SELECT DISTINCT MDAInvQr_SYS_ID, GATE_SYS_ID, MDA_SYS_ID, MDA_NO, INVOICEQrCODE, BASE64InvQrCode
								FROM mda_invoice_qr X
								WHERE X.PLANT_ID = {plant_id}
								AND X.GATE_SYS_ID IN (" + gateIds + ") ";

            DataTable dt = DataContext.ExecuteQuery_SQL(strQuery);

            if (dt != null && dt.Rows.Count > 0)
            {
                var client = new HttpClient();

                foreach (DataRow dr in dt.Rows)
                {
                    string MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "";

                    var invoiceNo = dr["INVOICEQrCODE"] != DBNull.Value ? Convert.ToString(dr["INVOICEQrCODE"]) : "";

                    string base64String = dr["BASE64InvQrCode"] != DBNull.Value ? Convert.ToString(dr["BASE64InvQrCode"]) : "";

                    var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

                    StringContent? content = new StringContent("{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31004\"" +
                        ",\"inParameters\" : [{ \"label\" : \"mdaNo\", \"value\" : \"" + MDA_No.ToUpper() + "\" }" +
                                            ",{ \"label\" : \"invoiceQrCode\", \"value\" : \"" + invoiceNo.ToUpper() + "\" }" +
                                            ",{ \"label\" : \"base64InvQrCode\", \"value\" : \"" + base64String + "\" }" +
                                            "]}\n\n", null, "application/json");

                    request.Content = content;

                    request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

                    var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                    if (responseBody.IsSuccessStatusCode)
                    {
                        var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    }

                    //var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

                    //StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"31004\"" +
                    //	",\"mdaNo\" : \"" + MDA_No.ToUpper() + "\",\"invoiceQrCode\" : \"" + invoiceNo + "\"" +
                    //	",\"base64InvQrCode\" : \"" + base64String + "\"}", null, "application/json");

                    //request.Content = content;

                    //var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

                    //if (responseBody.IsSuccessStatusCode)
                    //{
                    //	var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

                    //	if (!string.IsNullOrEmpty(responseContent) && responseContent.Contains("PostNanoMDAInvoiceQR"))
                    //	{

                    //	}
                    //}

                    Thread.Sleep(1000);

                }

            }

            return null;
        }



        public IActionResult Analyze_Shipper(string tableName, int PlantId, int type = 0)
        {
            DataTable dtSql = null;
            DataTable dtOracle = null;
            DataTable table_RowsInOracleAndSql = null;
            DataTable table_RowsInOracleNotInSql = null;
            DataTable table_RowsInSqlNotInOracle = null;

            dynamic resultObject = new ExpandoObject();

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SHIPPER_QRCODE_API")
            {
                dtOracle = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE, EXPIRY_DATE, EVENTTIME" +
                ", CREATED_BY, CREATED_DATETIME, RESPONSE_STATUS, TOTAL_SHIPPER_QTY, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, MARKETEDBY, MANUFACTUREDBY " +
                "FROM SHIPPER_QRCODE_API WHERE PLANT_ID = " + PlantId);

                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, BATCH_NO, MFG_DATE, EXPIRY_DATE, EVENTTIME" +
                    ", CREATED_BY, CREATED_DATETIME, RESPONSE_STATUS, TOTAL_SHIPPER_QTY, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, MARKETEDBY, MANUFACTUREDBY " +
                    "FROM SHIPPER_QRCODE_API WHERE PLANT_ID = " + PlantId);

                if (type == 0)
                {
                    table_RowsInOracleAndSql = dtOracle.Clone();

                    var rowsInOracleAndSql = from row1 in dtOracle.AsEnumerable()
                                             join row2 in dtSql.AsEnumerable()
                                             on new { BATCH_NO = row1.Field<string>("BATCH_NO") }
                                             equals new { BATCH_NO = row2.Field<string>("BATCH_NO") }
                                             select row1;

                    foreach (var row in rowsInOracleAndSql)
                        table_RowsInOracleAndSql.ImportRow(row);
                }

                if (type < 0 || type == 1)
                {
                    table_RowsInOracleNotInSql = dtOracle.Clone();

                    var rowsInOracleNotInSql = from row1 in dtOracle.AsEnumerable()
                                               where !dtSql.AsEnumerable().Any(row2 => row2.Field<string>("BATCH_NO") == row1.Field<string>("BATCH_NO"))
                                               select row1;

                    foreach (var row in rowsInOracleNotInSql)
                        table_RowsInOracleNotInSql.ImportRow(row);
                }

                if (type < 0 || type == 2)
                {
                    table_RowsInSqlNotInOracle = dtOracle.Clone();

                    var rowsInSqlNotInOracle = from row2 in dtSql.AsEnumerable()
                                               where !dtOracle.AsEnumerable().Any(row1 => row1.Field<string>("BATCH_NO") == row2.Field<string>("BATCH_NO"))
                                               select row2;

                    foreach (var row in rowsInSqlNotInOracle)
                        table_RowsInSqlNotInOracle.ImportRow(row);
                }

                resultObject.Shipper_QrCode_API_BatchNo_in_Oracle_and_Sql_Count = (table_RowsInOracleAndSql != null && table_RowsInOracleAndSql.Rows.Count > 0) ? table_RowsInOracleAndSql.Rows.Count : 0;

                resultObject.Shipper_QrCode_API_BatchNo_in_Oracle_Not_in_Sql_Count = (table_RowsInOracleNotInSql != null && table_RowsInOracleNotInSql.Rows.Count > 0) ? table_RowsInOracleNotInSql.Rows.Count : 0;

                resultObject.Shipper_QrCode_API_BatchNo_in_Sql_Not_in_Oracle_Count = (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0) ? table_RowsInSqlNotInOracle.Rows.Count : 0;

                resultObject.Test_1 = "[]";

                if (table_RowsInOracleAndSql != null && table_RowsInOracleAndSql.Rows.Count > 0)
                    resultObject.Shipper_QrCode_API_BatchNo_in_Oracle_and_Sql = string.Join(", ", table_RowsInOracleAndSql.AsEnumerable().Select(row => "'" + row["BATCH_NO"] + "'").ToList());

                resultObject.Test_2 = "[]";

                if (table_RowsInOracleNotInSql != null && table_RowsInOracleNotInSql.Rows.Count > 0)
                    resultObject.Shipper_QrCode_API_BatchNo_in_Oracle_Not_in_Sql = string.Join(", ", table_RowsInOracleNotInSql.AsEnumerable().Select(row => "'" + row["BATCH_NO"] + "'").ToList());

                resultObject.Test_3 = "[]";

                if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                    resultObject.Shipper_QrCode_API_BatchNo_in_Sql_Not_in_Oracle = string.Join(", ", table_RowsInSqlNotInOracle.AsEnumerable().Select(row => "'" + row["BATCH_NO"] + "'").ToList());

                resultObject.Test_4 = "[]";
            }

            if (string.IsNullOrEmpty(tableName) || tableName.ToUpper() == "SHIPPER_QRCODE")
            {
                resultObject.Test_5 = "[]";

                dtOracle = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, STATUS, ACTION, TOTAL_BOTTLES_QTY" +
                    ", OLD_SHIPPER_QRCODE_SYSID, PALLET_QRCODE_API_SYSID, CREATED_BY, CREATED_DATETIME, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, EVENTTIME " +
                "FROM SHIPPER_QRCODE WHERE PLANT_ID = " + PlantId);

                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE_API_SYSID, SHIPPER_QRCODE_SYSID, SHIPPER_QRCODE, STATUS, ACTION, TOTAL_BOTTLES_QTY" +
                    ", OLD_SHIPPER_QRCODE_SYSID, PALLET_QRCODE_API_SYSID, CREATED_BY, CREATED_DATETIME, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID, EVENTTIME " +
                    "FROM SHIPPER_QRCODE WHERE PLANT_ID = " + PlantId);

                if (type == 0)
                {
                    table_RowsInOracleAndSql = dtOracle.Clone();

                    var rowsInOracleAndSql = from row1 in dtOracle.AsEnumerable()
                                             join row2 in dtSql.AsEnumerable()
                                             on new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE"), ACTION = row1.Field<string>("ACTION") }
                                             equals new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE"), ACTION = row2.Field<string>("ACTION") }
                                             select row1;

                    foreach (var row in rowsInOracleAndSql)
                        table_RowsInOracleAndSql.ImportRow(row);
                }

                if (type < 0 || type == 1)
                {
                    table_RowsInOracleNotInSql = dtOracle.Clone();

                    var rowsInOracleNotInSql = from row1 in dtOracle.AsEnumerable()
                                               join row2 in dtSql.AsEnumerable()
                                               on new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE"), ACTION = row1.Field<string>("ACTION") }
                                               equals new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE"), ACTION = row2.Field<string>("ACTION") }
                                               into gj
                                               from subRow in gj.DefaultIfEmpty()
                                               where subRow == null
                                               select row1;

                    foreach (var row in rowsInOracleNotInSql)
                        table_RowsInOracleNotInSql.ImportRow(row);
                }

                if (type < 0 || type == 2)
                {
                    table_RowsInSqlNotInOracle = dtOracle.Clone();

                    var rowsInSqlNotInOracle = from row2 in dtSql.AsEnumerable()
                                               join row1 in dtOracle.AsEnumerable()
                                               on new { SHIPPER_QRCODE = row2.Field<string>("SHIPPER_QRCODE"), ACTION = row2.Field<string>("ACTION") }
                                               equals new { SHIPPER_QRCODE = row1.Field<string>("SHIPPER_QRCODE"), ACTION = row1.Field<string>("ACTION") }
                                               into gj
                                               from subRow in gj.DefaultIfEmpty()
                                               where subRow == null
                                               select row2;

                    foreach (var row in rowsInSqlNotInOracle)
                        table_RowsInSqlNotInOracle.ImportRow(row);
                }

                resultObject.Shipper_QrCode_in_Oracle_and_Sql_Count = (table_RowsInOracleAndSql != null && table_RowsInOracleAndSql.Rows.Count > 0) ? table_RowsInOracleAndSql.Rows.Count : 0;

                resultObject.Shipper_QrCode_in_Oracle_Not_in_Sql_Count = (table_RowsInOracleNotInSql != null && table_RowsInOracleNotInSql.Rows.Count > 0) ? table_RowsInOracleNotInSql.Rows.Count : 0;

                resultObject.Shipper_QrCode_in_Sql_Not_in_Oracle_Count = (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0) ? table_RowsInSqlNotInOracle.Rows.Count : 0;

                resultObject.Test_6 = "[]";

                if (table_RowsInOracleAndSql != null && table_RowsInOracleAndSql.Rows.Count > 0)
                    resultObject.Shipper_QrCode_in_Oracle_and_Sql = string.Join(", ", table_RowsInOracleAndSql.AsEnumerable().Select(row => "('" + row["SHIPPER_QRCODE"] + "','" + row["ACTION"] + "')").ToList());

                resultObject.Test_7 = "[]";

                if (table_RowsInOracleNotInSql != null && table_RowsInOracleNotInSql.Rows.Count > 0)
                    resultObject.Shipper_QrCode_in_Oracle_Not_in_Sql = string.Join(", ", table_RowsInOracleNotInSql.AsEnumerable().Select(row => "('" + row["SHIPPER_QRCODE"] + "','" + row["ACTION"] + "')").ToList());

                resultObject.Test_8 = "[]";

                if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                    resultObject.Shipper_QrCode_in_Sql_Not_in_Oracle = string.Join(", ", table_RowsInSqlNotInOracle.AsEnumerable().Select(row => "('" + row["SHIPPER_QRCODE"] + "','" + row["ACTION"] + "')").ToList());

                resultObject.Test_9 = "[]";
            }


            if (!string.IsNullOrEmpty(tableName) && tableName.ToUpper() == "BOTTLE_QRCODE")
            {
                resultObject.Test_10 = "[]";

                dtOracle = DataContext.ExecuteQuery("SELECT PLANT_ID, SHIPPER_QRCODE_SYSID, BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, CREATED_BY, CREATED_DATETIME" +
                    ", QR_REQUEST_ID, QR_REQUEST_FILE_NO, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID " +
                "FROM BOTTLE_QRCODE WHERE PLANT_ID = " + PlantId);

                dtSql = DataContext.ExecuteQuery_SQL("SELECT PLANT_ID, SHIPPER_QRCODE_SYSID, BOTTLE_QRCODE_SYSID, BOTTLE_QRCODE, PRODUCT_ID, STATUS, CREATED_BY, CREATED_DATETIME" +
                    ", QR_REQUEST_ID, QR_REQUEST_FILE_NO, CURRENT_HOLDER_TYPE, CURRENT_HOLDER_SYS_ID " +
                    "FROM BOTTLE_QRCODE WHERE PLANT_ID = " + PlantId);

                if (type == 0)
                {
                    table_RowsInOracleAndSql = dtOracle.Clone();

                    var rowsInOracleAndSql = from row1 in dtOracle.AsEnumerable()
                                             join row2 in dtSql.AsEnumerable()
                                             on new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                             equals new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                             select row1;

                    foreach (var row in rowsInOracleAndSql)
                        table_RowsInOracleAndSql.ImportRow(row);
                }

                if (type < 0 || type == 1)
                {
                    table_RowsInOracleNotInSql = dtOracle.Clone();

                    var rowsInOracleNotInSql = from row1 in dtOracle.AsEnumerable()
                                               join row2 in dtSql.AsEnumerable()
                                               on new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                               equals new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                               into gj
                                               from subRow in gj.DefaultIfEmpty()
                                               where subRow == null
                                               select row1;

                    foreach (var row in rowsInOracleNotInSql)
                        table_RowsInOracleNotInSql.ImportRow(row);
                }

                if (type < 0 || type == 2)
                {
                    table_RowsInSqlNotInOracle = dtOracle.Clone();

                    var rowsInSqlNotInOracle = from row2 in dtSql.AsEnumerable()
                                               join row1 in dtOracle.AsEnumerable()
                                               on new { BOTTLE_QRCODE = row2.Field<string>("BOTTLE_QRCODE") }
                                               equals new { BOTTLE_QRCODE = row1.Field<string>("BOTTLE_QRCODE") }
                                               into gj
                                               from subRow in gj.DefaultIfEmpty()
                                               where subRow == null
                                               select row2;

                    foreach (var row in rowsInSqlNotInOracle)
                        table_RowsInSqlNotInOracle.ImportRow(row);
                }

                resultObject.Bottle_QrCode_in_Oracle_and_Sql_Count = (table_RowsInOracleAndSql != null && table_RowsInOracleAndSql.Rows.Count > 0) ? table_RowsInOracleAndSql.Rows.Count : 0;

                resultObject.Bottle_QrCode_in_Oracle_Not_in_Sql_Count = (table_RowsInOracleNotInSql != null && table_RowsInOracleNotInSql.Rows.Count > 0) ? table_RowsInOracleNotInSql.Rows.Count : 0;

                resultObject.Bottle_QrCode_in_Sql_Not_in_Oracle_Count = (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0) ? table_RowsInSqlNotInOracle.Rows.Count : 0;

                resultObject.Test_11 = "[]";

                if (table_RowsInOracleAndSql != null && table_RowsInOracleAndSql.Rows.Count > 0)
                    resultObject.Bottle_QrCode_in_Oracle_and_Sql = string.Join(", ", table_RowsInOracleAndSql.AsEnumerable().Select(row => "'" + row["BOTTLE_QRCODE"] + "'").ToList());

                resultObject.Test_12 = "[]";

                if (table_RowsInOracleNotInSql != null && table_RowsInOracleNotInSql.Rows.Count > 0)
                    resultObject.Bottle_QrCode_in_Oracle_Not_in_Sql = string.Join(", ", table_RowsInOracleNotInSql.AsEnumerable().Select(row => "'" + row["BOTTLE_QRCODE"] + "'").ToList());

                resultObject.Test_13 = "[]";

                if (table_RowsInSqlNotInOracle != null && table_RowsInSqlNotInOracle.Rows.Count > 0)
                    resultObject.Bottle_QrCode_in_Sql_Not_in_Oracle = string.Join(", ", table_RowsInSqlNotInOracle.AsEnumerable().Select(row => "'" + row["BOTTLE_QRCODE"] + "'").ToList());

            }


            return Ok(JsonConvert.SerializeObject(resultObject));
        }


        public IActionResult Send_ErrorLogFile(string FromDate)
        {
            var result = new List<User_Log>();

            if (FromDate == null)
            {
                FromDate = DateTime.Now.AddDays(-2).ToString("dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture);
            }

            DataTable dt = new DataTable();

            try
            {
                var oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_FROM_DATE", MySqlDbType.String) { Value = FromDate ?? "" });

                dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_REPORT_LOG_SERVICE_FILE", oParams);

                if (dt != null && dt.Rows.Count > 1)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        var obj = new User_Log()
                        {
                            USER_LOG_SYS_ID = dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "",
                            REMARK = dr["MESSAGE"] != DBNull.Value ? Convert.ToString(dr["MESSAGE"]) : "",
                            Created_DateTime = dr["CREATED_DATE"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATE"]) : "",
                        };

                        result.Add(obj);
                    }

                    string projectRootPath = Directory.GetCurrentDirectory();
                    string wwwRootPath = Path.Combine(projectRootPath, "wwwroot");
                    string pdfDirectory = Path.Combine(wwwRootPath, "ErrorLogFiles");

                    try
                    {
                        string[] files = Directory.GetFiles(pdfDirectory);

                        if (files != null)
                        {
                            foreach (var file in files)
                            {
                                System.IO.File.Delete(file);
                            }
                        }
                    }
                    catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


                    // Ensure the directory exists
                    if (!Directory.Exists(pdfDirectory))
                    {
                        Directory.CreateDirectory(pdfDirectory);
                    }

                    string pdfPath = Path.Combine(pdfDirectory, "ErrorLogList_" + DateTime.Now.Ticks + ".pdf");
                    GeneratePDF(result, pdfPath);
                    SendEmailWithAttachment(pdfPath);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = true;
                    CommonViewModel.StatusCode = ResponseStatusCode.Success;
                    CommonViewModel.Message = "File sent successfully !...";

                    return Json(CommonViewModel);
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.Error;
            CommonViewModel.Message = "No Data Found !...";

            return Json(CommonViewModel);
        }

        public static void GeneratePDF(List<User_Log> users, string outputPath)
        {
            // Create a new PDF document
            Document document = new Document(PageSize.A4.Rotate());
            PdfWriter.GetInstance(document, new FileStream(outputPath, FileMode.Create));
            document.Open();

            // Add title
            document.Add(new Paragraph("Error Log List"));
            document.Add(new Paragraph("\n"));

            // Create a table with three columns
            PdfPTable table = new PdfPTable(3);

            float[] columnWidths = { 0.5f, 3.8f, 1.2f }; // Adjust these values to your needs
            table.SetWidths(columnWidths);

            table.AddCell("ID");
            table.AddCell("Message");
            table.AddCell("Date");

            // Add rows to the table
            foreach (var user in users)
            {
                table.AddCell(user.USER_LOG_SYS_ID);
                table.AddCell(user.REMARK);
                table.AddCell(user.Created_DateTime);
            }

            // Add table to the document
            document.Add(table);

            // Close the document
            document.Close();
        }

        public static void SendEmailWithAttachment(string attachmentPath)
        {
            // Email credentials
            string toEmail = "hpadhyasoft@gmail.com";
            string subject = "Error Log data file";
            string body = "Please find the attached Error Log List PDF.";
            string fromEmail = "hpadhyasoft@gmail.com";
            string password = "arhwbjepxxmqthss";

            // SMTP settings
            SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587)
            {
                Credentials = new NetworkCredential(fromEmail, password),
                EnableSsl = true
            };

            // Create the email
            MailMessage mailMessage = new MailMessage
            {
                From = new MailAddress(fromEmail),
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            };
            mailMessage.To.Add(toEmail);

            // Attach the PDF file
            Attachment attachment = new Attachment(attachmentPath);
            mailMessage.Attachments.Add(attachment);

            // Send the email
            smtpClient.Send(mailMessage);
        }


        public async Task<IActionResult> SendEmail_BatchLog(string BatchNo = null, string FromDate = null, string ToDate = null)
        {
            FromDate = string.IsNullOrEmpty(FromDate) ? DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/") :
                DateTime.ParseExact(FromDate, "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/");

            ToDate = string.IsNullOrEmpty(ToDate) ? DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/") :
                DateTime.ParseExact(ToDate, "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/");

            var url = AppHttpContextAccessor.AppBaseUrl + $"/Dispatch/Reports/GetData_BatchLogFile?searchTerm={BatchNo}&FromDate={FromDate}&ToDate={ToDate}&isPrint=true";

            List<(byte[] fileData, MemoryStream contentStream, string contentType, string? fileDownloadName)> list = new();

            using (HttpClient client = new HttpClient())
            {
                if (!string.IsNullOrEmpty(url))
                    url = HttpUtility.UrlDecode(url);

                //byte[] fileData = Task.Run(() => client.GetByteArrayAsync(url)).Result;

                var browserFetcher = new BrowserFetcher();
                await browserFetcher.DownloadAsync();

                using var browser = await Puppeteer.LaunchAsync(new LaunchOptions { Headless = true, Args = new[] { "--no-sandbox", "--disable-setuid-sandbox" } });
                using var page = await browser.NewPageAsync();
                await page.GoToAsync(url, WaitUntilNavigation.Networkidle0);
                await page.EvaluateExpressionHandleAsync("document.fonts.ready");
                byte[] fileData = await page.PdfDataAsync();

                if (fileData != null && fileData.Length > 0)
                {
                    (byte[] fileData, MemoryStream contentStream, string contentType, string? fileDownloadName) obj = new();

                    obj.fileData = fileData;

                    using (MemoryStream memoryStream = new MemoryStream(fileData))
                    {
                        obj.contentStream = memoryStream;

                        obj.fileDownloadName = $"Batch_files_Log_at_{(FromDate == ToDate ? FromDate : FromDate + " to " + ToDate).Replace("/", "-")}.pdf";
                        obj.contentType = "application/pdf";
                    }

                    list.Add(obj);
                }
            }

            if (list != null && list.Count > 0)
            {
                (byte[] fileData, MemoryStream contentStream, string contentType, string? fileDownloadName) obj = list.FirstOrDefault();

                Int64 id = DateTime.Now.Ticks;

                try
                {
                    string insertSql = $"INSERT INTO KL_TEMP_EMAIL_ATTACHMENTS (id, file_name,file_data) VALUES (:id,:file_name,:file_data)";

                    var listOracleParameter = new List<OracleParameter>();

                    listOracleParameter.Add(new OracleParameter(":id", OracleDbType.Int64) { Value = id });
                    listOracleParameter.Add(new OracleParameter(":file_name", OracleDbType.NVarchar2) { Value = obj.fileDownloadName });
                    listOracleParameter.Add(new OracleParameter(":file_data", OracleDbType.Blob) { Value = obj.fileData });

                    var isSuccess = DataContext.ExecuteNonQuery(insertSql, listOracleParameter);

                    if (isSuccess == true)
                    {
                        listOracleParameter = new List<OracleParameter>();
                        listOracleParameter.Add(new OracleParameter("p_from", OracleDbType.NVarchar2) { Value = AppHttpContextAccessor.AdminFromMail });
                        listOracleParameter.Add(new OracleParameter("p_to", OracleDbType.NVarchar2) { Value = AppHttpContextAccessor.ToMail_Batch_Log_File });
                        listOracleParameter.Add(new OracleParameter("p_cc", OracleDbType.NVarchar2) { Value = "" });
                        listOracleParameter.Add(new OracleParameter("p_bcc", OracleDbType.NVarchar2) { Value = "" });
                        listOracleParameter.Add(new OracleParameter("p_subject", OracleDbType.NVarchar2) { Value = $"Batch file(s) Log at {(FromDate == ToDate ? FromDate : FromDate + " to " + ToDate)}" });
                        listOracleParameter.Add(new OracleParameter("p_text_msg", OracleDbType.NVarchar2) { Value = "" });
                        listOracleParameter.Add(new OracleParameter("p_html_msg", OracleDbType.NVarchar2) { Value = "<h3><b>Good Morning</b></h3> <p><b>PFA</b></p>" });
                        listOracleParameter.Add(new OracleParameter("p_attachment_names", OracleDbType.NVarchar2) { Value = $"Batch_files_Log_at_{(FromDate == ToDate ? FromDate : FromDate + "_to_" + ToDate).Replace("/", "-")}.pdf" });
                        listOracleParameter.Add(new OracleParameter("p_attachment_id", OracleDbType.Int64) { Value = id });
                        listOracleParameter.Add(new OracleParameter("p_attachments_clob", OracleDbType.Clob) { Value = null });
                        listOracleParameter.Add(new OracleParameter("p_attachments_blob", OracleDbType.Blob) { Value = null });
                        listOracleParameter.Add(new OracleParameter("p_reply_to", OracleDbType.NVarchar2) { Value = null });

                        var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SEND_EMAIL", listOracleParameter, true);

                    }
                }
                catch (Exception ex) { }

                //Common.SendEmail($"Batch file(s) Log at {(FromDate == ToDate ? FromDate : FromDate + " to " + ToDate)}", "<h3><b>Good Morning</b></h3> <p><b>PFA</b></p>"
                //, AppHttpContextAccessor.ToMail_Batch_Log_File.Replace(" ", "").Replace(";", ",").Split(",").ToArray(), list.Select(x=>(x.contentStream, x.contentType, x.fileDownloadName)).ToList(), true);

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = true;
                CommonViewModel.StatusCode = ResponseStatusCode.Success;
                CommonViewModel.Message = "E-Mail Sending.....";

                return Json(CommonViewModel);
            }


            CommonViewModel.IsConfirm = false;
            CommonViewModel.IsSuccess = false;
            CommonViewModel.StatusCode = ResponseStatusCode.Error;
            CommonViewModel.Message = "Error : E-Mail Sending.";

            return Json(CommonViewModel);
        }


        public async Task<IActionResult> SendEmail(string to = null, string cc = null, string bcc = null, string subject = null, string body = null, string body_html = null, string url = null)
        {
            if (string.IsNullOrEmpty(subject)) return BadRequest("Enter Subject.");

            if (!string.IsNullOrEmpty(body_html)) body_html = HttpUtility.UrlDecode(body_html);

            to = to ?? "";
            cc = cc ?? "";
            bcc = bcc ?? "";

            to = to.Trim(';').Replace(" ", "").Replace(";", ",");
            cc = cc.Trim(';').Replace(" ", "").Replace(";", ",");
            bcc = bcc.Trim(';').Replace(" ", "").Replace(";", ",");

            if (string.IsNullOrEmpty(to)) return BadRequest("Enter to/cc/bcc mail address.");

            if (string.IsNullOrEmpty(body) && string.IsNullOrEmpty(body_html)) return BadRequest("Enter Mail body.");

            List<(byte[] fileData, MemoryStream contentStream, string contentType, string? fileDownloadName, long id)> list = new();

            if (!string.IsNullOrEmpty(url))
                foreach (var fileUrl in url.Split("<#>"))
                {
                    using (HttpClient client = new HttpClient())
                    {
                        (byte[] fileData, MemoryStream contentStream, string contentType, string? fileDownloadName, long id) obj = new();

                        var _url = fileUrl.Split("<>")[1];

                        if (!string.IsNullOrEmpty(_url))
                        {
                            _url = HttpUtility.UrlDecode(_url);
                            _url = _url.Replace("|", "&");
                        }

                        if (!string.IsNullOrEmpty(_url) && _url.Contains("<CURRENT_DATE>"))
                            _url = _url.Replace("<CURRENT_DATE>", DateTime.Now.ToString("dd/MM/yyyy").Replace("-", "/"));

                        if (!string.IsNullOrEmpty(_url) && _url.Contains("<PREVIOUS_DATE>"))
                            _url = _url.Replace("<PREVIOUS_DATE>", DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy").Replace("-", "/"));

                        //byte[] fileData = Task.Run(() => client.GetByteArrayAsync(_url)).Result;

                        using var browser = await Puppeteer.LaunchAsync(new LaunchOptions { Headless = true, Args = new[] { "--no-sandbox", "--disable-setuid-sandbox" } });
                        using var page = await browser.NewPageAsync();
                        await page.GoToAsync(_url, WaitUntilNavigation.Networkidle0);
                        await page.EvaluateExpressionHandleAsync("document.fonts.ready");
                        byte[] fileData = await page.PdfDataAsync();

                        obj.fileData = fileData;

                        using (MemoryStream memoryStream = new MemoryStream(fileData))
                        {
                            obj.contentStream = memoryStream;

                            obj.fileDownloadName = fileUrl.Split("<>")[0];
                            obj.contentType = "application/octet-stream";
                        }

                        list.Add(obj);
                    }
                }

            var listOracleParameter = new List<OracleParameter>();

            if (list != null && list.Count > 0)
            {
                for (int i = 0; i < list.Count(); i++)
                {
                    (byte[] fileData, MemoryStream contentStream, string contentType, string? fileDownloadName, long id) obj = list[i];

                    Int64 id = DateTime.Now.Ticks;

                    try
                    {
                        string insertSql = $"INSERT INTO KL_TEMP_EMAIL_ATTACHMENTS (id, file_name,file_data) VALUES (:id,:file_name,:file_data)";

                        listOracleParameter = new List<OracleParameter>();

                        listOracleParameter.Add(new OracleParameter(":id", OracleDbType.Int64) { Value = id });
                        listOracleParameter.Add(new OracleParameter(":file_name", OracleDbType.NVarchar2) { Value = obj.fileDownloadName });
                        listOracleParameter.Add(new OracleParameter(":file_data", OracleDbType.Blob) { Value = obj.fileData });

                        var isSuccess = DataContext.ExecuteNonQuery(insertSql, listOracleParameter);

                        obj.id = isSuccess ? id : 0;

                        var item = list[i];
                        list[i] = (item.fileData, item.contentStream, item.contentType, item.fileDownloadName, id);
                    }
                    catch (Exception ex) { }

                    Thread.Sleep(1000 * 1);
                }
            }


            listOracleParameter = new List<OracleParameter>();
            listOracleParameter.Add(new OracleParameter("p_from", OracleDbType.NVarchar2) { Value = AppHttpContextAccessor.AdminFromMail });
            listOracleParameter.Add(new OracleParameter("p_to", OracleDbType.NVarchar2) { Value = to });
            listOracleParameter.Add(new OracleParameter("p_cc", OracleDbType.NVarchar2) { Value = cc });
            listOracleParameter.Add(new OracleParameter("p_bcc", OracleDbType.NVarchar2) { Value = bcc });
            listOracleParameter.Add(new OracleParameter("p_subject", OracleDbType.NVarchar2) { Value = subject });
            listOracleParameter.Add(new OracleParameter("p_text_msg", OracleDbType.NVarchar2) { Value = body });
            listOracleParameter.Add(new OracleParameter("p_html_msg", OracleDbType.NVarchar2) { Value = body_html });
            listOracleParameter.Add(new OracleParameter("p_attachment_names", OracleDbType.NVarchar2) { Value = "" });
            listOracleParameter.Add(new OracleParameter("p_attachment_ids", OracleDbType.NVarchar2) { Value = (list != null && list.Count > 0 ? string.Join(",", list.Select(x => x.id)) : "") });
            listOracleParameter.Add(new OracleParameter("p_attachments_clob", OracleDbType.Clob) { Value = null });
            listOracleParameter.Add(new OracleParameter("p_attachments_blob", OracleDbType.Blob) { Value = null });
            listOracleParameter.Add(new OracleParameter("p_reply_to", OracleDbType.NVarchar2) { Value = null });

            var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SEND_EMAIL", listOracleParameter, true);

            //Common.SendEmail($"Batch file(s) Log at {(FromDate == ToDate ? FromDate : FromDate + " to " + ToDate)}", "<h3><b>Good Morning</b></h3> <p><b>PFA</b></p>"
            //, AppHttpContextAccessor.ToMail_Batch_Log_File.Replace(" ", "").Replace(";", ",").Split(",").ToArray(), list.Select(x=>(x.contentStream, x.contentType, x.fileDownloadName)).ToList(), true);

            CommonViewModel.IsConfirm = true;
            CommonViewModel.IsSuccess = true;
            CommonViewModel.StatusCode = ResponseStatusCode.Success;
            CommonViewModel.Message = "E-Mail Sending.....";

            return Json(CommonViewModel);

        }

        public IActionResult SendEmailTest()
        {
            LogService.LogInsert("Home - SendEmailTest", $"Send Email Test => Starting at {DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss").Replace("-", "/")}", null);

            //Common.SendEmail($"Dispatch System Send Mail Testing at {DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss").Replace("-", "/")}", "For Testing", AppHttpContextAccessor.AdminToMail.Replace(" ", "").Replace(";", ",").Split(",").ToArray(), null, false);

            var listOracleParameter = new List<OracleParameter>();

            listOracleParameter.Add(new OracleParameter("p_from", OracleDbType.NVarchar2) { Value = AppHttpContextAccessor.AdminFromMail });
            listOracleParameter.Add(new OracleParameter("p_to", OracleDbType.NVarchar2) { Value = AppHttpContextAccessor.AdminToMail });
            listOracleParameter.Add(new OracleParameter("p_cc", OracleDbType.NVarchar2) { Value = "" });
            listOracleParameter.Add(new OracleParameter("p_bcc", OracleDbType.NVarchar2) { Value = "" });
            listOracleParameter.Add(new OracleParameter("p_subject", OracleDbType.NVarchar2) { Value = $"Test subject : {DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss").Replace("-", "/")}" });
            listOracleParameter.Add(new OracleParameter("p_text_msg", OracleDbType.NVarchar2) { Value = "Test body" });
            listOracleParameter.Add(new OracleParameter("p_html_msg", OracleDbType.NVarchar2) { Value = "" });
            listOracleParameter.Add(new OracleParameter("p_attachment_names", OracleDbType.NVarchar2) { Value = "" });
            listOracleParameter.Add(new OracleParameter("p_attachment_ids", OracleDbType.NVarchar2) { Value = "" });
            listOracleParameter.Add(new OracleParameter("p_attachments_clob", OracleDbType.Clob) { Value = null });
            listOracleParameter.Add(new OracleParameter("p_attachments_blob", OracleDbType.Blob) { Value = null });
            listOracleParameter.Add(new OracleParameter("p_reply_to", OracleDbType.NVarchar2) { Value = null });

            var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_SEND_EMAIL", listOracleParameter, false);

            LogService.LogInsert("Home - SendEmailTest", $"Send Email Test => Completed at {DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss").Replace("-", "/")}", null);

            CommonViewModel.IsConfirm = true;
            CommonViewModel.IsSuccess = true;
            CommonViewModel.StatusCode = ResponseStatusCode.Success;
            CommonViewModel.Message = "E-Mail Sending.....";

            return Json(CommonViewModel);
        }



        public async Task<IActionResult> SendToPrinter(string V1 = "Test-V1", string V2 = "Test-V1", string V3 = "Test-V1")
        {
            Write_Log($"Printer : Data to Send => V1 : {V1}, V2 : {V2}, V3 : {V3} ");

            IPAddress listenIP;
            int listenPort;

            string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Printer_IP").Value ?? "");
            string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Printer_Port").Value ?? "");

            if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
                && IPAddress.TryParse(listenIPString, out listenIP) && int.TryParse(listenPortString, out listenPort) && listenPort > 0 && listenPort <= 65535)
            {
                try
                {
                    Write_Log(System.Environment.NewLine);

                    // Format the data to be sent
                    string dataToSend = "\x02" + "041C1E1Q0R1" + "\x17" + "D" + $"{V1}" + "\x0A" + $"{V2}" + "\x0A" + $"{V3}??" + "\x0D";

                    // Connect to the server
                    using var client = new TcpClient();
                    await client.ConnectAsync(listenIP, listenPort);

                    Write_Log("Printer : Connected to the server.");
                    Write_Log($"Printer : Listening on Address {listenIP.ToString()}:{listenPort}..." + System.Environment.NewLine);

                    // Get the network stream for writing data to the server
                    using NetworkStream stream = client.GetStream();

                    Write_Log($"Printer : Data to Send => {dataToSend}");

                    // Convert the string data to bytes
                    byte[] buffer = Encoding.UTF8.GetBytes(dataToSend);

                    // Send the data to the server
                    await stream.WriteAsync(buffer, 0, buffer.Length);

                    Write_Log("Printer : Data sent to the server.");

                    // Disconnect from the server
                    client.Close();

                }
                catch (Exception ex)
                {
                    Write_Log($"Printer : Error => {JsonConvert.SerializeObject(ex)}");

                    throw ex;
                }
            }


            return Json(null);
        }

        private void Write_Log(string text)
        {
            try
            {
                if (!string.IsNullOrEmpty(text))
                {
                    string filePath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Log_File_Path").Value ?? "C:\\Z_Project_Dispatch_System\\Logs\\<YYYYMMDD>\\MDA_QR_Scan_<HH>.txt");

                    //filePath = filePath.Replace("#", DateTime.Now.ToString("yyyyMMdd_HH"));

                    filePath = filePath.Replace("<YYYYMMDD>", DateTime.Now.ToString("yyyyMMdd"));
                    filePath = filePath.Replace("<HH>", DateTime.Now.ToString("HH"));

                    if (!System.IO.Directory.Exists(Path.GetDirectoryName(filePath)))
                        System.IO.Directory.CreateDirectory(Path.GetDirectoryName(filePath));

                    if (!System.IO.File.Exists(filePath))
                        System.IO.File.Create(filePath).Dispose();

                    using (StreamWriter sw = System.IO.File.AppendText(filePath))
                        sw.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text + System.Environment.NewLine);

                    Console.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt") + " || " + text + System.Environment.NewLine);
                }
            }
            catch (Exception ex) { }
        }
    }

}