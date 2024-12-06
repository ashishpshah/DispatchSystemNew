﻿using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
	[Area("Dispatch")]
    public class TransportOfGoodsController : BaseController<ResponseModel<GateIn>>
    {
        #region Loading
        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<GateIn>();
               
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return View(CommonViewModel);
        }



        #endregion

        #region Methods

        [HttpGet]
        public IActionResult GetMDA(string Rfid, string RfidSrNo)
        {
            var list = new List<MDA>();

            try
            {
                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                oParams.Add(new MySqlParameter("P_RFID_NO", MySqlDbType.VarChar) { Value = RfidSrNo });
                oParams.Add(new MySqlParameter("P_VEHICLE_NO", MySqlDbType.VarChar) { Value = "" });
                oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = 0 });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_CHANGE_RFIID_IN_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0) { 
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new MDA()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                            Inward_Sys_Id = dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0,
                            Inward_Type = dr["INWARD_TYPE"] != DBNull.Value ? Convert.ToString(dr["INWARD_TYPE"]) : "",
                            vehicle_no = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                            driver = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "",
                            tptr_name = dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "",
                            Tare_Wt = dr["TARE_WT"] != DBNull.Value ? Convert.ToDouble(dr["TARE_WT"]) : 0,
                            gross_qty = dr["GROSS_WT"] != DBNull.Value ? Convert.ToDouble(dr["GROSS_WT"]) : 0,
                            mobile_no = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : null,
                            out_time = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : "",
                            nett_qty = dr["NET_WT"] != DBNull.Value ? Convert.ToDouble(dr["NET_WT"]) : 0,
                            Out_Tolerance_Weight = dr["OUT_OF_TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(dr["OUT_OF_TOLERANCE_WT"]) : 0,
                            Remarks = dr["REMARKS"] != DBNull.Value ? Convert.ToString(dr["REMARKS"]) : "",
                            Allow_Out_Tolerance = dr["ALLOW_TOLERANCE_WT"] != DBNull.Value ? Convert.ToString(dr["ALLOW_TOLERANCE_WT"]) : ""
                        });
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

             return Json(list.FirstOrDefault());
            //return PartialView("_Partial_MDA", list);
        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult OldTruckSave(GateIn viewModel)
        {
            try
            {
                if (viewModel.RFID_Serial_Number != null)
                {
                    string sql = "SELECT RFSYSID, Status FROM RFID_MASTER_TEMP WHERE RFIDSRNO = '" + viewModel.RFID_Serial_Number + "'";

                    var dt = DataContext.ExecuteQuery_SQL(sql);

                    //var dt = ds.Tables[0];
                    //var dt1 = ds.Tables[1];

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        //viewModel.RefSysId = dt.Rows[0]["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["RFSYSID"]) : 0;
                        viewModel.Status = dt.Rows[0]["Status"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Status"]) : "";
                        viewModel.RefSysIdOld = dt.Rows[0]["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["RFSYSID"]) : 0;

                        if (viewModel.Status != "Act")
                        {
                            var errorMsg = viewModel.Status == "L" ? "This RFID Card is Already Lost" : "This RFID Card is Already Assign";
                            CommonViewModel.IsConfirm = false;
                            CommonViewModel.IsSuccess = false;
                            CommonViewModel.StatusCode = ResponseStatusCode.Error;
                            CommonViewModel.Message = errorMsg;
                            CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                            return Json(CommonViewModel);
                        }
                        else
                        {
                            List<MySqlParameter> oParams = new List<MySqlParameter>();

                            oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                            oParams.Add(new MySqlParameter("P_REF_SYS_ID", MySqlDbType.Int64) { Value = viewModel.RefSysId });
                            oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
                            oParams.Add(new MySqlParameter("P_REF_SYS_ID_OLD", MySqlDbType.Int64) { Value = viewModel.RefSysIdOld });
                            oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = viewModel.Station_Id });
                            oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarChar) { Value = viewModel.Cancel_Gate_Reason });
                            //oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = viewModel.IsActive ? "Y" : "N" });
                            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                            oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                            oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                            oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                            var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_OLD_TRUCK_SAVE", oParams, true);
                            viewModel.Id = Id;

                            CommonViewModel.IsConfirm = true;
                            CommonViewModel.IsSuccess = IsSuccess;
                            CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                            CommonViewModel.Message = response;

                            CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                        }                  

                    }
                    //else
                    //{
                    //    var errorMsg = "No Record Found of " + viewModel.RFID_Serial_Number;
                    //    CommonViewModel.IsConfirm = false;
                    //    CommonViewModel.IsSuccess = false;
                    //    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    //    CommonViewModel.Message = errorMsg;
                    //    CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                    //    return Json(CommonViewModel);
                    //}                   
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


        [HttpPost]
        public JsonResult NewTruckSave(GateIn viewModel)
        {
            try
            {
                if (viewModel.RFID_Number != null)
                {
                    string sql = "SELECT RFSYSID, Status FROM RFID_MASTER_TEMP WHERE RFIDSRNO = '" + viewModel.RFID_Number + "';SELECT RFSYSID, Status FROM RFID_MASTER_TEMP WHERE RFIDSRNO = '" + viewModel.RFID_Serial_Number + "'";

                    var ds = DataContext.ExecuteQuery_DataSet_SQL(sql);

                    var dt = ds.Tables[0];
                    var dt1 = ds.Tables[1];

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        viewModel.RefSysId = dt.Rows[0]["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["RFSYSID"]) : 0;
                        viewModel.Status = dt.Rows[0]["Status"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Status"]) : "";
                        viewModel.RefSysIdOld = dt1.Rows[0]["RFSYSID"] != DBNull.Value ? Convert.ToInt64(dt1.Rows[0]["RFSYSID"]) : 0;

                        if (viewModel.Status != "Act")
                        {
                            var errorMsg = viewModel.Status == "L" ? "This RFID Card is Already Lost" : "This RFID Card is Already Assign";
                            CommonViewModel.IsConfirm = false;
                            CommonViewModel.IsSuccess = false;
                            CommonViewModel.StatusCode = ResponseStatusCode.Error;
                            CommonViewModel.Message = errorMsg;
                            CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                            return Json(CommonViewModel);
                        }
                        else
                        {
                            List<MySqlParameter> oParams = new List<MySqlParameter>();

                            oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                            oParams.Add(new MySqlParameter("P_REF_SYS_ID", MySqlDbType.Int64) { Value = viewModel.RefSysId });
                            oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
                            oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = viewModel.Station_Id });
                            oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarChar) { Value = viewModel.Truck_No });
                            oParams.Add(new MySqlParameter("P_TRANSPORTER_NAME", MySqlDbType.VarChar) { Value = viewModel.Transporter_Name });
                            oParams.Add(new MySqlParameter("P_DRIVER_NAME", MySqlDbType.VarChar) { Value = viewModel.Driver_Name });
                            oParams.Add(new MySqlParameter("P_DRIVER_CONTACT", MySqlDbType.VarChar) { Value = viewModel.Driver_Contact });
                            oParams.Add(new MySqlParameter("P_DRIVER_ID_TYPE", MySqlDbType.VarChar) { Value = viewModel.Driver_Id_Type });
                            oParams.Add(new MySqlParameter("P_DRIVER_ID_NUMBER", MySqlDbType.VarChar) { Value = viewModel.Driver_Id_Number });
                            //oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = viewModel.IsActive ? "Y" : "N" });
                            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                            oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                            oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                            oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                            var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_NEW_TRUCK_SAVE", oParams, true);
                            viewModel.Id = Id;

                            CommonViewModel.IsConfirm = true;
                            CommonViewModel.IsSuccess = IsSuccess;
                            CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                            CommonViewModel.Message = response;

                            CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                        }

                    }
                    else
                    {
                        var errorMsg = "No Record Found of " + viewModel.RFID_Number;
                        CommonViewModel.IsConfirm = false;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = errorMsg;
                        CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                        return Json(CommonViewModel);
                    }
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