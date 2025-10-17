using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using System.Data;
using System.Globalization;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using VendorQRGeneration.Infra.Services;
using ZXing.QrCode.Internal;

namespace Dispatch_System.Areas.Admin.Controllers
{
	[Area("MDA_Automation")]
	public class Load_MDAController : BaseController<ResponseModel<MDA>>
	{
		private readonly SocketBackgroundTask _socketBackgroundTask;
		private readonly SharedDataService _sharedDataService;

		public Load_MDAController(SocketBackgroundTask socketBackgroundTask, SharedDataService sharedDataService)
		{
			_sharedDataService = sharedDataService;
			_socketBackgroundTask = socketBackgroundTask;
		}

		public IActionResult Index()
		{
			try
			{
				if (_socketBackgroundTask.IsRunning())
					_socketBackgroundTask.StopWork();
				_sharedDataService.ClearScanData();
			}
			catch (Exception ex) { }

			return View();
		}

		[HttpGet]
		public IActionResult GetMDA(string type, string searchTerm)
		{
			try
			{
				if (_socketBackgroundTask.IsRunning())
					_socketBackgroundTask.StopWork();
				_sharedDataService.ClearScanData();
			}
			catch (Exception ex) { }

			var list = new List<MDA>();

			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new MDA()
						{
							Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
							GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
							vehicle_no = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
							mda_no = dr["MDA_No"] != DBNull.Value ? Convert.ToString(dr["MDA_No"]) : "",
							plant_cd = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
							mda_dt = dr["MDA_DT"] != DBNull.Value ? Convert.ToString(dr["MDA_DT"]) : "",
							driver = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "",
							mobile_no = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "",
							dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
							wh_cd = dr["wh_cd"] != DBNull.Value ? Convert.ToString(dr["wh_cd"]) : "",
							party_name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
							tptr_cd = dr["tptr_cd"] != DBNull.Value ? Convert.ToString(dr["tptr_cd"]) : "",
							tptr_name = dr["tptr_name"] != DBNull.Value ? Convert.ToString(dr["tptr_name"]) : ""
						});

				if (dt == null || dt.Rows.Count == 0)
					LogService.LogInsert(GetCurrentAction(), "No any Records from PC_LOAD_MDA_GET_NEW | Gate_In_Out_Id : " + 0 + ", MDA_Id : " + 0 + ", searchTerm : " + searchTerm + "", null);
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S") return Json(list);
				else return PartialView("_Partial_MDA", list);
			else return Json(null);
			//return PartialView("_Partial_MDA", list);
		}

		[HttpGet]
		public IActionResult Load_MDA_Dtls(long MDA_Id = 0, long Gate_In_Out_Id = 0, string searchTerm = "")
		{
			try
			{
				if (_socketBackgroundTask.IsRunning())
					_socketBackgroundTask.StopWork();
				_sharedDataService.ClearScanData();
			}
			catch (Exception ex) { }

			//var objMDA = new MDA_Header();
			var listMDA_Dtls = new List<MDA_Dtls>();

			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = MDA_Id });
				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

				//if (dt != null && dt.Rows.Count > 0)
				//	objMDA = new MDA_Header()
				//	{
				//		Id = dt.Rows[0]["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["MDA_SYS_ID"]) : 0,
				//		GateInOut_Id = dt.Rows[0]["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["GATE_SYS_ID"]) : 0,
				//		Trans_Sys_Id = dt.Rows[0]["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["TRANS_SYS_ID"]) : 0,
				//		Vehicle_No = dt.Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VEHICLE_NO"]) : "",
				//		Mda_No = dt.Rows[0]["MDA_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_No"]) : "",
				//		Plant_Cd = dt.Rows[0]["Plant_CD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Plant_CD"]) : "",
				//		//Mda_Dt = dt.Rows[0]["MDA_DT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_DT"]) : "",
				//		Driver = dt.Rows[0]["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DRIVER_NAME"]) : "",
				//		Mobile_No = dt.Rows[0]["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DRIVER_CONTACT"]) : "",
				//		Wh_Cd = dt.Rows[0]["Wh_Cd"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Wh_Cd"]) : "",
				//		Party_Name = dt.Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PARTY_NAME"]) : "",
				//		tptr_cd = dt.Rows[0]["tptr_cd"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["tptr_cd"]) : "",
				//		tptr_name = dt.Rows[0]["tptr_name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["tptr_name"]) : "",
				//		Desp_Place = dt.Rows[0]["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DESP_PLACE"]) : "",
				//		Bag_Nos = dt.Rows[0]["Bag_Nos"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Bag_Nos"]) : 0,
				//		Nett_Qty = dt.Rows[0]["Nett_Qty"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Nett_Qty"]) : 0,
				//		Gross_Qty = dt.Rows[0]["Gross_Qty"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Gross_Qty"]) : 0,
				//		Dist = dt.Rows[0]["DIST"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["DIST"]) : 0
				//	};

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						listMDA_Dtls.Add(new MDA_Dtls()
						{
							Id = dr["MDA_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_DTL_SYS_ID"]) : 0,
							Mda_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
							Vehicle_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
							GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
							Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
							Prod_Sno = dr["PROD_SNO"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SNO"]) : 0,
							//Mda_Dt = dr["Mda_Dt"] != DBNull.Value ? Convert.ToDateTime(dr["Mda_Dt"]) : nullDateTime,
							Mda_Dt = dr["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Mda_Dt"]), "dd/MM/yyyy", CultureInfo.InvariantCulture) : nullDateTime,
							Prod_Sys_Id = dr["Prod_Sys_Id"] != DBNull.Value ? Convert.ToInt64(dr["Prod_Sys_Id"]) : 0,
							//Shipment_No = dr["Shipment_No"] != DBNull.Value ? Convert.ToInt64(dr["Shipment_No"]) : 0,
							//sku_code = dr["sku_code"] != DBNull.Value ? Convert.ToString(dr["sku_code"]) : "",
							//sku_name = dr["sku_name"] != DBNull.Value ? Convert.ToString(dr["sku_name"]) : "",
							prd_cd = dr["prd_cd"] != DBNull.Value ? Convert.ToString(dr["prd_cd"]) : "",
							prd_desc = dr["prd_desc"] != DBNull.Value ? Convert.ToString(dr["prd_desc"]) : "",
							Wh_Cd = dr["Wh_Cd"] != DBNull.Value ? Convert.ToString(dr["Wh_Cd"]) : "",
							Party_Name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
							Desp_Place = dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "",
							Bag_Nos = dr["BAG_NOS"] != DBNull.Value ? Convert.ToDecimal(dr["BAG_NOS"]) : 0,
							Carton_Qty = dr["SHIP_PER_PALLET"] != DBNull.Value ? Convert.ToDecimal(dr["SHIP_PER_PALLET"]) : 0,
							Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
							Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
							//Bag_Nos = dr["Bag_Nos"] != DBNull.Value ? Convert.ToDecimal(dr["Bag_Nos"]) : 0,
							//Nett_Qty = dr["Nett_Qty"] != DBNull.Value ? Convert.ToDecimal(dr["Nett_Qty"]) : 0,
							//Gross_Qty = dr["Gross_Qty"] != DBNull.Value ? Convert.ToDecimal(dr["Gross_Qty"]) : 0,
							//Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
							Is_Posted = dr["Is_End_Loading"] != DBNull.Value ? Convert.ToBoolean(dr["Is_End_Loading"]) : false,
							mda_order = dr["MDA_ORDER"] != DBNull.Value ? Convert.ToInt32(dr["MDA_ORDER"]) : 0,
							dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
						});

				if (dt == null || dt.Rows.Count == 0)
					LogService.LogInsert(GetCurrentAction(), "No any Records from PC_LOAD_MDA_GET_NEW | Gate_In_Out_Id : " + Gate_In_Out_Id + ", MDA_Id : " + MDA_Id + ", searchTerm : " + searchTerm + "", null);
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (listMDA_Dtls != null) listMDA_Dtls = listMDA_Dtls.OrderBy(x => x.mda_order).ToList();

			return Json(listMDA_Dtls);
		}


		[HttpGet]
		public IActionResult Partial_ViewQR(long mda_id = 0, long gatein_id = 0, long prod_id = 0, string type = "")
		{
			var list = new List<ShipperBatch>();

			if (gatein_id > 0 && mda_id > 0)
			{
				try
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = gatein_id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.VarString) { Value = mda_id });
					oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.VarString) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = prod_id });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_SHIPPER_QRCODE_HISTORY_GET_NEW", oParams, false);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							if ((dt.Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["ID"]) : 0) > 0
								&& (!string.IsNullOrEmpty(type) && type == "R" ? ((dr["LOG_Type"] != DBNull.Value ? Convert.ToString(dr["LOG_Type"]) : "") == "R" ? true : false) : true))
								list.Add(new ShipperBatch()
								{
									SrNo = dr["SrNo"] != DBNull.Value ? Convert.ToInt32(dr["SrNo"]) : 0,
									ShipperQRCode = dr["QRCODE"] != DBNull.Value ? Convert.ToString(dr["QRCODE"]) : "",
									Status = dr["LOG_Type"] != DBNull.Value ? Convert.ToString(dr["LOG_Type"]) : "",
									Reject_Reason = dr["REJECT_REASON"] != DBNull.Value ? Convert.ToString(dr["REJECT_REASON"]) : ""
								});

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			}

			list = list == null ? new List<ShipperBatch>() : list;

			return PartialView("_Partial_ViewQR", list);
		}


		[HttpGet]
		public IActionResult Check_MDA_Update(long MDA_Id = 0, long GateInOut_Id = 0, bool isConfirm_Update = false)
		{
			var isUpdate = false;

			if (GateInOut_Id > 0 && MDA_Id > 0)
			{
				var objMDA = new MDA_Header();
				//var listMDA_Dtls = new List<MDA_Dtls>();

				try
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = MDA_Id });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
						objMDA = new MDA_Header()
						{
							Id = dt.Rows[0]["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["MDA_SYS_ID"]) : 0,
							GateInOut_Id = dt.Rows[0]["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["GATE_SYS_ID"]) : 0,
							Trans_Sys_Id = dt.Rows[0]["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["TRANS_SYS_ID"]) : 0,
							Vehicle_No = dt.Rows[0]["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["VEHICLE_NO"]) : "",
							Mda_No = dt.Rows[0]["MDA_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_No"]) : "",
							Plant_Cd = dt.Rows[0]["Plant_CD"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Plant_CD"]) : "",
							//Mda_Dt = dt.Rows[0]["MDA_DT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["MDA_DT"]) : "",
							Driver = dt.Rows[0]["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DRIVER_NAME"]) : "",
							Mobile_No = dt.Rows[0]["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DRIVER_CONTACT"]) : "",
							Wh_Cd = dt.Rows[0]["Wh_Cd"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Wh_Cd"]) : "",
							Party_Name = dt.Rows[0]["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PARTY_NAME"]) : "",
							tptr_cd = dt.Rows[0]["tptr_cd"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["tptr_cd"]) : "",
							tptr_name = dt.Rows[0]["tptr_name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["tptr_name"]) : "",
							Desp_Place = dt.Rows[0]["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["DESP_PLACE"]) : "",
							Bag_Nos = dt.Rows[0]["Bag_Nos"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Bag_Nos"]) : 0,
							Nett_Qty = dt.Rows[0]["Nett_Qty"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Nett_Qty"]) : 0,
							Gross_Qty = dt.Rows[0]["Gross_Qty"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Gross_Qty"]) : 0,
							Dist = dt.Rows[0]["DIST"] != DBNull.Value ? Convert.ToInt64(dt.Rows[0]["DIST"]) : 0
						};

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

				try
				{
					var strMDA = "";

					// MDA HEADER DATA

					var client = new HttpClient();
					var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

					request.Content = new StringContent("{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31002\"," +
															"\"inParameters\" : [{ \"label\" : \"mdaNo\", \"value\" : \"" + objMDA.Mda_No + "\" }," +
																				"{ \"label\" : \"plantCd\", \"value\" : \"" + objMDA.Plant_Cd + "\" }" +
															"]}", null, "application/json");

					request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

					var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

					if (webRequestResponse.IsSuccessStatusCode)
					{
						var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

						if (!string.IsNullOrEmpty(responseContent))
						{
							JArray objArray = JArray.Parse(responseContent);

							JObject objMDA_Header = ((JObject)objArray.First);

							if (objMDA_Header != null && objMDA_Header["MDA_NO"] != null && Convert.ToString(((JValue)objMDA_Header["MDA_NO"]).Value).Trim().Length > 0)
							{
								if (objMDA_Header["BAG_NOS"] != null && ((JValue)objMDA_Header["BAG_NOS"]).Value != null && Convert.ToInt32(((JValue)objMDA_Header["BAG_NOS"]).Value).ToString().Trim() != objMDA.Bag_Nos.ToString())
									isUpdate = true;

								if (objMDA_Header["NETT_QTY"] != null && ((JValue)objMDA_Header["NETT_QTY"]).Value != null && Convert.ToInt32(((JValue)objMDA_Header["NETT_QTY"]).Value).ToString().Trim() != objMDA.Nett_Qty.ToString())
									isUpdate = true;

								if (objMDA_Header["GROSS_QTY"] != null && ((JValue)objMDA_Header["GROSS_QTY"]).Value != null && Convert.ToInt32(((JValue)objMDA_Header["GROSS_QTY"]).Value).ToString().Trim() != objMDA.Gross_Qty.ToString())
									isUpdate = true;

								//isUpdate = true;

								if (isUpdate == true && isConfirm_Update == true)
								{
									strMDA = (objMDA_Header["MDA_NO"] != null && ((JValue)objMDA_Header["MDA_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["MDA_NO"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["DI_NO"] != null && ((JValue)objMDA_Header["DI_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DI_NO"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["PLANT_CD"] != null && ((JValue)objMDA_Header["PLANT_CD"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["PLANT_CD"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["GR_NO"] != null && ((JValue)objMDA_Header["GR_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["GR_NO"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["GR_DT"] != null && ((JValue)objMDA_Header["GR_DT"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["GR_DT"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
											(objMDA_Header["MDA_DT"] != null && ((JValue)objMDA_Header["MDA_DT"]).Value != null ? Convert.ToDateTime(((JValue)objMDA_Header["MDA_DT"]).Value.ToString().Trim()).ToString("dd/MM/yyyy HH:mm").Replace("-", "/") : "=") + "|" +
											(objMDA_Header["TPTR_CD"] != null && ((JValue)objMDA_Header["TPTR_CD"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["TPTR_CD"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["TPTR_NAME"] != null && ((JValue)objMDA_Header["TPTR_NAME"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["TPTR_NAME"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["WH_CD"] != null && ((JValue)objMDA_Header["WH_CD"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["WH_CD"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["PARTY_NAME"] != null && ((JValue)objMDA_Header["PARTY_NAME"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["PARTY_NAME"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["DRIVER"] != null && ((JValue)objMDA_Header["DRIVER"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DRIVER"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["VEHICLE_NO"] != null && ((JValue)objMDA_Header["VEHICLE_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["VEHICLE_NO"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["MOBILE_NO"] != null && ((JValue)objMDA_Header["MOBILE_NO"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["MOBILE_NO"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["DIST"] != null && ((JValue)objMDA_Header["DIST"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DIST"]).Value).Trim() : "=") + "|" +
											(objMDA_Header["BAG_NOS"] != null && ((JValue)objMDA_Header["BAG_NOS"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["BAG_NOS"]).Value).ToString().Trim() : "=") + "|" +
											(objMDA_Header["NETT_QTY"] != null && ((JValue)objMDA_Header["NETT_QTY"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["NETT_QTY"]).Value).ToString().Trim() : "=") + "|" +
											(objMDA_Header["GROSS_QTY"] != null && ((JValue)objMDA_Header["GROSS_QTY"]).Value != null ? Convert.ToInt32(((JValue)objMDA_Header["GROSS_QTY"]).Value).ToString().Trim() : "=") + "|=|=|=|" +
											(objMDA_Header["DESP_PLACE"] != null && ((JValue)objMDA_Header["DESP_PLACE"]).Value != null ? Convert.ToString(((JValue)objMDA_Header["DESP_PLACE"]).Value).Trim() : "=");

									strMDA = strMDA + "$$";


									// MDA DETAIL
									// Fetch MDA Detail data from API

									request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

									request.Content = new StringContent("{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31003\"," +
																			"\"inParameters\" : [{ \"label\" : \"mdaNo\", \"value\" : \"" + Convert.ToString(((JValue)objMDA_Header["MDA_NO"]).Value).Trim() + "\" }," +
																								"{ \"label\" : \"plantCd\", \"value\" : \"" + Convert.ToString(((JValue)objMDA_Header["PLANT_CD"]).Value).Trim() + "\" }" +
																			"]}", null, "application/json");

									request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

									webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

									if (webRequestResponse.IsSuccessStatusCode)
									{
										responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

										if (!string.IsNullOrEmpty(responseContent))
										{
											JArray listMDA_Dtls_API = JArray.Parse(responseContent);

											if (listMDA_Dtls_API != null)
												for (int i = 0; i < listMDA_Dtls_API.Count(); i++)
													try
													{
														//listMDA_Dtls_API.Add(new MDA_Dtls()
														//{
														//	sku_code = Convert.ToString(((JValue)listMDA_Dtls_API[i]["SKU_CODE"]).Value).Trim(),
														//	prd_cd = Convert.ToString(((JValue)listMDA_Dtls_API[i]["PRD_CD"]).Value).Trim(),
														//	Shipment_No = Convert.ToUInt32(((JValue)listMDA_Dtls_API[i]["SHIPMENT_NO"]).Value),
														//	Bag_Nos = Convert.ToInt32(((JValue)listMDA_Dtls_API[i]["BAG_NOS"]).Value),
														//	Nett_Qty = Convert.ToInt32(((JValue)listMDA_Dtls_API[i]["NETT_QTY"]).Value),
														//	Gross_Qty = Convert.ToInt32(((JValue)listMDA_Dtls_API[i]["GROSS_QTY"]).Value)
														//});

														strMDA = strMDA + (listMDA_Dtls_API[i]["PROD_SNO"] != null && ((JValue)listMDA_Dtls_API[i]["PROD_SNO"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls_API[i]["PROD_SNO"]).Value).Trim() : "=") + "|" +
															(listMDA_Dtls_API[i]["SKU_CODE"] != null && ((JValue)listMDA_Dtls_API[i]["SKU_CODE"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls_API[i]["SKU_CODE"]).Value).Trim() : "=") + "|" +
															//Convert.ToString(((JValue)listMDA_Dtls_API[i]["SKU_NAME"]).Value).Trim()+ "|" +
															(listMDA_Dtls_API[i]["PRD_CD"] != null && ((JValue)listMDA_Dtls_API[i]["PRD_CD"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls_API[i]["PRD_CD"]).Value).Trim() : "=") + "|" +
															//Convert.ToString(((JValue)listMDA_Dtls_API[i]["PRD_DESC"]).Value).Trim()+ "|" +
															(listMDA_Dtls_API[i]["SHIPMENT_NO"] != null && ((JValue)listMDA_Dtls_API[i]["SHIPMENT_NO"]).Value != null ? Convert.ToString(((JValue)listMDA_Dtls_API[i]["SHIPMENT_NO"]).Value).Trim() : "=") + "|" +
															(listMDA_Dtls_API[i]["BAG_NOS"] != null && ((JValue)listMDA_Dtls_API[i]["BAG_NOS"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls_API[i]["BAG_NOS"]).Value).ToString().Trim() : "=") + "|" +
															(listMDA_Dtls_API[i]["NETT_QTY"] != null && ((JValue)listMDA_Dtls_API[i]["NETT_QTY"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls_API[i]["NETT_QTY"]).Value).ToString().Trim() : "=") + "|" +
															(listMDA_Dtls_API[i]["GROSS_QTY"] != null && ((JValue)listMDA_Dtls_API[i]["GROSS_QTY"]).Value != null ? Convert.ToInt32(((JValue)listMDA_Dtls_API[i]["GROSS_QTY"]).Value).ToString().Trim() : "=") + "@@";

													}
													catch (Exception ex) { continue; }

											if (!string.IsNullOrEmpty(strMDA))
											{
												//var objList_JSON = string.Join("##", listMDA.ToArray());

												var oParams = new List<MySqlParameter>();

												oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = MDA_Id });

												oParams.Add(new MySqlParameter("P_JSON_LIST", MySqlDbType.LongText) { Value = strMDA });

												oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
												oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
												oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
												oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

												var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_SAVE", oParams, true);

												CommonViewModel.IsConfirm = true;
												CommonViewModel.IsSuccess = IsSuccess;
												CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
												CommonViewModel.Message = response;
												CommonViewModel.RedirectURL = "";

												return Json(CommonViewModel);
											}
										}
									}

								}

							}

						}
					}
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); isUpdate = false; }
			}

			CommonViewModel.IsConfirm = true;
			CommonViewModel.IsSuccess = isUpdate;
			CommonViewModel.StatusCode = ResponseStatusCode.Success;

			CommonViewModel.Message = isUpdate && isConfirm_Update == false ? "Do you want to update MDA details ?" : "No any change in MDA.";
			CommonViewModel.RedirectURL = isUpdate ? Url.Content("~/") + GetCurrentControllerUrl() + "/Check_MDA_Update?Id=" + MDA_Id + "&GateInOut_Id=" + GateInOut_Id + "&isConfirm_Update=true" : "";

			return Json(CommonViewModel);
		}


		[HttpPost]
		public async Task<JsonResult> AddQty(MDA_Dtls viewModel)
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

				if (viewModel.Mda_Id <= 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select valid MDA Details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.GateInOut_Id <= 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select valid Gate In Details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Carton_Qty <= 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select valid Additional Qty";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}


				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

				if (dt != null && dt.Rows.Count > 0)
				{
					var client = new HttpClient();
					var request = new HttpRequestMessage(HttpMethod.Post, $"{AppHttpContextAccessor.API_Url_WMS}/DeliveryOrder");

					request.Headers.Add("Authorization", $"Basic {AppHttpContextAccessor.API_Authorization_WMS}");

					if (viewModel.Is_BypassWMS == false)
						try
						{
							List<string> listObj = new List<string>();

							foreach (DataRow dr in dt.Rows)
							{
								var mda_date = DateTime.ParseExact(dr["MDA_DT"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);

								DataRow[] filteredRows = dt.AsEnumerable().Where(row => row.Field<decimal>("ID") == viewModel.Id && row.Field<decimal>("MDA_ID") == viewModel.Mda_Id
								&& row.Field<decimal>("PROD_SYS_ID") == viewModel.Prod_Sys_Id).ToArray();

								for (int i = 0; i < filteredRows.Count(); i++)
								{
									listObj.Add("{\"TRUCK NO\": \"" + dr["VEHICLE_NO"] + "\",\"MDA NO\": \"" + dr["MDA_NO"] + "\",\"MDA DATE\": \"" + mda_date.ToString("yyyy-MM-dd") + " 00:00:00\"" +
										",\"DEL TYPE\": \"D\",\"SKU CODE\": \"" + filteredRows[i]["SKU_CODE"] + "\",\"SKU NAME\": \"" + filteredRows[i]["SKU_NAME"] + "\"" +
										",\"BOTTLE QTY\": \"" + filteredRows[i]["BAG_NOS"] + "\",\"CARTON QTY\": \"" + filteredRows[i]["SHIP_PER_PALLET"] + "\"" +
										",\"LOADING BAY\": \"" + AppHttpContextAccessor.Loading_Bay + "\",\"ORDER\": \"1\",\"STATUS CODE\": \"30\"" +
										",\"LOADING STATUS\": \"INPROGRESS\",\"LOADED QTY\": \"" + filteredRows[i]["Loaded_Shipper"] + "\",\"SHORT QTY\":\"0\"" +
										",\"ADDITIONAL QTY\":\"" + viewModel.Carton_Qty + "\", \"REASON\":\"" + viewModel.prd_desc + "\"\r\n}");
								}

							}

							string jsonString = "[" + string.Join(",", listObj.ToArray()) + "]";

							StringContent? content = new StringContent(jsonString, null, "application/json");

							request.Content = content;

							var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

							if (webRequestResponse.IsSuccessStatusCode)
							{
								var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

								if (!string.IsNullOrEmpty(responseContent))
								{
									JToken objData = JObject.Parse(responseContent);

									if (objData != null && objData["Message"] != null
										&& JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["RESULT"].ToString().ToLower() != "success")
									{
										CommonViewModel.IsConfirm = false;
										CommonViewModel.IsSuccess = false;
										CommonViewModel.StatusCode = ResponseStatusCode.Error;
										CommonViewModel.Message = JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["REMARKS"].ToString();

										CommonViewModel.Data1 = "AddQty";

										return Json(CommonViewModel);
									}

								}

							}

						}
						catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


					oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
					oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Id });
					oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Prod_Sys_Id });
					oParams.Add(new MySqlParameter("P_ADDITIONAL_QTY", MySqlDbType.Int64) { Value = viewModel.Carton_Qty });
					oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarString) { Value = viewModel.Reason });

					oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
					oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
					oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_ADD_QTY_SAVE", oParams, true);

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;

					CommonViewModel.Data1 = "AddQty";

					return Json(CommonViewModel);

				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> RequisitionWMS(MDA_Dtls viewModel)
		{
			try
			{
				var objMDA = new MDA_Header();
				var listMDA_Dtls = new List<MDA_Dtls>();

				if (viewModel.GateInOut_Id > 0 && viewModel.Mda_Id > 0)
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
					{
						//_socketBackgroundTask.SendToPrinter(dt.Rows[0]["MDA_ORDER"].ToString(), dt.Rows[0]["PARTY_NAME"].ToString(), dt.Rows[0]["DESP_PLACE"].ToString());

						var client = new HttpClient();
						var request = new HttpRequestMessage(HttpMethod.Post, $"{AppHttpContextAccessor.API_Url_WMS}/Product");

						request.Headers.Add("Authorization", $"Basic {AppHttpContextAccessor.API_Authorization_WMS}");

						try
						{
							List<string> listObj = new List<string>();

							foreach (DataRow dr in dt.Rows)
							{
								listObj.Add("{\"PRD_CD\": \"" + dr["PRD_CD"] + "\", \"PRD_DESC\": \"" + dr["PRD_DESC"] + "\", \"Number of Carton Per Pallet\": \"" + dr["SHIP_PER_PALLET"] + "\"}");
								//listObj.Add("{\"PRD_CD\": \"" + dr["PRD_CD"] + "\", \"PRD_DESC\": \"" + dr["PRD_DESC"] + "\", \"Number of Carton Per Pallet\": \"" + dr["SHIP_PER_PALLET"] + "\"}");
							}

							string jsonString = "[" + string.Join(",", listObj.ToArray()) + "]";

							StringContent? content = new StringContent(jsonString, null, "application/json");

							request.Content = content;

							var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

							if (webRequestResponse.IsSuccessStatusCode)
							{
								var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

								if (!string.IsNullOrEmpty(responseContent))
								{
									JToken objData = JObject.Parse(responseContent);

									//if (objData != null && objData["Message"] != null
									//	&& JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["Remarks"].ToString() != "Success")
									//{
									//	CommonViewModel.IsConfirm = false;
									//	CommonViewModel.IsSuccess = false;
									//	CommonViewModel.StatusCode = ResponseStatusCode.Error;
									//	CommonViewModel.Message = JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["REMARKS1"].ToString();

									//	CommonViewModel.Data1 = "RequisitionWMS";

									//	return Json(CommonViewModel);
									//}

								}

							}

						}
						catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

						request = new HttpRequestMessage(HttpMethod.Post, $"{AppHttpContextAccessor.API_Url_WMS}/DeliveryOrder");

						request.Headers.Add("Authorization", $"Basic {AppHttpContextAccessor.API_Authorization_WMS}");

						try
						{
							List<string> listObj = new List<string>();

							foreach (DataRow dr in dt.Rows)
							{
								var mda_date = DateTime.ParseExact(dr["MDA_DT"].ToString(), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);

								DataRow[] filteredRows = dt.AsEnumerable()
									.Where(row => row.Field<Int32>("GATE_SYS_ID") == viewModel.GateInOut_Id
												&& row.Field<Int32>("MDA_SYS_ID") == viewModel.Mda_Id
												&& row.Field<Int32>("PROD_SYS_ID") == viewModel.Prod_Sys_Id).ToArray();

								for (int i = 0; i < filteredRows.Count(); i++)
								{
									listObj.Add("{\"TRUCK NO\": \"" + dr["VEHICLE_NO"] + "\",\"MDA NO\": \"" + dr["MDA_NO"] + "\",\"MDA DATE\": \"" + mda_date.ToString("yyyy-MM-dd HH:mm:ss") + "\"" +
										",\"DEL TYPE\": \"D\",\"SKU CODE\": \"" + filteredRows[i]["SKU_CODE"] + "\",\"SKU NAME\": \"" + filteredRows[i]["SKU_NAME"] + "\"" +
										",\"BOTTLE QTY\": \"" + Convert.ToInt32(filteredRows[i]["BAG_NOS"]) + "\",\"CARTON QTY\": \"" + Convert.ToInt32(filteredRows[i]["SHIP_PER_PALLET"]) + "\"" +
										",\"LOADING BAY\": \"" + AppHttpContextAccessor.Loading_Bay + "\",\"ORDER\": \"1\",\"STATUS CODE\": \"10\"\r\n}");
								}

							}

							string jsonString = "[" + string.Join(",", listObj.ToArray()) + "]";

							StringContent? content = new StringContent(jsonString, null, "application/json");

							request.Content = content;

							var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

							if (webRequestResponse.IsSuccessStatusCode)
							{
								var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

								if (!string.IsNullOrEmpty(responseContent))
								{
									JToken objData = JObject.Parse(responseContent);

									if (objData != null && objData["Message"] != null
										&& JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["RESULT"].ToString() != "Success")
									{
										CommonViewModel.IsConfirm = false;
										CommonViewModel.IsSuccess = false;
										CommonViewModel.StatusCode = ResponseStatusCode.Error;
										CommonViewModel.Message = JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["REMARKS"].ToString();

										CommonViewModel.Data1 = "RequisitionWMS";

										return Json(CommonViewModel);
									}

								}

							}

						}
						catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

						oParams = new List<MySqlParameter>();

						oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
						oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
						oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Id });
						oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Prod_Sys_Id });
						oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarString) { Value = "" });
						oParams.Add(new MySqlParameter("P_LOADING_PROGRESS", MySqlDbType.VarString) { Value = "" });
						oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
						oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_REQUISITION_DATA_SAVE", oParams, true);

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = IsSuccess;
						CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
						CommonViewModel.Message = response;

						CommonViewModel.Data1 = "RequisitionWMS";

					}

					return Json(CommonViewModel);
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> BypassWMS(MDA_Dtls viewModel)
		{
			try
			{
				var objMDA = new MDA_Header();
				var listMDA_Dtls = new List<MDA_Dtls>();

				if (viewModel.GateInOut_Id > 0 && viewModel.Mda_Id > 0)
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
					{
						//_socketBackgroundTask.SendToPrinter(dt.Rows[0]["MDA_ORDER"].ToString(), dt.Rows[0]["PARTY_NAME"].ToString(), dt.Rows[0]["DESP_PLACE"].ToString());

						oParams = new List<MySqlParameter>();

						oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
						oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
						oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Id });
						oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Prod_Sys_Id });
						oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarString) { Value = viewModel.Reason });
						oParams.Add(new MySqlParameter("P_LOADING_PROGRESS", MySqlDbType.VarString) { Value = "" });
						oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
						oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_REQUISITION_DATA_SAVE", oParams, true);

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = IsSuccess;
						CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
						CommonViewModel.Message = response;

						CommonViewModel.Data1 = "BypassWMS";

						return Json(CommonViewModel);
					}

				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> StartLoading(MDA_Dtls viewModel)
		{
			try
			{
				var isRunning = false;

				var objMDA = new MDA_Header();
				var listMDA_Dtls = new List<MDA_Dtls>();

				if (viewModel != null && viewModel.GateInOut_Id > 0 && viewModel.Mda_Id > 0 && Common.IsUserLogged())
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
					{
						DataView dataView = dt.DefaultView;
						dataView.RowFilter = "GATE_SYS_ID = " + viewModel.GateInOut_Id + " AND MDA_SYS_ID = " + viewModel.Mda_Id;

						dt = dataView.ToTable();

						viewModel.Required_Shipper = dt.Rows[0]["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Required_Shipper"]) : 0;

						viewModel.Loaded_Shipper = dt.Rows[0]["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["Loaded_Shipper"]) : 0;

						if (viewModel.Required_Shipper > viewModel.Loaded_Shipper)
						{
							viewModel.Carton_Qty = dt.Rows[0]["REJECT_SHIPPER"] != DBNull.Value ? Convert.ToDecimal(dt.Rows[0]["REJECT_SHIPPER"]) : 0;

							IPAddress listenIP;
							int listenPort;

							string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_IP").Value ?? "");
							string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_Port").Value ?? "");

							if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
								&& IPAddress.TryParse(listenIPString, out listenIP) && int.TryParse(listenPortString, out listenPort) && listenPort > 0 && listenPort <= 65535)
							{
								_socketBackgroundTask.SetMDA(viewModel);

								var list = new List<ShipperBatch>();

								oParams = new List<MySqlParameter>();

								oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
								oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.VarString) { Value = viewModel.Mda_Id });
								oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.VarString) { Value = 0 });
								oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Prod_Sys_Id });

								dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_SHIPPER_QRCODE_HISTORY_GET_NEW", oParams, false);

								if (dt != null && dt.Rows.Count > 0)
									foreach (DataRow dr in dt.Rows)
										if ((dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0) > 0)
											list.Add(new ShipperBatch()
											{
												SrNo = dr["SrNo"] != DBNull.Value ? Convert.ToInt64(dr["SrNo"]) : 0,
												Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
												ShipperQRCode = dr["QRCODE"] != DBNull.Value ? Convert.ToString(dr["QRCODE"]) : "",
												Batch_no = dr["LOG_Type"] != DBNull.Value ? Convert.ToString(dr["LOG_Type"]) : ""
											});

								var requiredShipper = (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["REQUIRED_SHIPPER"] != DBNull.Value) ? Convert.ToInt64(dt.Rows[0]["REQUIRED_SHIPPER"]) : 0;
								var loaddedShipper = (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["LOADED_SHIPPER"] != DBNull.Value) ? Convert.ToInt64(dt.Rows[0]["LOADED_SHIPPER"]) : 0;
								var rejectShipper = (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["REJECT_SHIPPER"] != DBNull.Value) ? Convert.ToInt64(dt.Rows[0]["REJECT_SHIPPER"]) : 0;

								_sharedDataService.ClearScanData();

								if (dt != null && dt.Rows.Count > 0)
									_sharedDataService.AddOrUpdate(list.AsEnumerable().OrderBy(x => x.SrNo)
										.Select(x => (x.SrNo, x.ShipperQRCode, (x.Batch_no == "S" ? "OK" : "NOK"), x.Id, requiredShipper, loaddedShipper, rejectShipper)).ToList());

								isRunning = _socketBackgroundTask.IsRunning();

								////if (!isRunning) 
								//await _socketBackgroundTask.StartWork();

								//Thread.Sleep(Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "1") * 1000);

								Task.Run(() => _socketBackgroundTask.StartWork()).Wait();
							}
							else
							{
								CommonViewModel.IsConfirm = false;
								CommonViewModel.IsSuccess = false;
								CommonViewModel.StatusCode = ResponseStatusCode.Error;
								CommonViewModel.Message = "Enter listen's IP address and Port is invalid.";

								LogService.LogInsert(GetCurrentAction(), AppHttpContextAccessor.Loading_Bay + " : Enter listen's IP address and Port is invalid.", null);

								return Json(CommonViewModel);
							}

						}
						else
						{
							CommonViewModel.IsConfirm = true;
							CommonViewModel.IsSuccess = false;
							CommonViewModel.StatusCode = ResponseStatusCode.Error;
							CommonViewModel.Message = "MDA Loading Completed.";

							CommonViewModel.Data1 = "StartLoading";

							return Json(CommonViewModel);
						}
					}

					isRunning = _socketBackgroundTask.IsRunning();

					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = isRunning;
					CommonViewModel.StatusCode = CommonViewModel.IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = CommonViewModel.IsSuccess ? "Start Loading" : "Connectivity issue with Conveyor.";

					CommonViewModel.Data1 = "StartLoading";

					if (!CommonViewModel.IsSuccess)
						LogService.LogInsert(GetCurrentAction(), AppHttpContextAccessor.Loading_Bay + " : Connectivity issue with Conveyor.", null);

					return Json(CommonViewModel);

				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = Common.IsUserLogged() ? "Connectivity issue with Conveyor." : "Session has expired. Please log in first.";

			LogService.LogInsert(GetCurrentAction(), AppHttpContextAccessor.Loading_Bay + " : Connectivity issue with Conveyor.", null);

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> UpdateProgress(long seqNo = 0)
		{
			try
			{
				CommonViewModel.IsSuccess = true;
				CommonViewModel.StatusCode = ResponseStatusCode.Success;

				CommonViewModel.Data5 = _socketBackgroundTask.IsRunning();

				if (_socketBackgroundTask.IsRunning())
				{
					CommonViewModel.Data3 = _sharedDataService.GetScanData().OrderByDescending(x => x.Key).Select(x => new
					{
						No = x.Key,
						RequiredShipper = x.Value.requiredShipper
					}).FirstOrDefault();

					CommonViewModel.Data1 = _sharedDataService.GetScanData().Where(x => x.Key > seqNo).OrderBy(x => x.Key).Select(x => new
					{
						No = x.Key,
						Text = x.Value.qr_code,
						Success = x.Value.flag,
						Id = x.Value.id,
						RequiredShipper = x.Value.requiredShipper,
						LoaddedShipper = x.Value.loaddedShipper,
						RejectShipper = x.Value.rejectShipper
					}).ToList();
				}
				else
					CommonViewModel.Message = _socketBackgroundTask.ErrorMessage();

				try
				{
					if (_socketBackgroundTask.GetMDA() != null && CommonViewModel.Data1 != null
						&& Convert.ToString(CommonViewModel.Data1.Success) == "COMPLETED")
					{
						var oParams = new List<MySqlParameter>();

						oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().GateInOut_Id });
						oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().Mda_Id });
						oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().Id });
						oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().Prod_Sys_Id });
						oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarString) { Value = "" });
						oParams.Add(new MySqlParameter("P_LOADING_PROGRESS", MySqlDbType.VarString) { Value = "Completed" });
						oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
						oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_REQUISITION_DATA_SAVE", oParams, true);

					}
				}
				catch { }

				return Json(CommonViewModel);
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> StopProgress(bool IsStop = false)
		{
			try
			{
				//if (_socketBackgroundTask.IsRunning())
				_socketBackgroundTask.StopWork();

				//_sharedDataService.ClearScanData();

				Thread.Sleep(Convert.ToInt32(AppHttpContextAccessor.AppConfiguration.GetSection("MDA_QR_Scan_Delay_Sec").Value ?? "3") * 1000);

				CommonViewModel.IsConfirm = _socketBackgroundTask.IsRunning();

				CommonViewModel.IsSuccess = true;
				CommonViewModel.StatusCode = ResponseStatusCode.Success;

				CommonViewModel.Message = "Stop Loading";

				return Json(CommonViewModel);
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> StopLoading(MDA_Dtls viewModel)
		{
			try
			{
				//if (_socketBackgroundTask.IsRunning())
				_socketBackgroundTask.StopWork();

				var objMDA = new MDA_Header();
				var listMDA_Dtls = new List<MDA_Dtls>();

				if (viewModel.GateInOut_Id > 0 && viewModel.Mda_Id > 0)
				{

					//var client = new HttpClient();
					//var request = new HttpRequestMessage(HttpMethod.Post, $"{AppHttpContextAccessor.API_Url_WMS}/DeliveryOrder");

					//request.Headers.Add("Authorization", $"Basic {AppHttpContextAccessor.API_Authorization_WMS}");

					//try
					//{
					//	var loading_bay = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("LOADING_BAY").Value);

					//	List<string> listObj = new List<string>();

					//	foreach (DataRow dr in ds.Tables[0].Rows)
					//	{
					//		var mda_date = DateTime.ParseExact(dr["MDA_DT"].ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);

					//		DataRow[] filteredRows = ds.Tables[1].AsEnumerable().Where(row => row.Field<decimal>("ID") == viewModel.Id && row.Field<decimal>("MDA_ID") == viewModel.Mda_Id
					//		&& row.Field<decimal>("PROD_SYS_ID") == viewModel.Prod_Sys_Id).ToArray();

					//		for (int i = 0; i < filteredRows.Count(); i++)
					//		{
					//			listObj.Add("{\"TRUCK NO\": \"" + dr["VEHICLE_NO"] + "\",\"MDA NO\": \"" + dr["MDA_NO"] + "\",\"MDA DATE\": \"" + mda_date.ToString("yyyy-MM-dd") + " 00:00:00\"" +
					//				",\"DEL TYPE\": \"D\",\"SKU CODE\": \"" + filteredRows[i]["SKU_CODE"] + "\",\"SKU NAME\": \"" + filteredRows[i]["SKU_NAME"] + "\"" +
					//				",\"BOTTLE QTY\": \"" + filteredRows[i]["BAG_NOS"] + "\",\"CARTON QTY\": \"" + filteredRows[i]["SHIP_PER_PALLET"] + "\"" +
					//				",\"LOADING BAY\": \"" + loading_bay + "\",\"ORDER\": \"1\",\"STATUS CODE\": \"20\"" +
					//				",\"LOADING STATUS\": \"COMPLETED\",\"LOADED QTY\": \"" + filteredRows[i]["Loaded_Shipper"] + "\",\"SHORT QTY\":\"0\"" +
					//				",\"ADDITIONAL QTY\":\"0\", \"REASON\":\"_\"\r\n}");
					//		}

					//	}

					//	string jsonString = "[" + string.Join(",", listObj.ToArray()) + "]";

					//	StringContent? content = new StringContent(jsonString, null, "application/json");

					//	request.Content = content;

					//	var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

					//	if (webRequestResponse.IsSuccessStatusCode)
					//	{
					//		var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

					//		if (!string.IsNullOrEmpty(responseContent))
					//		{
					//			JToken objData = JObject.Parse(responseContent);

					//			if (objData != null && objData["Message"] != null
					//				&& JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["RESULT"].ToString() != "Success")
					//			{
					//				CommonViewModel.IsConfirm = false;
					//				CommonViewModel.IsSuccess = false;
					//				CommonViewModel.StatusCode = ResponseStatusCode.Error;
					//				CommonViewModel.Message = JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["REMARKS"].ToString();

					//				CommonViewModel.Data1 = "StopLoading";

					//				return Json(CommonViewModel);
					//			}

					//		}

					//	}

					//}
					//catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


					CommonViewModel.IsConfirm = true;
					CommonViewModel.IsSuccess = true;
					CommonViewModel.StatusCode = ResponseStatusCode.Success;
					CommonViewModel.Message = "Stop Loading";

					CommonViewModel.Data1 = "StopLoading";

					return Json(CommonViewModel);
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> FinishLoading(MDA_Dtls viewModel)
		{
			try
			{
				if (_socketBackgroundTask.IsRunning())
					_socketBackgroundTask.StopWork();

				//_sharedDataService.ClearScanData();

				var objMDA = new MDA_Header();
				var listMDA_Dtls = new List<MDA_Dtls>();

				if (viewModel.GateInOut_Id > 0 && viewModel.Mda_Id > 0)
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
					{
						var client = new HttpClient();
						var request = new HttpRequestMessage(HttpMethod.Post, $"{AppHttpContextAccessor.API_Url_WMS}/DeliveryOrder");

						request.Headers.Add("Authorization", $"Basic {AppHttpContextAccessor.API_Authorization_WMS}");

						try
						{
							List<string> listObj = new List<string>();

							foreach (DataRow dr in dt.Rows)
							{
								var mda_date = DateTime.ParseExact(dr["MDA_DT"].ToString(), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);

								DataRow[] filteredRows = dt.AsEnumerable().Where(row => row.Field<decimal>("ID") == viewModel.Id && row.Field<decimal>("MDA_ID") == viewModel.Mda_Id
								&& row.Field<decimal>("PROD_SYS_ID") == viewModel.Prod_Sys_Id).ToArray();

								for (int i = 0; i < filteredRows.Count(); i++)
								{
									listObj.Add("{\"TRUCK NO\": \"" + dr["VEHICLE_NO"] + "\",\"MDA NO\": \"" + dr["MDA_NO"] + "\",\"MDA DATE\": \"" + mda_date.ToString("yyyy-MM-dd") + " 00:00:00\"" +
										",\"DEL TYPE\": \"D\",\"SKU CODE\": \"" + filteredRows[i]["SKU_CODE"] + "\",\"SKU NAME\": \"" + filteredRows[i]["SKU_NAME"] + "\"" +
										",\"BOTTLE QTY\": \"" + filteredRows[i]["BAG_NOS"] + "\",\"CARTON QTY\": \"" + filteredRows[i]["SHIP_PER_PALLET"] + "\"" +
										",\"LOADING BAY\": \"" + AppHttpContextAccessor.Loading_Bay + "\",\"ORDER\": \"1\",\"STATUS CODE\": \"20\"" +
										",\"LOADING STATUS\": \"COMPLETED\",\"LOADED QTY\": \"" + filteredRows[i]["Loaded_Shipper"] + "\",\"SHORT QTY\":\"0\"" +
										",\"ADDITIONAL QTY\":\"0\", \"REASON\":\"_\"\r\n}");
								}

							}

							string jsonString = "[" + string.Join(",", listObj.ToArray()) + "]";

							StringContent? content = new StringContent(jsonString, null, "application/json");

							request.Content = content;

							var webRequestResponse = Task.Run(async () => await client.SendAsync(request)).Result;

							if (webRequestResponse.IsSuccessStatusCode)
							{
								var responseContent = Task.Run(async () => await webRequestResponse.Content.ReadAsStringAsync()).Result;

								if (!string.IsNullOrEmpty(responseContent))
								{
									JToken objData = JObject.Parse(responseContent);

									if (objData != null && objData["Message"] != null
										&& JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["RESULT"].ToString() != "Success")
									{
										CommonViewModel.IsConfirm = false;
										CommonViewModel.IsSuccess = false;
										CommonViewModel.StatusCode = ResponseStatusCode.Error;
										CommonViewModel.Message = JToken.Parse(((Newtonsoft.Json.Linq.JValue)objData["Message"]).Value.ToString())[0]["REMARKS"].ToString();

										CommonViewModel.Data1 = "FinishLoading";

										return Json(CommonViewModel);
									}

								}

							}

						}
						catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


						oParams = new List<MySqlParameter>();

						oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
						oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
						oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Id });
						oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Prod_Sys_Id });
						oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarString) { Value = viewModel.Reason });
						oParams.Add(new MySqlParameter("P_LOADING_PROGRESS", MySqlDbType.VarString) { Value = "Completed" });
						oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
						oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

						var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_REQUISITION_DATA_SAVE", oParams, true);

						CommonViewModel.IsConfirm = true;
						CommonViewModel.IsSuccess = IsSuccess;
						CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
						CommonViewModel.Message = response;


					}


					//CommonViewModel.IsConfirm = false;
					//CommonViewModel.IsSuccess = true;
					//CommonViewModel.StatusCode = ResponseStatusCode.Success;
					//CommonViewModel.Message = "";

					CommonViewModel.Data1 = "FinishLoading";

					return Json(CommonViewModel);
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public async Task<JsonResult> SendToPrinter(MDA_Dtls viewModel)
		{
			try
			{
				var objMDA = new MDA_Header();
				var listMDA_Dtls = new List<MDA_Dtls>();

				if (viewModel.GateInOut_Id > 0 && viewModel.Mda_Id > 0)
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = viewModel.GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Mda_Id });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
					{
						DataView dataView = dt.DefaultView;
						dataView.RowFilter = "GATE_SYS_ID = " + viewModel.GateInOut_Id + " AND MDA_SYS_ID = " + viewModel.Mda_Id;

						dt = dataView.ToTable();

						_socketBackgroundTask.SendToPrinter(dt.Rows[0]["MDA_ORDER"].ToString(), dt.Rows[0]["PARTY_NAME"].ToString(), dt.Rows[0]["desp_place"].ToString());

						CommonViewModel.IsConfirm = false;
						CommonViewModel.IsSuccess = true;
						CommonViewModel.StatusCode = ResponseStatusCode.Success;
						CommonViewModel.Message = "Send Data to printer";

						CommonViewModel.Data1 = "SendToPrinter";

						return Json(CommonViewModel);
					}
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsConfirm = false;
			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}



		[HttpGet]
		public IActionResult Check_QR_Code(long mda_id = 0, long mda_dtls_id = 0, long gatein_id = 0, long prod_id = 0, string qr_code = "")
		{
			try
			{
				_socketBackgroundTask.StopWork();

				if (gatein_id > 0 && mda_id > 0 && !string.IsNullOrEmpty(qr_code) && Common.IsUserLogged())
				{
					var PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);

					if (PLANT_ID <= 0) PLANT_ID = AppHttpContextAccessor.PlantId;

					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
					oParams.Add(new MySqlParameter("P_QR_CODE", MySqlDbType.VarString) { Value = qr_code });
					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = gatein_id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = mda_id });
					oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = mda_dtls_id });
					oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = prod_id });
					oParams.Add(new MySqlParameter("P_IS_MANUAL_SCAN", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = PLANT_ID });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SHIPPER_QRCODE_CHECK", oParams, true);

					long requiredShipper = Convert.ToInt64(response.Split("#")[1]);
					long loaddedShipper = Convert.ToInt64(response.Split("#")[2]);
					long rejectShipper = Convert.ToInt64(response.Split("#")[3]);

					response = response.Split("#")[0].ToString();

					CommonViewModel.IsConfirm = !IsSuccess;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;

					Console.WriteLine($"Response = {response}, RequiredShipper = {requiredShipper}, LoaddedShipper = {loaddedShipper}, RejectShipper = {rejectShipper}");

					CommonViewModel.Data1 = new
					{
						No = Id,
						Text = qr_code,
						Success = response,
						RequiredShipper = requiredShipper,
						LoaddedShipper = loaddedShipper,
						RejectShipper = rejectShipper
					};

					try
					{
						if (CommonViewModel.Data1 != null && requiredShipper <= loaddedShipper)
						{
							CommonViewModel.Data1.Success = "COMPLETED";

							oParams = new List<MySqlParameter>();

							oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().GateInOut_Id });
							oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().Mda_Id });
							oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().Id });
							oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = _socketBackgroundTask.GetMDA().Prod_Sys_Id });
							oParams.Add(new MySqlParameter("P_REASON", MySqlDbType.VarString) { Value = "" });
							oParams.Add(new MySqlParameter("P_LOADING_PROGRESS", MySqlDbType.VarString) { Value = "Completed" });
							oParams.Add(new MySqlParameter("P_LOADING_BAY", MySqlDbType.VarString) { Value = AppHttpContextAccessor.Loading_Bay });
							oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

							(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_MDA_REQUISITION_DATA_SAVE", oParams, true);

						}
					}
					catch { }

					return Json(CommonViewModel);
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = Common.IsUserLogged() ? ResponseStatusMessage.Error : "Session has expired. Please log in first.";

			return Json(CommonViewModel);
		}

		[HttpGet]
		public IActionResult Get_Scan_Code_History(long mda_id = 0, long mda_dtls_id = 0, long gatein_id = 0, long prod_id = 0)
		{
			_sharedDataService.ClearScanData();

			var list = new List<ShipperBatch>();

			long requiredShipper = 0;
			long loaddedShipper = 0;
			long rejectShipper = 0;

			if (gatein_id > 0 && mda_id > 0 && Common.IsUserLogged())
			{
				try
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = gatein_id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.VarString) { Value = mda_id });
					oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.VarString) { Value = mda_dtls_id });
					oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = prod_id });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_SHIPPER_QRCODE_HISTORY_GET_NEW", oParams, false);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							if ((dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0) > 0)
								list.Add(new ShipperBatch()
								{
									SrNo = dr["SrNo"] != DBNull.Value ? Convert.ToInt64(dr["SrNo"]) : 0,
									Id = dr["Id"] != DBNull.Value ? Convert.ToInt64(dr["Id"]) : 0,
									ShipperQRCode = dr["QRCODE"] != DBNull.Value ? Convert.ToString(dr["QRCODE"]) : "",
									Batch_no = dr["LOG_Type"] != DBNull.Value ? Convert.ToString(dr["LOG_Type"]) : ""
								});

					requiredShipper = (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["REQUIRED_SHIPPER"] != DBNull.Value) ? Convert.ToInt64(dt.Rows[0]["REQUIRED_SHIPPER"]) : 0;
					loaddedShipper = (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["LOADED_SHIPPER"] != DBNull.Value) ? Convert.ToInt64(dt.Rows[0]["LOADED_SHIPPER"]) : 0;
					rejectShipper = (dt != null && dt.Rows.Count > 0 && dt.Rows[0]["REJECT_SHIPPER"] != DBNull.Value) ? Convert.ToInt64(dt.Rows[0]["REJECT_SHIPPER"]) : 0;

					if (dt != null && dt.Rows.Count > 0)
						_sharedDataService.AddOrUpdate(list.AsEnumerable().OrderBy(x => x.SrNo)
							.Select(x => (x.SrNo, x.ShipperQRCode, (x.Batch_no == "S" ? "OK" : "NOK"), x.Id, requiredShipper, loaddedShipper, rejectShipper)).ToList());

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
			}

			list = list == null ? new List<ShipperBatch>() : list;

			return Json(new
			{
				No = list != null && list.Count() > 0 ? list.Max(x => x.SrNo) : 0,
				RequiredShipper = requiredShipper,
				LoaddedShipper = loaddedShipper,
				RejectShipper = rejectShipper,
				DataList = list,
				DataLast = new { No = list != null && list.Count() > 0 ? list.Max(x => x.SrNo) : 0, RequiredShipper = requiredShipper }
			});
		}

		[HttpGet]
		public IActionResult Delete_QR_Code(string qr_code = null, string qr_code_type = null, long mda_id = 0, long gatein_id = 0, long prod_id = 0, long id = 0)
		{
			long requiredShipper = 0;
			long loaddedShipper = 0;
			long rejectShipper = 0;

			try
			{
				if (gatein_id > 0 && mda_id > 0 && !string.IsNullOrEmpty(qr_code) && Common.IsUserLogged())
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = gatein_id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = mda_id });
					oParams.Add(new MySqlParameter("P_MDA_DTL_SYS_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PROD_SYS_ID", MySqlDbType.Int64) { Value = prod_id });

					oParams.Add(new MySqlParameter("P_QR_CODE_ID", MySqlDbType.Int64) { Value = id });
					oParams.Add(new MySqlParameter("P_QR_CODE_TYPE", MySqlDbType.VarString) { Value = qr_code_type });
					oParams.Add(new MySqlParameter("P_QR_CODE", MySqlDbType.VarString) { Value = qr_code });

					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_SHIPPER_QRCODE_DELETE_NEW", oParams, true);

					requiredShipper = response.Contains('#') ? Convert.ToInt64(response.Split("#")[1]) : 0;
					loaddedShipper = response.Contains('#') ? Convert.ToInt64(response.Split("#")[2]) : 0;
					rejectShipper = response.Contains('#') ? Convert.ToInt64(response.Split("#")[3]) : 0;

					response = response.Contains('#') ? response.Split("#")[0].ToString() : response;

					CommonViewModel.IsConfirm = !IsSuccess;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response;

					CommonViewModel.Data1 = new
					{
						RequiredShipper = requiredShipper,
						LoaddedShipper = loaddedShipper,
						RejectShipper = rejectShipper
					};

					return Json(CommonViewModel);

					//CommonViewModel.IsSuccess = true;
					//CommonViewModel.StatusCode = ResponseStatusCode.Success;
					//CommonViewModel.Message = ResponseStatusMessage.Success;

					//return Json(CommonViewModel);
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = Common.IsUserLogged() ? ResponseStatusMessage.Error : "Session has expired. Please log in first.";

			return Json(CommonViewModel);
		}

		[HttpGet]
		public IActionResult RemoveShipperFromTestMDA()
		{
			try { DataContext.ExecuteStoredProcedure_SQL("PC_REMOVE_SHIPPER_FROM_TEST_MDA", null, false); } catch (Exception ex) { }

			return Json(null);
		}

	}
}
