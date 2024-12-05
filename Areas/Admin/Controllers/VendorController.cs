
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;
using System.Numerics;
using System.Diagnostics.Metrics;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class VendorController : BaseController<ResponseModel<Vendor>>
	{
		#region Loading
		public IActionResult Index()
		{
			var list = new List<Vendor>();

			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						list.Add(new Vendor()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
							//UserId = dr["USER_ID"] != DBNull.Value ? Convert.ToInt32(dr["USER_ID"]) : 0,
							VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
							Is_ERP_Vendor = dr["IS_ERP_VENDOR"] != DBNull.Value ? Convert.ToString(dr["IS_ERP_VENDOR"]) : null,
							VendorType = dr["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_TYPE"]) : "",
							//SiteCode = dr["Site_Code"] != DBNull.Value ? Convert.ToString(dr["Site_Code"]) : "",
							//SiteName = dr["Site_Name"] != DBNull.Value ? Convert.ToString(dr["Site_Name"]) : "",
							Organization_Name = dr["Organization_Name"] != DBNull.Value ? Convert.ToString(dr["Organization_Name"]) : "",
							First_Name = dr["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dr["FIRST_NAME"]) : "",
							Last_Name = dr["LAST_NAME"] != DBNull.Value ? Convert.ToString(dr["LAST_NAME"]) : "",
							MobileNo = dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "",
							Email_Id = dr["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dr["EMAIL_ID"]) : "",
							//Full_Address = dr["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["FULL_ADDRESS"]) : "",
							Is_Active = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
							Is_Lock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dr["IS_LOCK"]) : false
						});
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.ListObj = list;

			return View(CommonViewModel);
		}
		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Partial_AddEditForm(long id, bool forMapping = false)
		{
			var obj = new Vendor();

			var list = new List<SelectListItem_Custom>();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
				//var parameters = new SqlParameter[] { new SqlParameter("Id", SqlDbType.BigInt) { Value = id, Direction = ParameterDirection.Input } };
				//dt = DataContext.ExecuteStoredProcedure_DataTable("SP_Vendor_Get", parameters);

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = (id > 0) ? id : -1 });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams);

				if (ds != null && ds.Tables.Count > 0)
					dt = ds.Tables[0];

				if (dt != null && dt.Rows.Count > 0)
				{
					obj = new Vendor()
					{
						Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
						PlantId = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
						VendorCode = dt.Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["VENDOR_CODE"]) : null,
						VendorType = dt.Rows[0]["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VENDOR_TYPE"]) : "",
						SiteCode = dt.Rows[0]["Site_Code"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Site_Code"]) : null,
						SiteName = dt.Rows[0]["Site_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Site_Name"]) : "",
						Organization_Name = dt.Rows[0]["Organization_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Organization_Name"]) : "",
						First_Name = dt.Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FIRST_NAME"]) : "",
						Last_Name = dt.Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["LAST_NAME"]) : "",
						MobileNo = dt.Rows[0]["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MOBILE_NO"]) : "",
						Alt_Mobile_No = dt.Rows[0]["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_MOBILE_NO"]) : "",
						Email_Id = dt.Rows[0]["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EMAIL_ID"]) : "",
						Alt_Email_Id = dt.Rows[0]["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_EMAIL_ID"]) : "",
						Full_Address = dt.Rows[0]["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FULL_ADDRESS"]) : "",
						Country_Id = dt.Rows[0]["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["COUNTRY_ID"]) : 0,
						State_Id = dt.Rows[0]["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["STATE_ID"]) : 0,
						District_Id = dt.Rows[0]["DISTRICT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["DISTRICT_ID"]) : 0,
						City = dt.Rows[0]["CITY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CITY"]) : "",
						Postal_Code = dt.Rows[0]["POSTAL_CODE"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["POSTAL_CODE"]) : 0,
						Print_Label_Qty = dt.Rows[0]["Print_Label_Qty"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["Print_Label_Qty"]) : 0,
						Is_System_User = dt.Rows[0]["Is_System_User"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["Is_System_User"]) : false,
						Is_Lock = dt.Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_LOCK"]) : false,
						Is_Active = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false,
						//SelectedPlants = dt.Rows[0]["PLANTS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANTS"]) : ""
					};
				}


				if (ds != null && ds.Tables.Count > 1)
					dt = ds.Tables[1];


				if (dt != null && dt.Rows.Count > 0)
				{
					CommonViewModel.ListObj = new List<Vendor>();

					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new Vendor()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
							//UserId = dr["USER_ID"] != DBNull.Value ? Convert.ToInt32(dr["USER_ID"]) : 0,
							VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
							VendorType = dr["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_TYPE"]) : "",
							SiteCode = dr["Site_Code"] != DBNull.Value ? Convert.ToString(dr["Site_Code"]) : null,
							SiteName = dr["Site_Name"] != DBNull.Value ? Convert.ToString(dr["Site_Name"]) : "",
							Organization_Name = dr["Organization_Name"] != DBNull.Value ? Convert.ToString(dr["Organization_Name"]) : "",
							First_Name = dr["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dr["FIRST_NAME"]) : "",
							Last_Name = dr["LAST_NAME"] != DBNull.Value ? Convert.ToString(dr["LAST_NAME"]) : "",
							Alt_Mobile_No = dr["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["ALT_MOBILE_NO"]) : "",
							Alt_Email_Id = dr["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dr["ALT_EMAIL_ID"]) : "",
							Full_Address = dr["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["FULL_ADDRESS"]) : "",
							City = dr["CITY"] != DBNull.Value ? Convert.ToString(dr["CITY"]) : "",
							Is_Active = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
							Is_Lock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dr["IS_LOCK"]) : false
						});
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			list = new List<SelectListItem_Custom>();

			oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PLANT_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "P"));

			//dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", _oParams, true);

			//if (dt != null && dt.Rows.Count > 0)
			//	foreach (DataRow dr in dt.Rows)
			//		list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "R"));

			if (list == null) list = new List<SelectListItem_Custom>();

			list.Add(new SelectListItem_Custom("0", "-- Select --", "C"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));

			if (list == null) list = new List<SelectListItem_Custom>();

			oParams.Insert(1, new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = (obj != null ? obj.Country_Id : 0) });

			list.Add(new SelectListItem_Custom("0", "-- Select --", "S"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_STATE_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

			if (list == null) list = new List<SelectListItem_Custom>();

			oParams.Insert(2, new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = (obj != null ? obj.State_Id : 0) });

			list.Add(new SelectListItem_Custom("0", "-- Select --", "D"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));


			CommonViewModel.SelectListItems = list;


			//var plants = string.IsNullOrEmpty(obj.SelectedPlants) ? new string[] { } : obj.SelectedPlants.Split(',').ToArray();

			//if (plants == null || plants.Length == 0)
			//{
			//	plants = new string[] { Common.Get_Session_Int(SessionKey.PLANT_ID).ToString() };

			//	obj.SelectedPlants = string.Join(",", plants);
			//}


			CommonViewModel.Obj = obj;

			return PartialView("_Partial_AddEditForm", CommonViewModel);
		}

		[HttpGet]
		public IActionResult Partial_AddEditForm_Site(long id, string vendor_code)
		{
			var obj = new Vendor();

			var list = new List<SelectListItem_Custom>();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
				//var parameters = new SqlParameter[] { new SqlParameter("Id", SqlDbType.BigInt) { Value = id, Direction = ParameterDirection.Input } };
				//dt = DataContext.ExecuteStoredProcedure_DataTable("SP_Vendor_Get", parameters);

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = (id > 0) ? id : -1 });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
				oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
				oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

				var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams);

				if (ds != null && ds.Tables.Count > 1)
					dt = ds.Tables[0];

				if (dt != null && dt.Rows.Count > 0)
				{
					obj = new Vendor()
					{
						Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
						//PlantId = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
						VendorCode = dt.Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["VENDOR_CODE"]) : null,
						//VendorType = dt.Rows[0]["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VENDOR_TYPE"]) : "",
						SiteCode = dt.Rows[0]["Site_Code"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Site_Code"]) : null,
						//SiteName = dt.Rows[0]["Site_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Site_Name"]) : "",
						//Organization_Name = dt.Rows[0]["Organization_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Organization_Name"]) : "",
						//First_Name = dt.Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FIRST_NAME"]) : "",
						//Last_Name = dt.Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["LAST_NAME"]) : "",
						//MobileNo = dt.Rows[0]["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MOBILE_NO"]) : "",
						//Alt_Mobile_No = dt.Rows[0]["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_MOBILE_NO"]) : "",
						//Email_Id = dt.Rows[0]["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EMAIL_ID"]) : "",
						//Alt_Email_Id = dt.Rows[0]["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_EMAIL_ID"]) : "",
						//Full_Address = dt.Rows[0]["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FULL_ADDRESS"]) : "",
						//Country_Id = dt.Rows[0]["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["COUNTRY_ID"]) : 0,
						//State_Id = dt.Rows[0]["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["STATE_ID"]) : 0,
						//District_Id = dt.Rows[0]["DISTRICT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["DISTRICT_ID"]) : 0,
						//City = dt.Rows[0]["CITY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CITY"]) : "",
						//Postal_Code = dt.Rows[0]["POSTAL_CODE"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["POSTAL_CODE"]) : 0,
						//Is_System_User = dt.Rows[0]["Is_System_User"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["Is_System_User"]) : false,
						//Is_Lock = dt.Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_LOCK"]) : false,
						//Is_Active = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false,
						//SelectedPlants = dt.Rows[0]["PLANTS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANTS"]) : ""
					};
				}


				if (ds != null && ds.Tables.Count > 1)
					dt = ds.Tables[1];

				if (dt != null && dt.Rows.Count > 0)
				{
					CommonViewModel.ListObj = new List<Vendor>();

					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new Vendor()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
							//UserId = dr["USER_ID"] != DBNull.Value ? Convert.ToInt32(dr["USER_ID"]) : 0,
							VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
							VendorType = dr["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_TYPE"]) : "",
							SiteCode = dr["Site_Code"] != DBNull.Value ? Convert.ToString(dr["Site_Code"]) : null,
							SiteName = dr["Site_Name"] != DBNull.Value ? Convert.ToString(dr["Site_Name"]) : "",
							Organization_Name = dr["Organization_Name"] != DBNull.Value ? Convert.ToString(dr["Organization_Name"]) : "",
							First_Name = dr["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dr["FIRST_NAME"]) : "",
							Last_Name = dr["LAST_NAME"] != DBNull.Value ? Convert.ToString(dr["LAST_NAME"]) : "",
							Alt_Mobile_No = dr["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["ALT_MOBILE_NO"]) : "",
							Alt_Email_Id = dr["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dr["ALT_EMAIL_ID"]) : "",
							Full_Address = dr["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["FULL_ADDRESS"]) : "",
							Country_Id = dr["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dr["COUNTRY_ID"]) : 0,
							State_Id = dr["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dr["STATE_ID"]) : 0,
							District_Id = dr["DISTRICT_ID"] != DBNull.Value ? Convert.ToInt32(dr["DISTRICT_ID"]) : 0,
							City = dr["CITY"] != DBNull.Value ? Convert.ToString(dr["CITY"]) : "",
							Postal_Code = dr["POSTAL_CODE"] != DBNull.Value ? Convert.ToInt32(dr["POSTAL_CODE"]) : 0,
							Is_Active = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
							Is_Lock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dr["IS_LOCK"]) : false
						});
					}
				}

				if (CommonViewModel.ListObj != null && CommonViewModel.ListObj.Any(x => x.SiteCode == vendor_code))
					obj = CommonViewModel.ListObj.Where(x => x.SiteCode == vendor_code).FirstOrDefault();
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			list = new List<SelectListItem_Custom>();

			oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			list.Add(new SelectListItem_Custom("0", "-- Select --", "C"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));


			oParams.Insert(1, new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = (obj != null ? obj.Country_Id : 0) });

			list.Add(new SelectListItem_Custom("0", "-- Select --", "S"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_STATE_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

			oParams.Insert(2, new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = (obj != null ? obj.State_Id : 0) });

			list.Add(new SelectListItem_Custom("0", "-- Select --", "D"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));

			CommonViewModel.SelectListItems = list;

			CommonViewModel.Obj = obj;

			return PartialView("_Partial_AddEditForm_Site", CommonViewModel);
		}


		[HttpGet]
		public IActionResult Search_Vendor(string searchTerm, long vendorcode = 0)
		{
			var list = new List<Vendor>();

			var dt = new DataTable();

			if (!string.IsNullOrEmpty(searchTerm) || vendorcode > 0)
				try
				{
					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = vendorcode });
					oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = vendorcode });
					oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = searchTerm });
					oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
					oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

					//var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);
					var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams);

					if (ds != null && ds.Tables.Count > 0)
						dt = ds.Tables[0];

					if (vendorcode == 0 && dt != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(searchTerm))
					{
						foreach (DataRow dr in dt.Rows)
						{
							list.Add(new Vendor()
							{
								Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
								//UserId = dr["USER_ID"] != DBNull.Value ? Convert.ToInt32(dr["USER_ID"]) : 0,
								VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
								VendorType = dr["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_TYPE"]) : "",
								//SiteCode = dr["Site_Code"] != DBNull.Value ? Convert.ToString(dr["Site_Code"]) : "",
								//SiteName = dr["Site_Name"] != DBNull.Value ? Convert.ToString(dr["Site_Name"]) : "",
								Organization_Name = dr["Organization_Name"] != DBNull.Value ? Convert.ToString(dr["Organization_Name"]) : "",
								First_Name = dr["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dr["FIRST_NAME"]) : "",
								Last_Name = dr["LAST_NAME"] != DBNull.Value ? Convert.ToString(dr["LAST_NAME"]) : "",
								MobileNo = dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "",
								Email_Id = dr["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dr["EMAIL_ID"]) : "",
								//Full_Address = dr["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["FULL_ADDRESS"]) : "",
								Is_Active = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
								Is_Lock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dr["IS_LOCK"]) : false
							});
						}
					}

					else if (vendorcode > 0 && dt != null && dt.Rows.Count > 0)
					{
						if (dt != null && dt.Rows.Count > 0 && (dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0) != Common.Get_Session_Int(SessionKey.PLANT_ID))
						{
							CommonViewModel.Obj = new Vendor()
							{
								Id = dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["ID"]) : 0,
								PlantId = dt.Rows[0]["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["PLANT_ID"]) : 0,
								VendorCode = dt.Rows[0]["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["VENDOR_CODE"]) : null,
								VendorCode_Temp = dt.Rows[0]["VENDOR_CODE_TEMP"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["VENDOR_CODE_TEMP"]) : null,
								VendorType = dt.Rows[0]["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VENDOR_TYPE"]) : "",
								SiteCode = dt.Rows[0]["Site_Code"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Site_Code"]) : null,
								SiteName = dt.Rows[0]["Site_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Site_Name"]) : "",
								Organization_Name = dt.Rows[0]["Organization_Name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Organization_Name"]) : "",
								First_Name = dt.Rows[0]["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FIRST_NAME"]) : "",
								Last_Name = dt.Rows[0]["LAST_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["LAST_NAME"]) : "",
								MobileNo = dt.Rows[0]["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MOBILE_NO"]) : "",
								Alt_Mobile_No = dt.Rows[0]["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_MOBILE_NO"]) : "",
								Email_Id = dt.Rows[0]["EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["EMAIL_ID"]) : "",
								Alt_Email_Id = dt.Rows[0]["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["ALT_EMAIL_ID"]) : "",
								Full_Address = dt.Rows[0]["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["FULL_ADDRESS"]) : "",
								Country_Id = dt.Rows[0]["COUNTRY_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["COUNTRY_ID"]) : 0,
								State_Id = dt.Rows[0]["STATE_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["STATE_ID"]) : 0,
								District_Id = dt.Rows[0]["DISTRICT_ID"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["DISTRICT_ID"]) : 0,
								City = dt.Rows[0]["CITY"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["CITY"]) : "",
								Postal_Code = dt.Rows[0]["POSTAL_CODE"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["POSTAL_CODE"]) : 0,
								Print_Label_Qty = dt.Rows[0]["Print_Label_Qty"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["Print_Label_Qty"]) : 0,
								Is_System_User = dt.Rows[0]["Is_System_User"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["Is_System_User"]) : false,
								Is_Lock = dt.Rows[0]["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_LOCK"]) : false,
								Is_Active = dt.Rows[0]["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["ISACTIVE"]) : false,
								//SelectedPlants = dt.Rows[0]["PLANTS"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANTS"]) : ""
							};
						}


						if (ds != null && ds.Tables.Count > 1)
							dt = ds.Tables[1];

						if (dt != null && dt.Rows.Count > 0)
						{
							list = new List<Vendor>();

							foreach (DataRow dr in dt.Rows)
							{
								if (dt != null && dt.Rows.Count > 0 && (dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt32(dr["PLANT_ID"]) : 0) != Common.Get_Session_Int(SessionKey.PLANT_ID)
									//&& list.Any(x=>x.SiteName != (dr["Site_Name"] != DBNull.Value ? Convert.ToString(dr["Site_Name"]) : "") && x.SiteCode != (dr["Site_Code"] != DBNull.Value ? Convert.ToString(dr["Site_Code"]) : ""))
									)
									list.Add(new Vendor()
									{
										Id = dr["SITE_ID"] != DBNull.Value ? Convert.ToInt32(dr["SITE_ID"]) : 0,
										//UserId = dr["USER_ID"] != DBNull.Value ? Convert.ToInt32(dr["USER_ID"]) : 0,
										VendorCode = dr["VENDOR_CODE"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE"]) : null,
										VendorCode_Temp = dr["VENDOR_CODE_TEMP"] != DBNull.Value ? Convert.ToInt64(dr["VENDOR_CODE_TEMP"]) : null,
										VendorType = dr["VENDOR_TYPE"] != DBNull.Value ? Convert.ToString(dr["VENDOR_TYPE"]) : "",
										SiteCode = dr["Site_Code"] != DBNull.Value ? Convert.ToString(dr["Site_Code"]) : null,
										SiteName = dr["Site_Name"] != DBNull.Value ? Convert.ToString(dr["Site_Name"]) : "",
										Organization_Name = dr["Organization_Name"] != DBNull.Value ? Convert.ToString(dr["Organization_Name"]) : "",
										First_Name = dr["FIRST_NAME"] != DBNull.Value ? Convert.ToString(dr["FIRST_NAME"]) : "",
										Last_Name = dr["LAST_NAME"] != DBNull.Value ? Convert.ToString(dr["LAST_NAME"]) : "",
										Alt_Mobile_No = dr["ALT_MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["ALT_MOBILE_NO"]) : "",
										Alt_Email_Id = dr["ALT_EMAIL_ID"] != DBNull.Value ? Convert.ToString(dr["ALT_EMAIL_ID"]) : "",
										Full_Address = dr["FULL_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["FULL_ADDRESS"]) : "",
										City = dr["CITY"] != DBNull.Value ? Convert.ToString(dr["CITY"]) : "",
										Is_Active = dr["ISACTIVE"] != DBNull.Value ? Convert.ToBoolean(dr["ISACTIVE"]) : false,
										Is_Lock = dr["IS_LOCK"] != DBNull.Value ? Convert.ToBoolean(dr["IS_LOCK"]) : false
									});
							}
						}
					}
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0 && vendorcode > 0 && CommonViewModel.Obj != null) { CommonViewModel.ListObj = list; return PartialView("_Partial_AddEditForm_Mapping", CommonViewModel); }
			else if (list != null && list.Count > 0 && vendorcode == 0) return PartialView("_Partial_Vendor", list);
			else return Json(null);
		}


		[HttpPost]
		public JsonResult GetStateList(long Country_Id = 0)
		{
			var list = new List<SelectListItem_Custom>();
			try
			{
				//var parameters_country = new SqlParameter[] { new SqlParameter("@Country_Id", SqlDbType.BigInt) { Value = Country_Id, Direction = ParameterDirection.Input } };
				//DataTable dt2 = DataContext.ExecuteStoredProcedure_DataTable("SP_StateMaster_Combo", parameters_country);

				//list2.Add(new SelectListItem_Custom("0", "-- Select --"));
				//if (dt2 != null && dt2.Rows.Count > 0)
				//	foreach (DataRow dr in dt2.Rows)
				//		list2.Add(new SelectListItem_Custom(dr["State_Id"] != DBNull.Value ? Convert.ToString(dr["State_Id"]) : "",
				//			dr["State_Name"] != DBNull.Value ? Convert.ToString(dr["State_Name"]) : ""));

				//ViewBag.Statelist = list2;


				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = Country_Id });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				list.Add(new SelectListItem_Custom("0", "-- Select --", ""));

				//var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_COUNTRY_GET", oParams, true);

				//if (dt != null && dt.Rows.Count > 0)
				//	foreach (DataRow dr in dt.Rows)
				//		list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "C"));

				var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_STATE_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "S"));

				//dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams, true);

				//if (dt != null && dt.Rows.Count > 0)
				//	foreach (DataRow dr in dt.Rows)
				//		list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return Json(list);
		}

		[HttpPost]
		public JsonResult GetDistrictList(long State_Id = 0)
		{
			var list = new List<SelectListItem_Custom>();
			try
			{
				//var parameters = new SqlParameter[] { new SqlParameter("@State_Id", SqlDbType.BigInt) { Value = State_Id, Direction = ParameterDirection.Input } };
				//DataTable dt2 = DataContext.ExecuteStoredProcedure_DataTable("SP_DistrictMaster_Combo", parameters);
				//list3.Add(new SelectListItem_Custom("0", "-- Select --"));
				//if (dt2 != null && dt2.Rows.Count > 0)

				//	foreach (DataRow dr in dt2.Rows)
				//		list3.Add(new SelectListItem_Custom(dr["District_Id"] != DBNull.Value ? Convert.ToString(dr["District_Id"]) : "",
				//			dr["District_Name"] != DBNull.Value ? Convert.ToString(dr["District_Name"]) : ""));
				//ViewBag.districtlist = list3;

				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = -1 });
				oParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = State_Id });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				list.Add(new SelectListItem_Custom("0", "-- Select --", ""));

				var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DISTRICT_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "D"));

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return Json(list);
		}

		#endregion

		#region Events

		[HttpPost]
		public JsonResult Save_VendorMap(long Vendor_Id, string SiteCode)
		{
			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = Vendor_Id });
				oParams.Add(new OracleParameter("P_VENDOR_SITE", OracleDbType.Varchar2) { Value = SiteCode });

				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_SITE_MAPPING", oParams, true);

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
		public JsonResult Save(Vendor viewModel)
		{
			try
			{
				if (viewModel == null)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Vendor details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				//if (string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.VendorCode))
				if (string.IsNullOrEmpty(viewModel.SiteCode) && (viewModel.VendorCode == null || viewModel.VendorCode <= 0))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Vendor Code";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Password) && viewModel.Id == 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Password";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.First_Name))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter first name";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				//if ((viewModel.SiteCode == null || viewModel.SiteCode <= 0) && string.IsNullOrEmpty(viewModel.Last_Name))
				//{
				//	CommonViewModel.IsSuccess = false;
				//	CommonViewModel.Message = "Please enter last name";
				//	CommonViewModel.StatusCode = ResponseStatusCode.Error;

				//	return Json(CommonViewModel);
				//}

				//////////////////////////////////////////////////

				//if ((viewModel.SiteCode == null || viewModel.SiteCode <= 0) && string.IsNullOrEmpty(viewModel.MobileNo))
				if (string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.MobileNo))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter mobile no.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				if (string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.Email_Id))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter email id";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (!string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.Alt_Mobile_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter mobile no.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				if (!string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.Alt_Email_Id))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter email id";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (!string.IsNullOrEmpty(viewModel.SiteCode) && string.IsNullOrEmpty(viewModel.Full_Address))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter full address";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				//////////////////////////////////////////////////

				if (viewModel.MobileNo != null && !ValidateField.IsValidMobileNo(viewModel.MobileNo))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid mobile No.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				if (viewModel.Alt_Mobile_No != null && !ValidateField.IsValidMobileNo(viewModel.Alt_Mobile_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid alt mobile No.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				if (viewModel.Email_Id != null && !ValidateField.IsValidEmail(viewModel.Email_Id))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid email id";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				if (viewModel.Alt_Email_Id != null && !ValidateField.IsValidEmail(viewModel.Alt_Email_Id))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid alt email id";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					return Json(CommonViewModel);
				}


				List<OracleParameter> oParams = new List<OracleParameter>();

				//var plants = string.IsNullOrEmpty(viewModel.SelectedPlants) ? new string[] { } : viewModel.SelectedPlants.Split(',').ToArray();

				//if (plants == null || plants.Length == 0)
				//{
				//	plants = new string[] { Common.Get_Session_Int(SessionKey.PLANT_ID).ToString() };

				//	viewModel.SelectedPlants = string.Join(",", plants);
				//}

				if (viewModel.IsPassword_Reset == true)
					viewModel.Password = "12345";

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = viewModel.VendorCode });
				oParams.Add(new OracleParameter("P_VENDOR_CODE_TEMP", OracleDbType.Int64) { Value = viewModel.VendorCode });
				oParams.Add(new OracleParameter("P_VENDOR_TYPE", OracleDbType.Varchar2) { Value = viewModel.VendorType });
				oParams.Add(new OracleParameter("P_SITE_CODE", OracleDbType.Varchar2) { Value = viewModel.SiteCode });
				oParams.Add(new OracleParameter("P_SITE_NAME", OracleDbType.Varchar2) { Value = viewModel.SiteName });
				oParams.Add(new OracleParameter("P_ORGANIZATION_NAME", OracleDbType.Varchar2) { Value = viewModel.Organization_Name });
				oParams.Add(new OracleParameter("P_PASSWORD", OracleDbType.Varchar2) { Value = Common.Encrypt(viewModel.Password) });
				oParams.Add(new OracleParameter("P_FIRST_NAME", OracleDbType.Varchar2) { Value = viewModel.First_Name });
				oParams.Add(new OracleParameter("P_MIDDLE_NAME", OracleDbType.Varchar2) { Value = viewModel.Middle_Name });
				oParams.Add(new OracleParameter("P_LAST_NAME", OracleDbType.Varchar2) { Value = viewModel.Last_Name });
				oParams.Add(new OracleParameter("P_MOBILE_NO", OracleDbType.Varchar2) { Value = viewModel.MobileNo });
				oParams.Add(new OracleParameter("P_ALT_MOBILE_NO", OracleDbType.Varchar2) { Value = viewModel.Alt_Mobile_No });
				oParams.Add(new OracleParameter("P_EMAIL_ID", OracleDbType.Varchar2) { Value = viewModel.Email_Id });
				oParams.Add(new OracleParameter("P_ALT_EMAIL_ID", OracleDbType.Varchar2) { Value = viewModel.Alt_Email_Id });
				oParams.Add(new OracleParameter("P_FULL_ADDRESS", OracleDbType.Varchar2) { Value = viewModel.Full_Address });
				oParams.Add(new OracleParameter("P_COUNTRY_ID", OracleDbType.Int64) { Value = viewModel.Country_Id });
				oParams.Add(new OracleParameter("P_STATE_ID", OracleDbType.Int64) { Value = viewModel.State_Id });
				oParams.Add(new OracleParameter("P_DISTRICT_ID", OracleDbType.Int64) { Value = viewModel.District_Id });
				oParams.Add(new OracleParameter("P_CITY", OracleDbType.Varchar2) { Value = viewModel.City });
				oParams.Add(new OracleParameter("P_POSTAL_CODE", OracleDbType.Varchar2) { Value = viewModel.Postal_Code });
				oParams.Add(new OracleParameter("P_PRINT_LABEL_QTY", OracleDbType.Int64) { Value = viewModel.Print_Label_Qty });
				oParams.Add(new OracleParameter("IS_SYSTEM_USER", OracleDbType.Varchar2) { Value = viewModel.Is_System_User ? "Y" : "N" });
				oParams.Add(new OracleParameter("P_IS_LOCK", OracleDbType.Varchar2) { Value = viewModel.Is_Lock ? "Y" : "N" });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = viewModel.Is_Active ? "Y" : "N" });
				oParams.Add(new OracleParameter("P_PLANTS", OracleDbType.Varchar2) { Value = viewModel.SelectedPlants ?? "" });
				oParams.Add(new OracleParameter("P_JSON_LIST_SITE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

				CommonViewModel.RedirectURL = IsSuccess && (viewModel.Id == 0 || string.IsNullOrEmpty(viewModel.SiteCode)) ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

				CommonViewModel.Data1 = viewModel.Id;
				CommonViewModel.Data2 = viewModel.SiteCode;

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

		[HttpPost]
		public JsonResult DeleteConfirmed(long id = 0)
		{
			try
			{
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = id });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_DELETE", oParams, true);

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
