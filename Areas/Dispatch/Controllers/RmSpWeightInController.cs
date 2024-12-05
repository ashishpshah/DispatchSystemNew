using Dispatch_System.Infra.Services;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Controllers
{
    [Area("Dispatch")]
	public class RmSpWeightInController : BaseController<ResponseModel<WeightIn>>
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
					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RM_WEIGHMENT_IN_GET", oParams);

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
					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_SP_WEIGHMENT_IN_GET", oParams);

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
					oParams_.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = string.IsNullOrEmpty(type) || type != "V" ? searchTerm ?? "" : "" });
					oParams_.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
					oParams_.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams_.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams_.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams_.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_WEIGHMENT_IN_GET_OTHER", oParams_);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new GateIn()
							{
								Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
								Inward_Sys_Id = dr["Inward_Sys_Id"] != DBNull.Value ? Convert.ToString(dr["Inward_Sys_Id"]) : "",
								Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
								Common_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
								Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
								Plant_CD = dr["PLANT_CODE"] != DBNull.Value ? Convert.ToString(dr["PLANT_CODE"]) : "",
								Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
								Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
								Transporter_Name = dr["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANSPORTER_NAME"]) : "",
								TransactionType = dr["TRANSACTION_TYPE"] != DBNull.Value ? Convert.ToString(dr["TRANSACTION_TYPE"]) : "",
								Verified_Documents = dr["Verified_Documents"] != DBNull.Value ? Convert.ToBoolean(dr["Verified_Documents"]) : false,
								Verified_Officer_Id = dr["Verified_Officer_Id"] != DBNull.Value ? Convert.ToString(dr["Verified_Officer_Id"]) : "",
								Verified_Officer_Name = dr["Verified_Officer_Name"] != DBNull.Value ? Convert.ToString(dr["Verified_Officer_Name"]) : "",
								Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
								Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : ""
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


		[HttpGet]
		public IActionResult GetSO(string type, string searchTerm)
		{
			var list = new List<SO>();

			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				//oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });

				//oParams.Add(new MySqlParameter("P_VEHICLE_NO", MySqlDbType.VarChar) { Value = "" });
				//oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = Inward_Sys_Id });
				//oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
				//oParams.Add(new MySqlParameter("P_DTLS", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_GATE_IN_SO_LIST", oParams);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						//if ((dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0) <= 0)
						list.Add(new SO()
						{
							Id = dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["SO_SYS_ID"]) : 0,
							//Id = dr["UNIT_CODE"] != DBNull.Value ? Convert.ToInt64(dr["UNIT_CODE"]) : 0,
							SoNo = dr["SO_NO"] != DBNull.Value ? Convert.ToString(dr["SO_NO"]) : "",
							SoDate_Text = dr["SO_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							SoReleaseDate_Text = dr["SO_RELEASE_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_RELEASE_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							SoValidDate_Text = dr["SO_VALID_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_VALID_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							SequenceNo = dr["SEQUENCE_NO"] != DBNull.Value ? Convert.ToInt64(dr["SEQUENCE_NO"]) : 0,
							TenderNo = dr["TENDER_NO"] != DBNull.Value ? Convert.ToString(dr["TENDER_NO"]) : "",
							TenderDate_Text = dr["SO_VALID_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["SO_VALID_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							VendorId = dr["VENSOR_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["VENSOR_SYS_ID"]) : 0,
							CustCd = dr["CUST_CD"] != DBNull.Value ? Convert.ToInt64(dr["CUST_CD"]) : 0,
							CustName = dr["CUST_NAME"] != DBNull.Value ? Convert.ToString(dr["CUST_NAME"]) : "",
							CustSiteCd = dr["CUST_SITE_CD"] != DBNull.Value ? Convert.ToInt64(dr["CUST_SITE_CD"]) : 0,
							SiteName = dr["SITE_NAME"] != DBNull.Value ? Convert.ToString(dr["SITE_NAME"]) : "",
							Add1 = dr["ADD1"] != DBNull.Value ? Convert.ToString(dr["ADD1"]) : "",
							Add2 = dr["ADD2"] != DBNull.Value ? Convert.ToString(dr["ADD2"]) : "",
							Add3 = dr["ADD3"] != DBNull.Value ? Convert.ToString(dr["ADD3"]) : "",
							City = dr["CITY"] != DBNull.Value ? Convert.ToString(dr["CITY"]) : "",
							Pin = dr["PIN"] != DBNull.Value ? Convert.ToInt64(dr["PIN"]) : 0,
							State = dr["STATE"] != DBNull.Value ? Convert.ToString(dr["STATE"]) : "",
							StateCd = dr["STATE_CD"] != DBNull.Value ? Convert.ToString(dr["STATE_CD"]) : "",
							GstnNo = dr["GSTN_NO"] != DBNull.Value ? Convert.ToString(dr["GSTN_NO"]) : "",
							PanNo = dr["PAN_NO"] != DBNull.Value ? Convert.ToString(dr["PAN_NO"]) : "",
							CustNonGst = dr["CUST_NON_GST"] != DBNull.Value ? Convert.ToInt64(dr["CUST_NON_GST"]) : 0,
							TelNo = dr["TEL_NO"] != DBNull.Value ? Convert.ToString(dr["TEL_NO"]) : "",
							SoRemarks = dr["SO_REMARKS"] != DBNull.Value ? Convert.ToString(dr["SO_REMARKS"]) : "",
							Status = dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "",
							StatusDate_Text = dr["STATUS_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["STATUS_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							StatusRemarks = dr["STATUS_REMARKS"] != DBNull.Value ? Convert.ToString(dr["STATUS_REMARKS"]) : "",
							TermsPymtTerm = dr["TERMS_PYMT_TERM"] != DBNull.Value ? Convert.ToString(dr["TERMS_PYMT_TERM"]) : "",
							TermsLiftingPeriodDays = dr["TERMS_LIFTING_PERIOD_DAYS"] != DBNull.Value ? Convert.ToString(dr["TERMS_LIFTING_PERIOD_DAYS"]) : "",
							TenderType = dr["TENDER_TYPE"] != DBNull.Value ? Convert.ToString(dr["TENDER_TYPE"]) : "",
							AmendNo = dr["AMEND_NO"] != DBNull.Value ? Convert.ToString(dr["AMEND_NO"]) : "",
							AmendReleaseDate_Text = dr["AMEND_RELEASE_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["AMEND_RELEASE_DATE"]), "dd-MM-yyyy HH:mm:ss", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							IsPosted = dr["IS_POSTED"] != DBNull.Value ? Convert.ToBoolean(dr["IS_POSTED"]) : false,
							PlantId = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
							Rivision = dr["RIVISION"] != DBNull.Value ? Convert.ToString(dr["RIVISION"]) : "",
						});

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			foreach (var item in list)
				if (!string.IsNullOrEmpty(item.SoDate_Text))
					try { item.SoDate_Text = DateTime.ParseExact(item.SoDate_Text.Trim(), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/"); } catch { continue; }

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
						CommonViewModel.Message = "Please enter Gross Weight.";
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;

						return Json(CommonViewModel);
					}

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
					oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
					oParams.Add(new MySqlParameter("P_GROSS_WT", MySqlDbType.Double) { Value = viewModel.Gross_Wt });
					oParams.Add(new MySqlParameter("P_GROSS_WT_MANUALLY", MySqlDbType.Int64) { Value = viewModel.Gross_Wt_Manually ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_GROSS_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gross_Wt_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RM_WEIGHMENT_IN_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "RmSpWeighmentInSlip") + "?Vehicle_No=" + viewModel.Truck_No + "&Inward_Sys_Id=" + viewModel.Inward_Sys_Id : null;

				}
				else if (viewModel.Inward_Sys_Id == 3)
				{
					if (viewModel.Tare_Wt < 0)
					{
						CommonViewModel.Message = "Please enter Tare Weight.";
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;

						return Json(CommonViewModel);
					}

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
					oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
					oParams.Add(new MySqlParameter("P_TARE_WT", MySqlDbType.Double) { Value = viewModel.Tare_Wt });
					oParams.Add(new MySqlParameter("P_TARE_WT_MANUALLY", MySqlDbType.Int64) { Value = viewModel.Is_Tare_Wt_Manually ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_TARE_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Tare_Wt_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 7 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SP_WEIGHMENT_IN_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "RmSpWeighmentInSlip") + "?Vehicle_No=" + viewModel.Truck_No + "&Inward_Sys_Id=" + viewModel.Inward_Sys_Id : null;
				}
				else if (viewModel.Inward_Sys_Id == 4)
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Gate_In_Id });
					oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
					oParams.Add(new MySqlParameter("P_TARE_WT", MySqlDbType.Double) { Value = viewModel.Tare_Wt });
					oParams.Add(new MySqlParameter("P_TARE_WT_MANUALLY", MySqlDbType.Int64) { Value = viewModel.Is_Tare_Wt_Manually ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_TARE_WT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Tare_Wt_Note });
					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_WEIGHMENT_IN_SAVE_OTHER", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;
					CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

					CommonViewModel.Data5 = IsSuccess ? Url.Action("Index", "WeighmentInSlip_Other") + "?Gate_In_Out_Id=" + viewModel.Gate_In_Id : null;

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
		//public async Task<IActionResult> GetWeighbridge_Interface_Data(string Weighbridge_Id = "")
		//{
		//	try
		//	{
		//		//	List<(string Name, string IP, int Port)> listWeighbridge = AppHttpContextAccessor.GetWeighbridgeList();

		//		//	if (listWeighbridge != null && listWeighbridge.Count() > 0 && listWeighbridge.Any(x => x.IP + ":" + x.Port == Weighbridge_Id))
		//		//	{
		//		//		var index = listWeighbridge.FindIndex(x => x.IP + ":" + x.Port == Weighbridge_Id);

		//		//		var weight = await TcpClientApp.GetData(listWeighbridge[index].IP, listWeighbridge[index].Port);

		//		//		CommonViewModel.IsConfirm = false;
		//		//		CommonViewModel.IsSuccess = true;
		//		//		CommonViewModel.StatusCode = ResponseStatusCode.Success;
		//		//		CommonViewModel.Message = ResponseStatusMessage.Success;

		//		//		CommonViewModel.Data1 = weight;

		//		//	}

		//		List<(string Name, string IP, int Port)> listWeighbridge = AppHttpContextAccessor.GetWeighbridgeList();

		//		Weighbridge_Id = string.IsNullOrEmpty(Weighbridge_Id) ? listWeighbridge.Select(x => x.IP + ":" + x.Port).FirstOrDefault() : Weighbridge_Id;

		//		if (listWeighbridge != null && listWeighbridge.Count() > 0 && listWeighbridge.Any(x => x.IP + ":" + x.Port == Weighbridge_Id))
		//		{
		//			var index = listWeighbridge.FindIndex(x => x.IP + ":" + x.Port == Weighbridge_Id);

		//			//var weight = await TcpClientApp.GetData(listWeighbridge[index].IP, listWeighbridge[index].Port);

		//			//CommonViewModel.IsConfirm = false;
		//			//CommonViewModel.IsSuccess = true;
		//			//CommonViewModel.StatusCode = ResponseStatusCode.Success;
		//			//CommonViewModel.Message = ResponseStatusMessage.Success;

		//			//CommonViewModel.Data1 = weight;

		//			using (var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30)))
		//			{
		//				try
		//				{
		//					var weight = await TcpClientApp.GetData(listWeighbridge[index].IP, listWeighbridge[index].Port, cts.Token);

		//					CommonViewModel.IsConfirm = false;
		//					CommonViewModel.IsSuccess = true;
		//					CommonViewModel.StatusCode = ResponseStatusCode.Success;
		//					CommonViewModel.Message = ResponseStatusMessage.Success;

		//					CommonViewModel.Data1 = weight;
		//				}
		//				catch (Exception ex) { }
		//			}
		//		}

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
