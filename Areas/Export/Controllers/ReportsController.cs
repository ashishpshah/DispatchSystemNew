using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
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

	}
}
