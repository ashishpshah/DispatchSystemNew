using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Export.Controllers
{
    [Area("Export")]
	public class GateOutController : BaseController<ResponseModel<GateIn>>
	{
		#region Loading
		public IActionResult Index()
		{
			return View(CommonViewModel);
		}

		#endregion

		#region Methods

		[HttpGet]
		public IActionResult GetMDA(string type, string searchTerm)
		{
			var list = new List<GateIn>();

			try
			{
				DataTable dt = new DataTable();

				var oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = string.IsNullOrEmpty(type) || type != "V" ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarChar) { Value = "Y" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_EXP_GATE_OUT_GET", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new GateIn()
						{
							Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt64(dr["Sr_No"]) : 0,
							Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
							Truck_No = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
							Common_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
							Common_Sys_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
							//Common_Date = dr["ORDER_DATE"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["ORDER_DATE"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture).ToString() : "",
							Plant_Id = dr["Plant_Id"] != DBNull.Value ? Convert.ToInt64(dr["Plant_Id"]) : 0,
							Plant_CD = dr["PLANT_CD"] != DBNull.Value ? Convert.ToString(dr["PLANT_CD"]) : "",
							Gate_In_Dt = dr["GATE_IN_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_IN_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Driver_Name = dr["Driver_Name"] != DBNull.Value ? Convert.ToString(dr["Driver_Name"]) : "",
							Driver_Contact = dr["Driver_Contact"] != DBNull.Value ? Convert.ToString(dr["Driver_Contact"]) : "",
							Transporter_Name = dr["TRANS_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANS_NAME"]) : "",
							Driver_Id_Type = dr["Driver_Id_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Type_Text"]) : "",
							Driver_Id_Number = dr["Driver_Id_Number"] != DBNull.Value ? Convert.ToString(dr["Driver_Id_Number"]) : "",
							Tare_Wt = dr["WEIGH_IN_WT"] != DBNull.Value ? Convert.ToDouble(dr["WEIGH_IN_WT"]) : 0,
							Tare_Wt_Dt = dr["WEIGH_IN_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGH_IN_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Gross_Wt = dr["WEIGH_OUT_WT"] != DBNull.Value ? Convert.ToDouble(dr["WEIGH_OUT_WT"]) : 0,
							Gross_Wt_Dt = dr["WEIGH_OUT_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["WEIGH_OUT_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
							Net_Wt = dr["NET_WT"] != DBNull.Value ? Convert.ToDouble(dr["NET_WT"]) : 0,
							Expected_Shipper = dr["Expected_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Expected_Shipper"]) : 0,
							Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToInt32(dr["Loaded_Shipper"]) : 0
						});

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S" && list.Count == 1) return Json(list.FirstOrDefault());
				else return PartialView("_Partial_MDA", list);
			else return Json(null);
			//return PartialView("_Partial_MDA", list);
		}

		#endregion

		#region Events

		[HttpPost]
		public IActionResult Save(GateIn viewModel)
		{
			try
			{
				if (viewModel.Id <= 0)
				{
					CommonViewModel.Message = "Please select valid Gate In data.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Common_No))
				{
					CommonViewModel.Message = "Please select valid MDA data.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				List<(long MDA_Id, string MDA_No, string Invoice_QR_Code, string Invoice_QR_Code_Base64)>
					listInvoice = new List<(long MDA_Id, string MDA_No, string Invoice_QR_Code, string Invoice_QR_Code_Base64)>();

				DataTable dt = DataContext.ExecuteQuery_SQL("SELECT DISTINCT PLANT_ID, GATE_SYS_ID, VEHICLE_NO, MDA_SYS_ID, MDA_NO " +
					"FROM vw_get_gate_in_mda_id " +
					"WHERE PLANT_ID = " + Common.Get_Session_Int(SessionKey.PLANT_ID) + " " +
					"AND COALESCE(CANCEL_GATE_IN, 0) = 0 " +
					"AND GATE_OUT_DT IS NULL AND OUT_TIME IS NULL " +
					"AND GATE_SYS_ID = " + viewModel.Id);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						string MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "";
						long MDA_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0;

						var invoiceNo = "00" + MDA_No + DateTime.Now.ToString("yyMMddHHmmssfffff");

						string base64String = Common.GenerateQrCodeBase64_ZXing((AppHttpContextAccessor.Invoice_QR_Image_URL_Domain.EndsWith("/")
							? AppHttpContextAccessor.Invoice_QR_Image_URL_Domain : AppHttpContextAccessor.Invoice_QR_Image_URL_Domain + "/") + invoiceNo);

						listInvoice.Add((MDA_Id, MDA_No, invoiceNo, base64String));

						Thread.Sleep(1000);
					}
				}

				var invoiceQrCode = listInvoice == null ? "" : string.Join(",", listInvoice.Select(x => x.MDA_Id + "|" + x.Invoice_QR_Code).ToArray());

				var invoiceQrCode_Base64String = listInvoice == null ? "" : string.Join(",", listInvoice.Select(x => x.MDA_Id + "|" + x.Invoice_QR_Code_Base64).ToArray());

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = viewModel.Common_Sys_Id });
				oParams.Add(new MySqlParameter("P_GATE_OUT_NOTE", MySqlDbType.VarChar) { Value = viewModel.Gate_Out_Note });
				oParams.Add(new MySqlParameter("P_INVOICE_QR_CODE", MySqlDbType.LongText) { Value = invoiceQrCode });
				oParams.Add(new MySqlParameter("P_BASE64_INVOICE_QR_CODE", MySqlDbType.LongText) { Value = invoiceQrCode_Base64String });

				oParams.Add(new MySqlParameter("P_STATION_ID", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_EXP_GATE_OUT_SAVE", oParams, true);

				//if (IsSuccess == true && AppHttpContextAccessor.IsSendInvoiceQRToCloud == true)
				//{
				//	var client = new HttpClient();

				//	if (listInvoice != null && listInvoice.Count() > 0)
				//	{
				//		foreach (var item in listInvoice)
				//		{
				//			try
				//			{
				//				string strContent = "{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31004\"" +
				//					",\"inParameters\" : [{ \"label\" : \"mdaNo\", \"value\" : \"" + item.MDA_No.ToUpper() + "\" }" +
				//										",{ \"label\" : \"invoiceQrCode\", \"value\" : \"" + item.Invoice_QR_Code.ToUpper() + "\" }" +
				//										",{ \"label\" : \"base64InvQrCode\", \"value\" : \"" + item.Invoice_QR_Code_Base64 + "\" }" +
				//										"]}\n\n";

				//				LogService.LogInsert("Gate Out Save", $"Invoice QR API Call (Gate In Id : {viewModel.Id}) => Content : {strContent}");

				//				var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

				//				StringContent? content = new StringContent(strContent, null, "application/json");

				//				request.Content = content;

				//				request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

				//				var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

				//				LogService.LogInsert("Gate Out Save", $"Invoice QR API Call (Gate In Id : {viewModel.Id}) => Result : {responseBody.IsSuccessStatusCode}");

				//				try
				//				{
				//					LogService.LogInsert("Gate Out Save", $"Invoice QR API Call (Gate In Id : {viewModel.Id}) => Response : {Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result}");
				//				}
				//				catch { }

				//				//var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url);

				//				//StringContent? content = content = new StringContent("{\"token\" : \"3369708919812376\",\"serviceID\" : \"31004\"" +
				//				//	",\"mdaNo\" : \"" + item.MDA_No.ToUpper() + "\",\"invoiceQrCode\" : \"" + item.Invoice_QR_Code + "\"" +
				//				//	",\"base64InvQrCode\" : \"" + item.Invoice_QR_Code_Base64 + "\"}", null, "application/json");

				//				//request.Content = content;

				//				//var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

				//				//if (responseBody.IsSuccessStatusCode)
				//				//{
				//				//	var responseContent = Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result;

				//				//	if (!string.IsNullOrEmpty(responseContent) && responseContent.Contains("PostNanoMDAInvoiceQR"))
				//				//	{

				//				//	}
				//				//}

				//				Thread.Sleep(1000);
				//			}
				//			catch (Exception ex)
				//			{
				//				listInvoice.RemoveAll(x => x.MDA_No == item.MDA_No);
				//			}
				//		}
				//	}
				//}

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				//CommonViewModel.Message = IsSuccess ? $"Gate Out completed successfully for truck number {viewModel.Truck_No} for finished goods." +
				//	$"{System.Environment.NewLine}MDA No. : {(listInvoice == null ? "" : string.Join(", ", listInvoice.Select(x => x.MDA_No).ToArray()))}" +
				//	$"{System.Environment.NewLine}Invoice QR Code : {System.Environment.NewLine} " +
				//	$"{(listInvoice == null ? "" : string.Join($", {System.Environment.NewLine}", listInvoice.Select(x => x.Invoice_QR_Code).ToArray()))}" : response;
				CommonViewModel.Message = response;

				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

				//if (IsSuccess)
				//{
				//	List<(long Gate_In_Out_Id, long MDA_Id)> listId = new List<(long Gate_In_Out_Id, long MDA_Id)>();

				//	if (dt != null && dt.Rows.Count > 0)
				//		foreach (DataRow dr in dt.Rows)
				//			listId.Add((dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0, dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0));

				//	if (listId != null && listId.Count() > 0)
				//	{
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("FG_GATE_IN_OUT", listId.Select(x => x.Gate_In_Out_Id).ToList(), null));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("FG_WEIGHMENT_DETAIL", listId.Select(x => x.Gate_In_Out_Id).ToList(), null));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_HEADER", null, listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_DETAIL", null, listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_LOADING", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_REQUISITION_DATA", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_SEQUENCE", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_INVOICE_QR", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_ADD_QTY_REQUEST", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
				//		Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_LOADING", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
				//	}
				//}

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

		public IActionResult GenerateInvoice(string mdaNo = null)
		{
			try
			{
				if (string.IsNullOrEmpty(mdaNo))
				{
					CommonViewModel.Message = "Please enter valid MDA no.";
					CommonViewModel.IsSuccess = false;
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				List<(long Gate_Id, long MDA_Id, string MDA_No, string Invoice_QR_Code, string Invoice_QR_Code_Base64)>
					listInvoice = new List<(long Gate_Id, long MDA_Id, string MDA_No, string Invoice_QR_Code, string Invoice_QR_Code_Base64)>();

				DataTable dt = DataContext.ExecuteQuery_SQL("With TBL_MAIN AS (select gio.PLANT_ID, gio.GATE_SYS_ID, gio.TRUCK_NO AS VEHICLE_NO " +
								", mh.MDA_SYS_ID, mh.MDA_NO, mh.MDA_DT, gio.GATE_IN_DT, gio.GATE_OUT_DT " +
								"from fg_gate_in_out gio " +
								"join mda_header mh on gio.PLANT_ID = mh.PLANT_ID and find_in_set(mh.MDA_SYS_ID, gio.MDA_SYS_IDS) > 0 " +
								"left join mda_detail md on md.PLANT_ID = mh.PLANT_ID and md.MDA_SYS_ID = mh.MDA_SYS_ID " +
								"WHERE(MH.MDA_NO = '" + mdaNo + "' OR gio.TRUCK_NO = '" + mdaNo + "') AND IFNULL(CANCEL_GATE_IN, 0) = 0 " +
								") SELECT X.PLANT_ID, X.GATE_SYS_ID, VEHICLE_NO, MDA_SYS_ID, MDA_NO, MDA_DT, GATE_IN_DT, DATE_FORMAT(X.GATE_OUT_DT, '%d/%m/%Y %H:%i') AS GATE_OUT_DT " +
								"FROM TBL_MAIN X " +
								//"WHERE 0 = (SELECT COUNT(*) FROM mda_invoice_qr Z " +
								//"WHERE Z.GATE_SYS_ID = X.GATE_SYS_ID AND Z.MDA_SYS_ID = X.MDA_SYS_ID) " +
								"");

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						string MDA_No = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "";
						long MDA_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0;
						long Gate_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0;
						string gate_out_Dt = dr["GATE_OUT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["GATE_OUT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture).ToString("yyMMddHHmmssfffff") : DateTime.Now.ToString("yyMMddHHmmssfffff");
						var invoiceNo = "00" + MDA_No + gate_out_Dt;

						string base64String = Common.GenerateQrCodeBase64_ZXing((AppHttpContextAccessor.Invoice_QR_Image_URL_Domain.EndsWith("/")
							? AppHttpContextAccessor.Invoice_QR_Image_URL_Domain : AppHttpContextAccessor.Invoice_QR_Image_URL_Domain + "/") + invoiceNo);

						listInvoice.Add((Gate_Id, MDA_Id, MDA_No, invoiceNo, base64String));

						Thread.Sleep(1000);
					}
				}

				var invoiceQrCode = listInvoice == null ? "" : string.Join(",", listInvoice.Select(x => x.MDA_Id + "|" + x.Invoice_QR_Code).ToArray());

				var invoiceQrCode_Base64String = listInvoice == null ? "" : string.Join(",", listInvoice.Select(x => x.MDA_Id + "|" + x.Invoice_QR_Code_Base64).ToArray());

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_GATE_IN_OUT_ID", MySqlDbType.Int64) { Value = listInvoice.Select(x => x.Gate_Id).FirstOrDefault() });
				oParams.Add(new MySqlParameter("P_MDA_SYS_ID", MySqlDbType.Int64) { Value = listInvoice.Select(x => x.MDA_Id).FirstOrDefault() });
				oParams.Add(new MySqlParameter("P_INVOICE_QR_CODE", MySqlDbType.LongText) { Value = invoiceQrCode });
				oParams.Add(new MySqlParameter("P_BASE64_INVOICE_QR_CODE", MySqlDbType.LongText) { Value = invoiceQrCode_Base64String });

				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_INVOICE_QR_SAVE", oParams, true);

				if (IsSuccess == true && AppHttpContextAccessor.IsSendInvoiceQRToCloud == true)
				{
					var client = new HttpClient();

					if (listInvoice != null && listInvoice.Count() > 0)
					{
						foreach (var item in listInvoice)
						{
							try
							{
								string strContent = "{ \"token\" : \"8548528525568856\",\"serviceID\" : \"31004\"" +
									",\"inParameters\" : [{ \"label\" : \"mdaNo\", \"value\" : \"" + item.MDA_No.ToUpper() + "\" }" +
														",{ \"label\" : \"invoiceQrCode\", \"value\" : \"" + item.Invoice_QR_Code.ToUpper() + "\" }" +
														",{ \"label\" : \"base64InvQrCode\", \"value\" : \"" + item.Invoice_QR_Code_Base64 + "\" }" +
														"]}\n\n";

								LogService.LogInsert($"Generate Invoice {mdaNo}", $"Invoice QR API Call (Gate In Id : {item.Gate_Id}) => Content : {strContent}");

								var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

								StringContent? content = new StringContent(strContent, null, "application/json");

								request.Content = content;

								request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

								var responseBody = Task.Run(async () => await client.SendAsync(request)).Result;

								LogService.LogInsert($"Generate Invoice {mdaNo}", $"Invoice QR API Call (Gate In Id : {item.Gate_Id}) => Result : {responseBody.IsSuccessStatusCode}");

								try
								{
									LogService.LogInsert($"Generate Invoice {mdaNo}", $"Invoice QR API Call (Gate In Id : {item.Gate_Id}) => Response : {Task.Run(async () => await responseBody.Content.ReadAsStringAsync()).Result}");
								}
								catch { }

								Thread.Sleep(1000);
							}
							catch (Exception ex)
							{
								listInvoice.RemoveAll(x => x.MDA_No == item.MDA_No);
							}
						}
					}
				}

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

				CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

				if (IsSuccess)
				{
					List<(long Gate_In_Out_Id, long MDA_Id)> listId = new List<(long Gate_In_Out_Id, long MDA_Id)>();

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							listId.Add((dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0, dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0));

					if (listId != null && listId.Count() > 0)
					{
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("FG_GATE_IN_OUT", listId.Select(x => x.Gate_In_Out_Id).ToList(), null));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("FG_WEIGHMENT_DETAIL", listId.Select(x => x.Gate_In_Out_Id).ToList(), null));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_HEADER", null, listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_DETAIL", null, listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_LOADING", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_REQUISITION_DATA", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_SEQUENCE", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_INVOICE_QR", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_ADD_QTY_REQUEST", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
						Task.Run(async () => await DataContext.SyncData_LocalToCloud("MDA_LOADING", listId.Select(x => x.Gate_In_Out_Id).ToList(), listId.Select(x => x.MDA_Id).ToList()));
					}
				}

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
