using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Export.Controllers
{
    [Area("Export")]
	public class WeightOutController : BaseController<ResponseModel<WeightIn>>
	{
		#region Loading
		public IActionResult Index()
		{
			return View(CommonViewModel);
		}
		#endregion

		#region Methods

		[HttpGet]
		public IActionResult GetMDA(string type, string searchTerm, int Inward_Sys_Id)
		{
			var list = new List<GateIn>();

			try
			{
				DataTable dt = new DataTable();

				var oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = string.IsNullOrEmpty(type) || type != "V" ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_EXP_WEIGHMENT_OUT_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new GateIn()
						{
							Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt64(dr["Sr_No"]) : 0,
							Id = dr["WT_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["WT_SYS_ID"]) : 0,
							GateIn_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
							Truck_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
							Common_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
							Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
							Plant_CD = dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "",
							Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
							Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
							Transporter_Name = dr["TRANS_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANS_NAME"]) : "",
							Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
							Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
							Tare_Wt = dr["WEIGH_IN_WT"] != DBNull.Value ? Convert.ToDouble(dr["WEIGH_IN_WT"]) : 0,
							Tare_Wt_Dt = dr["WEIGH_IN_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGH_IN_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Expected_Shipper = dr["Expected_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Expected_Shipper"]) : 0,
							Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Loaded_Shipper"]) : 0
						});

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
				else return PartialView("_Partial_MDA", list);
			else return Json(null);
			//return PartialView("_Partial_MDA", list);
		}

		#endregion

		#region Events

		[HttpPost]
		public IActionResult Save(WeightIn viewModel)
		{
			try
			{
				if (viewModel.Id <= 0)
				{
					CommonViewModel.Message = "Please select valid Weighment In data.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Gate_In_Id <= 0)
				{
					CommonViewModel.Message = "Please select valid Gate In data.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Gross_Wt < 0)
				{
					CommonViewModel.Message = "Please enter Gross Weight.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Gross_Wt < viewModel.Tare_Wt)
				{
					CommonViewModel.Message = "Gross weight is not less then Tare weight.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_GATE_IN_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
				oParams.Add(new MySqlParameter("P_GROSS_WT", MySqlDbType.Double) { Value = viewModel.Gross_Wt });
				oParams.Add(new MySqlParameter("P_GROSS_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gross_Wt_Note });
				oParams.Add(new MySqlParameter("P_NET_WT_MANUALLY", MySqlDbType.Double) { Value = viewModel.Net_Wt_Manually ? 1 : 0 });
				oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_EXP_WEIGHMENT_OUT_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;
				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

				CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "WeighmentOutSlip", new { area = "Export" }) + "?Id=" + viewModel.Gate_In_Id + "&PurposeType=" + viewModel.Inward_Sys_Id : null;

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
