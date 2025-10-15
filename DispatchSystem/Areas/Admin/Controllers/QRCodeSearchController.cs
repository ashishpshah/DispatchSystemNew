using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class QRCodeSearchController : BaseController<ResponseModel<QRCodeGeneration>>
    {

        public IActionResult Index()
        {
            var list = new List<SelectListItem_Custom>();

            CommonViewModel.Obj = new QRCodeGeneration();            

            return View(CommonViewModel);
        }


        [HttpGet]
        public IActionResult GetData(string Qr_code, bool withDetail = false, bool isPrint = false)
        {
            (string PageTitle_Primary, string PageTitle_Secondary) = ("", "");

            var result = new List<QRCodeGeneration>();

            DataSet ds = new DataSet();

            try
            {
                var oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_QR_CODE", OracleDbType.Varchar2) { Value = Qr_code ?? "" });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

                ds = DataContext.ExecuteStoredProcedure_DataSet("PC_REPORT_QR_CODE_GET_DATA", oParams);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                        result.Add(new QRCodeGeneration
                        {
                            SrNo = dr["RNUM"] != DBNull.Value ? Convert.ToInt64(dr["RNUM"]) : 0,
                            Qr_Code = dr["SERIAL_NO"] != DBNull.Value ? Convert.ToString(dr["SERIAL_NO"]) : "",
                            VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : 0,
                            VendorSiteName = dr["SITE_NAME"] != DBNull.Value ? Convert.ToString(dr["SITE_NAME"]) : "",
                            VendorName = dr["ORGANIZATION_NAME"] != DBNull.Value ? Convert.ToString(dr["ORGANIZATION_NAME"]) : "",
                            SkuDesc = dr["SKU_NAME"] != DBNull.Value ? Convert.ToString(dr["SKU_NAME"]) : "",
                            PoNumber = dr["PO_NO"] != DBNull.Value ? Convert.ToString(dr["PO_NO"]) : "",
                            Created_By = dr["CREATED_BY"] != DBNull.Value ? Convert.ToString(dr["CREATED_BY"]) : "",
                            PO_Date_Text = dr["CREATED_DATETIME"] != DBNull.Value ? Convert.ToString(dr["CREATED_DATETIME"]) : "",
                        });

                }
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            PageTitle_Primary = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
                                && ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

            if (!string.IsNullOrEmpty(Qr_code))
                PageTitle_Secondary += "QR Code. : " + Qr_code.ToUpper();

            dynamic objFilter = new { Qr_code = Qr_code };

            if (isPrint == true)
                return View("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
            else
                return PartialView("_Partial_GetData", (PageTitle_Primary, PageTitle_Secondary, objFilter, result, withDetail, isPrint));
        }



    }
}