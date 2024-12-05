using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using QRCoder;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Runtime.Intrinsics.Arm;

namespace Dispatch_System.Areas.LineMaster.Controllers
{
    [Area("LineMaster")]
    public class GenerateBatchQRController : BaseController<ResponseModel<GenerateBatchQR>>
    {
        public IActionResult Index()
        {
            CommonViewModel.Obj = new GenerateBatchQR();

            var list = new List<SelectListItem_Custom>();

            var oParams = new List<MySqlParameter>();

            try
            {
                list.Add(new SelectListItem_Custom("KL1", "NAP1", "PLANT"));
                list.Add(new SelectListItem_Custom("KL2", "NAP2", "PLANT"));

                //oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                //oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                //oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                //oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                //oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                //oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                //var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PLANT_GET", oParams, true);

                //if (dt != null && dt.Rows.Count > 0)
                //    foreach (DataRow dr in dt.Rows)
                //        list.Add(new SelectListItem_Custom(Convert.ToString(dr["CODE"]), Convert.ToString(dr["NAME"]), "PLANT"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            try
            {
                list.Add(new SelectListItem_Custom("DP", "NANO DAP", "PRODUCT"));
                list.Add(new SelectListItem_Custom("UP", "NANO UREA PLUS", "PRODUCT"));

                //var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PRODUCT_GET", oParams, true);

                //if (dt != null && dt.Rows.Count > 0)
                //    foreach (DataRow dr in dt.Rows)
                //        list.Add(new SelectListItem_Custom(Convert.ToString(dr["PRD_CD"]), Convert.ToString(dr["PRD_DESC"]), "PRODUCT"));

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            try
            {
                oParams[0].Value = -1;

                var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_BATCH_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    CommonViewModel.Obj.Serial_No = Convert.ToInt64(dt.Rows[0][0]);
            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.SelectListItems = list;

            return View(CommonViewModel);
        }


        [HttpGet]
        public IActionResult GetSerialNo(string MFG_Date)
        {
            var imageBase64 = "";

            CommonViewModel.Obj = new GenerateBatchQR();

            var oParams = new List<MySqlParameter>();

            try
            {
                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = -1 });
                oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_BATCH_GET", oParams, true);

                if (dt != null && dt.Rows.Count > 0)
                    CommonViewModel.Obj.Serial_No = Convert.ToInt64(dt.Rows[0][0]);

                CommonViewModel.IsConfirm = false;
                CommonViewModel.IsSuccess = true;
                CommonViewModel.StatusCode = ResponseStatusCode.Success;
                CommonViewModel.Message = null;

            }
            catch (Exception ex)
            {
                LogService.LogInsert(GetCurrentAction(), "", ex);

                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.Error;
            }

            return Json(CommonViewModel);
        }

        [HttpGet]
        public IActionResult Generate_QRCode(string strText)
        {
            var imageBase64 = "";

            try
            {
                QRCodeGenerator qrGenerator = new QRCodeGenerator();
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(strText, QRCodeGenerator.ECCLevel.Q);

                BitmapByteQRCode qrCode = new BitmapByteQRCode(qrCodeData);
                byte[] qrCodeAsBitmapByteArr = qrCode.GetGraphic(20);

                Bitmap qrCodeImage = null;
                using (var ms = new MemoryStream(qrCodeAsBitmapByteArr))
                {
                    qrCodeImage = new Bitmap(ms);

                    qrCodeImage.Save(strText.Split(',')[0] + ".png", System.Drawing.Imaging.ImageFormat.Png);

                    byte[] byteArray = ms.ToArray();

                    imageBase64 = "data:image/png;base64," + Convert.ToBase64String(byteArray);

                }

                CommonViewModel.IsConfirm = false;
                CommonViewModel.IsSuccess = true;
                CommonViewModel.StatusCode = ResponseStatusCode.Success;
                CommonViewModel.Message = null;

                CommonViewModel.Data1 = imageBase64;

            }
            catch (Exception ex)
            {
                LogService.LogInsert(GetCurrentAction(), "", ex);

                CommonViewModel.IsSuccess = false;
                CommonViewModel.StatusCode = ResponseStatusCode.Error;
                CommonViewModel.Message = ResponseStatusMessage.Error;
            }

            return Json(CommonViewModel);
        }



    }
}