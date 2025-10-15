using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class RoleController : BaseController<ResponseModel<Role>>
	{
		#region Loading
		public IActionResult Index()
		{
			try
			{
				var dt = new DataTable();

				CommonViewModel.ListObj = new List<Role>();

				if (AppHttpContextAccessor.IsCloudDBActive)
				{
					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
					oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", oParams, true);
				}
				else
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_ROLE_GET", oParams, true);
				}

                if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new Role()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
							Plant_Id = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PLANT_ID"]) : 0,
							Plant_Name = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
							Role_Name = dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "",
							IsActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
							IsAdmin = dr["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(dr["ISADMIN"]) : false
						});
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Partial_AddEditForm(int Id)
		{
			var obj = new Role();

			var dt = new DataTable();

			var list = new List<SelectListItem_Custom>();

			try
			{
				if (AppHttpContextAccessor.IsCloudDBActive)
				{
					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
					oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					if (Id > 0)
					{
						oParams[0].Value = Id;
						oParams[1].Value = "";
					}

					dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
					{
						obj = new Role()
						{
							Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
							Plant_Id = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
							Role_Name = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "",
							IsActive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false,
							IsAdmin = dt.Rows[0]["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISADMIN"]) : false,
							SelectedMenu = dt.Rows[0]["MENUS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MENUS"]) : ""
						};
					}

					oParams[0].Value = 0;
					oParams[1].Value = "Y";

					dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PLANT_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "P"));

					list.Insert(0, new SelectListItem_Custom("0", "All Plant", "P"));

					dt = DataContext.ExecuteStoredProcedure_DataTable("PC_MENU_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : ""
								, dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""
								, dr["PARENT_ID"] != DBNull.Value ? Convert.ToString(dr["PARENT_ID"]) : ""
								, dr["DISPLAYORDER"] != DBNull.Value ? Convert.ToString(dr["DISPLAYORDER"]) : ""
								, "M"));

				}
				else
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					if (Id > 0)
					{
						oParams[0].Value = Id;
						oParams[1].Value = "";
					}

					dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_ROLE_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
					{
						obj = new Role()
						{
							Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
							Plant_Id = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
							Role_Name = dt.Rows[0]["NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NAME"]) : "",
							IsActive = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false,
							IsAdmin = dt.Rows[0]["ISADMIN"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISADMIN"]) : false,
							SelectedMenu = dt.Rows[0]["MENUS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MENUS"]) : ""
						};
					}

					oParams[0].Value = 0;
					oParams[1].Value = "Y";

					dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PLANT_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "P"));

					list.Insert(0, new SelectListItem_Custom("0", "All Plant", "P"));

					dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_MENU_GET", oParams, true);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : ""
								, dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""
								, dr["PARENT_ID"] != DBNull.Value ? Convert.ToString(dr["PARENT_ID"]) : ""
								, dr["DISPLAYORDER"] != DBNull.Value ? Convert.ToString(dr["DISPLAYORDER"]) : ""
								, "M"));

				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.SelectListItems = list;

			CommonViewModel.Obj = obj;

			return PartialView("_Partial_AddEditForm", CommonViewModel);
		}

		#endregion

		#region Events

		[HttpPost]
		public JsonResult Save(Role viewModel)
		{
			try
			{
				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				if (AppHttpContextAccessor.IsCloudDBActive)
				{
					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new OracleParameter("P_ROLE_PLANT_ID", OracleDbType.Int64) { Value = viewModel.Plant_Id });
					oParams.Add(new OracleParameter("P_NAME", OracleDbType.Varchar2) { Value = viewModel.Role_Name ?? "" });
					oParams.Add(new OracleParameter("P_ISADMIN", OracleDbType.Varchar2) { Value = viewModel.IsAdmin ? "Y" : "N" });
					oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.IsActive ? "Y" : "N" });
					oParams.Add(new OracleParameter("P_MENUS", OracleDbType.Varchar2) { Value = viewModel.SelectedMenu ?? "" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_ROLE_SAVE", oParams, true);
				}
				else
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_ROLE_PLANT_ID", MySqlDbType.Int64) { Value = viewModel.Plant_Id });
					oParams.Add(new MySqlParameter("P_NAME", MySqlDbType.VarChar) { Value = viewModel.Role_Name ?? "" });
					oParams.Add(new MySqlParameter("P_ISADMIN", MySqlDbType.VarChar) { Value = viewModel.IsAdmin ? "Y" : "N" });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = viewModel.IsActive ? "Y" : "N" });
					oParams.Add(new MySqlParameter("P_MENUS", MySqlDbType.VarChar) { Value = viewModel.SelectedMenu ?? "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_ROLE_SAVE", oParams, true);

				}

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

		#endregion
	}
}

