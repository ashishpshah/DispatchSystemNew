using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Export.Controllers
{
    [Area("Export")]
	public class GateInController : BaseController<ResponseModel<GateIn>>
	{
		public ActionResult Index()
		{
			var list = new List<SelectListItem_Custom>();

			var oParams = new List<MySqlParameter>();

			try
			{
				list.Insert(0, new SelectListItem_Custom("", "-- Select --", "DRVIDPROOF"));

				oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "DRVIDPROOF" });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, false);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(Convert.ToString(dr["LOV_CODE"]), Convert.ToString(dr["LOV_DESC"]), "DRVIDPROOF"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			try
			{
				list.Insert(0, new SelectListItem_Custom("", "-- Select --", "TRANS"));

				oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(Convert.ToString(dr["tptr_cd"]), Convert.ToString(dr["NAME"]) + " (" + Convert.ToString(dr["tptr_cd"]) + ")", "TRANS"));
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			return View(CommonViewModel);
		}


		[HttpGet]
		public IActionResult GetMDA(string type, string searchTerm)
		{
			var list = new List<MDA>();

			try
			{
				DataTable dt = new DataTable();

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = string.IsNullOrEmpty(type) || type != "V" ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_EXP_GATE_IN_MDA_LIST", oParams);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new MDA()
						{
							sr_no = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
							Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
							vehicle_no = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
							mda_no = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
							di_no = dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "",
							plant_cd = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
							mda_dt = dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							driver = dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "",
							mobile_no = dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "",
							dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
							wh_cd = dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "",
							party_name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
							tptr_cd = dr["TRANS_CD"] != DBNull.Value ? Convert.ToString(dr["TRANS_CD"]) : "",
							tptr_name = dr["TRANS_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANS_NAME"]) : "",
							prod_cd = dr["PROD_CD"] != DBNull.Value ? Convert.ToString(dr["PROD_CD"]) : "",
							prod_name = dr["PROD_NAME"] != DBNull.Value ? Convert.ToString(dr["PROD_NAME"]) : "",
							mda_order = dr["MDA_ORDER"] != DBNull.Value ? Convert.ToInt32(dr["MDA_ORDER"]) : 0,
                            bag_nos = dr["bag_nos"] != DBNull.Value ? Convert.ToInt64(dr["bag_nos"]) : 0,
                            Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
							Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
							Expected_Shipper = dr["Expected_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Expected_Shipper"]) : 0,
							Vehicle_Shippers = dr["Vehicle_Shippers"] != DBNull.Value ? Convert.ToString(dr["Vehicle_Shippers"]) : ""
						});

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
				else return PartialView("_Partial_MDA", list);
			else return Json(null);
			//return PartialView("_Partial_MDA", list);
		}



		[HttpPost]
		public IActionResult Save(GateIn viewModel)
		{
			try
			{
				if (viewModel == null)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid Gate In details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Truck_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Vehicle Number";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Common_Sys_Id <= 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select valid MDA detalis.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Common_Date))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid MDA Date";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}


				if (string.IsNullOrEmpty(viewModel.Transporter_Name))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Transporter Name";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Driver_Name))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Driver Name";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Driver_Contact))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Driver Contact";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Driver_Changed == true && string.IsNullOrEmpty(viewModel.Driver_Name_New))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please Enter New Driver Name";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					return Json(CommonViewModel);
				}

				if (viewModel.Driver_Changed == true && string.IsNullOrEmpty(viewModel.Driver_Contact_New))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please Enter New Driver Contact";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.RFID_Number))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter RFID No.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					return Json(CommonViewModel);
				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Common_Sys_Id });
				oParams.Add(new MySqlParameter("P_MDA_NO", MySqlDbType.VarString) { Value = viewModel.Common_No });
				oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarString) { Value = viewModel.Truck_No });
				oParams.Add(new MySqlParameter("P_TRANSPORTER_CODE", MySqlDbType.VarString) { Value = viewModel.Transporter_Changed ? viewModel.Transporter_Code_New : viewModel.Transporter_Code });
				oParams.Add(new MySqlParameter("P_DRIVER_ID_TYPE", MySqlDbType.VarString) { Value = viewModel.Driver_Id_Type });
				oParams.Add(new MySqlParameter("P_DRIVER_ID_NUMBER", MySqlDbType.VarString) { Value = viewModel.Driver_Id_Number });
				oParams.Add(new MySqlParameter("P_DRIVER_NAME", MySqlDbType.VarString) { Value = viewModel.Driver_Name });
				oParams.Add(new MySqlParameter("P_DRIVER_CONTACT", MySqlDbType.VarString) { Value = viewModel.Driver_Contact });
				oParams.Add(new MySqlParameter("P_DRIVER_CHANGED", MySqlDbType.Int64) { Value = viewModel.Driver_Changed ? 1 : 0 });
				oParams.Add(new MySqlParameter("P_DRIVER_NAME_NEW", MySqlDbType.VarString) { Value = viewModel.Driver_Name_New });
				oParams.Add(new MySqlParameter("P_DRIVER_CONTACT_NEW", MySqlDbType.VarString) { Value = viewModel.Driver_Contact_New });
				oParams.Add(new MySqlParameter("P_EXPECTED_QTY", MySqlDbType.Int64) { Value = viewModel.Expected_Shipper });
				oParams.Add(new MySqlParameter("P_TRUCK_VALIDATION", MySqlDbType.Int64) { Value = viewModel.Truck_Validation ? 1 : 0 });
				oParams.Add(new MySqlParameter("P_RFSYSID", MySqlDbType.VarString) { Value = 0 });
				oParams.Add(new MySqlParameter("P_RFID_CODE", MySqlDbType.VarString) { Value = viewModel.RFID_Number });
				oParams.Add(new MySqlParameter("P_RFID_SRNO", MySqlDbType.VarString) { Value = viewModel.RFID_Serial_Number });
				oParams.Add(new MySqlParameter("P_RFID_RECEIVE", MySqlDbType.Int64) { Value = viewModel.Rfid_Receive ? 1 : 0 });
				oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_EXP_GATE_IN_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;
				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
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
		public JsonResult Save_Transporter(Transport viewModel)
		{
			try
			{
				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_CODE", MySqlDbType.VarString) { Value = viewModel.tptr_cd });
				oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarString) { Value = viewModel.tptr_name });
				oParams.Add(new MySqlParameter("P_IS_ENTRY_MANUAL", MySqlDbType.VarString) { Value = viewModel.IS_ENTRY_MANUAL ? "Y" : "N" });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = viewModel.IsActive ? "Y" : "N" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_TRANSPORTER_SAVE", oParams, true);

				CommonViewModel.IsConfirm = false;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

				CommonViewModel.Data1 = viewModel.tptr_cd;
				CommonViewModel.Data2 = viewModel.tptr_name + " (" + viewModel.tptr_cd + ")";
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

	}
}
