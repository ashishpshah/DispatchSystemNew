using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Data;
using System.Globalization;
using Humanizer;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
	[Area("Dispatch")]
	public class RmSpGateOutController : BaseController<ResponseModel<GateIn>>
	{
		#region Loading
		public IActionResult Index()
		{
			var list = new List<SelectListItem_Custom>();

			var oParams = new List<MySqlParameter>();

			try
			{
				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_INWARD_GET", oParams, false);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(Convert.ToString(dr["ID"]), Convert.ToString(dr["INWARD_TYPE"]), Convert.ToString(dr["order_by"]), "INWARDTYPE"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			list.Add(new SelectListItem_Custom(Convert.ToString(Common.Get_Session_Int(SessionKey.USER_ID)), Common.Get_Session(SessionKey.USER_NAME), "USER"));

			CommonViewModel.SelectListItems = list;

			return View(CommonViewModel);
		}

		#endregion

		#region Methods
		[HttpGet]
		public IActionResult GetPO(string type, string searchTerm, string Inward_Sys_Id)
		{
			var list = new List<GateIn>();

			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "2")
				{
					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RM_GATE_OUT_GET", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new GateIn()
                            {
                                Inward_Sys_Id = Inward_Sys_Id.ToString(),
                                //Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
                                GateIn_Id = dr["Gate_In_Id"] != DBNull.Value ? Convert.ToInt64(dr["Gate_In_Id"]) : 0,
								Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
								Common_Sys_Id = dr["Common_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Common_Sys_Id"]) : 0,
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
								Tare_Wt_Dt = dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Gross_Wt = dr["GROSS_WT"] != DBNull.Value ? Convert.ToDouble(dr["GROSS_WT"]) : 0,
								Gross_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Status = dr["INWARD_TYPE"] != DBNull.Value ? Convert.ToString(dr["INWARD_TYPE"]) : "",
							});
				}
				else if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "3")
				{
					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_SP_GATE_OUT_GET", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new GateIn()
                            {
                                Inward_Sys_Id = Inward_Sys_Id.ToString(),
                                //Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
                                GateIn_Id = dr["Gate_In_Id"] != DBNull.Value ? Convert.ToInt64(dr["Gate_In_Id"]) : 0,
								Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
								Common_Sys_Id = dr["Common_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Common_Sys_Id"]) : 0,
								Common_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
								Common_Date = dr["SO_DATE"] != DBNull.Value ? Convert.ToString(dr["SO_DATE"]) : "",
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
								Gross_Wt_Dt = dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Status = dr["INWARD_TYPE"] != DBNull.Value ? Convert.ToString(dr["INWARD_TYPE"]) : "",
							});
				}
				else if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "4")
				{
					var oParams_ = new List<MySqlParameter>();

					oParams_.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams_.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = string.IsNullOrEmpty(type) || type != "V" ? searchTerm : "" });
					oParams_.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
					oParams_.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams_.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams_.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams_.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_GATE_OUT_GET_OTHER", oParams_, true);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new GateIn()
                            {
                                Inward_Sys_Id = Inward_Sys_Id.ToString(),
                                //Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
                                GateIn_Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
								Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
								Common_Sys_Id = dr["Common_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Common_Sys_Id"]) : 0,
								Common_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
								//Common_Date = dr["ORDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ORDER_DATE"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture).ToString() : "",
								Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
								Plant_CD = dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) : "",
								Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
								Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
								Transporter_Name = dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "",
								TransactionType = dr["TRANSACTION_TYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTION_TYPE"]) : "",
								Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
								Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
								Tare_Wt = dr["Tare_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Tare_Wt"]) : 0,
								Tare_Wt_Dt = dr["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Gross_Wt = dr["GROSS_WT"] != DBNull.Value ? Convert.ToDouble(dr["GROSS_WT"]) : 0,
								Gross_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								//Status = dr["INWARD_TYPE"] != DBNull.Value ? Convert.ToString(dr["INWARD_TYPE"]) : "",
							});
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "2")
			{
				if (list != null && list.Count > 0)
					if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
					else return PartialView("_Partial_PO", list);
				else return Json(null);
			}
			else if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "3")
			{
				if (list != null && list.Count > 0)
					if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
					else return PartialView("_Partial_SO", list);
				else return Json(null);
			}
			else if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "4")
			{
				if (list != null && list.Count > 0)
					if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
					else return PartialView("_Partial_Other", list);
				else return Json(null);
			}

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
				else return PartialView("_Partial_SO", list);
			else return Json(null);
		}

		#endregion

		#region Events

		[HttpPost]
		public IActionResult Save(GateIn viewModel)
		{
			try
			{
				if (viewModel.GateIn_Id <= 0)
				{
					CommonViewModel.Message = "Please select valid Gate In data.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "2")
				{
					if (string.IsNullOrEmpty(viewModel.Common_No))
					{
						CommonViewModel.Message = "Please select valid PO data.";
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;

						return Json(CommonViewModel);
					}

					//if (viewModel.Tare_Wt < 0)
					//{
					//	CommonViewModel.Message = "Please enter Gross Weight.";
					//	CommonViewModel.IsSuccess = false;
					//	CommonViewModel.StatusCode = ResponseStatusCode.Error;

					//	return Json(CommonViewModel);
					//}

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.GateIn_Id });
					oParams.Add(new MySqlParameter("P_PO_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Common_Sys_Id });
					oParams.Add(new MySqlParameter("P_GATE_OUT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gate_Out_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RM_GATE_OUT_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					//CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "WeighmentInSlip") + "?Vehicle_No=" + viewModel.Truck_No : null;

				}
				else if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "3")
				{
					if (string.IsNullOrEmpty(viewModel.Common_No))
					{
						CommonViewModel.Message = "Please select valid SO data.";
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;

						return Json(CommonViewModel);
					}

					//if (viewModel.Tare_Wt < 0)
					//{
					//	CommonViewModel.Message = "Please enter Tare Weight.";
					//	CommonViewModel.IsSuccess = false;
					//	CommonViewModel.StatusCode = ResponseStatusCode.Error;

					//	return Json(CommonViewModel);
					//}

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.GateIn_Id });
					oParams.Add(new MySqlParameter("P_SO_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Common_Sys_Id });
					oParams.Add(new MySqlParameter("P_GATE_OUT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gate_Out_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SP_GATE_OUT_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					//CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "WeighmentInSlip") + "?Vehicle_No=" + viewModel.Truck_No : null;
				}
				else if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "4")
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.GateIn_Id });
					oParams.Add(new MySqlParameter("P_COMMON_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Common_Sys_Id });
					oParams.Add(new MySqlParameter("P_GATE_OUT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gate_Out_Note });

					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_GATE_OUT_SAVE_OTHER", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = IsSuccess ? $"Gate Out completed successfully for truck number {viewModel.Truck_No} for other material." : response;

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

		#endregion
	}
}
