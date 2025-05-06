using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("Admin")]
    public class ReportsController : BaseController<ResponseModel<QRCodeGeneration>>
    {
        public IActionResult Index(string type = "")
        {
            CommonViewModel.Status = type;

            var list = new List<SelectListItem_Custom>();

            CommonViewModel.Obj = new QRCodeGeneration();

            list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    list.Insert(0, new SelectListItem_Custom("", "--Select--", "P"));
                foreach (DataRow dr in dt.Rows)
                    list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "", "P"));

                oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                dt = new DataTable();
                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);
                if (dt != null && dt.Rows.Count > 0)
                {
                    list.Insert(0, new SelectListItem_Custom("", "--Select Site--", "V"));
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_CODE"]) : "", dr["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(dr["ORGANIZATION_NAME"]) : "", "V"));
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.SelectListItems = list;

            return View(CommonViewModel);
        }


        [HttpGet]
        public IActionResult GetData_QRCodePrintReceipt(int VendorCode, int SiteId, int ProductId, string FromDate, string ToDate, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<QRCodeGeneration>();

            string SKU_Name = "";
            string VendorName = "";
            string VendorSiteName = "";

            DataSet ds = new DataSet();

            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = VendorCode });
                oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = SiteId });
                oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = ProductId });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate ?? "" });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate ?? "" });
                oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = 0 });
                oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });

                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                oParams.Add(new OracleParameter("P_PAGE_HEADING", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_QR_CODE_PRINT_RECEIPT", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    SKU_Name = ds.Tables[1].Rows[0]["SKU_DESC"] != DBNull.Value ? ds.Tables[1].Rows[0]["SKU_DESC"].ToString() : "";
                    VendorName = ds.Tables[1].Rows[0]["VENDOR_NAME"] != DBNull.Value ? ds.Tables[1].Rows[0]["VENDOR_NAME"].ToString() : "";
                    VendorSiteName = ds.Tables[1].Rows[0]["VENDOR_SITE"] != DBNull.Value ? ds.Tables[1].Rows[0]["VENDOR_SITE"].ToString() : "";

                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new QRCodeGeneration()
                        {
                            SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                            PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                            PlantName = (dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) + " - " : "") + (dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : ""),
                            VendorId = dr["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_ID"]) : 0,
                            VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : 0,
                            VendorName = dr["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(dr["VENDOR_NAME"]) : "",
                            VendorSiteName = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
                            VPO_Id = dr["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VPO_SYS_ID"]) : 0,
                            PoNumber = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : null,
                            RequestNo = dr["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dr["REQUEST_NO"]) : null,
                            RequestDate_Text = dr["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_DATE_TEXT"]) : "",
                            RequestStatus = dr["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS_TEXT"]) : "",
                            LineItemDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
                            SkuDesc = dr["SKU_DESC"] != DBNull.Value ? Convert.ToString(dr["SKU_DESC"]) : "",
                            TotalQty = dr["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_QTY"]) : 0,
                            RequestQty = dr["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUEST_QTY"]) : 0,
                            RemainQty = dr["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAIN_QTY"]) : 0,
                            FileEmailSend = dr["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(dr["FILE_EMAIL_SEND"]) : "",
                            IsFileEmail = dr["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(dr["IS_FILE_EMAIL"]) > 0 : false,
                            IsLock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(dr["IS_LOCK"]) > 0 : false,
                            IsPrintFinish = dr["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(dr["IS_PRINT_FINISHED"]) > 0 : false,
                            Nooffiles = dr["NO_OF_FILES"] != DBNull.Value ? Convert.ToInt64(dr["NO_OF_FILES"]) : 0,
                            ConsignmentNo = dr["CONSIGNMENT_NO"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_NO"]) : null,
                            ConsignmentDate_Text = dr["CONSIGNMENT_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_DATE_TEXT"]) : null,
                            ExpectedDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
                            ModeofDispatch = dr["MODE_OF_DISPATCH"] != DBNull.Value ? Convert.ToString(dr["MODE_OF_DISPATCH"]) : null,
                            EstimateDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
                            Shipmentdetail = dr["SHIPMENT_DETAILS"] != DBNull.Value ? Convert.ToString(dr["SHIPMENT_DETAILS"]) : null,
                            PrintNotes = dr["PRINT_NOTES"] != DBNull.Value ? Convert.ToString(dr["PRINT_NOTES"]) : null
                        });
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            PageTitle_Secondary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PAGE_TITLE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PAGE_TITLE"]) : "";


            if (VendorCode > 0 && VendorCode != null)
                PageTitle_Secondary += "Vendor Name : " + VendorName;

            if (SiteId > 0 && SiteId != null)
                PageTitle_Secondary += " Site : " + VendorSiteName;

            if (ProductId > 0 && ProductId != null)
                PageTitle_Secondary += " SKU Name : " + SKU_Name;

            if (!string.IsNullOrEmpty(FromDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {FromDate.ToUpper()}";

            if (!string.IsNullOrEmpty(ToDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {ToDate.ToUpper()}";

            if (isPrint == true)
                return View("_Partial_QRCodePrintReceipt", (PageTitle_Primary, PageTitle_Secondary, result, withDetail, isPrint));
            else
                return PartialView("_Partial_QRCodePrintReceipt", (PageTitle_Primary, PageTitle_Secondary, result, withDetail, isPrint));
        }

        [HttpGet]
        public IActionResult GetData_QRCodesView(int ProductId, string FromDate, string ToDate, string Type, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<QRCodeGeneration>();

            string SKU_Name = "";

            DataSet ds = new DataSet();

            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = ProductId });
                oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
                oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
                oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = 0 });
                oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = !string.IsNullOrEmpty(Type) && Type == "QR_VOP" ? "OP" : "" });
                oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });


                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                oParams.Add(new OracleParameter("P_PAGE_HEADING", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_QR_CODE_GEN", oParams);

                if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                {
                    SKU_Name = ds.Tables[1].Rows[0]["SKU_DESC"] != DBNull.Value ? ds.Tables[1].Rows[0]["SKU_DESC"].ToString() : "";

                    foreach (DataRow dr in ds.Tables[1].Rows)
                        result.Add(new QRCodeGeneration()
                        {
                            SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                            PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                            PlantName = (dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) + " - " : "") + (dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : ""),
                            VendorId = dr["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_ID"]) : 0,
                            VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : 0,
                            VendorName = dr["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(dr["VENDOR_NAME"]) : "",
                            VendorSiteName = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
                            VPO_Id = dr["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VPO_SYS_ID"]) : 0,
                            PO_Number = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : null,
                            RequestNo = dr["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dr["REQUEST_NO"]) : null,
                            RequestDate_Text = dr["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_DATE_TEXT"]) : "",
                            RequestStatus = dr["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS_TEXT"]) : "",
                            LineItemDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
                            SkuDesc = dr["SKU_DESC"] != DBNull.Value ? Convert.ToString(dr["SKU_DESC"]) : "",
                            TotalQty = dr["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_QTY"]) : 0,
                            RequestQty = dr["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUEST_QTY"]) : 0,
                            RemainQty = dr["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAIN_QTY"]) : 0,
                            FileEmailSend = dr["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(dr["FILE_EMAIL_SEND"]) : "",
                            IsFileEmail = dr["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(dr["IS_FILE_EMAIL"]) > 0 : false,
                            IsLock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(dr["IS_LOCK"]) > 0 : false,
                            IsPrintFinish = dr["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(dr["IS_PRINT_FINISHED"]) > 0 : false,
                            Nooffiles = dr["NO_OF_FILES"] != DBNull.Value ? Convert.ToInt64(dr["NO_OF_FILES"]) : 0,
                            ConsignmentNo = dr["CONSIGNMENT_NO"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_NO"]) : null,
                            ConsignmentDate_Text = dr["CONSIGNMENT_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_DATE_TEXT"]) : null,
                            ExpectedDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
                            ModeofDispatch = dr["MODE_OF_DISPATCH"] != DBNull.Value ? Convert.ToString(dr["MODE_OF_DISPATCH"]) : null,
                            EstimateDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
                            Shipmentdetail = dr["SHIPMENT_DETAILS"] != DBNull.Value ? Convert.ToString(dr["SHIPMENT_DETAILS"]) : null,
                            PrintNotes = dr["PRINT_NOTES"] != DBNull.Value ? Convert.ToString(dr["PRINT_NOTES"]) : null,
                            Created_By = dr["CREATED_BY"] != DBNull.Value ? Convert.ToString(dr["CREATED_BY"]) : null,
                            LastDownloadBy = dr["LAST_DOWNLOAD_BY"] != DBNull.Value ? Convert.ToString(dr["LAST_DOWNLOAD_BY"]) : null,
                            LastDownloadDate_Text = dr["LAST_DOWNLOAD_DATE"] != DBNull.Value ? Convert.ToString(dr["LAST_DOWNLOAD_DATE"]) : null,
                            Serial_No_From = dr["SERIAL_NO_FROM"] != DBNull.Value ? Convert.ToString(dr["SERIAL_NO_FROM"]) : null,
                            Serial_No_To = dr["SERIAL_NO_TO"] != DBNull.Value ? Convert.ToString(dr["SERIAL_NO_TO"]) : null
                        });
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            PageTitle_Secondary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PAGE_TITLE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PAGE_TITLE"]) : "";

            if (ProductId > 0 && ProductId != null)
                PageTitle_Secondary += " SKU Name : " + SKU_Name;

            if (!string.IsNullOrEmpty(FromDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}From Date : {FromDate.ToUpper()}";

            if (!string.IsNullOrEmpty(ToDate))
                PageTitle_Secondary += $"{(!string.IsNullOrEmpty(PageTitle_Secondary) ? " and " : "")}To Date : {ToDate.ToUpper()}";



            if (isPrint == true)
                return View("_Partial_QRCodesView", (PageTitle_Primary, PageTitle_Secondary, result, Type, withDetail, isPrint));
            else
                return PartialView("_Partial_QRCodesView", (PageTitle_Primary, PageTitle_Secondary, result, Type, withDetail, isPrint));
        }


        #region Loading

        public IActionResult QRCode_Print_Receipt()
        {
            var list = new List<SelectListItem_Custom>();

            CommonViewModel.Obj = new QRCodeGeneration();

            list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    list.Insert(0, new SelectListItem_Custom("", "--Select--", "P"));
                foreach (DataRow dr in dt.Rows)
                    list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "", "P"));

                oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                dt = new DataTable();
                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);
                if (dt != null && dt.Rows.Count > 0)
                {
                    list.Insert(0, new SelectListItem_Custom("", "--Select Site--", "V"));
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_CODE"]) : "", dr["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(dr["ORGANIZATION_NAME"]) : "", "V"));
                }

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.SelectListItems = list;

            return View(CommonViewModel);
        }

        public IActionResult QRCode_View_Sup()
        {
            var list = new List<SelectListItem_Custom>();
            CommonViewModel.Obj = new QRCodeGeneration();
            list.Insert(0, new SelectListItem_Custom("", "-- Select --"));

            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "", "P"));

                oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                dt = new DataTable();
                dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PLANT_GET", oParams, true);
                if (dt != null && dt.Rows.Count > 0)
                {
                    CommonViewModel.Obj.PlantId = Common.Get_Session_Int(SessionKey.PLANT_ID);
                    CommonViewModel.Obj.PlantName = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "";
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.SelectListItems = list;

            return View(CommonViewModel);
        }

        public ActionResult GetData_QrCodeReq(JqueryDatatableParam param)
        {
            //string RequestNo = HttpContext.Request.Query["RequestNo"];
            //string PoNo = HttpContext.Request.Query["PoNo"];
            string VendorCode = HttpContext.Request.Query["VendorCode"];
            string VendorSiteName = HttpContext.Request.Query["SiteId"];
            string ProductId = HttpContext.Request.Query["ProductId"];
            string FromDate = HttpContext.Request.Query["FromDate"];
            string ToDate = HttpContext.Request.Query["ToDate"];
            //string ConsignmentNo = HttpContext.Request.Query["ConsignmentNo"];
            string Type = HttpContext.Request.Query["Type"];

            List<QRCodeGeneration> result = new List<QRCodeGeneration>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
            oParams.Add(new OracleParameter("P_REQUEST_NO", OracleDbType.Varchar2) { Value = "" });
            //oParams.Add(new OracleParameter("P_REQUEST_PLANT", OracleDbType.Int64) { Value = -1 });
            oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
            oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = VendorCode ?? "" });
            oParams.Add(new OracleParameter("P_PROD_ID", OracleDbType.Int64) { Value = ProductId == "" ? null : Convert.ToInt32(ProductId) });
            oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.Varchar2) { Value = FromDate });
            oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.Varchar2) { Value = ToDate });
            oParams.Add(new OracleParameter("P_CONSIGNMENT_NO", OracleDbType.Varchar2) { Value = 0 });
            oParams.Add(new OracleParameter("P_TYPE", OracleDbType.Varchar2) { Value = Type });
            oParams.Add(new OracleParameter("P_WITH_DTLS", OracleDbType.Varchar2) { Value = "" });
            oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
            oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
            oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

            var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_QR_CODE_GET", oParams);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                    result.Add(new QRCodeGeneration()
                    {
                        SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToInt64(dr["RNUM"]) : 0,
                        Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                        PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                        PlantName = (dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) + " - " : "") + (dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : ""),
                        VendorId = dr["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_ID"]) : 0,
                        VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : 0,
                        VendorName = dr["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(dr["VENDOR_NAME"]) : "",
                        VendorSiteName = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
                        VPO_Id = dr["VPO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VPO_SYS_ID"]) : 0,
                        PoNumber = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : null,
                        RequestNo = dr["REQUEST_NO"] != DBNull.Value ? Convert.ToString(dr["REQUEST_NO"]) : null,
                        RequestDate_Text = dr["REQUEST_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_DATE_TEXT"]) : "",
                        RequestStatus = dr["REQUEST_STATUS_TEXT"] != DBNull.Value ? Convert.ToString(dr["REQUEST_STATUS_TEXT"]) : "",
                        LineItemDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
                        SkuDesc = dr["SKU_DESC"] != DBNull.Value ? Convert.ToString(dr["SKU_DESC"]) : "",
                        TotalQty = dr["TOTAL_QTY"] != DBNull.Value ? Convert.ToInt64(dr["TOTAL_QTY"]) : 0,
                        RequestQty = dr["REQUEST_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REQUEST_QTY"]) : 0,
                        RemainQty = dr["REMAIN_QTY"] != DBNull.Value ? Convert.ToInt64(dr["REMAIN_QTY"]) : 0,
                        FileEmailSend = dr["FILE_EMAIL_SEND"] != DBNull.Value ? Convert.ToString(dr["FILE_EMAIL_SEND"]) : "",
                        IsFileEmail = dr["IS_FILE_EMAIL"] != DBNull.Value ? Convert.ToInt32(dr["IS_FILE_EMAIL"]) > 0 : false,
                        IsLock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToInt32(dr["IS_LOCK"]) > 0 : false,
                        IsPrintFinish = dr["IS_PRINT_FINISHED"] != DBNull.Value ? Convert.ToInt32(dr["IS_PRINT_FINISHED"]) > 0 : false,
                        Nooffiles = dr["NO_OF_FILES"] != DBNull.Value ? Convert.ToInt64(dr["NO_OF_FILES"]) : 0,
                        ConsignmentNo = dr["CONSIGNMENT_NO"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_NO"]) : null,
                        ConsignmentDate_Text = dr["CONSIGNMENT_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["CONSIGNMENT_DATE_TEXT"]) : null,
                        ExpectedDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
                        ModeofDispatch = dr["MODE_OF_DISPATCH"] != DBNull.Value ? Convert.ToString(dr["MODE_OF_DISPATCH"]) : null,
                        EstimateDate_Text = dr["EXPECTED_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["EXPECTED_DATE_TEXT"]) : null,
                        Shipmentdetail = dr["SHIPMENT_DETAILS"] != DBNull.Value ? Convert.ToString(dr["SHIPMENT_DETAILS"]) : null,
                        PrintNotes = dr["PRINT_NOTES"] != DBNull.Value ? Convert.ToString(dr["PRINT_NOTES"]) : null
                    });
            }

            return Json(new
            {
                param.sEcho,
                iTotalRecords = result.Count(),
                iTotalDisplayRecords = ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 ? Convert.ToInt32(ds.Tables[0].Rows[0]["COUNT_ROW"]?.ToString()) : 0,
                aaData = result
            });

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

        #endregion

    }
}