using ClosedXML.Excel;
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
    [Area("Dispatch")]
    public class RmUnloadingController : BaseController<ResponseModel<GateIn>>
    {
        #region Loading


        public IActionResult Index()
        {
            var list = new List<GateIn>();

            try
            {
                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarChar) { Value = "" });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RM_WEIGHMENT_OUT_GET", oParams);

                if (dt != null && dt.Rows.Count > 0)
                    foreach (DataRow dr in dt.Rows)
                        list.Add(new GateIn()
                        {
                            Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
                            GateIn_Id = dr["Gate_In_Id"] != DBNull.Value ? Convert.ToInt64(dr["Gate_In_Id"]) : 0,
                            Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
                            Common_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
                            Common_Date = dr["PO_DATE"] != DBNull.Value ? Convert.ToString(dr["PO_DATE"]) : "",
                            Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
                            Plant_CD = dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) : "",
                            Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
                            Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
                            Transporter_Name = dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "",
                            Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
                            Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
                            Tare_Wt = dr["Tare_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Tare_Wt"]) : 0,
                            Tare_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Gross_Wt = dr["GROSS_WT"] != DBNull.Value ? Convert.ToDouble(dr["GROSS_WT"]) : 0,
                            Gross_Wt_Dt = dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime
                        });

            }
            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            CommonViewModel.ListObj = list;
            return View(CommonViewModel);
        }

        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Load_RmUnloading_Dtls(string PoNo = "")
        {
			var list2 = new List<PODtls>();

			if (!string.IsNullOrEmpty(PoNo))
            {
                try
                {
                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = PoNo ?? "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RM_UNLOADING_GET", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list2.Add(new PODtls()
							{
								Id = dr["PO_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_DTL_SYS_ID"]) : 0,
								PO_Id = dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["PO_SYS_ID"]) : 0,
								LineNo = dr["PO_LINE_NO"] != DBNull.Value ? Convert.ToString(dr["PO_LINE_NO"]) : "",
								LineDesc = dr["LINE_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_DESC"]) : "",
								LineQty = dr["LINE_QTY"] != DBNull.Value ? Convert.ToInt64(dr["LINE_QTY"]) : 0,
								UOM = dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "",
							});
				}
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            }
			return PartialView("_Partial_GateWiseUnloading", list2);
        }

        [HttpPost]
        public JsonResult Save(PODtls viewModel)
        {
            try
            {
                List<MySqlParameter> oParams = new List<MySqlParameter>();

                oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
                oParams.Add(new MySqlParameter("P_PO_ID", MySqlDbType.Int64) { Value = viewModel.PO_Id });
                oParams.Add(new MySqlParameter("P_RECEIVE_QTY", MySqlDbType.Decimal) { Value = viewModel.ReceiveQty });
                oParams.Add(new MySqlParameter("P_RECEIVE_UOM", MySqlDbType.VarChar) { Value = viewModel.ReceiveUOM });
                oParams.Add(new MySqlParameter("P_SHORT_QTY", MySqlDbType.Decimal) { Value = viewModel.ShortQty });
                oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RM_UNLOADING_SAVE", oParams, true);
                viewModel.Id = Id;

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
        #endregion
    }
}
