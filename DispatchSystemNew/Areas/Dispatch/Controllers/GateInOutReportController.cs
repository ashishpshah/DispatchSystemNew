using ClosedXML.Excel;
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
	[Area("Dispatch")]
	public class GateInOutReportController : BaseController<ResponseModel<GateIn>>
	{
		#region Loading

		[Route("GateInOutReport/Index/{IsPrint?}")]
		public IActionResult Index(bool IsPrint = false, string FromDate = "", string ToDate = "")
		{
			if (IsPrint == true)
			{
				ViewBag.FromDate = FromDate;
				ViewBag.ToDate = ToDate;
				return GetMDA(true, FromDate, ToDate);
			}
			else
				return View();
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult GetMDA(bool IsPrint = false, string FromDate = "", string ToDate = "")
		{
			var list = new List<GateIn>();

			try
			{
				//var parameters = new MySqlParameter[] {
				//		new MySqlParameter("Id", MySqlDbType.Int64) { Value = 0 },
				//		new MySqlParameter("FromDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(FromDate)) ? FromDate:"" },
				//		new MySqlParameter("ToDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(ToDate)) ? ToDate:"" }
				//	};
				List<MySqlParameter> parameters = new List<MySqlParameter>();

				parameters.Add(new MySqlParameter("Id", MySqlDbType.Int64) { Value = 0 });
				parameters.Add(new MySqlParameter("FromDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(FromDate)) ? FromDate : "" });
				parameters.Add(new MySqlParameter("ToDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(ToDate)) ? ToDate : "" });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("SP_GateInOut_Get", parameters);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						list.Add(new GateIn()
						{
							Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
							Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
							MDA_No = dr["MDA_No"] != DBNull.Value ? Convert.ToString(dr["MDA_No"]) : "",
							Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
							Plant_CD = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
							Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gate_Out_Dt = dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
							Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
							Transporter_Name = dr["Transporter_Name"] != DBNull.Value ? Convert.ToString(dr["Transporter_Name"]) : "",
							Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
							Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
							Tare_Wt = dr["Tare_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Tare_Wt"]) : 0,
							Tare_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gross_Wt = dr["Gross_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Gross_Wt"]) : 0,
							Gross_Wt_Dt = dr["Gross_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Gross_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Net_Wt = dr["Net_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Net_Wt"]) : 0
						});
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (IsPrint == true)
				return View("Index_Print", list);
			else
				return PartialView("_Partial_MDA", list);
		}

		[HttpGet]
		public IActionResult Load_MDA_Dtls(string MDA_No = "")
		{
			var objMDA = new MDA_Header();
			var listMDA_Dtls = new List<MDA_Dtls>();

			if (!string.IsNullOrEmpty(MDA_No))
			{
				try
				{
					List<MySqlParameter> parameters = new List<MySqlParameter>();

					parameters.Add(new MySqlParameter("Id", MySqlDbType.Int64) { Value = 0 });
					parameters.Add(new MySqlParameter("MDA_No", MySqlDbType.VarChar) { Value = MDA_No });

					DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("SP_MDA_Get", parameters);

					if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
						objMDA = new MDA_Header()
						{
							Id = ds.Tables[0].Rows[0]["Id"] != DBNull.Value ? Convert.ToInt64(ds.Tables[0].Rows[0]["Id"]) : 0,
							Vehicle_No = ds.Tables[0].Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Truck_No"]) : "",
							Mda_No = ds.Tables[0].Rows[0]["MDA_No"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["MDA_No"]) : "",
							Plant_Cd = ds.Tables[0].Rows[0]["Plant_CD"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Plant_CD"]) : "",
							Gate_In_Dt = ds.Tables[0].Rows[0]["Gate_In_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Gate_In_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy hh:mm tt").Replace("-", "/") : "",
							Driver = ds.Tables[0].Rows[0]["Driver_Name"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Driver_Name"]) : "",
							Mobile_No = ds.Tables[0].Rows[0]["Driver_Contact"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Driver_Contact"]) : "",
							Party_Name = ds.Tables[0].Rows[0]["Transporter_Name"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Transporter_Name"]) : ""
						};

					if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
						foreach (DataRow dr in ds.Tables[1].Rows)
							listMDA_Dtls.Add(new MDA_Dtls()
							{
								Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
								Mda_Id = dr["Mda_Id"] != DBNull.Value ? Convert.ToInt64(dr["Mda_Id"]) : 0,
								Vehicle_No = objMDA.Vehicle_No,
								Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
								Prod_Sno = dr["Prod_Sno"] != DBNull.Value ? Convert.ToInt64(dr["Prod_Sno"]) : 0,
								Mda_Dt = dr["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Mda_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								Prod_Sys_Id = dr["Prod_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Prod_Sys_Id"]) : 0,
								Shipment_No = dr["Shipment_No"] != DBNull.Value ? Convert.ToInt64(dr["Shipment_No"]) : 0,
								sku_code = dr["sku_code"] != DBNull.Value ? Convert.ToString(dr["sku_code"]) : "",
								sku_name = dr["sku_name"] != DBNull.Value ? Convert.ToString(dr["sku_name"]) : "",
								prd_cd = dr["prd_cd"] != DBNull.Value ? Convert.ToString(dr["prd_cd"]) : "",
								prd_desc = dr["prd_desc"] != DBNull.Value ? Convert.ToString(dr["prd_desc"]) : "",
								Bag_Nos = dr["Bag_Nos"] != DBNull.Value ? Convert.ToDecimal(dr["Bag_Nos"]) : 0,
								Nett_Qty = dr["Nett_Qty"] != DBNull.Value ? Convert.ToDecimal(dr["Nett_Qty"]) : 0,
								Gross_Qty = dr["Gross_Qty"] != DBNull.Value ? Convert.ToDecimal(dr["Gross_Qty"]) : 0,
								Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0
							});

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			}

			return PartialView("_Partial_MDA_Dtls", listMDA_Dtls);

		}

		#endregion

		#region Events
		[HttpPost]
		public IActionResult Save(GateIn viewModel)
		{
			try
			{
				if (string.IsNullOrEmpty(viewModel.Cancel_Gate_Reason))
				{
					CommonViewModel.Message = "Please enter valid Reason.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				List<MySqlParameter> spCol = new List<MySqlParameter>();

				spCol.Add(new MySqlParameter("Id", MySqlDbType.Int64) { Value = viewModel.Id });
				spCol.Add(new MySqlParameter("Plant_Id", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				spCol.Add(new MySqlParameter("MDA_No", MySqlDbType.VarChar) { Value = viewModel.MDA_No });
				spCol.Add(new MySqlParameter("Truck_No", MySqlDbType.VarChar) { Value = viewModel.Truck_No });
				spCol.Add(new MySqlParameter("Transporter_Name", MySqlDbType.VarChar) { Value = viewModel.Transporter_Name });
				spCol.Add(new MySqlParameter("Driver_Id_Type", MySqlDbType.VarChar) { Value = viewModel.Driver_Id_Type ?? "" });
				spCol.Add(new MySqlParameter("Driver_Id_Number", MySqlDbType.VarChar) { Value = viewModel.Driver_Id_Number ?? "" });
				spCol.Add(new MySqlParameter("Driver_Name", MySqlDbType.VarChar) { Value = viewModel.Driver_Name ?? "" });
				spCol.Add(new MySqlParameter("Driver_Contact", MySqlDbType.VarChar) { Value = viewModel.Driver_Contact ?? "" });
				spCol.Add(new MySqlParameter("Cancel_Gate_In", MySqlDbType.VarChar) { Value = "Y" });
				spCol.Add(new MySqlParameter("Cancel_Gate_Reason", MySqlDbType.VarChar) { Value = viewModel.Cancel_Gate_Reason });
				spCol.Add(new MySqlParameter("Verified_Documents", MySqlDbType.VarChar) { Value = viewModel.Verified_Documents ? "Y" : "N" });
				spCol.Add(new MySqlParameter("Verified_Officer_Id", MySqlDbType.VarChar) { Value = viewModel.Verified_Officer_Id ?? "" });
				spCol.Add(new MySqlParameter("Operated_By", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("SP_Cancel_GateIn", spCol, true);

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


		[Route("GateInOutReport/Export")]
		public FileResult Export(string FromDate = "", string ToDate = "")
		{
			var list = new List<GateIn>();

			try
			{
				//var parameters = new MySqlParameter[] {
				//		new MySqlParameter("Id", MySqlDbType.Int64) { Value = 0 },
				//		new MySqlParameter("FromDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(FromDate)) ? FromDate:"" },
				//		new MySqlParameter("ToDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(ToDate)) ? ToDate:"" }
				//	};


				List<MySqlParameter> parameters = new List<MySqlParameter>();
				parameters.Add(new MySqlParameter("Id", MySqlDbType.Int64) { Value = 0 });
				parameters.Add(new MySqlParameter("FromDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(FromDate)) ? FromDate : "" });
				parameters.Add(new MySqlParameter("ToDate", MySqlDbType.VarChar) { Value = (!string.IsNullOrEmpty(ToDate)) ? ToDate : "" });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("SP_GateInOut_Get", parameters);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						list.Add(new GateIn()
						{
							Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
							Truck_No = dr["Truck_No"] != DBNull.Value ? Convert.ToString(dr["Truck_No"]) : "",
							MDA_No = dr["MDA_No"] != DBNull.Value ? Convert.ToString(dr["MDA_No"]) : "",
							Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
							Plant_CD = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
							Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gate_Out_Dt = dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
							Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
							Transporter_Name = dr["Transporter_Name"] != DBNull.Value ? Convert.ToString(dr["Transporter_Name"]) : "",
							Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
							Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
							Tare_Wt = dr["Tare_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Tare_Wt"]) : 0,
							Tare_Wt_Dt = dr["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gross_Wt = dr["Gross_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Gross_Wt"]) : 0,
							Gross_Wt_Dt = dr["Gross_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Gross_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Net_Wt = dr["Net_Wt"] != DBNull.Value ? Convert.ToDouble(dr["Net_Wt"]) : 0
						});
					}
				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


			using (XLWorkbook wb = new XLWorkbook())
			{
				var ws = wb.AddWorksheet();
				ws.Cell("A1").Value = "Gate In Out Report - From " + FromDate + " To " + ToDate;
				var range = ws.Range("A1:I1");
				range.Merge().Style.Font.SetBold().Font.FontSize = 18;


				ws.Cell("A3").Value = "Vehicle Number";
				ws.Cell("B3").Value = "MDA Number";
				ws.Cell("C3").Value = "Gate In Dt";
				ws.Cell("D3").Value = "Gate Out Dt";
				ws.Cell("E3").Value = "Driver Name";
				ws.Cell("F3").Value = "Driver Contact";
				ws.Cell("G3").Value = "Transporter Name";

				ws.Range("A3:Z3").Style.Font.SetBold();

				DataTable dt = new DataTable("Grid");
				dt.Columns.AddRange(new DataColumn[7] { new DataColumn("Vehicle Number"),
											new DataColumn("MDA Number"),
											new DataColumn("Gate In Dt"),
											new DataColumn("Gate Out Dt"),
											new DataColumn("Driver Name"),
											new DataColumn("Driver Contact"),
											new DataColumn("Transporter Name") });

				foreach (var item in list)
				{
					dt.Rows.Add(item.Truck_No, item.MDA_No, item.Gate_In_Dt, item.Gate_Out_Dt, item.Driver_Name, item.Driver_Contact, item.Transporter_Name);
				}


				ws.Cell("A4").InsertData(dt);

				//wb.Worksheets.Add(dt);
				using (MemoryStream stream = new MemoryStream())
				{
					wb.SaveAs(stream);
					return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Gate In Out Report - From " + FromDate + " To " + ToDate + ".xlsx");
				}
			}

			//var GridHtml = Convert.ToString(Task.Run(async () => await RenderPartialViewToString("_Partial_ShipperQRList", obj)).Result);

			//return File(Encoding.ASCII.GetBytes(GridHtml.ToString()), "application/vnd.ms-excel", "Shipper List by MDA - " + MDA_No + ".xls");


			return null;
		}

		#endregion

	}
}
