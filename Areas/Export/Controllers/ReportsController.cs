using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Dispatch_System.Areas.Export.Controllers
{
	[Area("Export")]
	public class ReportsController : BaseController<ResponseModel<GateIn>>
	{
		public IActionResult Gate_In_Out_Report()
		{
			return View();
		}

		public ActionResult GetData_Gate_In_Out_Report(JqueryDatatableParam param)
		{
			string SearchTerm = HttpContext.Request.Query["SearchTerm"];
			string FromDate = HttpContext.Request.Query["FromDate"];
			string ToDate = HttpContext.Request.Query["ToDate"];
			//string IsGateOut = HttpContext.Request.Query["IsGateOut"];

			List<WeighmentInSlip> result = new List<WeighmentInSlip>();

			var oParams = new List<MySqlParameter>();

			oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = 0 });
			oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = SearchTerm ?? "" });
			oParams.Add(new MySqlParameter("P_FROMDATE", MySqlDbType.VarChar) { Value = FromDate ?? "" });
			oParams.Add(new MySqlParameter("P_TODATE", MySqlDbType.VarChar) { Value = ToDate ?? "" });
			oParams.Add(new MySqlParameter("P_IS_OUT_TIME_NULL", MySqlDbType.Int64) { Value = 0 });
			oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

			DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_EXP_REPORT_GATE_IN_OUT", oParams);

			if (dt != null && dt.Rows.Count > 0)
			{
				DataRow[] filteredRows = dt.Select("SR_NO > " + param.iDisplayStart + " AND SR_NO <= " + (param.iDisplayStart + param.iDisplayLength));

				foreach (DataRow dr in filteredRows)
					//foreach (DataRow dr in dt.Rows)
					result.Add(new WeighmentInSlip()
					{
						SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
						Gate_In_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
						//Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
						Plant_Id = dr["PLANT_ID"] != DBNull.Value ? Convert.ToInt64(dr["PLANT_ID"]) : 0,
						Truck_No = dr["TRUCK_NO"] != DBNull.Value ? Convert.ToString(dr["TRUCK_NO"]) : null,
						MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : null,
						RFID_No = dr["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dr["RFIDSRNO"]) : null,
						Status = dr["STATUS"] != DBNull.Value ? Convert.ToString(dr["STATUS"]) : null,
						Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_IN_DT"]) : null,
						Gate_Out_Dt = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : null,
						Transporter_Name = dr["TPTR_NAME"] != DBNull.Value ? Convert.ToString(dr["TPTR_NAME"]) : null,
						Driver_Name = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : null,
						Driver_Contact = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : null,
						Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
						Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
					});
			}

			return Json(new
			{
				param.sEcho,
				iTotalRecords = result.Count(),
				iTotalDisplayRecords = dt != null ? dt.Rows.Count : 0,
				aaData = result
			});

		}


		[HttpGet]
		public IActionResult Pallate(string searchTerm = null, bool isPrint = false)
		{
			dynamic result = null;

			DataSet ds = new DataSet();

			if (!string.IsNullOrEmpty(searchTerm))
				try
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PALLATE_NO", MySqlDbType.VarString) { Value = searchTerm ?? "" });
					oParams.Add(new MySqlParameter("P_MDA_NO", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_PALLATE_GET", oParams);

					if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
						foreach (DataRow dr in ds.Tables[0].Rows)
							result = new
							{
								Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
								Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt32(dr["Sr_No"]) : 0,
								DI_No = dr["DI_No"] != DBNull.Value ? Convert.ToString(dr["DI_No"]) : "",
								Pallate_No = dr["Pallate_No"] != DBNull.Value ? Convert.ToString(dr["Pallate_No"]) : "",
								Pallate_Type = dr["Pallate_Type"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type"]) : "",
								Shipper_Qty = dr["Shipper_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Shipper_Qty"]) : 0,
								Bottle_Qty = dr["Bottle_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Bottle_Qty"]) : 0,
								//Shipper_QR_Code = dr["Shipper_QR_Code"] != DBNull.Value ? Convert.ToString(dr["Shipper_QR_Code"]) : "",
								Dispatch_Mode = dr["Dispatch_Mode"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode"]) : "",
								Pallate_Type_Text = dr["Pallate_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type_Text"]) : "",
								Dispatch_Mode_Text = dr["Dispatch_Mode_Text"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode_Text"]) : "",
								Plant_Name = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
								Plant_Address = dr["PLANT_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["PLANT_ADDRESS"]) : "",
								Report_Title = dr["REPORT_TITLE"] != DBNull.Value ? Convert.ToString(dr["REPORT_TITLE"]) : "",
								Vehicle_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
								MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
								Gate_In_dt = dr["GATE_IN_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_IN_DT"]) : "",
								Gate_Out_dt = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : "",
								Pallate_Status = dr["Pallate_Status"] != DBNull.Value ? Convert.ToString(dr["Pallate_Status"]) : "",
								Shipper_QR_Code = new List<Pallate_Shipper>()
							};

					if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
						foreach (DataRow dr in ds.Tables[1].Rows)
						{
							try
							{
								if (result.Shipper_QR_Code == null)
									result.Shipper_QR_Code = new List<Pallate_Shipper>();

								result.Shipper_QR_Code.Add(new Pallate_Shipper()
								{
									Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
									Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt32(dr["Sr_No"]) : 0,
									DI_No = dr["DI_No"] != DBNull.Value ? Convert.ToString(dr["DI_No"]) : "",
									Pallate_Id = dr["Pallate_Id"] != DBNull.Value ? Convert.ToInt64(dr["Pallate_Id"]) : 0,
									QR_Code = dr["Shipper_QR_Code"] != DBNull.Value ? Convert.ToString(dr["Shipper_QR_Code"]) : "",
									Status = dr["Status"] != DBNull.Value ? Convert.ToString(dr["Status"]) : "",
									Reason = dr["Reason"] != DBNull.Value ? Convert.ToString(dr["Reason"]) : "",
								});
							}
							catch { continue; }
						}

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (isPrint == true || string.IsNullOrEmpty(searchTerm))
				return View((searchTerm, result, isPrint));
			else
				return PartialView((searchTerm, result, isPrint));
		}


		[HttpGet]
		public IActionResult MDA_Wise_Pallate(string searchTerm = null, bool isPrint = false, bool withDetail = false)
		{
			List<dynamic> result = new List<dynamic>();

			DataSet ds = new DataSet();

			if (!string.IsNullOrEmpty(searchTerm))
				try
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PALLATE_NO", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_MDA_NO", MySqlDbType.VarString) { Value = searchTerm ?? "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_PALLATE_GET", oParams);

					if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
						foreach (DataRow dr in ds.Tables[0].Rows)
							try
							{
								result.Add(new
								{
									Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
									Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt32(dr["Sr_No"]) : 0,
									DI_No = dr["DI_No"] != DBNull.Value ? Convert.ToString(dr["DI_No"]) : "",
									Dest_Country = dr["Dest_Country"] != DBNull.Value ? Convert.ToString(dr["Dest_Country"]) : "",
									Pallate_Id = dr["Pallate_Id"] != DBNull.Value ? Convert.ToInt64(dr["Pallate_Id"]) : 0,
									Pallate_No = dr["Pallate_No"] != DBNull.Value ? Convert.ToString(dr["Pallate_No"]) : "",
									Pallate_Type = dr["Pallate_Type"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type"]) : "",
									Dispatch_Mode = dr["Dispatch_Mode"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode"]) : "",
									Pallate_Type_Text = dr["Pallate_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type_Text"]) : "",
									Dispatch_Mode_Text = dr["Dispatch_Mode_Text"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode_Text"]) : "",
									Plant_Name = dr["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dr["PLANT_NAME"]) : "",
									Plant_Address = dr["PLANT_ADDRESS"] != DBNull.Value ? Convert.ToString(dr["PLANT_ADDRESS"]) : "",
									Report_Title = dr["REPORT_TITLE"] != DBNull.Value ? Convert.ToString(dr["REPORT_TITLE"]) : "",
									Vehicle_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
									MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
									Gate_In_dt = dr["GATE_IN_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_IN_DT"]) : "",
									Gate_Out_dt = dr["GATE_OUT_DT"] != DBNull.Value ? Convert.ToString(dr["GATE_OUT_DT"]) : "",
									Transporter_Name = dr["TRANS_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANS_NAME"]) : null,
									Driver_Name = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : null,
									Driver_Contact = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : null,
									Expected_Shipper = dr["Expected_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Expected_Shipper"]) : 0,
									Expected_Bottle = dr["Expected_Bottle"] != DBNull.Value ? Convert.ToDecimal(dr["Expected_Bottle"]) : 0,
									Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
									Loaded_Bottle = dr["Loaded_Bottle"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Bottle"]) : 0,
									Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
									Bag_Nos = dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0,
									Party_Name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
									Dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
									Desp_Place = dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "",
									Shipper_QR_Code = new List<Pallate_Shipper>()
								});
							}
							catch { continue; }

					if (withDetail == true && ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
						foreach (DataRow dr in ds.Tables[1].Rows)
						{
							try
							{
								var index = result.FindIndex(x => x.Pallate_Id == (dr["Pallate_Id"] != DBNull.Value ? Convert.ToInt64(dr["Pallate_Id"]) : 0));

								if (index >= 0)
								{
									if (result[index].Shipper_QR_Code == null)
										result[index].Shipper_QR_Code = new List<Pallate_Shipper>();

									result[index].Shipper_QR_Code.Add(new Pallate_Shipper()
									{
										Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
										Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt32(dr["Sr_No"]) : 0,
										Pallate_Id = dr["Pallate_Id"] != DBNull.Value ? Convert.ToInt64(dr["Pallate_Id"]) : 0,
										QR_Code = dr["Shipper_QR_Code"] != DBNull.Value ? Convert.ToString(dr["Shipper_QR_Code"]) : ""
									});
								}
							}
							catch { continue; }
						}

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (isPrint == true || string.IsNullOrEmpty(searchTerm))
				return View((searchTerm, result, isPrint, withDetail));
			else
				return PartialView((searchTerm, result, isPrint, withDetail));
		}

	}
}
