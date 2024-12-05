
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class ProductController : BaseController<ResponseModel<Product>>
    {
        #region Loading
        public IActionResult Index()
        {
            var list = new List<Product>();

            try
            {
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

                    dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);
                }
                else
                {
                    List<MySqlParameter> oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PRODUCT_GET", oParams, true);
                }

                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        list.Add(new Product()
                        {
                            Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
                            Plant_id = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PLANT_ID"]) : 0,
                            //Plant_cd = dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "",
                            Sku_code = dr["SKU_CODE"] != DBNull.Value ? Convert.ToString(dr["SKU_CODE"]) : "",
                            Sku_name = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
                            Prd_cd = dr["PRD_CD"] != DBNull.Value ? Convert.ToString(dr["PRD_CD"]) : "",
                            Prd_desc = dr["PRD_DESC"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC"]) : "",
                            Is_posted = dr["IS_POSTED"] != DBNull.Value ? Convert.ToInt32(dr["IS_POSTED"]) : 0,
                            Prd_wt_fill = dr["PRD_WT_FILL"] != DBNull.Value ? Convert.ToDecimal(dr["PRD_WT_FILL"]) : 0,
                            Ship_wt_fill = dr["SHIP_WT_FILL"] != DBNull.Value ? Convert.ToDecimal(dr["SHIP_WT_FILL"]) : 0,
                            Prod_per_shipper = dr["PROD_PER_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(dr["PROD_PER_SHIPPER"]) : 0,
                            Tolerance_per = dr["TOLERANCE_PER"] != DBNull.Value ? Convert.ToDecimal(dr["TOLERANCE_PER"]) : 0,
                            Pal_wt_fill = dr["PAL_WT_FILL"] != DBNull.Value ? Convert.ToDecimal(dr["PAL_WT_FILL"]) : 0,
                            Ship_per_pallet = dr["SHIP_PER_PALLET"] != DBNull.Value ? Convert.ToDecimal(dr["SHIP_PER_PALLET"]) : 0,
                            Note = dr["NOTE"] != DBNull.Value ? Convert.ToString(dr["NOTE"]) : "",
                            Prd_desc_h = dr["PRD_DESC_H"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC_H"]) : "",
                            Print_order = dr["PRINT_ORDER"] != DBNull.Value ? Convert.ToString(dr["PRINT_ORDER"]) : "",
                            Prd_desc_short = dr["PRD_DESC_SHORT"] != DBNull.Value ? Convert.ToString(dr["PRD_DESC_SHORT"]) : "",
                            Extra1 = dr["EXTRA1"] != DBNull.Value ? Convert.ToString(dr["EXTRA1"]) : "",
                            Extra2 = dr["EXTRA2"] != DBNull.Value ? Convert.ToString(dr["EXTRA2"]) : "",
                            Extra3 = dr["EXTRA3"] != DBNull.Value ? Convert.ToString(dr["EXTRA3"]) : "",
                            Prd_type = dr["PRD_TYPE"] != DBNull.Value ? Convert.ToString(dr["PRD_TYPE"]) : "",
                            Sub_plant_cd = dr["SUB_PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["SUB_PLANT_CD"]) : "",
                            Prd_category = dr["PRD_CATEGORY"] != DBNull.Value ? Convert.ToString(dr["PRD_CATEGORY"]) : "",
                            Active = dr["ACTIVE"] != DBNull.Value ? Convert.ToString(dr["ACTIVE"]) : "",
                            Hsn_code = dr["HSN_CODE"] != DBNull.Value ? Convert.ToString(dr["HSN_CODE"]) : "",
                            Prd_cd_group_app = dr["PRD_CD_GROUP_APP"] != DBNull.Value ? Convert.ToString(dr["PRD_CD_GROUP_APP"]) : "",
                            Uom = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : "",
                            ConvFactor = dr["CONV_FACTOR"] != DBNull.Value ? Convert.ToInt64(dr["CONV_FACTOR"]) : 0,
                            UomEvikas = dr["UOM_EVIKAS"] != DBNull.Value ? Convert.ToString(dr["UOM_EVIKAS"]) : "",
                            Gtin = dr["GTIN"] != DBNull.Value ? Convert.ToString(dr["GTIN"]) : "",
                            Qr_last_serial_no = dr["QR_LAST_SERIAL_NO"] != DBNull.Value ? Convert.ToString(dr["QR_LAST_SERIAL_NO"]) : "",
                            BPEX = dr["BPEX"] != DBNull.Value ? Convert.ToString(dr["BPEX"]) : "",
                            Isactive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false
                        });
                    }
                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.ListObj = list;

            return View(CommonViewModel);
        }
        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Partial_AddEditForm(long id)
        {
            var obj = new Product();

            if (id > 0)
            {
                try
                {
                    var dt = new DataTable();

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PRODUCT_GET", oParams, true);
                    }
                    else
                    {
                        List<MySqlParameter> oParams = new List<MySqlParameter>();

                        oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
                        oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
                        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PRODUCT_GET", oParams, true);
                    }

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        obj = new Product()
                        {
                            Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
                            Plant_id = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
                            //Plant_cd = dt.Rows[0]["PLANT_CD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_CD"]) : "",
                            Sku_code = dt.Rows[0]["SKU_CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SKU_CODE"]) : "",
                            Sku_name = dt.Rows[0]["SKU_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SKU_NAME"]) : "",
                            Prd_cd = dt.Rows[0]["PRD_CD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_CD"]) : "",
                            Prd_desc = dt.Rows[0]["PRD_DESC"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_DESC"]) : "",
                            Is_posted = dt.Rows[0]["IS_POSTED"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["IS_POSTED"]) : 0,
                            Prd_wt_fill = dt.Rows[0]["PRD_WT_FILL"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["PRD_WT_FILL"]) : 0,
                            Ship_wt_fill = dt.Rows[0]["SHIP_WT_FILL"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["SHIP_WT_FILL"]) : 0,
                            Prod_per_shipper = dt.Rows[0]["PROD_PER_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["PROD_PER_SHIPPER"]) : 0,
                            Tolerance_per = dt.Rows[0]["TOLERANCE_PER"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["TOLERANCE_PER"]) : 0,
                            Pal_wt_fill = dt.Rows[0]["PAL_WT_FILL"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["PAL_WT_FILL"]) : 0,
                            Ship_per_pallet = dt.Rows[0]["SHIP_PER_PALLET"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["SHIP_PER_PALLET"]) : 0,
                            Note = dt.Rows[0]["NOTE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NOTE"]) : "",
                            Prd_desc_h = dt.Rows[0]["PRD_DESC_H"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_DESC_H"]) : "",
                            Print_order = dt.Rows[0]["PRINT_ORDER"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRINT_ORDER"]) : "",
                            Prd_desc_short = dt.Rows[0]["PRD_DESC_SHORT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_DESC_SHORT"]) : "",
                            Extra1 = dt.Rows[0]["EXTRA1"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EXTRA1"]) : "",
                            Extra2 = dt.Rows[0]["EXTRA2"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EXTRA2"]) : "",
                            Extra3 = dt.Rows[0]["EXTRA3"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EXTRA3"]) : "",
                            Prd_type = dt.Rows[0]["PRD_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_TYPE"]) : "",
                            Sub_plant_cd = dt.Rows[0]["SUB_PLANT_CD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SUB_PLANT_CD"]) : "",
                            Prd_category = dt.Rows[0]["PRD_CATEGORY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_CATEGORY"]) : "",
                            Active = dt.Rows[0]["ACTIVE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ACTIVE"]) : "",
                            Hsn_code = dt.Rows[0]["HSN_CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["HSN_CODE"]) : "",
                            Prd_cd_group_app = dt.Rows[0]["PRD_CD_GROUP_APP"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PRD_CD_GROUP_APP"]) : "",
                            Uom = dt.Rows[0]["UOM"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["UOM"]) : "",
                            ConvFactor = dt.Rows[0]["CONV_FACTOR"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["CONV_FACTOR"]) : 0,
							ValidMonth = dt.Rows[0]["VALIDITY_MONTH"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["VALIDITY_MONTH"]) : 0,
							UomEvikas = dt.Rows[0]["UOM_EVIKAS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["UOM_EVIKAS"]) : "",
                            Gtin = dt.Rows[0]["GTIN"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["GTIN"]) : "",
                            Qr_last_serial_no = dt.Rows[0]["QR_LAST_SERIAL_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["QR_LAST_SERIAL_NO"]) : "",
                            BPEX = dt.Rows[0]["BPEX"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["BPEX"]) : "",
                            Isactive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false
                        };
                    }

                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            }

            CommonViewModel.Obj = obj;

            return PartialView("_Partial_AddEditForm", CommonViewModel);
        }

        #endregion

        #region Events

        [HttpPost]
        public JsonResult Save(Product viewModel)
        {
            try
            {
                if (viewModel == null)
                {
                    CommonViewModel.IsSuccess = false;
                    CommonViewModel.Message = "Please enter Product details";
                    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                    return Json(CommonViewModel);
                }

                var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                if (AppHttpContextAccessor.IsCloudDBActive)
                {
                    List<OracleParameter> oParams = new List<OracleParameter>();

                    oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
                    //oParams.Add(new OracleParameter("P_CODE", OracleDbType.Varchar2) { Value = viewModel.Plant_cd });
                    oParams.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = viewModel.Prd_desc });
                    oParams.Add(new OracleParameter("P_SKU_CODE", OracleDbType.Varchar2) { Value = viewModel.Sku_code });
                    oParams.Add(new OracleParameter("P_SKU_NAME", OracleDbType.Varchar2) { Value = viewModel.Sku_name });
                    oParams.Add(new OracleParameter("P_PRD_CD", OracleDbType.Varchar2) { Value = viewModel.Prd_cd });
                    oParams.Add(new OracleParameter("P_IS_POSTED", OracleDbType.Int64) { Value = viewModel.Is_posted });
                    oParams.Add(new OracleParameter("P_PRD_WT_FILL", OracleDbType.Int64) { Value = viewModel.Prd_wt_fill });
                    oParams.Add(new OracleParameter("P_SHIP_WT_FILL", OracleDbType.Int64) { Value = viewModel.Ship_wt_fill });
                    oParams.Add(new OracleParameter("P_PROD_PER_SHIPPER", OracleDbType.Int64) { Value = viewModel.Prod_per_shipper });
                    oParams.Add(new OracleParameter("P_TOLERANCE_PER", OracleDbType.Int64) { Value = viewModel.Tolerance_per });
                    oParams.Add(new OracleParameter("P_PAL_WT_FILL", OracleDbType.Int64) { Value = viewModel.Pal_wt_fill });
                    oParams.Add(new OracleParameter("P_SHIP_PER_PALLET", OracleDbType.Int64) { Value = viewModel.Ship_per_pallet });
                    oParams.Add(new OracleParameter("P_NOTE", OracleDbType.Varchar2) { Value = viewModel.Note });
                    oParams.Add(new OracleParameter("P_PRD_DESC_H", OracleDbType.Varchar2) { Value = viewModel.Prd_desc_h });
                    oParams.Add(new OracleParameter("P_PRINT_ORDER", OracleDbType.Varchar2) { Value = viewModel.Print_order });
                    oParams.Add(new OracleParameter("P_PRD_DESC_SHORT", OracleDbType.Varchar2) { Value = viewModel.Prd_desc_short });
                    oParams.Add(new OracleParameter("P_EXTRA1", OracleDbType.Varchar2) { Value = viewModel.Extra1 });
                    oParams.Add(new OracleParameter("P_EXTRA2", OracleDbType.Varchar2) { Value = viewModel.Extra2 });
                    oParams.Add(new OracleParameter("P_EXTRA3", OracleDbType.Varchar2) { Value = viewModel.Extra3 });
                    oParams.Add(new OracleParameter("P_PRD_TYPE", OracleDbType.Varchar2) { Value = viewModel.Prd_type });
                    oParams.Add(new OracleParameter("P_SUB_PLANT_CD", OracleDbType.Varchar2) { Value = viewModel.Sub_plant_cd });
                    oParams.Add(new OracleParameter("P_PRD_CATEGORY", OracleDbType.Varchar2) { Value = viewModel.Prd_category });
                    oParams.Add(new OracleParameter("P_ACTIVE", OracleDbType.Varchar2) { Value = viewModel.Active });
                    oParams.Add(new OracleParameter("P_HSN_CODE", OracleDbType.Varchar2) { Value = viewModel.Hsn_code });
                    oParams.Add(new OracleParameter("P_PRD_CD_GROUP_APP", OracleDbType.Varchar2) { Value = viewModel.Prd_cd_group_app });
                    oParams.Add(new OracleParameter("P_UOM", OracleDbType.Varchar2) { Value = viewModel.Uom });
                    oParams.Add(new OracleParameter("P_CONV_FACTOR", OracleDbType.Int64) { Value = viewModel.ConvFactor });
                    oParams.Add(new OracleParameter("P_UOM_EVIKAS", OracleDbType.Varchar2) { Value = viewModel.UomEvikas });
                    oParams.Add(new OracleParameter("P_GTIN", OracleDbType.Varchar2) { Value = viewModel.Gtin });
					oParams.Add(new OracleParameter("P_VALID_MONTH", OracleDbType.Int64) { Value = viewModel.ValidMonth });
					oParams.Add(new OracleParameter("P_QR_LAST_SERIAL_NO", OracleDbType.Varchar2) { Value = viewModel.Qr_last_serial_no });
                    oParams.Add(new OracleParameter("P_BPEX", OracleDbType.Varchar2) { Value = viewModel.BPEX });
                    oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.Isactive ? "Y" : "N" });
                    oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                    oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                    oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                    oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_Product_SAVE", oParams, true);
                }
                //else
                //{
                //    List<MySqlParameter> oParams = new List<MySqlParameter>();

                //    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                //    //oParams.Add(new MySqlParameter("P_CODE", MySqlDbType.VarString) { Value = viewModel.Plant_cd });
                //    oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarString) { Value = viewModel.Prd_desc });
                //    oParams.Add(new MySqlParameter("P_SKU_CODE", MySqlDbType.VarString) { Value = viewModel.Sku_code });
                //    oParams.Add(new MySqlParameter("P_SKU_NAME", MySqlDbType.VarString) { Value = viewModel.Sku_name });
                //    oParams.Add(new MySqlParameter("P_PRD_CD", MySqlDbType.VarString) { Value = viewModel.Prd_cd });
                //    oParams.Add(new MySqlParameter("P_IS_POSTED", MySqlDbType.Int64) { Value = viewModel.Is_posted });
                //    oParams.Add(new MySqlParameter("P_PRD_WT_FILL", MySqlDbType.Int64) { Value = viewModel.Prd_wt_fill });
                //    oParams.Add(new MySqlParameter("P_SHIP_WT_FILL", MySqlDbType.Int64) { Value = viewModel.Ship_wt_fill });
                //    oParams.Add(new MySqlParameter("P_PROD_PER_SHIPPER", MySqlDbType.Int64) { Value = viewModel.Prod_per_shipper });
                //    oParams.Add(new MySqlParameter("P_TOLERANCE_PER", MySqlDbType.Int64) { Value = viewModel.Tolerance_per });
                //    oParams.Add(new MySqlParameter("P_PAL_WT_FILL", MySqlDbType.Int64) { Value = viewModel.Pal_wt_fill });
                //    oParams.Add(new MySqlParameter("P_SHIP_PER_PALLET", MySqlDbType.Int64) { Value = viewModel.Ship_per_pallet });
                //    oParams.Add(new MySqlParameter("P_NOTE", MySqlDbType.VarString) { Value = viewModel.Note });
                //    oParams.Add(new MySqlParameter("P_PRD_DESC_H", MySqlDbType.VarString) { Value = viewModel.Prd_desc_h });
                //    oParams.Add(new MySqlParameter("P_PRINT_ORDER", MySqlDbType.VarString) { Value = viewModel.Print_order });
                //    oParams.Add(new MySqlParameter("P_PRD_DESC_SHORT", MySqlDbType.VarString) { Value = viewModel.Prd_desc_short });
                //    oParams.Add(new MySqlParameter("P_EXTRA1", MySqlDbType.VarString) { Value = viewModel.Extra1 });
                //    oParams.Add(new MySqlParameter("P_EXTRA2", MySqlDbType.VarString) { Value = viewModel.Extra2 });
                //    oParams.Add(new MySqlParameter("P_EXTRA3", MySqlDbType.VarString) { Value = viewModel.Extra3 });
                //    oParams.Add(new MySqlParameter("P_PRD_TYPE", MySqlDbType.VarString) { Value = viewModel.Prd_type });
                //    oParams.Add(new MySqlParameter("P_SUB_PLANT_CD", MySqlDbType.VarString) { Value = viewModel.Sub_plant_cd });
                //    oParams.Add(new MySqlParameter("P_PRD_CATEGORY", MySqlDbType.VarString) { Value = viewModel.Prd_category });
                //    oParams.Add(new MySqlParameter("P_ACTIVE", MySqlDbType.VarString) { Value = viewModel.Active });
                //    oParams.Add(new MySqlParameter("P_HSN_CODE", MySqlDbType.VarString) { Value = viewModel.Hsn_code });
                //    oParams.Add(new MySqlParameter("P_PRD_CD_GROUP_APP", MySqlDbType.VarString) { Value = viewModel.Prd_cd_group_app });
                //    oParams.Add(new MySqlParameter("P_UOM", MySqlDbType.VarString) { Value = viewModel.Uom });
                //    oParams.Add(new MySqlParameter("P_CONV_FACTOR", MySqlDbType.Int64) { Value = viewModel.ConvFactor });
                //    oParams.Add(new MySqlParameter("P_UOM_EVIKAS", MySqlDbType.VarString) { Value = viewModel.UomEvikas });
                //    oParams.Add(new MySqlParameter("P_GTIN", MySqlDbType.VarString) { Value = viewModel.Gtin });
                //    oParams.Add(new MySqlParameter("P_QR_LAST_SERIAL_NO", MySqlDbType.VarString) { Value = viewModel.Qr_last_serial_no });
                //    oParams.Add(new MySqlParameter("P_BPEX", MySqlDbType.VarString) { Value = viewModel.BPEX });
                //    oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.Isactive ? "Y" : "N" });
                //    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                //    oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                //    oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                //    oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                //    (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_Product_SAVE", oParams, true);
                //}

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = IsSuccess;
                CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                CommonViewModel.Message = response;
                CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

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
                    var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

                    if (AppHttpContextAccessor.IsCloudDBActive)
                    {
                        List<OracleParameter> oParams = new List<OracleParameter>();

                        oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
                        oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "N" });
                        oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_PRODUCT_DELETE", oParams, true);
                    }
                    else
                    {
                        List<MySqlParameter> oParams = new List<MySqlParameter>();

                        oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
                        oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "N" });
                        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                        oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                        oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                        oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                        (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PRODUCT_DELETE", oParams, true);
                    }

                    CommonViewModel.IsConfirm = true;
                    CommonViewModel.IsSuccess = IsSuccess;
                    CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                    CommonViewModel.Message = response;
                    CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

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
