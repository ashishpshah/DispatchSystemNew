using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
	[Area("Dispatch")]
	public class RFIDController : BaseController<ResponseModel<RFID>>
	{
		#region Loading
		public IActionResult Index()
		{
			try
			{
				CommonViewModel.ListObj = new List<RFID>();

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RFID_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
						CommonViewModel.ListObj.Add(new RFID()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
							Plant_Id = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
							Station_Id = dr["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dr["STATION_ID"]) : 0,
							RfidSrno = dr["SRNO"] != DBNull.Value ? Convert.ToString(dr["SRNO"]) : "",
							RfidCode = dr["CODE"] != DBNull.Value ? Convert.ToString(dr["CODE"]) : "",
							Status = dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : "",
							ReasonforEdit = dr["REASONFOREDIT"] != DBNull.Value ? Convert.ToString(dr["REASONFOREDIT"]) : "",
							//IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
						});
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			for (int i = 0; i < CommonViewModel.ListObj.Count; i++)
				CommonViewModel.ListObj[i].IsActive = string.IsNullOrEmpty(CommonViewModel.ListObj[i].Status) || CommonViewModel.ListObj[i].Status.Trim().ToUpper() == "ACTIVE";

			return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Partial_AddEditForm(int Id)
		{
			var obj = new RFID();

			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Id });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				if (Id > 0)
				{
					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RFID_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
						obj = new RFID()
						{
							Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["ID"]) : 0,
							Plant_Id = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["PLANT_ID"]) : 0,
							Station_Id = dt.Rows[0]["STATION_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["STATION_ID"]) : 0,
							RfidSrno = dt.Rows[0]["SRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SRNO"]) : "",
							RfidCode = dt.Rows[0]["CODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CODE"]) : "",
							Status = dt.Rows[0]["STATUS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["STATUS"]) : "",
							ReasonforEdit = dt.Rows[0]["REASONFOREDIT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["REASONFOREDIT"]) : "",
							//IsActive = dt.Rows[0]["IS_POSTED"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_POSTED"]) : false,
						};
				}
				else
				{
					oParams[0].Value = -1;

					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_RFID_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
						obj = new RFID() { RfidSrno = dt.Rows[0]["SRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["SRNO"]) : "" };
				}

				obj.IsActive = string.IsNullOrEmpty(obj.Status) || obj.Status.Trim().ToUpper() == "ACTIVE";
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.Obj = obj;

			return PartialView("_Partial_AddEditForm", CommonViewModel);

		}

		#endregion

		#region Events

		[HttpPost]
		public JsonResult Save(RFID viewModel)
		{
			try
			{
				if (viewModel.IsActive == true)
					viewModel.Status = "Active";
				else
					viewModel.Status = "Assigned";

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = viewModel.Station_Id });
				oParams.Add(new MySqlParameter("P_RFIDCODE", MySqlDbType.VarChar) { Value = viewModel.RfidCode });
				oParams.Add(new MySqlParameter("P_RFIDSRNO", MySqlDbType.VarChar) { Value = viewModel.RfidSrno });
				oParams.Add(new MySqlParameter("P_STATUS", MySqlDbType.VarChar) { Value = viewModel.Status });
				oParams.Add(new MySqlParameter("P_REASONFOREDIT", MySqlDbType.VarChar) { Value = viewModel.ReasonforEdit });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = viewModel.IsActive ? "Y" : "N" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RFID_SAVE", oParams, true);
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

		[HttpPost]
		public JsonResult DeleteConfirmed(long id = 0)
		{
			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_RFID_DELETE", oParams, true);

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
	}
}
