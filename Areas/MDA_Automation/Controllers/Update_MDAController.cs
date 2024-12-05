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
	public class Update_MDAController : BaseController<ResponseModel<MDA>>
	{
		public Update_MDAController()
		{

		}

		public IActionResult Index()
		{
			return View();
		}

		[HttpGet]
		public IActionResult GetMDA(string type, string searchTerm)
		{
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
							tptr_name = dr["tptr_name"] != DBNull.Value ? Convert.ToString(dr["tptr_name"]) : "",
							mda_order = dr["MDA_ORDER"] != DBNull.Value ? Convert.ToInt32(dr["MDA_ORDER"]) : 0
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
			var objMDA = new MDA_Header();
			var listMDA_Dtls = new List<MDA_Dtls>();

			try
			{
				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = MDA_Id });
				oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
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

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						if (MDA_Id == 0 || (MDA_Id > 0 && MDA_Id == (dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0)))
							listMDA_Dtls.Add(new MDA_Dtls()
							{
								Id = dr["MDA_DTL_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_DTL_SYS_ID"]) : 0,
								Mda_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
								Vehicle_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
								GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
								Mda_No = dr["Mda_No"] != DBNull.Value ? Convert.ToString(dr["Mda_No"]) : "",
								Prod_Sno = dr["PROD_SNO"] != DBNull.Value ? Convert.ToInt64(dr["PROD_SNO"]) : 0,
								//Mda_Dt = dr["Mda_Dt"] != DBNull.Value ? Convert.ToDateTime(dr["Mda_Dt"]) : nullDateTime,
								Mda_Dt = dr["Mda_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["Mda_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
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
		public IActionResult Check_MDA_Update(long GateInOut_Id = 0, bool isConfirm_Update = false)
		{
			var isUpdate = false;

			if (GateInOut_Id > 0)
			{
				var objMDA = new MDA_Header();
				//var listMDA_Dtls = new List<MDA_Dtls>();

				try
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_GATE_SYS_ID", MySqlDbType.Int64) { Value = GateInOut_Id });
					oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_SearchTerm", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOAD_MDA_GET_NEW", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
						{
							if (isUpdate == false || isConfirm_Update == true)
							{
								objMDA = new MDA_Header()
								{
									Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
									GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
									Trans_Sys_Id = dr["TRANS_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["TRANS_SYS_ID"]) : 0,
									Vehicle_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
									Mda_No = dr["MDA_No"] != DBNull.Value ? Convert.ToString(dr["MDA_No"]) : "",
									Plant_Cd = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
									//Mda_Dt = dr["MDA_DT"] != DBNull.Value ? Convert.ToString(dr["MDA_DT"]) : "",
									Driver = dr["DRIVER_NAME"] != DBNull.Value ? Convert.ToString(dr["DRIVER_NAME"]) : "",
									Mobile_No = dr["DRIVER_CONTACT"] != DBNull.Value ? Convert.ToString(dr["DRIVER_CONTACT"]) : "",
									Wh_Cd = dr["Wh_Cd"] != DBNull.Value ? Convert.ToString(dr["Wh_Cd"]) : "",
									Party_Name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
									tptr_cd = dr["tptr_cd"] != DBNull.Value ? Convert.ToString(dr["tptr_cd"]) : "",
									tptr_name = dr["tptr_name"] != DBNull.Value ? Convert.ToString(dr["tptr_name"]) : "",
									Desp_Place = dr["DESP_PLACE"] != DBNull.Value ? Convert.ToString(dr["DESP_PLACE"]) : "",
									Bag_Nos = dr["Bag_Nos"] != DBNull.Value ? Convert.ToDecimal(dr["Bag_Nos"]) : 0,
									Nett_Qty = dr["Nett_Qty"] != DBNull.Value ? Convert.ToDecimal(dr["Nett_Qty"]) : 0,
									Gross_Qty = dr["Gross_Qty"] != DBNull.Value ? Convert.ToDecimal(dr["Gross_Qty"]) : 0,
									Dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0
								};

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
												if (objMDA_Header["BAG_NOS"] != null && ((JValue)objMDA_Header["BAG_NOS"]).Value != null
													&& Convert.ToInt32(((JValue)objMDA_Header["BAG_NOS"]).Value).ToString().Trim() != objMDA.Bag_Nos.ToString())
													isUpdate = true;

												if (objMDA_Header["NETT_QTY"] != null && ((JValue)objMDA_Header["NETT_QTY"]).Value != null
													&& Convert.ToInt32(((JValue)objMDA_Header["NETT_QTY"]).Value).ToString().Trim() != objMDA.Nett_Qty.ToString())
													isUpdate = true;

												if (objMDA_Header["GROSS_QTY"] != null && ((JValue)objMDA_Header["GROSS_QTY"]).Value != null
													&& Convert.ToInt32(((JValue)objMDA_Header["GROSS_QTY"]).Value).ToString().Trim() != objMDA.Gross_Qty.ToString())
													isUpdate = true;

												if (objMDA_Header["TPTR_CD"] != null && ((JValue)objMDA_Header["TPTR_CD"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["TPTR_CD"]).Value).ToString().Trim() != objMDA.tptr_cd.ToString())
													isUpdate = true;

												if (objMDA_Header["TPTR_NAME"] != null && ((JValue)objMDA_Header["TPTR_NAME"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["TPTR_NAME"]).Value).ToString().ToUpper().Trim() != objMDA.tptr_name.ToUpper().ToString())
													isUpdate = true;

												if (objMDA_Header["WH_CD"] != null && ((JValue)objMDA_Header["WH_CD"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["WH_CD"]).Value).ToString().ToUpper().Trim() != objMDA.Wh_Cd.ToUpper().ToString())
													isUpdate = true;

												if (objMDA_Header["PARTY_NAME"] != null && ((JValue)objMDA_Header["PARTY_NAME"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["PARTY_NAME"]).Value).ToString().ToUpper().Trim() != objMDA.Party_Name.ToUpper().ToString())
													isUpdate = true;

												if (objMDA_Header["DRIVER"] != null && ((JValue)objMDA_Header["DRIVER"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["DRIVER"]).Value).ToString().ToUpper().Trim() != objMDA.Driver.ToUpper().ToString())
													isUpdate = true;

												if (objMDA_Header["MOBILE_NO"] != null && ((JValue)objMDA_Header["MOBILE_NO"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["MOBILE_NO"]).Value).ToString().ToUpper().Trim() != objMDA.Mobile_No.ToUpper().ToString())
													isUpdate = true;

												if (objMDA_Header["DESP_PLACE"] != null && ((JValue)objMDA_Header["DESP_PLACE"]).Value != null
													&& Convert.ToString(((JValue)objMDA_Header["DESP_PLACE"]).Value).ToString().ToUpper().Trim() != objMDA.Desp_Place.ToUpper().ToString())
													isUpdate = true;

												if (objMDA_Header["DIST"] != null && ((JValue)objMDA_Header["DIST"]).Value != null
													&& Convert.ToInt32(((JValue)objMDA_Header["DIST"]).Value).ToString().Trim() != objMDA.Dist.ToString())
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
																oParams = new List<MySqlParameter>();

																oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = objMDA.Id });

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
						}

				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }


			}

			CommonViewModel.IsConfirm = true;
			CommonViewModel.IsSuccess = isUpdate;
			CommonViewModel.StatusCode = ResponseStatusCode.Success;

			CommonViewModel.Message = isUpdate && isConfirm_Update == false ? "Do you want to update MDA details ?" : "No any change in MDA.";
			CommonViewModel.RedirectURL = isUpdate ? Url.Content("~/") + GetCurrentControllerUrl() + "/Check_MDA_Update?GateInOut_Id=" + GateInOut_Id + "&isConfirm_Update=true" : "";

			return Json(CommonViewModel);
		}

	}
}
