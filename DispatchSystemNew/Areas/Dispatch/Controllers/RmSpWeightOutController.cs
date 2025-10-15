using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;
using VendorQRGeneration.Infra.Services;

namespace Dispatch_System.Controllers
{
    [Area("Dispatch")]
	public class RmSpWeightOutController : BaseController<ResponseModel<WeightIn>>
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
				else if (!string.IsNullOrEmpty(Inward_Sys_Id) && Inward_Sys_Id == "3")
				{
					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_SP_WEIGHMENT_OUT_GET", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new GateIn()
							{
								Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
								GateIn_Id = dr["Gate_In_Id"] != DBNull.Value ? Convert.ToInt64(dr["Gate_In_Id"]) : 0,
								Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
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
								Tare_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime
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

					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_WEIGHMENT_OUT_GET_OTHER", oParams_);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new GateIn()
							{
								Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
								GateIn_Id = dr["Gate_In_Id"] != DBNull.Value ? Convert.ToInt64(dr["Gate_In_Id"]) : 0,
								Inward_Sys_Id = dr["Inward_Sys_Id"] != DBNull.Value ? Convert.ToString(dr["Inward_Sys_Id"]) : "",
								Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
								Common_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
								Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
								Plant_CD = dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) : "",
								Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
								Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
								Transporter_Name = dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "",
								TransactionType = dr["Transaction_Type"] != DBNull.Value ? Convert.ToString(dr["Transaction_Type"]) : "",
								Verified_Documents = dr["Verified_Documents"] != DBNull.Value ? Convert.ToBoolean(dr["Verified_Documents"]) : false,
								Verified_Officer_Id = dr["Verified_Officer_Id"] != DBNull.Value ? Convert.ToString(dr["Verified_Officer_Id"]) : "",
								Verified_Officer_Name = dr["Verified_Officer_Name"] != DBNull.Value ? Convert.ToString(dr["Verified_Officer_Name"]) : "",
								Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
								Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
								Tare_Wt = dr["Tare_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Tare_Wt"]) : 0,
								Tare_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime
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
			//return PartialView("_Partial_MDA", list);
		}


		#endregion

		#region Events
		[HttpPost]
		public IActionResult Save(WeightIn viewModel)
		{
			try
			{
				if (viewModel.Gate_In_Id <= 0)
				{
					CommonViewModel.Message = "Please select valid Gate In data.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Inward_Sys_Id == 2)
				{

					if (viewModel.Tare_Wt < 0)
					{
						CommonViewModel.Message = "Please enter Tare Weight.";
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;

						return Json(CommonViewModel);
					}

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_GATE_IN_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
					oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
					oParams.Add(new MySqlParameter("P_TARE_WT", MySqlDbType.Double) { Value = viewModel.Tare_Wt_1 });
					oParams.Add(new MySqlParameter("P_NET_WT_MANUALLY", MySqlDbType.Double) { Value = viewModel.Net_Wt_Manually ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_TARE_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Tare_Wt_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RM_WEIGHMENT_OUT_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "RmSpWeighmentOutSlip") + "?Vehicle_No=" + viewModel.Truck_No + "&Inward_Sys_Id=" + viewModel.Inward_Sys_Id : null;

				}
				else if (viewModel.Inward_Sys_Id == 3)
				{
					if (viewModel.Gross_Wt < 0)
					{
						CommonViewModel.Message = "Please enter Gross Weight.";
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;

						return Json(CommonViewModel);
					}

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_GATE_IN_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
					oParams.Add(new MySqlParameter("P_GROSS_WT", MySqlDbType.Double) { Value = viewModel.Gross_Wt_1 });
					oParams.Add(new MySqlParameter("P_GROSS_WT_MANUALLY", MySqlDbType.Int64) { Value = viewModel.Net_Wt_Manually ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_GROSS_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gross_Wt_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SP_WEIGHMENT_OUT_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "RmSpWeighmentOutSlip") + "?Vehicle_No=" + viewModel.Truck_No + "&Inward_Sys_Id=" + viewModel.Inward_Sys_Id : null;
				}
				else if (viewModel.Inward_Sys_Id == 4)
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_GATE_IN_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
					oParams.Add(new MySqlParameter("P_GROSS_WT", MySqlDbType.Double) { Value = viewModel.Gross_Wt_1 });
					oParams.Add(new MySqlParameter("P_GROSS_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gross_Wt_Note });
					oParams.Add(new MySqlParameter("P_NET_WT_MANUALLY", MySqlDbType.Double) { Value = viewModel.Net_Wt_Manually ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_WEIGHMENT_OUT_SAVE_OTHER", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "WeighmentOutSlip_Other") + "?Gate_In_Out_Id=" + viewModel.Gate_In_Id : null;

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


		[HttpGet]
		public async Task<IActionResult> GetWeighbridge_Interface_Data(string Weighbridge_Id = "")
		{
			try
			{
				List<(string Name, string IP, int Port)> listWeighbridge = AppHttpContextAccessor.GetWeighbridgeList();

				Weighbridge_Id = string.IsNullOrEmpty(Weighbridge_Id) ? listWeighbridge.Select(x => x.IP + ":" + x.Port).FirstOrDefault() : Weighbridge_Id;

				if (listWeighbridge != null && listWeighbridge.Count() > 0 && listWeighbridge.Any(x => x.IP + ":" + x.Port == Weighbridge_Id))
				{
					var index = listWeighbridge.FindIndex(x => x.IP + ":" + x.Port == Weighbridge_Id);

					//var weight = await TcpClientApp.GetData(listWeighbridge[index].IP, listWeighbridge[index].Port);

					//CommonViewModel.IsConfirm = false;
					//CommonViewModel.IsSuccess = true;
					//CommonViewModel.StatusCode = ResponseStatusCode.Success;
					//CommonViewModel.Message = ResponseStatusMessage.Success;

					//CommonViewModel.Data1 = weight;

					using (var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30)))
					{
						try
						{
							var weight = await TcpClientApp.GetData(listWeighbridge[index].IP, listWeighbridge[index].Port, cts.Token);

							CommonViewModel.IsConfirm = false;
							CommonViewModel.IsSuccess = true;
							CommonViewModel.StatusCode = ResponseStatusCode.Success;
							CommonViewModel.Message = ResponseStatusMessage.Success;

							CommonViewModel.Data1 = weight;
						}
						catch (Exception ex) { }
					}
				}
			}
			catch (Exception ex)
			{
				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}

			return Json(CommonViewModel);
		}


		//[HttpGet]
		//public IActionResult GetWeighbridge_Interface_Data()
		//{
		//	try
		//	{
		//		//string strwwwpath = Path.Combine(AppHttpContextAccessor.ContentRootPath, "wwwroot\\BatchFile\\CheckFile1.bat");
		//		string strwwwpath = Path.Combine(AppHttpContextAccessor.ContentRootPath, "wwwroot\\BatchFile\\CheckFile1.bat");

		//		using (Process MyProcess = new Process())
		//		{
		//			var MyProcessInfo = new ProcessStartInfo()
		//			{
		//				UseShellExecute = false,
		//				WorkingDirectory = strwwwpath,
		//				FileName = "CheckFile1.bat",
		//				Arguments = "args"
		//			};
		//			MyProcess.StartInfo = MyProcessInfo;
		//			MyProcess.Start();
		//		}


		//		System.Diagnostics.Process.Start(strwwwpath);

		//		var weight = System.IO.File.ReadAllText("").ToString();

		//		CommonViewModel.IsConfirm = false;
		//		CommonViewModel.IsSuccess = true;
		//		CommonViewModel.StatusCode = ResponseStatusCode.Success;
		//		CommonViewModel.Message = ResponseStatusMessage.Success;

		//		CommonViewModel.Data1 = weight;

		//	}
		//	catch (Exception ex)
		//	{
		//		CommonViewModel.IsSuccess = false;
		//		CommonViewModel.StatusCode = ResponseStatusCode.Error;
		//		CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
		//	}

		//	return Json(CommonViewModel);
		//}


		#endregion


	}
}
