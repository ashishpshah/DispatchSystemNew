using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;

namespace Dispatch_System.Areas.Export.Controllers
{
    [Area("Export")]
	public class WeighmentInSlipController : BaseController<ResponseModel<WeighmentInSlip>>
	{
		#region Loading

		public IActionResult Index(string Vehicle_No = "", long Id = 0, int PurposeType = 1)
		{
			if (!string.IsNullOrEmpty(Vehicle_No) || Id > 0)
				return Load_MDA_Dtls(Vehicle_No, Id, PurposeType, true);
			else
				return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult Load_MDA_Dtls(string Vehicle_No = "", long Gate_In_Out_Id = 0, int PurposeType = 1, bool IsPrint = false)
		{
			DataSet ds = new DataSet();

			var obj = new Weighment();

			if (!string.IsNullOrEmpty(Vehicle_No) || Gate_In_Out_Id > 0)
			{
				try
				{
					var oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
					oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_EXP_WEIGHMENT_IN_SLIP", oParams);

					if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
					{
						obj = new Weighment()
						{
							Common_No = ds.Tables[1].Rows[0]["MDA_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["MDA_NO"]) : "",
							Vehicle_No = ds.Tables[1].Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["VEHICLE_NO"]) : "",
							Transporter_Name = ds.Tables[1].Rows[0]["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["TRANSPORTER_NAME"]) : "",
							Party_Name = ds.Tables[1].Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["PARTY_NAME"]) : "",
							WeighIn_Wt = ds.Tables[1].Rows[0]["WEIGH_IN_WT"] != DBNull.Value ? Convert.ToDouble(ds.Tables[1].Rows[0]["WEIGH_IN_WT"]) : 0,
							WeighIn_Wt_Dt = ds.Tables[1].Rows[0]["WEIGH_IN_WT_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGH_IN_WT_DT"]) : "",
							WeighIn_Wt_Note = ds.Tables[1].Rows[0]["WEIGH_IN_WT_NOTE"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGH_IN_WT_NOTE"]) : "",
							WeighOut_Wt = ds.Tables[1].Rows[0]["WEIGH_OUT_WT"] != DBNull.Value ? Convert.ToDouble(ds.Tables[1].Rows[0]["WEIGH_OUT_WT"]) : 0,
							WeighOut_Wt_Dt = ds.Tables[1].Rows[0]["WEIGH_OUT_WT_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGH_OUT_WT_DT"]) : "",
							WeighOut_Wt_Note = ds.Tables[1].Rows[0]["WEIGH_OUT_WT_NOTE"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGH_OUT_WT_NOTE"]) : "",
							RFID_No = ds.Tables[1].Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["RFIDSRNO"]) : "",
							UOM = ds.Tables[1].Rows[0]["WEIGHT_UOM"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGHT_UOM"]) : "",
							Required_Shipper = ds.Tables[1].Rows[0]["Expected_Shipper"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["Expected_Shipper"]) : 0
						};

						obj.listWeighmentDtls = new List<WeighmentDtls>();

						foreach (DataRow dr in ds.Tables[1].Rows)
							obj.listWeighmentDtls.Add(new WeighmentDtls()
							{
								SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt32(dr["SR_NO"]) : 0,
								Common_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
								Product_Code = dr["PRODUCT_CODE"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_CODE"]) : "",
								Product_Desc = dr["PRODUCT_DESC"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_DESC"]) : "",
								No_of_bottle = dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt32(dr["BAG_NOS"]) : 0,
								No_of_Box = dr["Required_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Required_Shipper"]) : 0,
								Distance = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
								Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
								UOM = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : ""
							});
					}

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			}

			obj.Plant_Name = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
								&& ds.Tables[0].Rows[0]["PLANT_NAME"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_NAME"]) : "";

			obj.Plant_Address = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
								&& ds.Tables[0].Rows[0]["PLANT_ADDRESS"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["PLANT_ADDRESS"]) : "";

			obj.Report_Title = (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0
								&& ds.Tables[0].Rows[0]["REPORT_TITLE"] != DBNull.Value) ? Convert.ToString(ds.Tables[0].Rows[0]["REPORT_TITLE"]) : "";


			if (IsPrint == true)
				return View("_Partial_Report", (obj, PurposeType, IsPrint));
			else
				return PartialView("_Partial_Report", (obj, PurposeType, IsPrint));
		}


		#endregion
	}
}
