using Dispatch_System.Controllers;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using MySql.Data.MySqlClient;
using Newtonsoft.Json.Linq;
using Oracle.ManagedDataAccess.Client;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Export.Controllers
{
	[Area("Export")]
	public class InvoiceController : BaseController<ResponseModel<Pallate>>
	{
		public IActionResult Index()
		{
			return View();
		}

		[HttpGet]
		public IActionResult GetInvoice(string searchTerm, JqueryDatatableParam param = null, bool IsDataTable = false)
		{
			var iTotalRecords = 0;

			var list = new List<dynamic>();

			try
			{
				if (IsDataTable == false)
				{
					var client = new HttpClient();

					var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

					request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

					var content = new StringContent("{\"serviceID\":\"8003\",\"token\":\"8548528525568856\", \"inParameters\": " +
						"[{\"label\": \"P_INVOICE_NO\",\"value\": \"" + searchTerm + "\"}]}", null, "application/json");

					request.Content = content;
					var response = Task.Run(async () => await client.SendAsync(request)).Result;
					response.EnsureSuccessStatusCode();

					if (response.IsSuccessStatusCode)
					{
						var responseContent = Task.Run(async () => await response.Content.ReadAsStringAsync()).Result;

						if (!string.IsNullOrEmpty(responseContent))
						{
							JArray jsonArray = JArray.Parse(responseContent);

							foreach (JObject item in jsonArray)
							{
								try
								{
									list.Add(new
									{
										Invoice_No = item["Invoice NO"] != null ? Convert.ToString(item["Invoice NO"]) : "",
										Invoice_Date = item["Invoice date"] != null ? DateTime.Parse(Convert.ToString(item["Invoice date"])).ToString("dd/MM/yyyy").Replace("-", "/") : null,
										Order_Ref_No = item["Order Ref NO"] != null ? Convert.ToString(item["Order Ref NO"]) : "",
										Order_Ref_Date = item["Order Ref date"] != null ? DateTime.Parse(Convert.ToString(item["Order Ref date"])).ToString("dd/MM/yyyy").Replace("-", "/") : null,
										Performa_Invoice_No = item["Performa invoice No"] != null ? Convert.ToString(item["Performa invoice No"]) : "",
										Performa_Invoice_Date = item["Performa invoice date"] != null ? DateTime.Parse(Convert.ToString(item["Performa invoice date"])).ToString("dd/MM/yyyy").Replace("-", "/") : null,
										Indent_No = item["Indent No"] != null ? Convert.ToString(item["Indent No"]) : "",
										Plant_MDA_No = item["PLANT_MDA_NO"] != null ? Convert.ToString(item["PLANT_MDA_NO"]) : "",
										Port_Loading = item["Port of loading"] != null ? Convert.ToString(item["Port of loading"]) : "",
										Port_Discharge = item["Port of discharge"] != null ? Convert.ToString(item["Port of discharge"]) : "",
										Carrier = item["carrier"] != null ? Convert.ToString(item["carrier"]) : "",
										Sailing = item["sailing or about detail"] != null ? Convert.ToString(item["sailing or about detail"]) : "",
										Country = item["country of origin"] != null ? Convert.ToString(item["country of origin"]) : "",
										Incoterms2020 = item["incoterms2020"] != null ? Convert.ToString(item["incoterms2020"]) : "",
										Marks_No_Packing = item["Marks and No of Packing"] != null ? Convert.ToString(item["Marks and No of Packing"]) : "",
										Product_Desc = item["Product Description"] != null ? Convert.ToString(item["Product Description"]) : "",
										HSN_Code = item["HSN code"] != null ? Convert.ToString(item["HSN code"]) : "",
										Qty = item["Qty"] != null ? Convert.ToString(item["Qty"]) : ""
									});
								}
								catch { continue; }
							}
						}
					}
				}
				else
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = "" });
					oParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.VarString) { Value = param.sSearch ?? "" });
					oParams.Add(new MySqlParameter("P_DISPLAY_LENGTH", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_DISPLAY_START", MySqlDbType.Int64) { Value = 0 });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

					DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_EXP_INVOICE_GET", oParams);

					if (dt != null && dt.Rows.Count > 0)
						foreach (DataRow dr in dt.Rows)
							try
							{
								list.Add(new
								{
									Invoice_No = dr["Invoice_No"] != DBNull.Value ? Convert.ToString(dr["Invoice_No"]) : "",
									Invoice_Date = dr["Invoice_Date"] != DBNull.Value ? Convert.ToString(dr["Invoice_Date"]) : "",
									Order_Ref_No = dr["Order_Ref_No"] != DBNull.Value ? Convert.ToString(dr["Order_Ref_No"]) : "",
									Order_Ref_Date = dr["Order_Ref_Date"] != DBNull.Value ? Convert.ToString(dr["Order_Ref_Date"]) : "",
									Performa_Invoice_No = dr["Performa_Invoice_No"] != DBNull.Value ? Convert.ToString(dr["Performa_Invoice_No"]) : "",
									Performa_Invoice_Date = dr["Performa_Invoice_Date"] != DBNull.Value ? Convert.ToString(dr["Performa_Invoice_Date"]) : "",
									Indent_No = dr["Indent_No"] != DBNull.Value ? Convert.ToString(dr["Indent_No"]) : "",
									Plant_MDA_No = dr["Plant_MDA_No"] != DBNull.Value ? Convert.ToString(dr["Plant_MDA_No"]) : "",
									Port_Loading = dr["Port_Loading"] != DBNull.Value ? Convert.ToString(dr["Port_Loading"]) : "",
									Port_Discharge = dr["Port_Discharge"] != DBNull.Value ? Convert.ToString(dr["Port_Discharge"]) : "",
									Carrier = dr["Carrier"] != DBNull.Value ? Convert.ToString(dr["Carrier"]) : "",
									Sailing = dr["Sailing"] != DBNull.Value ? Convert.ToString(dr["Sailing"]) : "",
									Country = dr["Country"] != DBNull.Value ? Convert.ToString(dr["Country"]) : "",
									Incoterms2020 = dr["Incoterms2020"] != DBNull.Value ? Convert.ToString(dr["Incoterms2020"]) : "",
									Marks_No_Packing = dr["Marks_No_Packing"] != DBNull.Value ? Convert.ToString(dr["Marks_No_Packing"]) : "",
									Product_Desc = dr["Product_Desc"] != DBNull.Value ? Convert.ToString(dr["Product_Desc"]) : "",
									HSN_Code = dr["HSN_Code"] != DBNull.Value ? Convert.ToString(dr["HSN_Code"]) : "",
									Qty = dr["Qty"] != DBNull.Value ? Convert.ToString(dr["Qty"]) : ""
								});
							}
							catch { continue; }

				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return Json(new
			{
				param.sEcho,
				iTotalRecords = iTotalRecords,
				iTotalDisplayRecords = list.Count(),
				aaData = list
			});
		}

		[HttpPost]
		public IActionResult Save(string searchTerm, string Product_Desc = null)
		{
			try
			{
				if (string.IsNullOrEmpty(searchTerm))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Invoice No.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}
				var list = new List<dynamic>();

				try
				{
					var client = new HttpClient();

					var request = new HttpRequestMessage(HttpMethod.Post, AppHttpContextAccessor.API_Url_MDA);

					request.Headers.Add("Cookie", "X-Oracle-BMC-LBS-Route=b28d4f89e783eaee1f58fb4d2d5a28ae34cda340");

					var content = new StringContent("{\"serviceID\":\"8003\",\"token\":\"8548528525568856\", \"inParameters\": " +
						"[{\"label\": \"P_INVOICE_NO\",\"value\": \"" + searchTerm + "\"}]}", null, "application/json");

					request.Content = content;

					var response_ = Task.Run(async () => await client.SendAsync(request)).Result;
					response_.EnsureSuccessStatusCode();

					if (response_.IsSuccessStatusCode)
					{
						var responseContent = Task.Run(async () => await response_.Content.ReadAsStringAsync()).Result;

						if (!string.IsNullOrEmpty(responseContent))
						{
							JArray jsonArray = JArray.Parse(responseContent);

							if (!string.IsNullOrEmpty(Product_Desc))
								jsonArray = new JArray( jsonArray.Where(item => item["Product Description"] != null && item["Product Description"].ToString() == Product_Desc).ToList());
							
							foreach (JObject item in jsonArray)
							{
								try
								{
									List<MySqlParameter> oParams = new List<MySqlParameter>();

									var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

									oParams.Add(new MySqlParameter("P_Invoice_No", MySqlDbType.VarString) { Value = item["Invoice NO"] != null ? Convert.ToString(item["Invoice NO"]) : "" });
									oParams.Add(new MySqlParameter("P_Invoice_Date", MySqlDbType.VarString) { Value = item["Invoice date"] != null ? DateTime.Parse(Convert.ToString(item["Invoice date"])).ToString("dd/MM/yyyy").Replace("-", "/") : "" });
									oParams.Add(new MySqlParameter("P_Order_Ref_No", MySqlDbType.VarString) { Value = item["Order Ref NO"] != null ? Convert.ToString(item["Order Ref NO"]) : "" });
									oParams.Add(new MySqlParameter("P_Order_Ref_Date", MySqlDbType.VarString) { Value = item["Order Ref date"] != null ? DateTime.Parse(Convert.ToString(item["Order Ref date"])).ToString("dd/MM/yyyy").Replace("-", "/") : "" });
									oParams.Add(new MySqlParameter("P_Performa_Invoice_No", MySqlDbType.VarString) { Value = item["Performa invoice No"] != null ? Convert.ToString(item["Performa invoice No"]) : "" });
									oParams.Add(new MySqlParameter("P_Performa_Invoice_Date", MySqlDbType.VarString) { Value = item["Performa invoice date"] != null ? DateTime.Parse(Convert.ToString(item["Performa invoice date"])).ToString("dd/MM/yyyy").Replace("-", "/") : "" });
									oParams.Add(new MySqlParameter("P_Indent_No", MySqlDbType.VarString) { Value = item["Indent No"] != null ? Convert.ToString(item["Indent No"]) : "" });
									oParams.Add(new MySqlParameter("P_Plant_MDA_No", MySqlDbType.VarString) { Value = item["PLANT_MDA_NO"] != null ? Convert.ToString(item["PLANT_MDA_NO"]) : "" });
									oParams.Add(new MySqlParameter("P_Port_Loading", MySqlDbType.VarString) { Value = item["Port of loading"] != null ? Convert.ToString(item["Port of loading"]) : "" });
									oParams.Add(new MySqlParameter("P_Port_Discharge", MySqlDbType.VarString) { Value = item["Port of discharge"] != null ? Convert.ToString(item["Port of discharge"]) : "" });
									oParams.Add(new MySqlParameter("P_Carrier", MySqlDbType.VarString) { Value = item["carrier"] != null ? Convert.ToString(item["carrier"]) : "" });
									oParams.Add(new MySqlParameter("P_Sailing", MySqlDbType.VarString) { Value = item["sailing or about detail"] != null ? Convert.ToString(item["sailing or about detail"]) : "" });
									oParams.Add(new MySqlParameter("P_Country", MySqlDbType.VarString) { Value = item["country of origin"] != null ? Convert.ToString(item["country of origin"]) : "" });
									oParams.Add(new MySqlParameter("P_Incoterms2020", MySqlDbType.VarString) { Value = item["incoterms2020"] != null ? Convert.ToString(item["incoterms2020"]) : "" });
									oParams.Add(new MySqlParameter("P_Marks_No_Packing", MySqlDbType.VarString) { Value = item["Marks and No of Packing"] != null ? Convert.ToString(item["Marks and No of Packing"]) : "" });
									oParams.Add(new MySqlParameter("P_Product_Desc", MySqlDbType.VarString) { Value = item["Product Description"] != null ? Convert.ToString(item["Product Description"]) : "" });
									oParams.Add(new MySqlParameter("P_HSN_Code", MySqlDbType.VarString) { Value = item["HSN code"] != null ? Convert.ToString(item["HSN code"]) : "" });
									oParams.Add(new MySqlParameter("P_Qty", MySqlDbType.Int64) { Value = item["Qty"] != null ? Convert.ToInt64(item["Qty"]) : 0 });
									oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
									oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

									(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_EXP_INVOICE_SAVE", oParams, true);
								}
								catch { continue; }
							}
						}
					}
				}
				catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = true;
				CommonViewModel.StatusCode = ResponseStatusCode.Success;
				CommonViewModel.Message = ResponseStatusMessage.Success;
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

	}
}
