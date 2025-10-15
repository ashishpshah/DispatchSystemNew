using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Bibliography;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class VendorPoController : BaseController<ResponseModel<VendorPO>>
    {
        #region Loading

        public IActionResult Index()
        {
            //try
            //{
            //	CommonViewModel.Obj = new VendorPO() { PoDate_Text = DateTime.Now.Year.ToString() };
            //}
            //catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return View(CommonViewModel);
        }

        #endregion

        #region Methods

        public ActionResult GetData_VendorPO(JqueryDatatableParam param)
        {
            string PoNo = HttpContext.Request.Query["PoNo"];
            string VendorCode = HttpContext.Request.Query["VendorCode"];
            string Year = HttpContext.Request.Query["Year"];

            List<VendorPO> result = new List<VendorPO>();

            List<OracleParameter> oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = -1 });
            oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = PoNo ?? "" });
            oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = VendorCode ?? "" });
            oParams.Add(new OracleParameter("P_YEAR", OracleDbType.Int16) { Value = string.IsNullOrEmpty(Year) ? 0 : Convert.ToInt32(Year) });
            oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
            oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = param.sSearch ?? "" });
            oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = param.iDisplayLength });
            oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = param.iDisplayStart });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
            oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
            oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

            var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_PO_GET", oParams);

            if (dt != null && dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                    result.Add(new VendorPO()
                    {
                        SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToInt64(dr["RNUM"]) : 0,
                        Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                        PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                        SiteId = dr["SITE_ID"] != DBNull.Value ? Convert.ToInt64(dr["SITE_ID"]) : 0,
                        VendorId = dr["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_ID"]) : null,
                        VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
                        VendorName = dr["VENDOR_NAME"] != DBNull.Value ? Convert.ToString(dr["VENDOR_NAME"]) : "",
                        VendorSite = dr["VENDOR_SITE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_SITE"]) : "",
                        PoNo = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : null,
                        PoDate = dr["PO_DATE"] != DBNull.Value ? Convert.ToDateTime(dr["PO_DATE"]) : nullDateTime,
                        PoDate_Text = dr["PO_DATE_TEXT"] != DBNull.Value ? Convert.ToString(dr["PO_DATE_TEXT"]) : "",
                        PoDesc = dr["PO_DESC"] != DBNull.Value ? Convert.ToString(dr["PO_DESC"]) : "",
                        IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
                    });
            }

            return Json(new
            {
                param.sEcho,
                iTotalRecords = result.Count(),
                iTotalDisplayRecords = dt != null && dt.Rows.Count > 0 ? Convert.ToInt32(dt.Rows[0]["COUNT_ROW"]?.ToString()) : 0,
                aaData = result
            });

        }

        [HttpGet]
        public IActionResult Partial_AddEditForm(int Id)
        {
            var obj = new VendorPO();

            List<VendorPoDtls> ListVendorPoDtls = new List<VendorPoDtls>();
            List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

            var dt = new DataTable();
            DataSet ds = new DataSet();

            List<OracleParameter> oParams = new List<OracleParameter>();

            try
            {
                if (Id > 0)
                {
                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Id });
                    oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_YEAR", OracleDbType.Int16) { Value = 0 });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_PO_GET", oParams);

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        obj = new VendorPO()
                        {
                            Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["ID"]) : 0,
                            PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
                            SiteId = ds.Tables[0].Rows[0]["SITE_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["SITE_ID"]) : 0,
                            VendorId = ds.Tables[0].Rows[0]["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_ID"]) : null,
                            PoNo = ds.Tables[0].Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_NO"]) : null,
                            PoDate = ds.Tables[0].Rows[0]["PO_DATE"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[0]["PO_DATE"]) : nullDateTime,
                            PoDate_Text = ds.Tables[0].Rows[0]["PO_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DATE_TEXT"]) : null,
                            PoDesc = ds.Tables[0].Rows[0]["PO_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DESC"]) : "",
                            IsActive = ds.Tables[0].Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISACTIVE"]) : false,
                        };

                    if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[1].Rows)
                            ListVendorPoDtls.Add(new VendorPoDtls()
                            {
                                Id = dr["ID_DTL"] != DBNull.Value ? Convert.ToInt64(dr["ID_DTL"]) : 0,
                                VPO_Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                                PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                                LineNo = dr["LINE_ITEM_NO"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_NO"]) : "",
                                LineDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
                                LineQty = dr["LINE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LINE_QTY"]) : 0,
                                UOM = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : "",
                                //Requested_Qty = dr["Requested_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Requested_Qty"]) : 0,
                                Adjusted_Qty = dr["Adjusted_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Adjusted_Qty"]) : 0,
                                Amendment_Qty = dr["Amendment_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Amendment_Qty"]) : 0,
                                Remark = dr["Remark"] != DBNull.Value ? Convert.ToString(dr["Remark"]) : "",
                                //IsPosted = dr["ISPOSTED"] != DBNull.Value ? Convert.ToBoolean(dr["ISPOSTED"]) : false,
                                //IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
                            });
                    }

                    obj.listVendorPoDtls = ListVendorPoDtls;

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
            oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
            oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
            oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
            oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
            oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

            dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);

            list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));
            if (dt != null && dt.Rows.Count > 0)
                foreach (DataRow row in dt.Rows)
                    list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

            oParams[0].Value = obj.VendorId;

            ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams);

            if (ds != null && ds.Tables.Count > 1)
            {
                dt = ds.Tables[1];

                list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor Site --", "N"));
                foreach (DataRow row in dt.Rows)
                    list.Add(new SelectListItem_Custom(row["SITE_ID"].ToString(), row["SITE_NAME"].ToString() + " (" + row["SITE_CODE"].ToString() + ") ", "N"));

            }

            oParams = new List<OracleParameter>();

            oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = "UOM" });
            oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
            oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
            oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
            oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
            oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
            oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

            dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams);

            list.Insert(0, new SelectListItem_Custom("", "--Select UOM--", "U"));
            foreach (DataRow row in dt.Rows)
                list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

            if (obj.listVendorPoDtls == null)
                obj.listVendorPoDtls = new List<VendorPoDtls>();

            CommonViewModel.Obj = obj;

            CommonViewModel.SelectListItems = list;

            return PartialView("_Partial_AddEditForm", CommonViewModel);

        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Get_PO_Details(string PoNo)
        {
            try
            {
                if (string.IsNullOrEmpty(PoNo))
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter PO No.";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }


                var dt = new DataTable();
                DataSet ds = new DataSet();

                List<OracleParameter> oParams = new List<OracleParameter>();

                try
                {
                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = PoNo });
                    oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_YEAR", OracleDbType.Int16) { Value = 0 });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_SEARCH_TERM", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_DISPLAY_LENGTH", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_DISPLAY_START", OracleDbType.Int64) { Value = 0 });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_DTLS", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_PO_GET", oParams);

                    if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                        CommonViewModel.Obj = new VendorPO()
                        {
                            Id = ds.Tables[0].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["ID"]) : 0,
                            PlantId = ds.Tables[0].Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["PLANT_ID"]) : 0,
                            SiteId = ds.Tables[0].Rows[0]["SITE_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["SITE_ID"]) : 0,
                            VendorId = ds.Tables[0].Rows[0]["VENDOR_ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["VENDOR_ID"]) : null,
                            PoNo = ds.Tables[0].Rows[0]["PO_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_NO"]) : null,
                            PoDate = ds.Tables[0].Rows[0]["PO_DATE"] != DBNull.Value ? Convert.ToDateTime(ds.Tables[0].Rows[0]["PO_DATE"]) : nullDateTime,
                            PoDate_Text = ds.Tables[0].Rows[0]["PO_DATE_TEXT"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DATE_TEXT"]) : null,
                            PoDesc = ds.Tables[0].Rows[0]["PO_DESC"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["PO_DESC"]) : "",
                            //IsActive = ds.Tables[0].Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(ds.Tables[0].Rows[0]["ISACTIVE"]) : false,
                        };

                    if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        CommonViewModel.Obj.listVendorPoDtls = new List<VendorPoDtls>();

                        foreach (DataRow dr in ds.Tables[1].Rows)
                            CommonViewModel.Obj.listVendorPoDtls.Add(new VendorPoDtls()
                            {
                                Id = dr["ID_DTL"] != DBNull.Value ? Convert.ToInt64(dr["ID_DTL"]) : 0,
                                VPO_Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
                                PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
                                LineNo = dr["LINE_ITEM_NO"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_NO"]) : "",
                                LineDesc = dr["LINE_ITEM_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_ITEM_DESC"]) : "",
                                LineQty = dr["LINE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LINE_QTY"]) : 0,
                                UOM = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : "",
                                Adjusted_Qty = dr["Adjusted_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Adjusted_Qty"]) : 0,
                                Amendment_Qty = dr["Amendment_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Amendment_Qty"]) : 0,
                                Remark = dr["Remark"] != DBNull.Value ? Convert.ToString(dr["Remark"]) : "",
                                //IsPosted = dr["ISPOSTED"] != DBNull.Value ? Convert.ToBoolean(dr["ISPOSTED"]) : false,
                                //IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
                            });
                    }

                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


                if (CommonViewModel.Obj == null)
                {
                    var client = new HttpClient();
                    var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

                    try
                    {
                        StringContent? content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"50007\", \"P_PO_NUM\" : \"" + PoNo + "\", \"P_UNIT_CODE\" : \"" + Common.Get_Session_Int(SessionKey.UNIT_CODE) + "\"}", null, "application/json");

                        request.Content = content;

                        var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

                        if (webRequestResponse.IsSuccessStatusCode)
                        {
                            var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

                            if (!string.IsNullOrEmpty(responseContent))
                            {
                                JToken objData = JObject.Parse(responseContent);

                                if (objData != null && objData["GetPOHdrs"] != null)
                                {
                                    CommonViewModel.Obj = new VendorPO()
                                    {
                                        PoNo = objData["GetPOHdrs"][0]["po_number"] != null ? Convert.ToString(objData["GetPOHdrs"][0]["po_number"]) : null,
                                        PoDate = objData["GetPOHdrs"][0]["po_date"] != null ? DateTime.ParseExact(Convert.ToString(objData["GetPOHdrs"][0]["po_date"]), "yyyy-MM-dd HH:mm:ss.s", CultureInfo.InvariantCulture) : null,
                                        PoDate_Text = objData["GetPOHdrs"][0]["po_date"] != null ? DateTime.ParseExact(Convert.ToString(objData["GetPOHdrs"][0]["po_date"]), "yyyy-MM-dd HH:mm:ss.s", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : null,
                                        PoDesc = objData["GetPOHdrs"][0]["po_header_desc"] != null ? Convert.ToString(objData["GetPOHdrs"][0]["po_header_desc"]) : "",
                                        VendorCode = objData["GetPOHdrs"][0]["vendor_code"] != null ? Convert.ToInt64(objData["GetPOHdrs"][0]["vendor_code"]) : null,
                                        VendorName = objData["GetPOHdrs"][0]["vendor_name"] != null ? Convert.ToString(objData["GetPOHdrs"][0]["vendor_name"]) : null,
                                        VendorSite = objData["GetPOHdrs"][0]["vendor_site_code"] != null ? Convert.ToString(objData["GetPOHdrs"][0]["vendor_site_code"]) : null
                                    };
                                }
                            }
                        }
                    }
                    catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

                    if (CommonViewModel != null && CommonViewModel.Obj != null)
                        try
                        {
                            client = new HttpClient();
                            request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

                            StringContent? content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"50006\", \"P_VENDOR_CODE\" : \"295129\"}", null, "application/json");

                            request.Content = content;

                            var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

                            client = new HttpClient();
                            request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

                            content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"50008\", \"P_PO_NUM\" : \"" + PoNo + "\", \"P_UNIT_CODE\" : \"" + Common.Get_Session_Int(SessionKey.UNIT_CODE) + "\"}", null, "application/json");

                            request.Content = content;

                            webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

                            if (webRequestResponse.IsSuccessStatusCode)
                            {
                                var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

                                if (!string.IsNullOrEmpty(responseContent))
                                {
                                    JToken objData = JObject.Parse(responseContent);

                                    if (objData != null && objData["GetPODtls"] != null)
                                    {
                                        CommonViewModel.Obj.listVendorPoDtls = new List<VendorPoDtls>();

                                        foreach (JToken item in objData["GetPODtls"])
                                        {
                                            try
                                            {
                                                CommonViewModel.Obj.listVendorPoDtls.Add(new VendorPoDtls()
                                                {
                                                    LineNo = item["po_line_no"] != null ? Convert.ToString(item["po_line_no"]) : "",
                                                    LineDesc = item["line_desc"] != null ? Convert.ToString(item["line_desc"]) : "",
                                                    UOM = item["uom"] != null ? Convert.ToString(item["uom"]) : "",
                                                    LineQty = item["line_qty"] != null ? Convert.ToInt64(item["line_qty"]) : 0
                                                });
                                            }
                                            catch { continue; }
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


                }

                if (CommonViewModel.Obj != null && CommonViewModel.Obj.VendorId > 0)
                    CommonViewModel.SelectListItems = fnGetVendorSitelist(CommonViewModel.Obj.VendorId ?? 0);
                else if (CommonViewModel.Obj != null && (CommonViewModel.Obj.VendorId ?? 0) == 0 && (CommonViewModel.Obj.VendorCode ?? 0) > 0)
                    CommonViewModel.SelectListItems = fnGetVendorSitelist(0, Convert.ToString(CommonViewModel.Obj.VendorCode ?? 0));


                if (CommonViewModel.Obj != null && (CommonViewModel.Obj.VendorId ?? 0) == 0 && (CommonViewModel.Obj.VendorCode ?? 0) > 0)
                {
                    oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = CommonViewModel.Obj.VendorCode });
                    oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = CommonViewModel.Obj.VendorCode });
                    oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                    oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                    oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                    ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams);

                    if (ds == null || ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0)
                    {
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Vendor not found. Please copy vendor from ERP." + System.Environment.NewLine + System.Environment.NewLine
                            + "Vendor Code : " + (CommonViewModel.Obj.VendorCode ?? 0) + System.Environment.NewLine + System.Environment.NewLine
                            + "Vendor Name : " + CommonViewModel.Obj.VendorName + System.Environment.NewLine + System.Environment.NewLine
                            + "Site : " + CommonViewModel.Obj.VendorSite;

                        CommonViewModel.Obj = null;

                        return Json(CommonViewModel);
                    }
                    else if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count == 0)
                    {
                        CommonViewModel.IsSuccess = false;
                        CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        CommonViewModel.Message = "Vendor Site not found. Please merge vendor site from ERP." + System.Environment.NewLine + System.Environment.NewLine
                            + "Vendor Code : " + (CommonViewModel.Obj.VendorCode ?? 0) + System.Environment.NewLine + System.Environment.NewLine
                            + "Vendor Name : " + CommonViewModel.Obj.VendorName + System.Environment.NewLine + System.Environment.NewLine
                            + "Site : " + CommonViewModel.Obj.VendorSite;

                        CommonViewModel.Obj = null;

                        return Json(CommonViewModel);
                    }
                    else if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                    {
                        DataView dv = new DataView(ds.Tables[1]);
                        dv.RowFilter = "PLANT_ID = " + Common.Get_Session_Int(SessionKey.PLANT_ID);
                        //if (dv != null && dv.ToTable().Rows != null && dv.ToTable().Rows.Count > 0)
                        //{
                        //	dv = new DataView(ds.Tables[1]);
                        //	dv.RowFilter = "SITE_ID = " + Common.Get_Session_Int(SessionKey.SITE_ID);
                        //	if (dv == null || dv.ToTable().Rows == null || dv.ToTable().Rows.Count == 0)
                        //	{
                        //		CommonViewModel.IsSuccess = false;
                        //		CommonViewModel.StatusCode = ResponseStatusCode.Error;
                        //		CommonViewModel.Message = "Vendor Site is not map to current site." + System.Environment.NewLine + System.Environment.NewLine
                        //			+ "Vendor Code : " + (CommonViewModel.Obj.VendorCode ?? 0) + System.Environment.NewLine + System.Environment.NewLine
                        //			+ "Vendor Name : " + CommonViewModel.Obj.VendorName + System.Environment.NewLine + System.Environment.NewLine
                        //			+ "Site : " + CommonViewModel.Obj.VendorSite;

                        //		CommonViewModel.Obj = null;

                        //		return Json(CommonViewModel);
                        //	}
                        //}
                        //else
                        if (dv == null || dv.ToTable().Rows == null || dv.ToTable().Rows.Count == 0)
                        {
                            CommonViewModel.IsSuccess = false;
                            CommonViewModel.StatusCode = ResponseStatusCode.Error;
                            CommonViewModel.Message = "Vendor is exist in another plant. Please Map to current plant." + System.Environment.NewLine + System.Environment.NewLine
                                + "Vendor Code : " + (CommonViewModel.Obj.VendorCode ?? 0) + System.Environment.NewLine + System.Environment.NewLine
                                + "Vendor Name : " + CommonViewModel.Obj.VendorName + System.Environment.NewLine + System.Environment.NewLine
                                + "Site : " + CommonViewModel.Obj.VendorSite;

                            CommonViewModel.Obj = null;

                            return Json(CommonViewModel);
                        }
                    }
                }

                CommonViewModel.IsSuccess = (CommonViewModel.Obj == null);
                CommonViewModel.StatusCode = (CommonViewModel.Obj == null) ? ResponseStatusCode.Error : ResponseStatusCode.Success;
                CommonViewModel.Message = (CommonViewModel.Obj == null) ? ResponseStatusMessage.NotFound : ResponseStatusMessage.Success;

                CommonViewModel.RedirectURL = "";

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
        public JsonResult Save(VendorPO viewModel)
        {
            try
            {
                if (viewModel == null)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter Vendor PO details";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }


                string objList_JSON = "";

                if (viewModel.listVendorPoDtls != null && viewModel.listVendorPoDtls.Any(x => !string.IsNullOrEmpty(x.LineDesc) && !string.IsNullOrEmpty(x.UOM) && x.LineQty > 0))
                    objList_JSON = string.Join("<#>", viewModel.listVendorPoDtls.Where(x => !string.IsNullOrEmpty(x.LineDesc) && !string.IsNullOrEmpty(x.UOM) && x.LineQty > 0)
                                                        .Select(x => x.Id + "|" + x.LineNo + "|" + x.LineDesc + "|" + x.UOM + "|" + x.LineQty + "|" + x.Adjusted_Qty + "|" + x.Amendment_Qty + "|" + x.Remark).ToArray());

                List<OracleParameter> oParams = new List<OracleParameter>();

                VendorPoDtls vendorPoDtls = new VendorPoDtls();

                DataTable dt = new DataTable();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
                oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
                oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = viewModel.SiteId });
                oParams.Add(new OracleParameter("P_PO_NO", OracleDbType.Varchar2) { Value = viewModel.PoNo });
                oParams.Add(new OracleParameter("P_PO_DATE", OracleDbType.Varchar2) { Value = viewModel.PoDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
                oParams.Add(new OracleParameter("P_PO_DESC", OracleDbType.Varchar2) { Value = viewModel.PoDesc });
                oParams.Add(new OracleParameter("P_PO_DTLS", OracleDbType.Varchar2) { Value = objList_JSON });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.IsActive ? "Y" : "N" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_PO_SAVE", oParams, true);

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


        [HttpPost]
        public JsonResult DeleteConfirmed(long id = 0, long id_dtls = 0)
        {
            try
            {
                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                oParams.Add(new OracleParameter("P_ID_DTLS", OracleDbType.Int64) { Value = id_dtls });
                oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_PO_DELETE", oParams, true);

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


        [HttpPost]
        public JsonResult GetVendorSitelist(long Vendor_Id = 0)
        {
            var list2 = new List<SelectListItem_Custom>();
            try
            {
                list2 = fnGetVendorSitelist(Vendor_Id);
                //List<OracleParameter> oParams3 = new List<OracleParameter>();

                //oParams3.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Vendor_Id });
                //oParams3.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = "" });
                //oParams3.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
                //oParams3.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                //oParams3.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                //oParams3.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                //oParams3.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                //oParams3.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                //oParams3.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                //oParams3.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                //var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams3);

                //if (ds != null && ds.Tables.Count > 1)
                //{
                //	var dt = ds.Tables[1];

                //	foreach (DataRow row in dt.Rows)
                //		list2.Add(new SelectListItem_Custom(row["SITE_ID"].ToString(), row["SITE_NAME"].ToString() + " (" + row["SITE_CODE"].ToString() + ") ", "S"));

                //}
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            list2.Insert(0, new SelectListItem_Custom("", "-- Select Vendor Site --", "S"));

            return Json(list2);
        }

        private List<SelectListItem_Custom> fnGetVendorSitelist(long Vendor_Id = 0, string VendorCode = null)
        {
            var list2 = new List<SelectListItem_Custom>();

            try
            {
                List<OracleParameter> oParams3 = new List<OracleParameter>();

                oParams3.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = Vendor_Id });
                oParams3.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Varchar2) { Value = VendorCode });
                oParams3.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
                oParams3.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
                oParams3.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams3.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams3.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams3.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
                oParams3.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
                oParams3.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams3);

                if (ds != null && ds.Tables.Count > 1)
                {
                    var dt = ds.Tables[1];

                    foreach (DataRow row in dt.Rows)
                        list2.Add(new SelectListItem_Custom(row["SITE_ID"].ToString(), row["SITE_NAME"].ToString() + " (" + row["SITE_CODE"].ToString() + ") ", "S"));

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return list2;
        }


        #endregion


    }
}

