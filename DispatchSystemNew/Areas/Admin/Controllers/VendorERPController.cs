
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Data.SqlClient;
using System.Numerics;
using DocumentFormat.OpenXml.Spreadsheet;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class VendorERPController : BaseController<ResponseModel<Vendor>>
	{
		#region Loading

		public IActionResult Index()
		{
			return View(CommonViewModel);
		}

		public IActionResult CopyFromERP()
		{
			return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Partial_AddEditForm(long vendor_code)
		{
			var obj = new Vendor();

			var list = new List<SelectListItem_Custom>();

			var dt = new DataTable();

			List<OracleParameter> oParams = new List<OracleParameter>();

			try
			{
				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = vendor_code });
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
					CommonViewModel.ListObj = new List<Vendor>();

					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new Vendor()
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt32(dr["ID"]) : 0,
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
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			list = new List<SelectListItem_Custom>();

			oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			list.Add(new SelectListItem_Custom("0", "-- Select --", "P"));
			dt = DataContext.ExecuteStoredProcedure_DataTable("PC_PLANT_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["ID"] != DBNull.Value ? Convert.ToString(dr["ID"]) : "", dr["NAME"] != DBNull.Value ? Convert.ToString(dr["NAME"]) : "", "P"));

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
		public IActionResult Partial_AddEditForm_ERP(long vendor_code, bool forCreate = false)
		{
			var obj = new Vendor();
			var listObj = new List<Vendor>();

			List<OracleParameter> oParams = new List<OracleParameter>();

			oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = vendor_code });
			oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = vendor_code });
			oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = "" });
			oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
			oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
			oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
			oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

			var ds = DataContext.ExecuteStoredProcedure_DataSet("PC_VENDOR_GET", oParams);

			if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
			{
				DataView dv = new DataView(ds.Tables[1]);
				dv.RowFilter = "PLANT_ID = " + Common.Get_Session_Int(SessionKey.PLANT_ID);
				if (dv != null && dv.ToTable().Rows != null && dv.ToTable().Rows.Count > 0)
					CommonViewModel.Data2 = "Vendor is already exist.";
				else
					CommonViewModel.Data2 = "Vendor is already exist in another plant.";
			}
			else
			{
				var client = new HttpClient();
				var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

				try
				{
					StringContent? content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"50006\", \"P_VENDOR_CODE\" : \"" + vendor_code + "\"}", null, "application/json");

					request.Content = content;

					var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

					if (webRequestResponse.IsSuccessStatusCode)
					{
						var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

						if (!string.IsNullOrEmpty(responseContent))
						{
							JToken objData = JObject.Parse(responseContent);

							if (objData != null && objData["GetSuppDtls"] != null)
							{
								foreach (JToken item in objData["GetSuppDtls"])
								{
									try
									{
										listObj.Add(new Vendor()
										{
											VendorCode = item["vendor_code"] != null ? Convert.ToInt64(item["vendor_code"]) : null,
											PlantId = item["unit_code"] != null ? Convert.ToInt64(item["unit_code"]) : 0,
											Plant_Name = item["ou_name"] != null ? Convert.ToString(item["ou_name"]) : "",
											SiteName = item["vendor_site_code"] != null ? Convert.ToString(item["vendor_site_code"]) : "",
											Organization_Name = item["vendor_company_name"] != null ? Convert.ToString(item["vendor_company_name"]) : "",
											First_Name = item["vendor_name"] != null ? Convert.ToString(item["vendor_name"]) : "",
											//Last_Name = item["vendor_name"] != null ? Convert.ToString(item["vendor_name"]) : "",
											MobileNo = item["primary_mobile"] != null ? Convert.ToString(item["primary_mobile"]) : "",
											Alt_Mobile_No = item["primary_mobile"] != null ? Convert.ToString(item["primary_mobile"]) : "",
											Email_Id = item["primary_email"] != null ? Convert.ToString(item["primary_email"]) : "",
											Alt_Email_Id = item["primary_email"] != null ? Convert.ToString(item["primary_email"]) : "",
											Full_Address = item["address"] != null ? Convert.ToString(item["address"]) : "",
											City = item["city"] != null ? Convert.ToString(item["city"]) : "",
											State_Name = item["state"] != null ? Convert.ToString(item["state"]) : "",
											Country_Name = item["country"] != null ? Convert.ToString(item["country"]) : "",
											Is_Active = item["status_active"] != null && Convert.ToString(item["status_active"]) == "ACTIVE" ? true : false
										});
									}
									catch { continue; }
								}
							}

							//var listMDA = JsonConvert.DeserializeObject<List<MDA>>(((Newtonsoft.Json.Linq.JArray)((Newtonsoft.Json.Linq.JProperty)obj.First).Value).ToString());

							//if (listMDA != null)
							//	mda = listMDA.Where(x => x.mda_no == viewModel.MDA_No).FirstOrDefault();
						}

					}
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			}

			CommonViewModel.Obj = listObj.Where(x => x.PlantId == Common.Get_Session_Int(SessionKey.UNIT_CODE)).FirstOrDefault();
			CommonViewModel.ListObj = listObj.Where(x => x.PlantId == Common.Get_Session_Int(SessionKey.UNIT_CODE)).ToList();
			CommonViewModel.Data1 = forCreate;

			return PartialView("_Partial_AddEditForm_ERP", CommonViewModel);
		}


		[HttpGet]
		public IActionResult Search_Vendor(string searchTerm)
		{
			var list = new List<Vendor>();

			if (!string.IsNullOrEmpty(searchTerm))
				try
				{
					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = 0 });
					oParams.Add(new OracleParameter("P_SEARCHTERM", OracleDbType.Varchar2) { Value = searchTerm });
					oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });
					oParams.Add(new OracleParameter("P_SITES", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

					var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_VENDOR_GET", oParams, false);

					if (dt != null && dt.Rows.Count > 0 && !string.IsNullOrEmpty(searchTerm))
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
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0) return PartialView("_Partial_Vendor", list);
			else return Json(null);
		}

		[HttpGet]
		public IActionResult Show_Menu(long RoleId = 0)
		{
			if (RoleId > 0)
				try
				{
					List<OracleParameter> oParams = new List<OracleParameter>();

					oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = RoleId });
					oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "" });
					oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					oParams.Add(new OracleParameter("P_RESULT", OracleDbType.RefCursor) { Direction = ParameterDirection.Output });

					var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_ROLE_GET", oParams, false);

					if (dt != null && dt.Rows.Count > 0)
					{
						var SelectedMenu = dt.Rows[0]["MENUS_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MENUS_NAME"]) : "";

						var strHTML = "<div class=\"row col-12 w-100\"><table id=\"table_Common\" class=\"table table-bordered table-striped w-100 table_Common\"><thead><tr><th width=\"5%\">Sr. No.</th><th>Name</th></tr></thead><tbody>#</tbody></table></div>";

						var rows = "";

						var i = 0;
						if (!string.IsNullOrEmpty(SelectedMenu) && SelectedMenu.Contains("||"))
							foreach (string item in SelectedMenu.Split("||"))
								rows = rows + $"<tr><td>{++i}</td><td>{item}</td></tr>";
						else if (!string.IsNullOrEmpty(SelectedMenu))
							rows = rows + $"<tr><td>{++i}</td><td>{SelectedMenu}</td></tr>";

						strHTML = strHTML.Replace("#", rows);

						return Json(strHTML);
					}
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


			return Json(null);
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

				if (viewModel.VendorCode == null || viewModel.VendorCode <= 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Vendor Code from ERP";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.listSite == null && (viewModel.VendorCode_Temp == null || viewModel.VendorCode_Temp <= 0))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Vendor Code from current database";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.First_Name))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter first name";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				//////////////////////////////////////////////////

				//if (string.IsNullOrEmpty(viewModel.MobileNo))
				//{
				//	CommonViewModel.IsSuccess = false;
				//	CommonViewModel.Message = "Please enter mobile no.";
				//	CommonViewModel.StatusCode = ResponseStatusCode.Error;

				//	return Json(CommonViewModel);
				//}
				//if (string.IsNullOrEmpty(viewModel.Email_Id))
				//{
				//	CommonViewModel.IsSuccess = false;
				//	CommonViewModel.Message = "Please enter email id";
				//	CommonViewModel.StatusCode = ResponseStatusCode.Error;

				//	return Json(CommonViewModel);
				//}

				//if (viewModel.listSite == null && (viewModel.SiteCode == null || viewModel.SiteCode <= 0))
				if (viewModel.listSite == null && string.IsNullOrEmpty(viewModel.SiteCode))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Site from Site Details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.listSite == null && (string.IsNullOrEmpty(viewModel.SiteName)))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Site from ERP Site Details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				viewModel.Password = "12345";

				string objList_JSON = "";

				if (viewModel.listSite != null && viewModel.listSite.Where(x => x.Id > 0 && !(string.IsNullOrEmpty(x.SiteName))).Count() > 0)
				{
					objList_JSON = string.Join("<#>", viewModel.listSite.Where(x => x.Id > 0 && !(string.IsNullOrEmpty(x.SiteName)))
						.Select(x => x.SiteName + "|" + x.Full_Address + "|" + x.City + "|" + x.State_Name + "|" + x.Country_Name + "|" + x.MobileNo + "|" + x.Email_Id).ToArray());

					//dynamic objData = (from x in viewModel.listSite.ToList()
					//				   where !(string.IsNullOrEmpty(x.SiteName))
					//				   select new
					//				   {
					//					   SiteName = x.SiteName,
					//					   Full_Address = x.Full_Address,
					//					   City = x.City,
					//					   State_Name = x.State_Name ?? "",
					//					   Country_Name = x.Country_Name,
					//					   MobileNo = x.MobileNo,
					//					   Email_Id = x.Email_Id,
					//				   }).ToList();

					//objList_JSON = JsonConvert.SerializeObject(objData);

				}


				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_ID", OracleDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new OracleParameter("P_VENDOR_CODE", OracleDbType.Int64) { Value = viewModel.VendorCode });
				oParams.Add(new OracleParameter("P_VENDOR_CODE_TEMP", OracleDbType.Int64) { Value = null });
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
				oParams.Add(new OracleParameter("IS_SYSTEM_USER", OracleDbType.Varchar2) { Value = "N" });
				oParams.Add(new OracleParameter("P_IS_LOCK", OracleDbType.Varchar2) { Value = "N" });
				oParams.Add(new OracleParameter("P_ISACTIVE", OracleDbType.Varchar2) { Value = "Y" });
				oParams.Add(new OracleParameter("P_PLANTS", OracleDbType.Varchar2) { Value = viewModel.SelectedPlants ?? "" });
				oParams.Add(new OracleParameter("P_JSON_LIST_SITE", OracleDbType.Varchar2) { Value = objList_JSON });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

				CommonViewModel.RedirectURL = IsSuccess && (viewModel.Id == 0 || string.IsNullOrEmpty(viewModel.SiteCode) /*viewModel.SiteCode == null || viewModel.SiteCode <= 0*/) ? Url.Content("~/") + GetCurrentControllerUrl() + "/CopyFromERP" : "";

				CommonViewModel.Data1 = viewModel.VendorCode_Temp;
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


		#endregion

	}
}
