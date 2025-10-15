using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
    [Area("Dispatch")]
    public class RmGateInController : BaseController<ResponseModel<GateIn>>
    {
        #region Loading

        public IActionResult Index()
        {
            var list = new List<SelectListItem_Custom>();

            var oParams = new List<MySqlParameter>();

            try
            {
                list.Insert(0, new SelectListItem_Custom("", "-- Select --", "DRVIDPROOF"));

                oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarChar) { Value = "DRVIDPROOF" });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, false);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(Convert.ToString(dr["LOV_CODE"]), Convert.ToString(dr["LOV_DESC"]), "DRVIDPROOF"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            try
            {
                //list.Insert(0, new SelectListItem_Custom("0", "-- Select --", "INWARDTYPE"));

                oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

                var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_INWARD_GET", oParams, false);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(Convert.ToString(dr["ID"]), Convert.ToString(dr["INWARD_TYPE"]), "INWARDTYPE"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            CommonViewModel.SelectListItems = list;

            return View(CommonViewModel);
        }

        #endregion

        #region Methods

        [HttpGet]
        public IActionResult GetPO(string type, string searchTerm)
        {
            var list = new List<PO>();

            try
            {
                List<MySqlParameter> oParams = new List<MySqlParameter>();

                //oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });

                //oParams.Add(new MySqlParameter("P_VEHICLE_NO", MySqlDbType.VarChar) { Value = "" });
                //oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = Inward_Sys_Id });
                //oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
                //oParams.Add(new MySqlParameter("P_DTLS", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_GATE_IN_PO_LIST", oParams);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        //if ((dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0) <= 0)
                        list.Add(new PO()
                        {
                            Id = dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0,
                            PoNo = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : "",
                            PoDate_Text = dr["PO_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["PO_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
                            VendorId = dr["VENDOR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_SYS_ID"]) : 0,
                            VendorName = dr["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(dr["ORGANIZATION_NAME"]) : "",
                            SiteName = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
                            CostCenter = dr["COST_CENTER"] != DBNull.Value ? Convert.ToInt64(dr["COST_CENTER"]) : 0,
                            PoDesc = dr["PO_DESCCRIPTION"] != DBNull.Value ? Convert.ToString(dr["PO_DESCCRIPTION"]) : "",
                            TransId = dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0,
                            TruckNo = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
                            Transporter_Code = dr["tptr_cd"] != DBNull.Value ? Convert.ToString(dr["tptr_cd"]) : "",
                            Transporter_Name = dr["TPTR_NAME"] != DBNull.Value ? Convert.ToString(dr["TPTR_NAME"]) : "",
                            Is_PO_Manually = dr["IS_PO_MANUAL"] != DBNull.Value ? Convert.ToBoolean(dr["IS_PO_MANUAL"]) : false,
                            SiteId = dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0,
                            PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                            Plant_CD = dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "",
                        });

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            foreach (var item in list)
                if (!string.IsNullOrEmpty(item.PoDate_Text))
                    try { item.PoDate_Text = DateTime.ParseExact(item.PoDate_Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/"); } catch { continue; }

            if (list != null && list.Count > 0)
                if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
                else return PartialView("_Partial_PO", list);
            else return Json(null);
            //return PartialView("_Partial_MDA", list);
        }

        [HttpGet]
        public IActionResult Partial_AddEditForm_PO(int Id)
        {
            var obj = new ResponseModel<PO>();

            List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

            list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));

            List<MySqlParameter> oParams = new List<MySqlParameter>();

            oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
            oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
            oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = "" });
            oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
            //oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
            //oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

            var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

            if (dt != null && dt.Rows.Count > 0)
                foreach (DataRow row in dt.Rows)
                    list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " -- " + row["VENDOR_SITE"].ToString(), row["VENDOR_SITE"].ToString(), "V"));

            oParams = new List<MySqlParameter>();

            oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarChar) { Value = "UOM" });
            oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

            list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));

            if (dt != null && dt.Rows.Count > 0)
                foreach (DataRow row in dt.Rows)
                    list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

            oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

            dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

            list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));

            if (dt != null && dt.Rows.Count > 0)
                foreach (DataRow dr in dt.Rows)
                    list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
                                                        , (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
                                                            + (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

            obj.SelectListItems = list;
            obj.Obj = new PO();

            return PartialView("_Partial_AddEditForm_PO", obj);
        }

        [HttpGet]
        public IActionResult Partial_AddEditForm_SO(int Id)
        {
            var obj = new ResponseModel<SO>();

            List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

            List<MySqlParameter> oParams = new List<MySqlParameter>();

            oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
            oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
            oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = "" });
            oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
            //oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
            //oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

            var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

            list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));
            if (dt != null && dt.Rows.Count > 0)
                foreach (DataRow row in dt.Rows)
                    list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

            oParams = new List<MySqlParameter>();

            oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarChar) { Value = "UOM" });
            oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

            dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

            list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));
            foreach (DataRow row in dt.Rows)
                list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

            oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

            dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

            list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));
            foreach (DataRow dr in dt.Rows)
                list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
                                                    , (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
                                                        + (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

            obj.SelectListItems = list;
            obj.Obj = new SO();

            return PartialView("_Partial_AddEditForm_SO", obj);
        }

        #endregion


        #region Events

        [HttpPost]
        public IActionResult Save(GateIn viewModel)
        {
            try
            {
                if (viewModel == null)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid Gate In details";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Inward_Sys_Id) || viewModel.Inward_Sys_Id == "0")
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please select Inward Type";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Truck_No))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter Vehicle Number";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Transporter_Name))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter Transporter Name";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                //if (string.IsNullOrEmpty(viewModel.Driver_Name))
                //{
                //	CommonViewModel.IsSuccess = false;
                //	CommonViewModel.Message = "Please enter Driver Name";
                //	CommonViewModel.StatusCode = ResponseStatusCode.Error;

                //	return Json(CommonViewModel);
                //}

                //if (string.IsNullOrEmpty(viewModel.Driver_Contact))
                //{
                //	CommonViewModel.IsSuccess = false;
                //	CommonViewModel.Message = "Please enter Driver Contact";
                //	CommonViewModel.StatusCode = ResponseStatusCode.Error;

                //	return Json(CommonViewModel);
                //}

                //if (viewModel.Driver_Changed == true && string.IsNullOrEmpty(viewModel.Driver_Name_New))
                //{
                //	CommonViewModel.IsSuccess = false;
                //	CommonViewModel.Message = "Please Enter New Driver Name";
                //	CommonViewModel.StatusCode = ResponseStatusCode.Error;
                //	return Json(CommonViewModel);
                //}

                //if (viewModel.Driver_Changed == true && string.IsNullOrEmpty(viewModel.Driver_Contact_New))
                //{
                //	CommonViewModel.IsSuccess = false;
                //	CommonViewModel.Message = "Please Enter New Driver Contact";
                //	CommonViewModel.StatusCode = ResponseStatusCode.Error;
                //	return Json(CommonViewModel);
                //}


                //if (string.IsNullOrEmpty(viewModel.Driver_Id_Type))
                //{
                //	CommonViewModel.IsSuccess = false;
                //	CommonViewModel.Message = "Please select Driver ID proof";
                //	CommonViewModel.StatusCode = ResponseStatusCode.Error;
                //	return Json(CommonViewModel);
                //}
                //if (string.IsNullOrEmpty(viewModel.Driver_Id_Number))
                //{
                //	CommonViewModel.IsSuccess = false;
                //	CommonViewModel.Message = "Please enter ID proof No.";
                //	CommonViewModel.StatusCode = ResponseStatusCode.Error;
                //	return Json(CommonViewModel);
                //}
                if (string.IsNullOrEmpty(viewModel.RFID_Number))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter RFID No.";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Common_No))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid PO Number";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (string.IsNullOrEmpty(viewModel.Common_Date))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter valid PO Date";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                if (!string.IsNullOrEmpty(viewModel.Common_No))
                {
                    //string objList_JSON = "";

                    //if (viewModel.listSerial != null && viewModel.listSerial.Count() > 0)
                    //	objList_JSON = string.Join("<#>", viewModel.listSerial.Select(x => x.Id + "|" + (x.IsLock ? 1 : 0)).ToArray());

                    List<MySqlParameter> oParams = new List<MySqlParameter>();
                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                    oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
                    oParams.Add(new MySqlParameter("P_COMMON_SYS_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_COMMON_NO", MySqlDbType.VarChar) { Value = viewModel.Common_No });
                    oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarChar) { Value = viewModel.Truck_No });
                    oParams.Add(new MySqlParameter("P_TRANSPORTER_NAME", MySqlDbType.VarChar) { Value = viewModel.Transporter_Name });
                    oParams.Add(new MySqlParameter("P_DRIVER_ID_TYPE", MySqlDbType.VarChar) { Value = viewModel.Driver_Id_Type });
                    oParams.Add(new MySqlParameter("P_DRIVER_ID_NUMBER", MySqlDbType.VarChar) { Value = viewModel.Driver_Id_Number });
                    oParams.Add(new MySqlParameter("P_DRIVER_NAME", MySqlDbType.VarChar) { Value = viewModel.Driver_Name });
                    oParams.Add(new MySqlParameter("P_DRIVER_CONTACT", MySqlDbType.VarChar) { Value = viewModel.Driver_Contact });
                    oParams.Add(new MySqlParameter("P_DRIVER_CHANGED", MySqlDbType.Int64) { Value = viewModel.Driver_Changed ? 1 : 0 });
                    oParams.Add(new MySqlParameter("P_DRIVER_NAME_NEW", MySqlDbType.VarChar) { Value = viewModel.Driver_Name_New });
                    oParams.Add(new MySqlParameter("P_DRIVER_CONTACT_NEW", MySqlDbType.VarChar) { Value = viewModel.Driver_Contact_New });
                    oParams.Add(new MySqlParameter("P_TRUCK_VALIDATION", MySqlDbType.Int64) { Value = viewModel.Truck_Validation ? 1 : 0 });
                    oParams.Add(new MySqlParameter("P_RFSYSID", MySqlDbType.VarChar) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_RFID_CODE", MySqlDbType.VarChar) { Value = viewModel.RFID_Number });
                    oParams.Add(new MySqlParameter("P_RFID_SRNO", MySqlDbType.VarChar) { Value = viewModel.RFID_Serial_Number });
                    oParams.Add(new MySqlParameter("P_RFID_RECEIVE", MySqlDbType.Int64) { Value = viewModel.Rfid_Receive ? 1 : 0 });
                    oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RM_GATE_IN_SAVE", oParams, true);

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = response;
                    CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
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
        public JsonResult Save_PO(PO viewModel)
        {
            var obj = new ResponseModel<PO>();

            try
            {
                if (viewModel == null)
                {
                    obj.IsSuccess = false;
                    obj.Message = "Please fill Vendor PO details";
                    obj.StatusCode = ResponseStatusCode.Error;

                    return Json(obj);
                }

                if (viewModel.VendorId == 0 && string.IsNullOrEmpty(viewModel.VendorName))
                {
                    obj.IsSuccess = false;
                    obj.Message = "Please provide Vendor name";
                    obj.StatusCode = ResponseStatusCode.Error;

                    return Json(obj);
                }

                //if (string.IsNullOrEmpty(viewModel.SelectedSiteName) && string.IsNullOrEmpty(viewModel.SiteName))
                //{
                //    obj.IsSuccess = false;
                //    obj.Message = "Please provide Vendor site";
                //    obj.StatusCode = ResponseStatusCode.Error;

                //    return Json(obj);
                //}

                if (viewModel.TransId == 0 && string.IsNullOrEmpty(viewModel.Transporter_Name))
                {
                    obj.IsSuccess = false;
                    obj.Message = "Please provide Transporter";
                    obj.StatusCode = ResponseStatusCode.Error;

                    return Json(obj);
                }


                string objList_JSON = "";

                if (viewModel.listPoDtls != null && viewModel.listPoDtls.Any(x => !string.IsNullOrEmpty(x.LineDesc) && !string.IsNullOrEmpty(x.UOM) && x.LineQty > 0))
                    objList_JSON = string.Join("<#>", viewModel.listPoDtls.Where(x => !string.IsNullOrEmpty(x.LineDesc) && !string.IsNullOrEmpty(x.UOM) && x.LineQty > 0)
                                                        .Select(x => x.Id + "|" + (x.LineNo ?? "0") + "|" + x.LineDesc + "|" + x.UOM + "|" + x.LineQty).ToArray());

                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                oParams.Add(new MySqlParameter("P_VENDOR_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
                oParams.Add(new MySqlParameter("P_VENDOR_NAME", MySqlDbType.VarChar) { Value = viewModel.VendorName });
                oParams.Add(new MySqlParameter("P_SITE_ID", MySqlDbType.Int64) { Value = viewModel.SiteId });
                oParams.Add(new MySqlParameter("P_SITE_NAME", MySqlDbType.VarChar) { Value = !string.IsNullOrEmpty(viewModel.SelectedSiteName) ? viewModel.SelectedSiteName : viewModel.SiteName });
                oParams.Add(new MySqlParameter("P_PO_NO", MySqlDbType.VarChar) { Value = viewModel.PoNo });
                oParams.Add(new MySqlParameter("P_PO_DATE", MySqlDbType.VarChar) { Value = viewModel.PoDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
                oParams.Add(new MySqlParameter("P_PO_DESC", MySqlDbType.VarChar) { Value = viewModel.PoDesc });
                oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarChar) { Value = viewModel.TruckNo });
                oParams.Add(new MySqlParameter("P_TRANS_SYS_ID", MySqlDbType.Int64) { Value = viewModel.TransId });
                oParams.Add(new MySqlParameter("P_TRANS_NAME", MySqlDbType.VarChar) { Value = viewModel.Transporter_Name });
                oParams.Add(new MySqlParameter("P_PO_DTLS", MySqlDbType.VarChar) { Value = objList_JSON });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PO_SAVE", oParams, true);

                obj.IsConfirm = true;
                obj.IsSuccess = IsSuccess;
                obj.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                obj.Message = response;

                if (IsSuccess == true)
                {
                    List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

                    oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
                    oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = "" });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    //oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
                    //oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

                    var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

                    if (dt != null && dt.Rows.Count > 0)
                        foreach (DataRow row in dt.Rows)
                            list.Add(new SelectListItem_Custom(row["VENDOR_CODE"].ToString(), row["Organization_Name"].ToString(), "V"));

                    obj.SelectListItems = list;

                    viewModel.Id = Id;
                    viewModel.PoDate_Text = viewModel.PoDate?.ToString("dd/MM/yyyy").Replace("-", "/");

                    obj.Obj = viewModel;
                }

            }
            catch (Exception ex)
            {
                LogService.LogInsert(GetCurrentAction(), "", ex);

                obj.IsSuccess = false;
                obj.StatusCode = ResponseStatusCode.Error;
                obj.Message = ResponseStatusMessage.Error + " | " + ex.Message;
            }

            return Json(obj);
        }

        [HttpPost]
        public JsonResult Save_SO(SO viewModel)
        {
            var obj = new ResponseModel<SO>();

            try
            {
                if (viewModel == null)
                {
                    obj.IsSuccess = false;
                    obj.Message = "Please enter Vendor SO details";
                    obj.StatusCode = ResponseStatusCode.Error;

                    return Json(obj);
                }


                string objList_JSON = "";

                if (viewModel.listSoDtls != null && viewModel.listSoDtls.Any(x => !string.IsNullOrEmpty(x.ScrapDesc) && !string.IsNullOrEmpty(x.Uom) && x.SoQty > 0))
                    objList_JSON = string.Join("<#>", viewModel.listSoDtls.Where(x => !string.IsNullOrEmpty(x.ScrapDesc) && !string.IsNullOrEmpty(x.Uom) && x.SoQty > 0)
                                                        .Select(x => x.Id + "|" + x.SlNo + "|" + x.ScrapDesc + "|" + x.Uom + "|" + x.SoQty).ToArray());

                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                oParams.Add(new MySqlParameter("P_VENDOR_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
                oParams.Add(new MySqlParameter("P_SITE_NAME", MySqlDbType.VarChar) { Value = viewModel.SiteName });
                oParams.Add(new MySqlParameter("P_SO_NO", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.SoNo) });
                oParams.Add(new MySqlParameter("P_SO_DATE", MySqlDbType.VarChar) { Value = viewModel.SoDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
                oParams.Add(new MySqlParameter("P_RIVISION", MySqlDbType.VarChar) { Value = viewModel.Rivision });
                oParams.Add(new MySqlParameter("P_ORDER_TYPE", MySqlDbType.VarChar) { Value = viewModel.TenderType });
                oParams.Add(new MySqlParameter("P_SO_RELEASE_DATE", MySqlDbType.VarChar) { Value = viewModel.SoReleaseDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
                oParams.Add(new MySqlParameter("P_SO_VALID_DATE", MySqlDbType.VarChar) { Value = viewModel.SoValidDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
                oParams.Add(new MySqlParameter("P_EMD_AMT", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.EmdAmt) });
                oParams.Add(new MySqlParameter("P_MSR_NO", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.AmendNo) });
                oParams.Add(new MySqlParameter("P_CUST_NAME", MySqlDbType.VarChar) { Value = viewModel.CustName });
                oParams.Add(new MySqlParameter("P_ADDRESS", MySqlDbType.VarChar) { Value = viewModel.Add1 });
                oParams.Add(new MySqlParameter("P_CITY", MySqlDbType.VarChar) { Value = viewModel.City });
                oParams.Add(new MySqlParameter("P_STATE", MySqlDbType.VarChar) { Value = viewModel.State });
                oParams.Add(new MySqlParameter("P_PANNO", MySqlDbType.VarChar) { Value = viewModel.PanNo });
                oParams.Add(new MySqlParameter("P_GSTNNO", MySqlDbType.VarChar) { Value = viewModel.GstnNo });
                oParams.Add(new MySqlParameter("P_TERMS_PRICE", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.TermsPrice) });
                oParams.Add(new MySqlParameter("P_TERMS_PYMT_TERM", MySqlDbType.VarChar) { Value = viewModel.TermsPymtTerm });
                oParams.Add(new MySqlParameter("P_TERMS_LIFTING_PERIOD_DAYS", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.TermsLiftingPeriodDays) });
                oParams.Add(new MySqlParameter("P_SO_REMARKS", MySqlDbType.VarChar) { Value = viewModel.SoRemarks });
                oParams.Add(new MySqlParameter("P_STATUS_REMARKS", MySqlDbType.VarChar) { Value = viewModel.StatusRemarks });
                oParams.Add(new MySqlParameter("P_SO_DTLS", MySqlDbType.VarChar) { Value = objList_JSON });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SO_SAVE", oParams, true);

                obj.IsConfirm = true;
                obj.IsSuccess = IsSuccess;
                obj.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                obj.Message = response;

                if (IsSuccess == true)
                {
                    List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

                    oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
                    oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = "" });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    //oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
                    //oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

                    var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

                    if (dt != null && dt.Rows.Count > 0)
                        foreach (DataRow row in dt.Rows)
                            list.Add(new SelectListItem_Custom(row["VENDOR_CODE"].ToString(), row["Organization_Name"].ToString(), "V"));

                    obj.SelectListItems = list;

                    viewModel.Id = Id;
                    viewModel.SoDate_Text = viewModel.SoDate?.ToString("dd/MM/yyyy").Replace("-", "/");

                    obj.Obj = viewModel;
                }

            }
            catch (Exception ex)
            {
                LogService.LogInsert(GetCurrentAction(), "", ex);

                obj.IsSuccess = false;
                obj.StatusCode = ResponseStatusCode.Error;
                obj.Message = ResponseStatusMessage.Error + " | " + ex.Message;
            }

            return Json(obj);
        }


        [HttpGet]
        public IActionResult fngetRfidNoCode(string rfidNo, string rfidCode)
        {
            var viewModel = new RFID();

            try
            {
                if (rfidNo != null || rfidCode != null)
                {
                    string sql = "SELECT RFIDSRNO, Status, RFIDCODE FROM RFID_MASTER WHERE RFIDSRNO = '" + rfidNo + "' OR RFIDCODE = '" + rfidCode + "'";

                    var dt = DataContext.ExecuteQuery_SQL(sql);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        viewModel.RfidSrno = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : "";
                        viewModel.Status = dt.Rows[0]["Status"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Status"]) : "";
                        viewModel.RfidCode = dt.Rows[0]["RFIDCODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDCODE"]) : "";

                        if (viewModel.Status != "Active")
                        {
                            var errorMsg = viewModel.Status == "L" ? "This RFID Card is Already Lost" : "This RFID Card is Already Assigned";
                            CommonViewModel.IsConfirm = false;
                            CommonViewModel.IsSuccess = false;
                            CommonViewModel.StatusCode = ResponseStatusCode.Error;
                            CommonViewModel.Message = errorMsg;
                            viewModel.ReasonforEdit = errorMsg;
                            CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                            return Json(viewModel);
                        }

                    }
                    else
                    {
                        var errorMsg = "No Record Found of " + viewModel.RfidSrno;
                        CommonViewModel.IsConfirm = false;
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = errorMsg;
                        viewModel.ReasonforEdit = errorMsg;
                        CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
                        return Json(viewModel);
                    }
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return Json(viewModel);
        }


        [HttpGet]
        public JsonResult GetVendorSitelist(long Vendor_Id = 0, string VendorCode = null)
        {
            var list2 = new List<SelectListItem_Custom>();

            try
            {
                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Vendor_Id });
                oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.VarString) { Value = VendorCode ?? "" });
                oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarString) { Value = "" });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

                if (dt != null && dt.Rows.Count > 1)
                {
                    foreach (DataRow row in dt.Rows)
                        list2.Add(new SelectListItem_Custom(row["SITE_NAME"].ToString(), row["SITE_NAME"].ToString(), "S"));

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            list2.Insert(0, new SelectListItem_Custom("", "-- Select Vendor Site --", "S"));

            return Json(list2);
        }


        #endregion



    }
}
