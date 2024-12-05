using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
	[Area("Dispatch")]
	public class GateInController : BaseController<ResponseModel<GateIn>>
	{
		#region Loading

		public IActionResult Index()
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

				list.Insert(0, new SelectListItem_Custom("", "-- Select --", 0, "UOM"));

				oParams[0].Value = "UOM";

				dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, false);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(Convert.ToString(dr["LOV_CODE"]), Convert.ToString(dr["LOV_DESC"]), Convert.ToString(dr["DISPLAY_SEQ_NO"]), "UOM"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


			try
			{
				oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

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
		public IActionResult GetMDA(string type, string searchTerm, int Inward_Sys_Id = 0)
		{
			var list = new List<MDA>();

			try
			{
				DataTable dt = new DataTable();

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = string.IsNullOrEmpty(type) || type != "V" ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				if (Inward_Sys_Id == 1)
				{
					dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_GATE_IN_MDA_LIST", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new MDA()
							{
								Inward_Sys_Id = Inward_Sys_Id,
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
								mda_order = dr["MDA_ORDER"] != DBNull.Value ? Convert.ToInt32(dr["MDA_ORDER"]) : 0
							});

				}
				else if (Inward_Sys_Id == 4)
				{
					dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_GATE_IN_OTHER_LIST", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new MDA()
							{
								Inward_Sys_Id = Inward_Sys_Id,
								Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
								vehicle_no = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : "",
								mda_no = dr["ORDER_NO"] != DBNull.Value ? Convert.ToString(dr["ORDER_NO"]) : "",
								mda_dt = dr["ORDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ORDER_DATE"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
								tptr_cd = dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "",
								tptr_name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
								mda_order = dr["SR_NO"] != DBNull.Value ? Convert.ToInt32(dr["SR_NO"]) : 0
							});
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
				else return PartialView("_Partial_MDA", list);
			else return Json(null);
			//return PartialView("_Partial_MDA", list);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_PO(int Id)
		{
			var obj = new ResponseModel<PO>();
			obj.Obj = new PO();

			var dt = DataContext.ExecuteQuery_SQL("SELECT CONCAT('KLPO24', LPAD(IFNULL(MAX(PO_SYS_ID) + 1, 1), 5, '0')) AS PO_NO FROM PO_HEADER;");

			obj.Obj.PoNo = (dt != null && dt.Rows.Count > 0 && dt.Rows[0][0] != DBNull.Value ? Convert.ToString(dt.Rows[0][0]) : "");

			List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

			List<OracleParameter> oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
			oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
			oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);

			list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));
			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow row in dt.Rows)
					list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

			oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = "UOM" });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams, true);

			list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));
			foreach (DataRow row in dt.Rows)
				list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

			oParams[0] = new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 };

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_TRANSPORTER_GET", oParams, true);

			list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));
			foreach (DataRow dr in dt.Rows)
				list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
													, (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
														+ (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

			obj.SelectListItems = list;


			return PartialView("_Partial_AddEditForm_PO", obj);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_SO(int Id)
		{
			var obj = new ResponseModel<SO>();

			obj.Obj = new SO();

			var dt = DataContext.ExecuteQuery_SQL("SELECT CONCAT('KLSO24', LPAD(IFNULL(MAX(SO_SYS_ID) + 1, 1), 5, '0')) AS SO_NO FROM SO_HEADER");

			obj.Obj.SoNo = (dt != null && dt.Rows.Count > 0 && dt.Rows[0][0] != DBNull.Value ? Convert.ToString(dt.Rows[0][0]) : "");

			List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

			List<OracleParameter> oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
			oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
			oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);

			list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));
			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow row in dt.Rows)
					list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

			oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_LOV_COLUMN", OracleDbType.Varchar2) { Value = "UOM" });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_LOV_GET", oParams, true);

			list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));
			foreach (DataRow row in dt.Rows)
				list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

			oParams[0] = new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 };

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_TRANSPORTER_GET", oParams, true);

			list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));
			foreach (DataRow dr in dt.Rows)
				list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
													, (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
														+ (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

			obj.SelectListItems = list;

			return PartialView("_Partial_AddEditForm_SO", obj);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_Other(int Id)
		{
			var obj = new ResponseModel<OtherMaterial>();

			obj.Obj = new OtherMaterial();

			List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

			List<MySqlParameter> oParams = new List<MySqlParameter>();

			oParams = new List<MySqlParameter>();

			oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "UOM" });
			oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
			oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

			list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));
			foreach (DataRow row in dt.Rows)
				list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

			oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

			dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

			list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));
			foreach (DataRow dr in dt.Rows)
				list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
													, (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
														+ (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

			obj.SelectListItems = list;

			return PartialView("_Partial_AddEditForm_Other", obj);
		}

		//[HttpGet]
		//public IActionResult Partial_AddEditForm_PO(int Id)
		//{
		//	var obj = new ResponseModel<PO>();

		//	List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

		//	List<MySqlParameter> oParams = new List<MySqlParameter>();

		//	oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
		//	oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
		//	oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarString) { Value = "" });
		//	oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
		//	oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
		//	oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
		//	oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
		//	oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
		//	//oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
		//	//oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

		//	var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

		//	list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));
		//	if (dt != null && dt.Rows.Count > 0)
		//		foreach (DataRow row in dt.Rows)
		//			list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

		//	oParams = new List<MySqlParameter>();

		//	oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "UOM" });
		//	oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
		//	oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
		//	oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
		//	oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
		//	oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

		//	dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

		//	list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));
		//	if (dt != null && dt.Rows.Count > 0)
		//		foreach (DataRow row in dt.Rows)
		//			list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

		//	oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

		//	dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

		//	list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));
		//	if (dt != null && dt.Rows.Count > 0)
		//		foreach (DataRow dr in dt.Rows)
		//			list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
		//												, (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
		//													+ (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

		//	obj.SelectListItems = list;
		//	obj.Obj = new PO();

		//	return PartialView("_Partial_AddEditForm_PO", obj);
		//}

		//[HttpGet]
		//public IActionResult Partial_AddEditForm_SO(int Id)
		//{
		//	var obj = new ResponseModel<SO>();

		//	List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

		//	List<MySqlParameter> oParams = new List<MySqlParameter>();

		//	oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
		//	oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
		//	oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarString) { Value = "" });
		//	oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
		//	oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
		//	oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
		//	oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
		//	oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
		//	//oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
		//	//oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

		//	var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

		//	list.Insert(0, new SelectListItem_Custom("", "-- Select Vendor --", "V"));
		//	if (dt != null && dt.Rows.Count > 0)
		//		foreach (DataRow row in dt.Rows)
		//			list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

		//	oParams = new List<MySqlParameter>();

		//	oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "UOM" });
		//	oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
		//	oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
		//	oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
		//	oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
		//	oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

		//	dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

		//	list.Insert(0, new SelectListItem_Custom("", "-- Select UOM --", "U"));
		//	if (dt != null && dt.Rows.Count > 0)
		//		foreach (DataRow row in dt.Rows)
		//			list.Add(new SelectListItem_Custom(row["LOV_CODE"].ToString(), row["LOV_DESC"].ToString(), "U"));

		//	oParams[0] = new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 };

		//	dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

		//	list.Insert(0, new SelectListItem_Custom("", "-- Select Transporter --", "T"));
		//	if (dt != null && dt.Rows.Count > 0)
		//		foreach (DataRow dr in dt.Rows)
		//			list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
		//												, (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
		//													+ (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

		//	obj.SelectListItems = list;
		//	obj.Obj = new SO();

		//	return PartialView("_Partial_AddEditForm_SO", obj);
		//}

		#endregion


		#region Events

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

				if (string.IsNullOrEmpty(viewModel.Inward_Sys_Id) || viewModel.Inward_Sys_Id == "0")
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Inward Type";
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


				if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "1"
					&& (string.IsNullOrEmpty(viewModel.Common_Sys_Id_Multi) && viewModel.Common_Sys_Id <= 0))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select valid MDA detalis.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				else if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "4"
					&& string.IsNullOrEmpty(viewModel.Common_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Other Material detalis.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}


				if (string.IsNullOrEmpty(viewModel.Common_Date))
				{
					CommonViewModel.IsSuccess = false;
					if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "1")
						CommonViewModel.Message = "Please enter valid MDA Date";
					else if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "4")
						CommonViewModel.Message = "Please enter valid Order Date";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}


				if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id != "4"
					&& string.IsNullOrEmpty(viewModel.Transporter_Name))
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

				if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "4"
					&& (string.IsNullOrEmpty(viewModel.TransactionType) || !viewModel.TransactionType.Contains("LOAD")))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Transaction Type.";
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

				//if (string.IsNullOrEmpty(viewModel.Common_No) || string.IsNullOrEmpty(viewModel.input_Common_Id_Multi))
				//{
				//	CommonViewModel.IsSuccess = false;
				//	if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "1")
				//		CommonViewModel.Message = "Please select valid MDA detalis.";
				//	else if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "4")
				//		CommonViewModel.Message = "Please enter valid Order Number";
				//	CommonViewModel.StatusCode = ResponseStatusCode.Error;

				//	return Json(CommonViewModel);
				//}


				//string objList_JSON = "";

				//if (viewModel.listSerial != null && viewModel.listSerial.Count() > 0)
				//	objList_JSON = string.Join("<#>", viewModel.listSerial.Select(x => x.Id + "|" + (x.IsLock ? 1 : 0)).ToArray());

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "1"
					&& (!string.IsNullOrEmpty(viewModel.Common_Sys_Id_Multi) || viewModel.Common_Sys_Id > 0))
				{
					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
					oParams.Add(new MySqlParameter("P_COMMON_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Common_Sys_Id });
					oParams.Add(new MySqlParameter("P_COMMON_SYS_ID_MULTI", MySqlDbType.VarString) { Value = !string.IsNullOrEmpty(viewModel.Common_Sys_Id_Multi) ? viewModel.Common_Sys_Id_Multi.Trim().Replace(" ", "") : "" });
					oParams.Add(new MySqlParameter("P_COMMON_NO", MySqlDbType.VarString) { Value = viewModel.Common_No });
					oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarString) { Value = viewModel.Truck_No });
					//oParams.Add(new MySqlParameter("P_TRANSPORTER_CODE", MySqlDbType.VarString) { Value = viewModel.Transporter_Code });
					oParams.Add(new MySqlParameter("P_DRIVER_ID_TYPE", MySqlDbType.VarString) { Value = viewModel.Driver_Id_Type });
					oParams.Add(new MySqlParameter("P_DRIVER_ID_NUMBER", MySqlDbType.VarString) { Value = viewModel.Driver_Id_Number });
					oParams.Add(new MySqlParameter("P_DRIVER_NAME", MySqlDbType.VarString) { Value = viewModel.Driver_Name });
					oParams.Add(new MySqlParameter("P_DRIVER_CONTACT", MySqlDbType.VarString) { Value = viewModel.Driver_Contact });
					oParams.Add(new MySqlParameter("P_DRIVER_CHANGED", MySqlDbType.Int64) { Value = viewModel.Driver_Changed ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_DRIVER_NAME_NEW", MySqlDbType.VarString) { Value = viewModel.Driver_Name_New });
					oParams.Add(new MySqlParameter("P_DRIVER_CONTACT_NEW", MySqlDbType.VarString) { Value = viewModel.Driver_Contact_New });
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

					(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_GATE_IN_SAVE_NEW", oParams, true);
				}
				else if (!string.IsNullOrEmpty(viewModel.Inward_Sys_Id) && viewModel.Inward_Sys_Id == "4")
				{
					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_INWARD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Inward_Sys_Id });
					oParams.Add(new MySqlParameter("P_COMMON_SYS_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_COMMON_NO", MySqlDbType.VarString) { Value = viewModel.Common_No });
					oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarString) { Value = viewModel.Truck_No });
					oParams.Add(new MySqlParameter("P_TRANSACTION_TYPE", MySqlDbType.VarString) { Value = viewModel.TransactionType });
					oParams.Add(new MySqlParameter("P_DRIVER_ID_TYPE", MySqlDbType.VarString) { Value = viewModel.Driver_Id_Type });
					oParams.Add(new MySqlParameter("P_DRIVER_ID_NUMBER", MySqlDbType.VarString) { Value = viewModel.Driver_Id_Number });
					oParams.Add(new MySqlParameter("P_DRIVER_NAME", MySqlDbType.VarString) { Value = viewModel.Driver_Name });
					oParams.Add(new MySqlParameter("P_DRIVER_CONTACT", MySqlDbType.VarString) { Value = viewModel.Driver_Contact });
					oParams.Add(new MySqlParameter("P_DRIVER_CHANGED", MySqlDbType.Int64) { Value = viewModel.Driver_Changed ? 1 : 0 });
					oParams.Add(new MySqlParameter("P_DRIVER_NAME_NEW", MySqlDbType.VarString) { Value = viewModel.Driver_Name_New });
					oParams.Add(new MySqlParameter("P_DRIVER_CONTACT_NEW", MySqlDbType.VarString) { Value = viewModel.Driver_Contact_New });
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

					(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_GATE_IN_OTHER_SAVE", oParams, true);

				}

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
		public JsonResult Save_PO(PO viewModel)
		{
			var obj = new ResponseModel<PO>();

			try
			{
				if (viewModel == null)
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Vendor PO details";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}


				string objList_JSON = "";

				if (viewModel.listPoDtls != null && viewModel.listPoDtls.Any(x => !string.IsNullOrEmpty(x.LineDesc) && !string.IsNullOrEmpty(x.UOM) && x.LineQty > 0))
					objList_JSON = string.Join("##", viewModel.listPoDtls.Where(x => !string.IsNullOrEmpty(x.LineDesc) && !string.IsNullOrEmpty(x.UOM) && x.LineQty > 0)
														.Select(x => x.Id + "|" + (x.LineNo ?? "0") + "|" + x.LineDesc + "|" + x.UOM + "|" + x.LineQty).ToArray());

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_VENDOR_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new MySqlParameter("P_SITE_ID", MySqlDbType.Int64) { Value = viewModel.SiteId });
				oParams.Add(new MySqlParameter("P_PO_NO", MySqlDbType.VarString) { Value = viewModel.PoNo });
				oParams.Add(new MySqlParameter("P_PO_DATE", MySqlDbType.VarString) { Value = viewModel.PoDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
				oParams.Add(new MySqlParameter("P_PO_DESC", MySqlDbType.VarString) { Value = viewModel.PoDesc });
				oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarString) { Value = viewModel.TruckNo });
				oParams.Add(new MySqlParameter("P_TRANS_SYS_ID", MySqlDbType.Int64) { Value = viewModel.TransId });
				oParams.Add(new MySqlParameter("P_PO_DTLS", MySqlDbType.VarString) { Value = objList_JSON });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PO_SAVE", oParams, true);

				obj.IsConfirm = true;
				obj.IsSuccess = IsSuccess;
				obj.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				obj.Message = response;

				if (IsSuccess == true)
				{
					List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

					List<OracleParameter> oParams_ = new List<OracleParameter>();

					oParams_.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.VendorId });
					oParams_.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
					oParams_.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
					oParams_.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
					oParams_.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams_.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams_.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams_.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					oParams_.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
					oParams_.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

					var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams_, false);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow row in dt.Rows)
							list.Add(new SelectListItem_Custom(row["ID"].ToString(), row["Organization_Name"].ToString() + " (" + row["VENDOR_CODE"].ToString() + ")", row["VENDOR_CODE"].ToString(), "V"));

					obj.SelectListItems = list;

					viewModel.Id = Id;
					viewModel.PoDate_Text = viewModel.PoDate?.ToString("dd/MM/yyyy").Replace("-", "/");

					obj.Obj = viewModel;
				}
			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);

				obj.IsSuccess = false;
				obj.StatusCode = ResponseStatusCode.Error;
				obj.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}

			return Json(obj);
		}

		[HttpPost]
		public JsonResult Save_SO(SO viewModel)
		{
			var obj = new ResponseModel<SO>();

			try
			{
				if (viewModel == null)
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Vendor SO details";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}


				string objList_JSON = "";

				if (viewModel.listSoDtls != null && viewModel.listSoDtls.Any(x => !string.IsNullOrEmpty(x.ScrapDesc) && !string.IsNullOrEmpty(x.Uom) && x.SoQty > 0))
					objList_JSON = string.Join("<#>", viewModel.listSoDtls.Where(x => !string.IsNullOrEmpty(x.ScrapDesc) && !string.IsNullOrEmpty(x.Uom) && x.SoQty > 0)
														.Select(x => x.Id + "|" + x.SlNo + "|" + x.ScrapDesc + "|" + x.Uom + "|" + x.SoQty).ToArray());

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_VENDOR_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
				oParams.Add(new MySqlParameter("P_SITE_ID", MySqlDbType.VarString) { Value = viewModel.SiteId });
				oParams.Add(new MySqlParameter("P_SO_NO", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.SoNo) });
				oParams.Add(new MySqlParameter("P_SO_DATE", MySqlDbType.VarString) { Value = viewModel.SoDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
				oParams.Add(new MySqlParameter("P_RIVISION", MySqlDbType.VarString) { Value = viewModel.Rivision });
				oParams.Add(new MySqlParameter("P_ORDER_TYPE", MySqlDbType.VarString) { Value = viewModel.TenderType });
				oParams.Add(new MySqlParameter("P_SO_RELEASE_DATE", MySqlDbType.VarString) { Value = viewModel.SoReleaseDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
				oParams.Add(new MySqlParameter("P_SO_VALID_DATE", MySqlDbType.VarString) { Value = viewModel.SoValidDate?.ToString("dd/MM/yyyy").Replace("-", "/") });
				oParams.Add(new MySqlParameter("P_EMD_AMT", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.EmdAmt) });
				oParams.Add(new MySqlParameter("P_MSR_NO", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.AmendNo) });
				oParams.Add(new MySqlParameter("P_CUST_NAME", MySqlDbType.VarString) { Value = viewModel.CustName });
				oParams.Add(new MySqlParameter("P_ADDRESS", MySqlDbType.VarString) { Value = viewModel.Add1 });
				oParams.Add(new MySqlParameter("P_CITY", MySqlDbType.VarString) { Value = viewModel.City });
				oParams.Add(new MySqlParameter("P_STATE", MySqlDbType.VarString) { Value = viewModel.State });
				oParams.Add(new MySqlParameter("P_PANNO", MySqlDbType.VarString) { Value = viewModel.PanNo });
				oParams.Add(new MySqlParameter("P_GSTNNO", MySqlDbType.VarString) { Value = viewModel.GstnNo });
				oParams.Add(new MySqlParameter("P_TERMS_PRICE", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.TermsPrice) });
				oParams.Add(new MySqlParameter("P_TERMS_PYMT_TERM", MySqlDbType.VarString) { Value = viewModel.TermsPymtTerm });
				oParams.Add(new MySqlParameter("P_TERMS_LIFTING_PERIOD_DAYS", MySqlDbType.Int64) { Value = Convert.ToInt64(viewModel.TermsLiftingPeriodDays) });
				oParams.Add(new MySqlParameter("P_SO_REMARKS", MySqlDbType.VarString) { Value = viewModel.SoRemarks });
				oParams.Add(new MySqlParameter("P_STATUS_REMARKS", MySqlDbType.VarString) { Value = viewModel.StatusRemarks });
				oParams.Add(new MySqlParameter("P_SO_DTLS", MySqlDbType.VarString) { Value = objList_JSON });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SO_SAVE", oParams, true);

				obj.IsConfirm = true;
				obj.IsSuccess = IsSuccess;
				obj.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				obj.Message = response;

				if (IsSuccess == true)
				{
					List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

					oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.VendorId });
					oParams.Add(new MySqlParameter("P_VENDOR_CODE", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					//oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
					//oParams.Add(new MySqlParameter("P_SITES", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_VENDOR_GET", oParams, false);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow row in dt.Rows)
							list.Add(new SelectListItem_Custom(row["VENDOR_CODE"].ToString(), row["Organization_Name"].ToString(), "V"));

					obj.SelectListItems = list;

					viewModel.Id = Id;
					viewModel.SoDate_Text = viewModel.SoDate?.ToString("dd/MM/yyyy").Replace("-", "/");

					obj.Obj = viewModel;
				}

			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);

				obj.IsSuccess = false;
				obj.StatusCode = ResponseStatusCode.Error;
				obj.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}

			return Json(obj);
		}

		[HttpPost]
		public JsonResult Save_Other(OtherMaterial viewModel)
		{
			var obj = new ResponseModel<OtherMaterial>();

			try
			{
				if (viewModel == null)
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Vendor SO details";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				if (string.IsNullOrEmpty(viewModel.OrderNo))
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Order No.";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				if (string.IsNullOrEmpty(viewModel.OrderDate_Text))
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Order Date.";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				if (string.IsNullOrEmpty(viewModel.Transporter_Code))
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Party/Supplier.";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				if (string.IsNullOrEmpty(viewModel.Truck_No))
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Truck No.";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				if (viewModel.listOtherMaterialDtls == null)
				{
					obj.IsSuccess = false;
					obj.Message = "Please enter Material Details.";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				if (viewModel.listOtherMaterialDtls != null && viewModel.listOtherMaterialDtls.Any(x => string.IsNullOrEmpty(x.UOM)))
				{
					obj.IsSuccess = false;
					obj.Message = "Please select UOM.";
					obj.StatusCode = ResponseStatusCode.Error;

					return Json(obj);
				}

				string objList_JSON = "";

				if (viewModel.listOtherMaterialDtls != null && viewModel.listOtherMaterialDtls.Any(x => !string.IsNullOrEmpty(x.Material) && !string.IsNullOrEmpty(x.UOM) && x.Qty > 0))
					objList_JSON = string.Join("<#>", viewModel.listOtherMaterialDtls.Where(x => !string.IsNullOrEmpty(x.Material) && !string.IsNullOrEmpty(x.UOM) && x.Qty > 0)
														.Select(x => x.Material + "|" + x.MaterialDesc + "|" + x.UOM + "|" + x.Qty).ToArray());

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_ORDER_NO", MySqlDbType.VarString) { Value = viewModel.OrderNo });
				oParams.Add(new MySqlParameter("P_ORDER_DATE", MySqlDbType.VarString) { Value = viewModel.OrderDate_Text.Replace("-", "/") });
				oParams.Add(new MySqlParameter("P_TRANSPORTER", MySqlDbType.VarString) { Value = viewModel.Transporter_Code });
				oParams.Add(new MySqlParameter("P_TRUCK_NO", MySqlDbType.VarString) { Value = viewModel.Truck_No });
				oParams.Add(new MySqlParameter("P_DTLS", MySqlDbType.VarString) { Value = objList_JSON });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_OTHER_SAVE", oParams, true);

				obj.IsConfirm = true;
				obj.IsSuccess = IsSuccess;
				obj.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				obj.Message = response;

				if (IsSuccess == true)
				{
					List<SelectListItem_Custom> list = new List<SelectListItem_Custom>();

					oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_TRANSPORTER_GET", oParams, true);

					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom((dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0).ToString()
															, (dr["TPTR_CD"] != DBNull.Value ? Convert.ToString(dr["TPTR_CD"]) + " - " : "")
																, (dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : ""), "T"));

					viewModel.Id = Id;
					viewModel.Transporter_Code = list != null && list.Any(x => x.Value.ToUpper() == viewModel.Transporter_Code.ToUpper() || x.Value2.ToUpper() == viewModel.Transporter_Code.ToUpper()) ?
						list.Where(x => x.Value.ToUpper() == viewModel.Transporter_Code.ToUpper() || x.Value2.ToUpper() == viewModel.Transporter_Code.ToUpper()).Select(x => x.Value2).FirstOrDefault() : viewModel.Transporter_Code;
					viewModel.OrderDate_Text = viewModel.OrderDate_Text.Replace("-", "/");

					obj.Obj = viewModel;
				}

			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);

				obj.IsSuccess = false;
				obj.StatusCode = ResponseStatusCode.Error;
				obj.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}

			return Json(obj);
		}


		[HttpGet]
		public IActionResult fngetRfidNoCode(string rfidNo, string rfidCode)
		{
			var viewModel = new RFID();

			try
			{
				if (rfidNo != null || rfidCode != null)
				{
					string sql = "SELECT RFIDSRNO, Status, RFIDCODE FROM RFID_MASTER WHERE RFIDSRNO = '" + rfidNo + "' OR RFIDCODE = '" + rfidCode + "'";

					var dt = DataContext.ExecuteQuery_SQL(sql);

					if (dt != null && dt.Rows.Count > 0)
					{
						viewModel.RfidSrno = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : "";
						viewModel.Status = dt.Rows[0]["Status"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Status"]) : "";
						viewModel.RfidCode = dt.Rows[0]["RFIDCODE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDCODE"]) : "";

						if (viewModel.Status != "Active")
						{
							var errorMsg = viewModel.Status == "L" ? "This RFID Card is Already Lost" : "This RFID Card is Already Assigned";
							CommonViewModel.IsConfirm = false;
							CommonViewModel.IsSuccess = false;
							CommonViewModel.StatusCode = ResponseStatusCode.Error;
							CommonViewModel.Message = errorMsg;
							viewModel.ReasonforEdit = errorMsg;
							CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
							return Json(viewModel);
						}

					}
					else
					{
						var errorMsg = "No Record Found of " + viewModel.RfidSrno;
						CommonViewModel.IsConfirm = false;
						CommonViewModel.IsSuccess = false;
						CommonViewModel.StatusCode = ResponseStatusCode.Error;
						CommonViewModel.Message = errorMsg;
						viewModel.ReasonforEdit = errorMsg;
						CommonViewModel.RedirectURL = false ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";
						return Json(viewModel);
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return Json(viewModel);
		}

		#endregion

	}
}