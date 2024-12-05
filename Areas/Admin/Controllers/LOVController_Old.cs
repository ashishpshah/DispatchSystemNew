using BaseStructure_47.Services;
using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;

namespace Dispatch_System.Controllers
{
	[Area("Admin")]
	public class LOVController_Old : BaseController<ResponseModel<LOV>>
	{
		#region Lov Master

		#region Loading

		public IActionResult Index()
		{
			try
			{
				CommonViewModel.ListObj = new List<LOV>();

				var parameters = new SqlParameter[] { new SqlParameter("@Lov_Column", ""), new SqlParameter("@Lov_Code", ""), new SqlParameter("@Flag", "LI") };
				var dt = DataContext.ExecuteStoredProcedure_DataTable("SP_LOV_Get", parameters);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new LOV()
						{
							Lov_Column = dr["Lov_Column"] != DBNull.Value ? Convert.ToString(dr["Lov_Column"]) : "",
							Column_For = dr["Column_For"] != DBNull.Value ? Convert.ToString(dr["Column_For"]) : ""
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
		public IActionResult Partial_AddEditForm(string Lov_Column = "")
		{
			try
			{
				var obj = new LOV();
				var dt = new DataTable();

				ViewBag.Statelist = "";
				ViewBag.Districtlist = "";

				if (Lov_Column != "" && Lov_Column != null)
				{
					var parameters = new SqlParameter[] { new SqlParameter("@Lov_Column", Lov_Column), new SqlParameter("@Flag", "LE") };
					dt = DataContext.ExecuteStoredProcedure_DataTable("SP_LOV_Get", parameters);

					if (dt != null && dt.Rows.Count > 0)
					{
						obj = new LOV()
						{
							Lov_Column = dt.Rows[0]["Lov_Column"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Column"]) : "",
							Column_For = dt.Rows[0]["Column_For"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Column_For"]) : ""
						};
					}
				}
				obj.Lov_Column = Lov_Column;
				ViewBag.Action = (Lov_Column == "" ? "INSERT" : "UPDATE");
				CommonViewModel.Obj = obj;


			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			return PartialView("_Partial_AddEditForm", CommonViewModel);
		}

		#endregion

		#region Events
		[HttpPost]
		public JsonResult Save(LOV obj, IFormFileCollection files)
		{
			try
			{
				if (obj == null)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter lov details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(obj.Lov_Column))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter lov column";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(obj.Column_For))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter column for";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}


				SqlParameter[] spCol = new SqlParameter[] {
					new SqlParameter("@Lov_Column", obj.Lov_Column),
					new SqlParameter("@Column_For", obj.Column_For),
					new SqlParameter("@Action", obj.Action),
					new SqlParameter("@Operated_By",SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.USER_ID), Direction = ParameterDirection.Input },
					new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
				};

				var response = DataContext.ExecuteStoredProcedure("SP_Lov_Insert_Update", spCol);

				string[] strmsg = response.Split('|');
				var msgtype = strmsg[0];
				var message = strmsg[1].Replace("\"", "");
				if (msgtype.Contains("E"))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					CommonViewModel.Message = message;

					return Json(CommonViewModel);
				}

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = true;
				CommonViewModel.StatusCode = ResponseStatusCode.Success;
				CommonViewModel.Message = message;
				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

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
		public JsonResult DeleteConfirmed(string Lov_Column = "", string Column_For = "")
		{
			try
			{
				if (Lov_Column != "")
				{
					SqlParameter[] spCol = new SqlParameter[] {
						new SqlParameter("@Lov_Column", SqlDbType.VarChar) { Value = Lov_Column, Direction = ParameterDirection.Input },
						new SqlParameter("@Column_For", SqlDbType.VarChar) { Value = Column_For, Direction = ParameterDirection.Input },
						new SqlParameter("@Operated_By", SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.USER_ID), Direction = ParameterDirection.Input },
						new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
					};

					var returnCode = DataContext.ExecuteStoredProcedure("SP_LOV_Delete", spCol);

					string[] strmsg = returnCode.ToString().Split('|');
					string msgtype = strmsg[0];
					string message = strmsg[1].Replace("\"", "");

					CommonViewModel.IsConfirm = (msgtype.Contains("S") ? true : false);
					CommonViewModel.IsSuccess = (msgtype.Contains("S") ? true : false);
					CommonViewModel.Message = message;
					CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Area"].ToString() + "/" + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/Index";
					CommonViewModel.StatusCode = (msgtype.Contains("S") ? ResponseStatusCode.Success : ResponseStatusCode.Error);

					return Json(CommonViewModel);
				}

				CommonViewModel.IsSuccess = false;
				CommonViewModel.Message = ResponseStatusMessage.NotFound;
				CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
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

		#endregion


		#region Lov Dtl

		#region Loading

		public IActionResult IndexLovDtl(string Lov_Column = "", string Column_For = "")
		{
			try
			{
				CommonViewModel.ListObj = new List<LOV>();

				var parameters = new SqlParameter[] {
					new SqlParameter("@Lov_Column", Lov_Column),
					new SqlParameter("@Lov_Code", ""),
					new SqlParameter("@Flag", "LDI") };

				var dt = DataContext.ExecuteStoredProcedure_DataTable("SP_LOV_Get", parameters);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new LOV()
						{
							Lov_Column = dr["Lov_Column"] != DBNull.Value ? Convert.ToString(dr["Lov_Column"]) : "",
							Column_For = dr["Column_For"] != DBNull.Value ? Convert.ToString(dr["Column_For"]) : "",
							Lov_Code = dr["Lov_Code"] != DBNull.Value ? Convert.ToString(dr["Lov_Code"]) : "",
							Lov_Desc = dr["Lov_Desc"] != DBNull.Value ? Convert.ToString(dr["Lov_Desc"]) : "",
							Tag_Data_Type = dr["Tag_Data_Type"] != DBNull.Value ? Convert.ToString(dr["Tag_Data_Type"]) : "",
							Tag_Data_Input_Mask = dr["Tag_Data_Input_Mask"] != DBNull.Value ? Convert.ToString(dr["Tag_Data_Input_Mask"]) : "",
							Display_Seq_No = dr["Display_Seq_No"] != DBNull.Value ? Convert.ToInt64(dr["Display_Seq_No"]) : 0,
							MaxDisplay_Seq_No = dr["MaxDisplay_Seq_No"] != DBNull.Value ? Convert.ToInt64(dr["MaxDisplay_Seq_No"]) : 0,
						});
					}
				}
				ViewBag.Lov_Column = Lov_Column.Replace(" ", "%20");
				ViewBag.Column_For = Column_For.Replace(" ", "%20");
			}
			catch (Exception ex)
			{
				string actionName = this.ControllerContext.RouteData.Values["action"].ToString();
				string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
				//LogEntry.InsertLogEntry(controllerName + '_' + actionName, ex.Message);
				return null;
			}
			return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Partial_AddEditFormLovDtl(string Lov_Column = "", string Column_For = "", string Display_Seq_No = "", string Lov_Code = "")
		{
			try
			{
				var obj = new LOV { Lov_Column = "", Lov_Code = "", Column_For = "" };

				var dt = new DataTable();
				ViewBag.Statelist = "";
				ViewBag.Districtlist = "";

				// database query
				//if (Lov_Column != "" && Lov_Column != null)
				//{
				var parameters = new SqlParameter[] {
						new SqlParameter("@Lov_Column", Lov_Column),
						new SqlParameter("@Lov_Code", Lov_Code),
						new SqlParameter("@Flag", "LDE") };

				dt = DataContext.ExecuteStoredProcedure_DataTable("SP_LOV_Get", parameters);

				if (dt != null && dt.Rows.Count > 0)
				{
					obj = new LOV()
					{
						Lov_Column = dt.Rows[0]["Lov_Column"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Column"]) : "",
						Column_For = dt.Rows[0]["Column_For"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Column_For"]) : "",
						Lov_Code = dt.Rows[0]["Lov_Code"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Code"]) : "",
						Lov_Desc = dt.Rows[0]["Lov_Desc"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Lov_Desc"]) : "",
						Tag_Data_Type = dt.Rows[0]["Tag_Data_Type"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Data_Type"]) : "",
						Tag_Data_Input_Mask = dt.Rows[0]["Tag_Data_Input_Mask"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Data_Input_Mask"]) : "",
						Display_Seq_No = dt.Rows[0]["Display_Seq_No"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["Display_Seq_No"]) : 0,
						Tag_Min_Len = dt.Rows[0]["Tag_Min_Len"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Min_Len"]) : "",
						Tag_Max_Len = dt.Rows[0]["Tag_Max_Len"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Max_Len"]) : "",
						Tag_Default_Values = dt.Rows[0]["Tag_Default_Values"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Default_Values"]) : "",
						Tag_Min_Value = dt.Rows[0]["Tag_Min_Value"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Min_Value"]) : "",
						Tag_Max_Value = dt.Rows[0]["Tag_Max_Value"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tag_Max_Value"]) : ""
					};
				}
				//}
				//else
				//{
				//	ViewBag.Display_Seq_No = Display_Seq_No;
				//}

				obj.Lov_Column = Lov_Column;

				ViewBag.Lov_Column1 = Lov_Column.Replace(" ", "%20");
				ViewBag.Column_For = Column_For.Replace(" ", "%20");

				//var list = new List<SelectListItem_Custom>();


				//DataTable dt1 = DataContext.ExecuteStoredProcedure_DataTable("SP_CountrytMaster_Combo", null);
				//list.Add(new SelectListItem_Custom("0", "-- Select --"));
				//if (dt1 != null && dt1.Rows.Count > 0)
				//	foreach (DataRow dr in dt1.Rows)
				//		list.Add(new SelectListItem_Custom(dr["CountryId"] != DBNull.Value ? Convert.ToString(dr["CountryId"]) : "",
				//			dr["Country_Name"] != DBNull.Value ? Convert.ToString(dr["Country_Name"]) : ""));

				//CommonViewModel.SelectList = list;


				CommonViewModel.Obj = obj;


			}
			catch (Exception ex)
			{
				string actionName = this.ControllerContext.RouteData.Values["action"].ToString();
				string controllerName = this.ControllerContext.RouteData.Values["controller"].ToString();
				//LogEntry.InsertLogEntry(controllerName + '_' + actionName, ex.Message);
				return null;
			}
			return PartialView("_Partial_AddEditFormLovDtl", CommonViewModel);
		}

		#endregion

		#region Events

		[HttpPost]
		public JsonResult SaveLovDtl(LOV obj, IFormFileCollection files)
		{
			try
			{
				if (obj == null)
				{
					//CommonViewModel.Status = "error";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter lov details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(obj.Lov_Code))
				{
					//CommonViewModel.Status = "error";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter lov column";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(obj.Lov_Desc))
				{
					//CommonViewModel.Status = "error";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter column for";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}



				string col_for = obj.Column_For.Replace("%20", " ");
				string lov_col = obj.Lov_Column.Replace("%20", " ");
				SqlParameter[] spCol = new SqlParameter[] {
					new SqlParameter("@Lov_Column", lov_col),
					new SqlParameter("@Column_For", col_for),
					new SqlParameter("@Lov_Code", obj.Lov_Code),
					new SqlParameter("@Lov_Desc", obj.Lov_Desc),
					new SqlParameter("@Tag_Data_Type", obj.Tag_Data_Type),
					new SqlParameter("@Tag_Data_Input_Mask", obj.Tag_Data_Input_Mask),
					new SqlParameter("@Display_Seq_No", obj.Display_Seq_No),
					new SqlParameter("@Tag_Min_Len", obj.Tag_Min_Len),
					new SqlParameter("@Tag_Max_Len", obj.Tag_Max_Len),
					new SqlParameter("@Tag_Default_Values", obj.Tag_Default_Values),
					new SqlParameter("@Tag_Min_Value", obj.Tag_Min_Value),
					new SqlParameter("@Tag_Max_Value", obj.Tag_Max_Value),
					new SqlParameter("@IsActive", 1),
					new SqlParameter("@Action", obj.Action),
					new SqlParameter("@Operated_By",SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.USER_ID), Direction = ParameterDirection.Input },
					new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
				};

				var response = DataContext.ExecuteStoredProcedure("SP_LovDtl_Insert_Update", spCol);

				string[] strmsg = response.Split('|');
				var msgtype = strmsg[0];
				var message = strmsg[1].Replace("\"", "");

				if (msgtype.Contains("S"))
				{
					//CommonViewModel.Status = "success";
					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.Message = message;
					CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Area"].ToString() + "/" + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/IndexLovDtl?Lov_Column=" + obj.Lov_Column + "&Column_For=" + obj.Column_For;

					CommonViewModel.StatusCode = ResponseStatusCode.Success;
				}
				else
				{
					//CommonViewModel.Status = "error";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = message;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
				}

			}
			catch (Exception ex)
			{
				//CommonViewModel.Status = "error";
				CommonViewModel.IsSuccess = false;
				CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
			}

			return Json(CommonViewModel);
		}

		[HttpPost]
		public JsonResult DeleteLovDtlConfirmed(string Lov_Column = "", string Column_For = "", string Lov_Code = "")
		{
			try
			{
				if (Lov_Column != "")
				{
					SqlParameter[] spCol = new SqlParameter[] {
						new SqlParameter("@Lov_Column", SqlDbType.VarChar) { Value = Lov_Column, Direction = ParameterDirection.Input },
						new SqlParameter("@Lov_Code", SqlDbType.VarChar) { Value = Lov_Code, Direction = ParameterDirection.Input },
						new SqlParameter("@Operated_By", SqlDbType.BigInt) { Value = Common.Get_Session_Int(SessionKey.USER_ID), Direction = ParameterDirection.Input },
						new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
					};

					var returnCode = DataContext.ExecuteStoredProcedure("SP_LovDtl_Delete", spCol);

					string[] strmsg = returnCode.ToString().Split('|');
					string msgtype = strmsg[0];
					string message = strmsg[1].Replace("\"", "");

					CommonViewModel.IsConfirm = (msgtype.Contains("S") ? true : false);
					CommonViewModel.IsSuccess = (msgtype.Contains("S") ? true : false);
					CommonViewModel.Message = message;
					CommonViewModel.RedirectURL = Url.Content("~/") + this.ControllerContext.RouteData.Values["Area"].ToString() + "/" + this.ControllerContext.RouteData.Values["Controller"].ToString() + "/IndexLovDtl?Lov_Column=" + Lov_Column + "&Column_For=" + Column_For;

					CommonViewModel.StatusCode = (msgtype.Contains("S") ? ResponseStatusCode.Success : ResponseStatusCode.Error);

					return Json(CommonViewModel);
				}

				CommonViewModel.IsSuccess = false;
				CommonViewModel.Message = ResponseStatusMessage.NotFound;
				CommonViewModel.StatusCode = ResponseStatusCode.NotFound;
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
		#endregion
	}
}
