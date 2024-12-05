using ClosedXML.Excel;
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
	[Area("Dispatch")]
	public class WeighmentOutSlipController : BaseController<ResponseModel<WeighmentOutSlip>>
	{

		#region Loading

		//[Route("WeighmentOutSlip/Index/{Vehicle_No?}")]
		public IActionResult Index(string Vehicle_No = "", long Id = 0, int PurposeType = 1)
		{
			if (!string.IsNullOrEmpty(Vehicle_No) || Id > 0)
				return Load_MDA_Dtls(Vehicle_No, Id, PurposeType, true);
			else
			{
				var list = new List<SelectListItem_Custom>();

				var oParams = new List<MySqlParameter>();

				try
				{
					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_INWARD_GET", oParams, false);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							list.Add(new SelectListItem_Custom(Convert.ToString(dr["ID"]), Convert.ToString(dr["INWARD_TYPE"]), Convert.ToString(dr["order_by"]), "INWARDTYPE"));

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

				CommonViewModel.SelectListItems = list;

				return View(CommonViewModel);
			}

			return View();
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

					oParams.Add(new MySqlParameter("P_PURPOSE_TYPE", MySqlDbType.Int64) { Value = PurposeType });
					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
					oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_WEIGHMENT_OUT_SLIP_GET", oParams);

					if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
					{
						obj = new Weighment()
						{
							Common_No = ds.Tables[1].Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["COMMON_NO"]) : "",
							Vehicle_No = ds.Tables[1].Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["VEHICLE_NO"]) : "",
							Transporter_Name = ds.Tables[1].Rows[0]["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["TRANSPORTER_NAME"]) : "",
							Status = ds.Tables[1].Rows[0]["TRANSACTION_TYPE"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["TRANSACTION_TYPE"]) : "",
							Party_Name = ds.Tables[1].Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["PARTY_NAME"]) : "",
							WeighIn_Wt = ds.Tables[1].Rows[0]["WEIGHIN_WT"] != DBNull.Value ? Convert.ToDouble(ds.Tables[1].Rows[0]["WEIGHIN_WT"]) : 0,
							WeighIn_Wt_Dt = ds.Tables[1].Rows[0]["WEIGHIN_WT_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGHIN_WT_DT"]) : "",
							WeighIn_Wt_Note = ds.Tables[1].Rows[0]["WEIGHIN_WT_NOTE"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGHIN_WT_NOTE"]) : "",
							WeighOut_Wt = ds.Tables[1].Rows[0]["WEIGHOUT_WT"] != DBNull.Value ? Convert.ToDouble(ds.Tables[1].Rows[0]["WEIGHOUT_WT"]) : 0,
							WeighOut_Wt_Dt = ds.Tables[1].Rows[0]["WEIGHOUT_WT_DT"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGHOUT_WT_DT"]) : "",
							WeighOut_Wt_Note = ds.Tables[1].Rows[0]["WEIGHOUT_WT_NOTE"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGHOUT_WT_NOTE"]) : "",
							Net_Wt = ds.Tables[1].Rows[0]["NET_WT"] != DBNull.Value ? Convert.ToDouble(ds.Tables[1].Rows[0]["NET_WT"]) : 0,
							Tolerance_Wt = ds.Tables[1].Rows[0]["TOLERANCE_WT"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[1].Rows[0]["TOLERANCE_WT"]) : 0,
							RFID_No = ds.Tables[1].Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["RFIDSRNO"]) : "",
							UOM = ds.Tables[1].Rows[0]["WEIGHT_UOM"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["WEIGHT_UOM"]) : ""
						};

						obj.listWeighmentDtls = new List<WeighmentDtls>();

						foreach (DataRow dr in ds.Tables[1].Rows)
							obj.listWeighmentDtls.Add(new WeighmentDtls()
							{
								SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt32(dr["SR_NO"]) : 0,
								Common_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
								Product_Code = dr["PRODUCT_CODE"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_CODE"]) : "",
								Product_Desc = dr["PRODUCT_DESC"] != DBNull.Value ? Convert.ToString(dr["PRODUCT_DESC"]) : "",
								No_of_bottle = dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt32(dr["BAG_NOS"]) : 0,
								No_of_Box = dr["Required_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Required_Shipper"]) : 0,
								No_of_Box_Loaded = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Loaded_Shipper"]) : 0,
								Distance = dr["Distance"] != DBNull.Value ? Convert.ToInt64(dr["Distance"]) : 0,
								Desp_Place = dr["Desp_Place"] != DBNull.Value ? Convert.ToString(dr["Desp_Place"]) : "",
								Qty = dr["Qty"] != DBNull.Value ? Convert.ToInt32(dr["Qty"]) : 0,
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

		//[HttpGet]
		//public IActionResult Load_MDA_Dtls(string Vehicle_No = "", long Gate_In_Out_Id = 0, bool IsPrint = false)
		//{
		//	var obj = new WeighmentOutSlip();

		//	//if (!string.IsNullOrEmpty(Vehicle_No) || Gate_In_Out_Id > 0)
		//	//{
		//	//	try
		//	//	{
		//	//		var oParams = new List<MySqlParameter>();

		//	//		oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
		//	//		oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
		//	//		oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
		//	//		oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
		//	//		oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
		//	//		oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
		//	//		oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
		//	//		//oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
		//	//		//oParams.Add(new MySqlParameter("P_DTLS", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

		//	//		DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_WEIGHMENT_OUT_SLIP_GET", oParams);

		//	//		if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
		//	//			obj = new WeighmentOutSlip()
		//	//			{
		//	//				Report_Title = ds.Tables[0].Rows[0]["Report_Title"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Report_Title"]) : "Weighment Slip - Weight Out",
		//	//				MDA_No = ds.Tables[0].Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["COMMON_NO"]) : "",
		//	//				Truck_No = ds.Tables[0].Rows[0]["TRUCK_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["TRUCK_NO"]) : "",
		//	//				Transporter_Name = ds.Tables[0].Rows[0]["Transporter_Name"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Transporter_Name"]) : "",
		//	//				Tare_Wt = ds.Tables[0].Rows[0]["Tare_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Tare_Wt"]) : 0,
		//	//				Tare_Wt_Dt = ds.Tables[0].Rows[0]["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
		//	//				Gross_Wt = ds.Tables[0].Rows[0]["Gross_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Gross_Wt"]) : 0,
		//	//				Gross_Wt_Dt = ds.Tables[0].Rows[0]["Gross_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Gross_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
		//	//				Gross_Wt_Note = ds.Tables[0].Rows[0]["Gross_Wt_Note"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Gross_Wt_Note"]) : "",
		//	//				Tolerance_Wt = ds.Tables[0].Rows[0]["Tolerance_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Tolerance_Wt"]) : 0,
		//	//				Net_Wt = ds.Tables[0].Rows[0]["Net_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Net_Wt"]) : 0,
		//	//				RFID_No = ds.Tables[0].Rows[0]["RFID_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["RFID_NO"]) : "",
		//	//				Skip_LILO_Remarks = ds.Tables[0].Rows[0]["Skip_LILO_Remarks"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Skip_LILO_Remarks"]) : ""

		//	//			};
		//	//		if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
		//	//		{
		//	//			obj.listdtls = new List<WeighmentOutSliplistdtls>();

		//	//			foreach (DataRow dr in ds.Tables[1].Rows)
		//	//				obj.listdtls.Add(new WeighmentOutSliplistdtls()
		//	//				{
		//	//					Mda_Id = dr["COMMON_SYS_ID"] != DBNull.Value ? Convert.ToInt32(dr["COMMON_SYS_ID"]) : 0,
		//	//					Mda_No = dr["COMMON_NO"] != DBNull.Value ? Convert.ToString(dr["COMMON_NO"]) : "",
		//	//					Mda_Dt = dr["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Mda_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
		//	//					prd_cd = dr["prd_cd"] != DBNull.Value ? Convert.ToString(dr["prd_cd"]) : "",
		//	//					prd_desc = dr["prd_desc"] != DBNull.Value ? Convert.ToString(dr["prd_desc"]) : "",
		//	//					no_of_Box = dr["no_of_Box"] != DBNull.Value ? Convert.ToInt32(dr["no_of_Box"]) : 0,
		//	//					no_of_bottle = dr["no_of_bottle"] != DBNull.Value ? Convert.ToInt32(dr["no_of_bottle"]) : 0,
		//	//					no_of_Box_Loaded = dr["no_of_Box_Loaded"] != DBNull.Value ? Convert.ToInt32(dr["no_of_Box_Loaded"]) : 0
		//	//				});
		//	//		}
		//	//	}
		//	//	catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
		//	//}



		//	if (!string.IsNullOrEmpty(Vehicle_No) || Gate_In_Out_Id > 0)
		//	{
		//		try
		//		{
		//			var oParams = new List<MySqlParameter>();

		//			oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
		//			oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
		//			oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

		//			DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_WEIGHMENT_OUT_SLIP_GET", oParams);

		//			if (dt != null && dt.Rows.Count > 0)
		//			{
		//				obj = new WeighmentOutSlip()
		//				{
		//					Report_Title = "Weighment Slip - Weigh Out Print",
		//					Plant_Name = dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "",
		//					Plant_Address = dt.Rows[0]["PlantAddress"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PlantAddress"]) : "",
		//					MDA_No = dt.Rows[0]["MDA_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_NO"]) : "",
		//					Truck_No = dt.Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Truck_No"]) : "",
		//					Transporter_Name = dt.Rows[0]["TPTR_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TPTR_NAME"]) : "",
		//					Tare_Wt = dt.Rows[0]["Tare_Wt"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Tare_Wt"]) : 0,
		//					Tare_Wt_Dt = dt.Rows[0]["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
		//					Gross_Wt = dt.Rows[0]["Gross_Wt"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Gross_Wt"]) : 0,
		//					Gross_Wt_Dt = dt.Rows[0]["Gross_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["Gross_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
		//					Gross_Wt_Note = dt.Rows[0]["Gross_Wt_Note"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Gross_Wt_Note"]) : "",
		//					Tolerance_Wt = dt.Rows[0]["Tolerance_Wt"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Tolerance_Wt"]) : 0,
		//					Net_Wt = dt.Rows[0]["Net_Wt"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Net_Wt"]) : 0,
		//					Skip_LILO_Remarks = dt.Rows[0]["Skip_LILO_Remarks"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Skip_LILO_Remarks"]) : "",
		//					RFID_No = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : ""

		//				};

		//				obj.listdtls = new List<WeighmentOutSliplistdtls>();

		//				foreach (DataRow dr in dt.Rows)
		//					obj.listdtls.Add(new WeighmentOutSliplistdtls()
		//					{
		//						SrNo = dr["SR_NO"] != DBNull.Value ? Convert.ToInt32(dr["SR_NO"]) : 0,
		//						Mda_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt32(dr["MDA_SYS_ID"]) : 0,
		//						Mda_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
		//						prd_cd = dr["prd_cd"] != DBNull.Value ? Convert.ToString(dr["prd_cd"]) : "",
		//						prd_desc = dr["prd_desc"] != DBNull.Value ? Convert.ToString(dr["prd_desc"]) : "",
		//						no_of_bottle = dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt32(dr["BAG_NOS"]) : 0,
		//						no_of_Box = dr["Required_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Required_Shipper"]) : 0,
		//						no_of_Box_Loaded = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Loaded_Shipper"]) : 0
		//					});
		//			}
		//		}
		//		catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
		//	}

		//	if (IsPrint == true)
		//		return View("Index_Print", obj);
		//	else
		//		return PartialView("_Partial_ShipperQRList", obj);
		//}


		[Route("WeighmentOutSlip/Export/{Vehicle_No?}")]
		public FileResult Export(string Vehicle_No = "")
		{
			var obj = new WeighmentOutSlip();
			var list = new List<WeighmentOutSliplistdtls>();

			if (!string.IsNullOrEmpty(Vehicle_No))
			{
				try
				{
					var oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_RFID_NO", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
					oParams.Add(new MySqlParameter("P_VEHICLE_NO", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
					//oParams.Add(new OracleParameter("P_FROM_DATE", OracleDbType.NVarchar2) { Value = "" });
					//oParams.Add(new OracleParameter("P_TO_DATE", OracleDbType.NVarchar2) { Value = "" });
					oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });
					//oParams.Add(new MySqlParameter("P_RESULT", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });
					//oParams.Add(new MySqlParameter("P_DTLS", MySqlDbType.RefCursor) { Direction = ParameterDirection.Output });

					DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_WEIGHMENT_OUT_SLIP_GET", oParams);

					if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
						obj = new WeighmentOutSlip()
						{
							Report_Title = ds.Tables[0].Rows[0]["Report_Title"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Report_Title"]) : "Weighment Slip - Weight Out",
							MDA_No = ds.Tables[0].Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["COMMON_NO"]) : "",
							Truck_No = ds.Tables[0].Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Truck_No"]) : "",
							Transporter_Name = ds.Tables[0].Rows[0]["Transporter_Name"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Transporter_Name"]) : "",
							Tare_Wt = ds.Tables[0].Rows[0]["Tare_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Tare_Wt"]) : 0,
							Tare_Wt_Dt = ds.Tables[0].Rows[0]["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gross_Wt = ds.Tables[0].Rows[0]["Gross_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Gross_Wt"]) : 0,
							Gross_Wt_Dt = ds.Tables[0].Rows[0]["Gross_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[0].Rows[0]["Gross_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gross_Wt_Note = ds.Tables[0].Rows[0]["Gross_Wt_Note"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Gross_Wt_Note"]) : "",
							Tolerance_Wt = ds.Tables[0].Rows[0]["Tolerance_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Tolerance_Wt"]) : 0,
							Net_Wt = ds.Tables[0].Rows[0]["Net_Wt"] != DBNull.Value ? Convert.ToDecimal(ds.Tables[0].Rows[0]["Net_Wt"]) : 0,
							RFID_No = ds.Tables[0].Rows[0]["RFID_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["RFID_NO"]) : "",
							Skip_LILO_Remarks = ds.Tables[0].Rows[0]["Skip_LILO_Remarks"] != DBNull.Value ? Convert.ToString(ds.Tables[0].Rows[0]["Skip_LILO_Remarks"]) : ""
						};
					if (ds != null && ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
					{
						foreach (DataRow dr in ds.Tables[1].Rows)
							list.Add(new WeighmentOutSliplistdtls()
							{
								Mda_Id = ds.Tables[1].Rows[0]["COMMON_SYS_ID"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["COMMON_SYS_ID"]) : 0,
								Mda_No = ds.Tables[1].Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["COMMON_NO"]) : "",
								Mda_Dt = ds.Tables[1].Rows[0]["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(ds.Tables[1].Rows[0]["Mda_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
								prd_cd = dr["prd_cd"] != DBNull.Value ? Convert.ToString(dr["prd_cd"]) : "",
								prd_desc = dr["prd_desc"] != DBNull.Value ? Convert.ToString(dr["prd_desc"]) : "",
								no_of_Box = dr["no_of_Box"] != DBNull.Value ? Convert.ToInt32(dr["no_of_Box"]) : 0,
								no_of_bottle = dr["no_of_bottle"] != DBNull.Value ? Convert.ToInt32(dr["no_of_bottle"]) : 0,
								no_of_Box_Loaded = dr["no_of_Box_Loaded"] != DBNull.Value ? Convert.ToInt32(dr["no_of_Box_Loaded"]) : 0
							});
					}
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			}

			using (XLWorkbook wb = new XLWorkbook())
			{
				var ws = wb.AddWorksheet();
				ws.Cell("A1").Value = "Weighment Slip - Weight Out";
				var range = ws.Range("A1:I1");
				range.Merge().Style.Font.SetBold().Font.FontSize = 18;


				ws.Cell("A2").Value = "RFID No ";
				ws.Cell("B2").Value = obj.RFID_No;
				ws.Cell("D2").Value = "Weigh In Date & Time ";
				ws.Cell("E2").Value = obj.Tare_Wt_Dt;

				ws.Cell("F2").Value = "Weigh Out Date & Time ";
				ws.Cell("G2").Value = obj.Gross_Wt_Dt;

				ws.Cell("A3").Value = "Vehicle No. ";
				ws.Cell("B3").Value = obj.Truck_No;
				ws.Cell("D3").Value = "Party Name ";
				ws.Cell("E3").Value = obj.Transporter_Name;

				ws.Cell("A4").Value = "Tolerance Weight ";
				ws.Cell("B4").Value = obj.Tolerance_Wt + " Kg";
				ws.Cell("D4").Value = "IN Weight ";
				ws.Cell("E4").Value = obj.Tare_Wt + " Kg";

				ws.Cell("F4").Value = "Out Weight ";
				ws.Cell("G4").Value = obj.Gross_Wt + " Kg";

				ws.Cell("A5").Value = "Remark ";
				ws.Cell("B5").Value = obj.Gross_Wt_Note;

				ws.Cell("A8").Value = "MDA No.";
				ws.Cell("B8").Value = "Product Description";
				ws.Cell("C8").Value = "No. of Bottle";
				ws.Cell("D8").Value = "No. of Box";
				ws.Cell("E8").Value = "No. of Box Loaded";
				ws.Range("A8:Z8").Style.Font.SetBold();

				DataTable dt = new DataTable("Grid");
				dt.Columns.AddRange(new DataColumn[5] { new DataColumn("MDA No."),
											new DataColumn("Product Description"),
											new DataColumn("No. of Bottle"),
											new DataColumn("No. of Box") ,
											new DataColumn("No. of Box Loaded") });

				foreach (var item in list)
				{
					dt.Rows.Add(item.Mda_No, item.prd_desc, item.no_of_bottle, item.no_of_Box, item.no_of_Box_Loaded);
				}

				ws.Cell("A9").InsertData(dt);

				//wb.Worksheets.Add(dt);
				using (MemoryStream stream = new MemoryStream())
				{
					wb.SaveAs(stream);
					return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", (obj != null && !string.IsNullOrEmpty(obj.Report_Title) ? obj.Report_Title : "Weighment Slip") + " - Weight Out - " + obj.Truck_No + ".xlsx");
				}
			}

			//var GridHtml = Convert.ToString(Task.Run(async () => await RenderPartialViewToString("_Partial_ShipperQRList", obj)).Result);

			//return File(Encoding.ASCII.GetBytes(GridHtml.ToString()), "application/vnd.ms-excel", "Shipper List by MDA - " + MDA_No + ".xls");


			return null;
		}

		#endregion
	}
}
