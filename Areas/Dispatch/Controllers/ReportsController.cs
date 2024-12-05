﻿using Dispatch_System.Controllers;
using Dispatch_System;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;
using DocumentFormat.OpenXml.Wordprocessing;
using Oracle.ManagedDataAccess.Client;
using DocumentFormat.OpenXml.Vml.Spreadsheet;
using Humanizer;
using Newtonsoft.Json;

namespace VendorQRGeneration.Areas.Dispatch.Controllers
{
    [Area("Dispatch")]
    public class ReportsController : BaseController<ResponseModel<GateIn>>
    {
        public IActionResult Index(string type = "")
        {
            if (!string.IsNullOrEmpty(type) && type.ToUpper() == "BL_ISSUE")
            {
                var list = new List<SelectListItem_Custom>();

                try
                {
                    string sourceFolderPath = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Sync_Batch").GetSection("Error_Folder_Path").Value ?? "");

                    string[] sourceFilePaths = sourceFilePaths = Directory.GetFiles(sourceFolderPath, "*.json", SearchOption.AllDirectories);

                    if (sourceFilePaths != null && sourceFilePaths.Length > 0)
                        foreach (string sourceFilePath in sourceFilePaths)
                        {
                            string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(sourceFilePath);
                            list.Add(new SelectListItem_Custom(fileNameWithoutExtension, fileNameWithoutExtension));
                        }

                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

                CommonViewModel.SelectListItems = list;

            }

            CommonViewModel.Status = type.ToUpper();

            return View(CommonViewModel);
        }


        public IActionResult Gate_In_Out_Report()
        {
            return View();
        }

        public ActionResult GetData_Gate_In_Out_Report(JqueryDatatableParam param)
        {
            string SearchTerm = HttpContext.Request.Query["SearchTerm"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            //string IsGateOut = HttpContext.Request.Query["IsGateOut"];

            List<WeighmentInSlip> result = new List<WeighmentInSlip>();

            var oParams = new List<MySqlParameter>();

            oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = 0 });
            oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = SearchTerm });
            oParams.Add(new MySqlParameter("P_FROMDATE", MySqlDbType.VarChar) { Value = FromDate ?? "" });
            oParams.Add(new MySqlParameter("P_TODATE", MySqlDbType.VarChar) { Value = ToDate ?? "" });
            oParams.Add(new MySqlParameter("P_IS_OUT_TIME_NULL", MySqlDbType.Int64) { Value = 0 });
            oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

            DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_REPORT_WEIGHT_IN_OUT_GET", oParams);

            if (dt != null && dt.Rows.Count > 0)
            {
                DataRow[] filteredRows = dt.Select("SR_NO > " + param.iDisplayStart + " AND SR_NO <= " + (param.iDisplayStart + param.iDisplayLength));

                foreach (DataRow dr in filteredRows)
                    //foreach (DataRow dr in dt.Rows)
                    result.Add(new WeighmentInSlip()
                    {
                        SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
                        Gate_In_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
                        Inward_sys_id = dr["INWARD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["INWARD_SYS_ID"]) : 0,
                        //Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
                        Plant_Id = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                        Truck_No = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : null,
                        MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : null,
                        RFID_No = dr["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dr["RFIDSRNO"]) : null,
                        Status = dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : null,
                        Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_IN_DT"]) : null,
                        Gate_Out_Dt = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : null,
                        Transporter_Name = dr["TPTR_NAME"] != DBNull.Value ? Convert.ToString(dr["TPTR_NAME"]) : null,
                        Driver_Name = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : null,
                        Driver_Contact = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : null,
                        Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
                        Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
                    });
            }

            return Json(new
            {
                param.sEcho,
                iTotalRecords = result.Count(),
                iTotalDisplayRecords = dt != null ? dt.Rows.Count : 0,
                aaData = result
            });

        }

        [HttpGet]
        public IActionResult GetData_ShipperQRCodeList(string searchTerm, bool isPrint = false)
        {
            var obj = new MDA_Dtls();

            if (!string.IsNullOrEmpty(searchTerm))
                try
                {
                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = searchTerm });
                    oParams.Add(new MySqlParameter("P_TYPE", MySqlDbType.VarChar) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_REPORT_GATE_IN_OUT", oParams, true);

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        obj = new MDA_Dtls()
                        {
                            Mda_No = ds.Tables[0].Rows[0]["Mda_No"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Mda_No"]) : "",
                            Plant_Name = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "",
                            Plant_Address = ds.Tables[0].Rows[0]["PlantAddress"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PlantAddress"]) : "",
                            Mda_Dt = ds.Tables[0].Rows[0]["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Mda_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Vehicle_No = ds.Tables[0].Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VEHICLE_NO"]) : "",
                            prd_cd = ds.Tables[0].Rows[0]["prd_cd"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["prd_cd"]) : "",
                            prd_desc = ds.Tables[0].Rows[0]["prd_desc"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["prd_desc"]) : "",
                            Wh_Cd = ds.Tables[0].Rows[0]["Wh_Cd"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Wh_Cd"]) : "",
                            Party_Name = ds.Tables[0].Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PARTY_NAME"]) : "",
                            Bag_Nos = ds.Tables[0].Rows[0]["BAG_NOS"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["BAG_NOS"]) : 0,
                            Required_Shipper = ds.Tables[0].Rows[0]["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Required_Shipper"]) : 0,
                            Loaded_Shipper = ds.Tables[0].Rows[0]["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Loaded_Shipper"]) : 0,
                            PlantName = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : null
                        };

                    if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        obj.listShipperBatch = new List<ShipperBatch>();

                        foreach (DataRow dr in ds.Tables[1].Rows)
                            obj.listShipperBatch.Add(new ShipperBatch()
                            {
                                SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
                                ShipperQRCode = dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "",
                                Batch_no = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                                mfg_dt = dr["mfg_date"] != DBNull.Value ? Convert.ToString(dr["mfg_date"]) : "",
                                expiry_dt = dr["expiry_date"] != DBNull.Value ? Convert.ToString(dr["expiry_date"]) : ""
                            });
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            if (isPrint == true)
                return View("_Print_ShipperQRCodeList", obj);
            else
                return PartialView("_Partial_ShipperQRCodeList", obj);
        }

        [HttpGet]
        public IActionResult GetData_ShipperQRCodeList_Rejected(string searchTerm, bool isPrint = false)
        {
            var obj = new MDA_Dtls();

            if (!string.IsNullOrEmpty(searchTerm))
                try
                {
                    var oParams = new List<MySqlParameter>();

                    //oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = searchTerm });
                    //oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    //DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_MDAWISEREJECTREPORT", oParams, true);

                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = searchTerm });
                    oParams.Add(new MySqlParameter("P_TYPE", MySqlDbType.VarChar) { Value = "R" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_REPORT_GATE_IN_OUT", oParams, true);

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        obj = new MDA_Dtls()
                        {
                            Mda_No = ds.Tables[0].Rows[0]["Mda_No"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Mda_No"]) : "",
                            Plant_Name = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "",
                            Plant_Address = ds.Tables[0].Rows[0]["PlantAddress"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PlantAddress"]) : "",
                            Mda_Dt = ds.Tables[0].Rows[0]["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Mda_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Vehicle_No = ds.Tables[0].Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["VEHICLE_NO"]) : "",
                            prd_cd = ds.Tables[0].Rows[0]["prd_cd"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["prd_cd"]) : "",
                            prd_desc = ds.Tables[0].Rows[0]["prd_desc"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["prd_desc"]) : "",
                            Wh_Cd = ds.Tables[0].Rows[0]["Wh_Cd"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Wh_Cd"]) : "",
                            Party_Name = ds.Tables[0].Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PARTY_NAME"]) : "",
                            Bag_Nos = ds.Tables[0].Rows[0]["BAG_NOS"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["BAG_NOS"]) : 0,
                            Required_Shipper = ds.Tables[0].Rows[0]["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Required_Shipper"]) : 0,
                            Loaded_Shipper = ds.Tables[0].Rows[0]["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Loaded_Shipper"]) : 0,
                            PlantName = ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : null
                        };

                    if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        obj.listShipperBatch = new List<ShipperBatch>();

                        foreach (DataRow dr in ds.Tables[1].Rows)
                            obj.listShipperBatch.Add(new ShipperBatch()
                            {
                                SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
                                ShipperQRCode = dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "",
                                Reject_Reason = dr["REJECT_REASON"] != DBNull.Value ? Convert.ToString(dr["REJECT_REASON"]) : ""
                            });
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            if (isPrint == true)
                return View("_Print_ShipperQRCodeList_Rejected", obj);
            else
                return PartialView("_Partial_ShipperQRCodeList_Rejected", obj);
        }

        [HttpGet]
        public IActionResult GetData_DispatchSummary(string Report_Type = null, string MDA_No = null, string Truck_No = null, string PartyName = null, string FromDate = null, string ToDate = null, string Destination = null, bool isPrint = false)
        {
            List<MDA_Status> result = new List<MDA_Status>();

            var ds = new DataSet();

            //if (!string.IsNullOrEmpty(FromDate) && !string.IsNullOrEmpty(ToDate))
            try
            {
                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_REPORT_TYPE", OracleDbType.Varchar2) { Value = Report_Type });
                    oParams.Add(new OracleParameter("P_MDA_NO", OracleDbType.Varchar2) { Value = MDA_No });
                    oParams.Add(new OracleParameter("P_TRUCK_NO", OracleDbType.Varchar2) { Value = Truck_No });
                    oParams.Add(new OracleParameter("P_PARTY_NAME", OracleDbType.Varchar2) { Value = PartyName });
                    oParams.Add(new OracleParameter("P_DESTINATION", OracleDbType.Varchar2) { Value = Destination });
                    oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
                    oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });


                    if (Convert.ToString(Report_Type).Contains("DS_COUNT"))
                        ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_DISPATCH_SUMMARY_COUNT", oParams);
                    else
                        ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_DISPATCH_SUMMARY", oParams);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_REPORT_TYPE", MySqlDbType.VarString) { Value = Report_Type });
                    oParams.Add(new MySqlParameter("P_MDA_NO", MySqlDbType.VarString) { Value = MDA_No });
                    oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarString) { Value = Truck_No });
                    oParams.Add(new MySqlParameter("P_PARTY_NAME", MySqlDbType.VarString) { Value = PartyName });
                    oParams.Add(new MySqlParameter("P_DESTINATION", MySqlDbType.VarString) { Value = Destination });
                    oParams.Add(new MySqlParameter("P_FROM_DATE", MySqlDbType.VarString) { Value = FromDate });
                    oParams.Add(new MySqlParameter("P_TO_DATE", MySqlDbType.VarString) { Value = ToDate });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_REPORT_DISPATCH_SUMMARY_NEW", oParams, true);
                }


                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new MDA_Status
                        {
                            MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                            TransactionType = dr["TRANSACTIONTYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTIONTYPE"]) : "",
                            ArticleCode = dr["ARTICLECODE"] != DBNull.Value ? Convert.ToString(dr["ARTICLECODE"]) : "",
                            ArticleName = dr["ARTICLENAME"] != DBNull.Value ? Convert.ToString(dr["ARTICLENAME"]) : "",
                            DispatchDateTime = dr["DISP_DATE_TIME"] != DBNull.Value ? Convert.ToString(dr["DISP_DATE_TIME"]) : "",
                            DispatchFromType = dr["DISPATCHFROMTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMTYPE"]) : "",
                            DispatchFromCodeAndName = dr["DISPATCHFROMCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMCODENAME"]) : "",
                            DispatchToType = dr["DISPATCHTOTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOTYPE"]) : "",
                            DispatchToCodeAndName = dr["DISPATCHTOCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOCODENAME"]) : "",
                            DispatchedQtyKL = dr["DISPATCHEDQTYKL"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYKL"]) : 0,
                            DispatchedQtyShipper = dr["DISPATCHEDQTYSHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYSHIPPER"]) : 0,
                            DispatchedQtyUnits = dr["DISPATCHEDQTYUNITS"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYUNITS"]) : 0,

                            MDAReceiveDate = dr["MDA_DT"] != DBNull.Value ? Convert.ToString(dr["MDA_DT"]) : "",
                            TruckNo = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
                            BatchNo = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                            ManufacturingDate = dr["MFG_DATE"] != DBNull.Value ? Convert.ToString(dr["MFG_DATE"]) : "",
                            MDAQty = dr["Shipper_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Shipper_Qty"]) : 0,
                            LoadedQty = dr["Bottle_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Bottle_Qty"]) : 0,
                            LoadingBayPrintedTo = dr["LOADING_BAY"] != DBNull.Value ? Convert.ToString(dr["LOADING_BAY"]) : "",
                            CustomerName = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
                            Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
                            Reason = dr["ADDRESS"] != DBNull.Value ? Convert.ToString(dr["ADDRESS"]) : ""
                        });
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            //var PageTitle = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][0] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0][0]) : "";

            var PlantName = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][1] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0][1]) : "";

            var PageTitle = "";

            if (!string.IsNullOrEmpty(MDA_No))
                PageTitle = "MDA No. : " + MDA_No.ToUpper();

            if (!string.IsNullOrEmpty(Truck_No))
                PageTitle = "Truck No. : " + Truck_No.ToUpper();

            if (!string.IsNullOrEmpty(PartyName))
                PageTitle += $"{(!string.IsNullOrEmpty(PageTitle) ? " and " : "")}Party Name : {PartyName}";

            if (!string.IsNullOrEmpty(Destination))
                PageTitle += $"{(!string.IsNullOrEmpty(PageTitle) ? " and " : "")}Destination : {Destination}";

            if (!string.IsNullOrEmpty(FromDate))
                PageTitle += $"{(!string.IsNullOrEmpty(PageTitle) ? " and " : "")}From Date : {FromDate.ToUpper()}";

            if (!string.IsNullOrEmpty(ToDate))
                PageTitle += $"{(!string.IsNullOrEmpty(PageTitle) ? " and " : "")}To Date : {ToDate.ToUpper()}";

            dynamic objFilter = new { MDA_No = MDA_No, Truck_No = Truck_No, PartyName = PartyName, FromDate = FromDate, ToDate = ToDate, Destination = Destination };

            if (isPrint == true)
                return View("_Partial_DispatchSummary", (Report_Type, PageTitle, PlantName, objFilter, result, isPrint));
            else
                return PartialView("_Partial_DispatchSummary", (Report_Type, PageTitle, PlantName, objFilter, result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_KnowYourBatch(string searchTerm, bool withDetail = false, bool isPrint = false)
        {
            var result = new List<KnowYourBatch>();

            DataSet ds = new DataSet();

            if (!string.IsNullOrEmpty(searchTerm))
                try
                {
                    var oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.NVarchar2) { Value = searchTerm });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_KNOW_BATCH", oParams);

                    if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[1].Rows)
                        {
                            var index = result.FindIndex(x => x.Plant_Id == (dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0)
                                && x.Mda_Sys_Id == (dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0)
                                && x.Batch_No == (dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : ""));

                            if (index < 0)
                            {
                                var obj = new KnowYourBatch()
                                {
                                    Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
                                    Mda_Sys_Id = dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0,
                                    Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
                                    Batch_No = dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : "",
                                    Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToString(dr["Loaded_Shipper"]) : "",
                                    Mda_Date = dr["Mda_Date"] != DBNull.Value ? Convert.ToString(dr["Mda_Date"]) : "",
                                    InvoiceQrCode = dr["InvoiceQrCode"] != DBNull.Value ? Convert.ToString(dr["InvoiceQrCode"]) : "",
                                    Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
                                    Party_Name = dr["Party_Name"] != DBNull.Value ? Convert.ToString(dr["Party_Name"]) : ""
                                };

                                result.Add(obj);
                            }

                            index = result.FindIndex(x => x.Plant_Id == (dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0)
                                && x.Mda_Sys_Id == (dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0)
                                && x.Batch_No == (dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : ""));

                            result[index].listShipper_QrCode = result[index].listShipper_QrCode == null ? new List<string>() : result[index].listShipper_QrCode;

                            if (!string.IsNullOrEmpty(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : ""))
                                result[index].listShipper_QrCode.Add(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "");
                        }

                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            var objShipper = new ShipperData()
            {
                Batch_no = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["BATCH_NO"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["BATCH_NO"]) : "",
                PlantCd = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "",
                Mfg_Date = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["MFG_DATE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["MFG_DATE"]) : "",
                Expiry_Date = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["EXPIRY_DATE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["EXPIRY_DATE"]) : "",
                Token = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["TOTAL_SHIPPER_QTY"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["TOTAL_SHIPPER_QTY"]) : ""

            };

            if (isPrint == true)
                return View("_Partial_KnowYourBatch", (searchTerm, withDetail, objShipper, result, isPrint));
            else
                return PartialView("_Partial_KnowYourBatch", (searchTerm, withDetail, objShipper, result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_KnowYourBatch_Issue(string searchTerm)
        {
            var result = new List<KnowYourBatch>();

            DataSet ds = new DataSet();

            if (!string.IsNullOrEmpty(searchTerm))
                try
                {
                    var oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.NVarchar2) { Value = searchTerm });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_KNOW_BATCH", oParams);

                    if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[1].Rows)
                        {
                            var index = result.FindIndex(x => x.Plant_Id == (dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0)
                                && x.Mda_Sys_Id == (dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0)
                                && x.Batch_No == (dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : ""));

                            if (index < 0)
                            {
                                var obj = new KnowYourBatch()
                                {
                                    Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
                                    Mda_Sys_Id = dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0,
                                    Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
                                    Batch_No = dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : "",
                                    Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToString(dr["Loaded_Shipper"]) : "",
                                    Mda_Date = dr["Mda_Date"] != DBNull.Value ? Convert.ToString(dr["Mda_Date"]) : "",
                                    InvoiceQrCode = dr["InvoiceQrCode"] != DBNull.Value ? Convert.ToString(dr["InvoiceQrCode"]) : "",
                                    Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
                                    Party_Name = dr["Party_Name"] != DBNull.Value ? Convert.ToString(dr["Party_Name"]) : ""
                                };

                                result.Add(obj);
                            }

                            index = result.FindIndex(x => x.Plant_Id == (dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0)
                                && x.Mda_Sys_Id == (dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0)
                                && x.Batch_No == (dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : ""));

                            result[index].listShipper_QrCode = result[index].listShipper_QrCode == null ? new List<string>() : result[index].listShipper_QrCode;

                            if (!string.IsNullOrEmpty(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : ""))
                                result[index].listShipper_QrCode.Add(dr["SHIPPER_QRCODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QRCODE"]) : "");
                        }

                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            var objShipper = new ShipperData()
            {
                Batch_no = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["BATCH_NO"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["BATCH_NO"]) : "",
                PlantCd = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "",
                Mfg_Date = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["MFG_DATE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["MFG_DATE"]) : "",
                Expiry_Date = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["EXPIRY_DATE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["EXPIRY_DATE"]) : "",
                Token = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["TOTAL_SHIPPER_QTY"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["TOTAL_SHIPPER_QTY"]) : ""

            };

            return View("_Partial_KnowYourBatch", (searchTerm, objShipper, result));
        }

        [HttpGet]
        public IActionResult GetData_KnowYourBatch_MonthWise(string searchTerm, int Month = 0, int Year = 0, bool withDetail = false, bool isPrint = false)
        {
            var result = new List<KnowYourBatch>();
            var dispatch_result = new List<MDA_Status>();

            DataSet ds = new DataSet();

            //if (!string.IsNullOrEmpty(searchTerm))
            try
            {
                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_BATCH_NO", OracleDbType.NVarchar2) { Value = searchTerm });
                oParams.Add(new OracleParameter("P_MONTH", OracleDbType.Int64) { Value = Month });
                oParams.Add(new OracleParameter("P_YEAR", OracleDbType.Int64) { Value = Year });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_PAGE_TITLE", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_DISPATCH_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_KNOW_BATCH_MONTH_WISE", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                    {
                        var index = result.FindIndex(x => x.Plant_Id == (dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0)
                            //&& x.Mda_Sys_Id == (dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0)
                            && x.Batch_No == (dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : ""));

                        if (index < 0)
                        {
                            var obj = new KnowYourBatch()
                            {
                                Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
                                //Mda_Sys_Id = dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0,
                                //Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
                                Batch_No = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                                Loaded_Shipper = dr["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToString(dr["TOTAL_SHIPPER_QTY"]) : "",
                                Batch_Start_Date = dr["BATCH_START_DATE"] != DBNull.Value ? Convert.ToString(dr["BATCH_START_DATE"]) : "",
                                Mfg_Date = dr["MFG_DATE"] != DBNull.Value ? Convert.ToString(dr["MFG_DATE"]) : "",
                                Exp_Date = dr["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dr["EXPIRY_DATE"]) : "",
                                Bottle_QrCode = dr["BOTTLE_QTY"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QTY"]) : "",
                                //InvoiceQrCode = dr["InvoiceQrCode"] != DBNull.Value ? Convert.ToString(dr["InvoiceQrCode"]) : "",
                                //Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
                                //Party_Name = dr["Party_Name"] != DBNull.Value ? Convert.ToString(dr["Party_Name"]) : ""
                            };

                            result.Add(obj);
                        }

                        index = result.FindIndex(x => x.Plant_Id == (dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0)
                            //&& x.Mda_Sys_Id == (dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0)
                            && x.Batch_No == (dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : ""));

                        result[index].listShipper_QrCode = result[index].listShipper_QrCode == null ? new List<string>() : result[index].listShipper_QrCode;

                        if (!string.IsNullOrEmpty(dr["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToString(dr["TOTAL_SHIPPER_QTY"]) : ""))
                            result[index].listShipper_QrCode.Add(dr["TOTAL_SHIPPER_QTY"] != DBNull.Value ? Convert.ToString(dr["TOTAL_SHIPPER_QTY"]) : "");
                    }

                }

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[2].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[2].Rows)
                    {
                        dispatch_result.Add(new MDA_Status
                        {
                            MDANo = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
                            //TransactionType = dr["TRANSACTIONTYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTIONTYPE"]) : "",
                            DispatchDateTime = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : "",
                            //DispatchFromType = dr["DISPATCHFROMTYPE"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMTYPE"]) : "",
                            //DispatchFromCodeAndName = dr["DISPATCHFROMCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHFROMCODENAME"]) : "",
                            //DispatchToCodeAndName = dr["DISPATCHTOCODENAME"] != DBNull.Value ? Convert.ToString(dr["DISPATCHTOCODENAME"]) : "",
                            DispatchedQtyShipper = dr["DISPATCHEDQTYSHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYSHIPPER"]) : 0,
                            DispatchedQtyUnits = dr["DISPATCHED_BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHED_BOTTLE_QTY"]) : 0,
                            MDAReceiveDate = dr["MDA_DT"] != DBNull.Value ? Convert.ToString(dr["MDA_DT"]) : "",
                            //TruckNo = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
                            //MDAQty = dr["DISPATCHEDQTYSHIPPER"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHEDQTYSHIPPER"]) : 0,
                            //LoadedQty = dr["DISPATCHED_BOTTLE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["DISPATCHED_BOTTLE_QTY"]) : 0,
                            CustomerName = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
                            Destination = dr["DESTINATION"] != DBNull.Value ? Convert.ToString(dr["DESTINATION"]) : "",
                        });

                    }
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            var objShipper = new ShipperData()
            {
                Batch_no = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["BATCH_NO"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["BATCH_NO"]) : "",
                PlantCd = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "",
                Mfg_Date = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["YEAR"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["YEAR"]) : "",
                //Expiry_Date = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["EXPIRY_DATE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["EXPIRY_DATE"]) : "",
                //Token = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["TOTAL_SHIPPER_QTY"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["TOTAL_SHIPPER_QTY"]) : ""

            };

            if (isPrint == true)
                return View("_Partial_KnowYourBatch_MonthWise", (searchTerm, Month, Year, withDetail, objShipper, result, dispatch_result, isPrint));
            else
                return PartialView("_Partial_KnowYourBatch_MonthWise", (searchTerm, Month, Year, withDetail, objShipper, result, dispatch_result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_KnowYourShipper(string searchTerm, bool isPrint = false)
        {
            var result = new List<KnowYourBatch>();

            DataTable dt = new DataTable();

            if (!string.IsNullOrEmpty(searchTerm))
                try
                {
                    var oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.NVarchar2) { Value = searchTerm });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_REPORT_KNOW_SHIPPER", oParams, true);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            var obj = new KnowYourBatch()
                            {
                                InvoiceQrCode = searchTerm,
                                Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
                                Mda_Sys_Id = dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0,
                                Shipper_QR_Code_Id = dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0,
                                Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
                                Batch_No = dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : "",
                                Loaded_Shipper = dr["NO_OF_BOTTLE"] != DBNull.Value ? Convert.ToString(dr["NO_OF_BOTTLE"]) : "",
                                Status = dr["Status"] != DBNull.Value ? Convert.ToString(dr["Status"]) : "",
                                Mfg_Date = dr["MFG_DATE"] != DBNull.Value ? Convert.ToString(dr["MFG_DATE"]) : "",
                                Exp_Date = dr["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dr["EXPIRY_DATE"]) : "",
                                Mda_Date = dr["DISPATCH_DATE"] != DBNull.Value ? Convert.ToString(dr["DISPATCH_DATE"]) : "",
                                Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
                                Party_Name = dr["Party_Name"] != DBNull.Value ? Convert.ToString(dr["Party_Name"]) : "",
                                listShipper_QrCode = dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]).Split(", ").ToList() : null,
                                PlantName = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : null
                            };

                            result.Add(obj);
                        }
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            if (isPrint == true)
                return View("_Partial_KnowYourShipper", (searchTerm, result, isPrint));
            else
                return PartialView("_Partial_KnowYourShipper", (searchTerm, result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_KnowYourBottle(string searchTerm, bool isPrint = false)
        {
            var result = new List<KnowYourBatch>();

            DataTable dt = new DataTable();

            if (!string.IsNullOrEmpty(searchTerm))
                try
                {
                    var oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.NVarchar2) { Value = searchTerm });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_REPORT_KNOW_BOTTLE", oParams, true);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
                            var obj = new KnowYourBatch()
                            {
                                Bottle_QrCode = dr["BOTTLE_QRCODE"] != DBNull.Value ? Convert.ToString(dr["BOTTLE_QRCODE"]) : null,
                                Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
                                Mda_Sys_Id = dr["Mda_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Sys_Id"]) : 0,
                                Shipper_QR_Code_Id = dr["SHIPPER_QRCODE_SYSID"] != DBNull.Value ? Convert.ToInt64(dr["SHIPPER_QRCODE_SYSID"]) : 0,
                                Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
                                Batch_No = dr["Batch_No"] != DBNull.Value ? Convert.ToString(dr["Batch_No"]) : "",
                                Status = dr["Status"] != DBNull.Value ? Convert.ToString(dr["Status"]) : "",
                                Product = dr["Product"] != DBNull.Value ? Convert.ToString(dr["Product"]) : "",
                                Mfg_Date = dr["MFG_DATE"] != DBNull.Value ? Convert.ToString(dr["MFG_DATE"]) : "",
                                Exp_Date = dr["EXPIRY_DATE"] != DBNull.Value ? Convert.ToString(dr["EXPIRY_DATE"]) : "",
                                Mda_Date = dr["DISPATCH_DATE"] != DBNull.Value ? Convert.ToString(dr["DISPATCH_DATE"]) : "",
                                Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
                                Party_Name = dr["Party_Name"] != DBNull.Value ? Convert.ToString(dr["Party_Name"]) : "",
                                Shipper_QrCode = dr["shipper_qrcode"] != DBNull.Value ? Convert.ToString(dr["shipper_qrcode"]) : null,
                                PlantName = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : null
                            };

                            result.Add(obj);
                        }
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            if (isPrint == true)
                return View("_Partial_KnowYourBottle", (searchTerm, result, isPrint));
            else
                return PartialView("_Partial_KnowYourBottle", (searchTerm, result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_KnowYourInvoice(string invoice_qr_code, bool withDetail = false, bool isPrint = false)
        {
            var result = new KnowYourInvoice();

            DataSet ds = new DataSet();

            if (!string.IsNullOrEmpty(invoice_qr_code))
                try
                {
                    var oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_INVOICE_QR_CODE", OracleDbType.NVarchar2) { Value = invoice_qr_code });
                    oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Int64) { Value = withDetail ? 1 : 0 });

                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
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
                                ShipperQRCode = dr["SHIPPER_QR_CODE"] != DBNull.Value ? Convert.ToString(dr["SHIPPER_QR_CODE"]) : "",
                                Batch_no = dr["BATCH_NO"] != DBNull.Value ? Convert.ToString(dr["BATCH_NO"]) : "",
                                mfg_dt = dr["mfg_date"] != DBNull.Value ? Convert.ToString(dr["mfg_date"]) : "",
                                expiry_dt = dr["expiry_date"] != DBNull.Value ? Convert.ToString(dr["expiry_date"]) : ""
                            });
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            if (isPrint == true)
                return View("_Partial_KnowYourInvoice", (invoice_qr_code, withDetail, result, isPrint));
            else
                return PartialView("_Partial_KnowYourInvoice", (invoice_qr_code, withDetail, result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_BatchLogFile(string searchTerm, string FromDate = null, string ToDate = null, bool isPrint = false)
        {
            var result = new List<BatchLogFile>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.String) { Value = searchTerm ?? "" });
                oParams.Add(new MySqlParameter("P_FROM_DATE", MySqlDbType.String) { Value = FromDate ?? "" });
                oParams.Add(new MySqlParameter("P_TO_DATE", MySqlDbType.String) { Value = ToDate ?? "" });

                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_REPORT_BATCH_LOG_FILE", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                    {
                        var obj = new BatchLogFile()
                        {
                            SrNo = dr["Sr_No"] != DBNull.Value ? Convert.ToInt64(dr["Sr_No"]) : 0,
                            FileName = dr["FileName"] != DBNull.Value ? Convert.ToString(dr["FileName"]) : "",
                            StartDate = dr["StartDate"] != DBNull.Value ? Convert.ToString(dr["StartDate"]) : "",
                            EndDate = dr["EndDate"] != DBNull.Value ? Convert.ToString(dr["EndDate"]) : "",
                            QRCode_Count = dr["QRCode_Count"] != DBNull.Value ? Convert.ToInt64(dr["QRCode_Count"]) : 0,
                            Status = dr["Status"] != DBNull.Value ? Convert.ToString(dr["Status"]) : "",
                            Remark = dr["Remark"] != DBNull.Value ? Convert.ToString(dr["Remark"]) : "",
                            Batch_no = dr["Batch_no"] != DBNull.Value ? Convert.ToString(dr["Batch_no"]) : "",
                            mfg_dt = dr["mfg_date"] != DBNull.Value ? Convert.ToString(dr["mfg_date"]) : "",
                            expiry_dt = dr["expiry_date"] != DBNull.Value ? Convert.ToString(dr["expiry_date"]) : "",
                            total_shipper_qty = dr["total_shipper_qty"] != DBNull.Value ? Convert.ToString(dr["total_shipper_qty"]) : ""
                        };

                        result.Add(obj);
                    }
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            var PlantName = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            var PageTitle_Secondary = "";

            if (!string.IsNullOrEmpty(searchTerm))
                PageTitle_Secondary = "File Name / Batch No. : " + searchTerm;

            if (!string.IsNullOrEmpty(FromDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {FromDate.ToUpper()}";

            if (!string.IsNullOrEmpty(ToDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {ToDate.ToUpper()}";

            if (isPrint == true)
                return View("_Partial_BatchLogFile", (searchTerm, PageTitle_Secondary, PlantName, FromDate, ToDate, result, isPrint));
            else
                return PartialView("_Partial_BatchLogFile", (searchTerm, PageTitle_Secondary, PlantName, FromDate, ToDate, result, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_BatchLogFileLive(string searchTerm, string FromDate = null, string ToDate = null, bool isPrint = false)
        {
            var result = new List<BatchLogFile>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.NVarchar2) { Value = searchTerm ?? "" });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.NVarchar2) { Value = FromDate ?? "" });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.NVarchar2) { Value = ToDate ?? "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_PLANT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_BATCH_LOG_FILE_LIVE", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                    {
                        var obj = new BatchLogFile()
                        {
                            SrNo = dr["Sr_No"] != DBNull.Value ? Convert.ToInt64(dr["Sr_No"]) : 0,
                            FileName = dr["FileName"] != DBNull.Value ? Convert.ToString(dr["FileName"]) : "",
                            StartDate = dr["StartDate"] != DBNull.Value ? Convert.ToString(dr["StartDate"]) : "",
                            EndDate = dr["EndDate"] != DBNull.Value ? Convert.ToString(dr["EndDate"]) : "",
                            QRCode_Count = dr["QRCode_Count"] != DBNull.Value ? Convert.ToInt64(dr["QRCode_Count"]) : 0,
                            Status = dr["Status"] != DBNull.Value ? Convert.ToString(dr["Status"]) : "",
                            Remark = dr["Remark"] != DBNull.Value ? Convert.ToString(dr["Remark"]) : "",
                            Batch_no = dr["Batch_no"] != DBNull.Value ? Convert.ToString(dr["Batch_no"]) : "",
                            mfg_dt = dr["mfg_date"] != DBNull.Value ? Convert.ToString(dr["mfg_date"]) : "",
                            expiry_dt = dr["expiry_date"] != DBNull.Value ? Convert.ToString(dr["expiry_date"]) : "",
                            total_shipper_qty = dr["total_shipper_qty"] != DBNull.Value ? Convert.ToString(dr["total_shipper_qty"]) : ""
                        };

                        result.Add(obj);
                    }
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


            var PlantName = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            var PageTitle_Secondary = "";

            if (!string.IsNullOrEmpty(searchTerm))
                PageTitle_Secondary = "File Name / Batch No. : " + searchTerm;

            if (!string.IsNullOrEmpty(FromDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {FromDate.ToUpper()}";

            if (!string.IsNullOrEmpty(ToDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {ToDate.ToUpper()}";

            if (isPrint == true)
                return View("_Partial_BatchLogFileLive", (searchTerm, PageTitle_Secondary, PlantName, FromDate, ToDate, result, isPrint));
            else
                return PartialView("_Partial_BatchLogFileLive", (searchTerm, PageTitle_Secondary, PlantName, FromDate, ToDate, result, isPrint));
        }
    }
}