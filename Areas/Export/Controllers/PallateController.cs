using com.itextpdf.text.pdf;
using Dispatch_System.Controllers;
using Dispatch_System.Infra;
using DocumentFormat.OpenXml.Office2010.Excel;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using MySql.Data.MySqlClient;
using MySqlX.XDevAPI;
using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using Org.BouncyCastle.Asn1.Ocsp;
using System;
using System.Data;
using System.Globalization;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Text.RegularExpressions;
using VendorQRGeneration.Infra.Services;

namespace Dispatch_System.Areas.Export.Controllers
{
	[Area("Export")]
	public class PallateController : BaseController<ResponseModel<Pallate>>
	{
		private readonly ConveyorBackgroundTask _socketBackgroundTask;
		private string iffco_url { get; set; }
		private Int64 PLANT_ID { get; set; }

		private readonly IHubContext<ConveyorHub> _hubContext;
		private Thread threadConnectionStatus;

		public PallateController(ConveyorBackgroundTask socketBackgroundTask, IHubContext<ConveyorHub> hubContext)
		{
			PLANT_ID = Common.Get_Session_Int(SessionKey.PLANT_ID);

			iffco_url = AppHttpContextAccessor.IFFCO_Domain.TrimEnd('/');

			_hubContext = hubContext ?? throw new ArgumentNullException(nameof(hubContext));

			_socketBackgroundTask = socketBackgroundTask;

			threadConnectionStatus = null;

		}

		public void ConnectionStatus()
		{
			while (threadConnectionStatus != null)
			{
				_hubContext.Clients.All.SendAsync("ReceiveMessage", $"CONNECTION_STATUS:{Convert.ToString(_socketBackgroundTask.IsConnect()).ToUpper()}");
				Thread.Sleep(1000 * 10);
			}
		}

		public async Task<IActionResult> StopLoading(bool isManuallyStop = false)
		{
			try
			{
				if (!isManuallyStop)
					_socketBackgroundTask.SendToClient("STOP");
				else
				{
					_socketBackgroundTask.IsRunning(false);

					_socketBackgroundTask.DisconnectToServer();

					_hubContext.Clients.All.SendAsync("ReceiveMessage", "SERVER_STOP");

				}

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = true;
				CommonViewModel.StatusCode = ResponseStatusCode.Success;
				CommonViewModel.Message = "Stop Loading";
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

		public async Task<IActionResult> StartLoading(Int64 Id = 0, string DI_No = "")
		{
			try
			{
				threadConnectionStatus = null;

				var isRunning = _socketBackgroundTask.IsConnect();

				if (!isRunning)
				{
					string listenIPString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_IP").Value ?? "");
					string listenPortString = Convert.ToString(AppHttpContextAccessor.AppConfiguration.GetSection("Listen_Port").Value ?? "");

					if (Regex.IsMatch((listenIPString ?? ""), @"^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")
						&& IPAddress.TryParse(listenIPString, out IPAddress listenIP) && int.TryParse(listenPortString, out int listenPort) && listenPort > 0 && listenPort <= 65535)
					{
						LoadingData objLoad = new LoadingData() { Id = Id, Data1 = DI_No };
						_socketBackgroundTask.SetObjLoad(objLoad);
						_socketBackgroundTask.ConnectToServer(listenIP, listenPort);
						_socketBackgroundTask.DataReceive += Server_DataReceive;
						_socketBackgroundTask.ConnectionClosed += Server_ConnectionClosed;
						_socketBackgroundTask.ServerStarted += Server_ServerStarted;

					}
				}

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = isRunning;
				CommonViewModel.StatusCode = isRunning ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = isRunning ? "Start Loading" : "Connectivity issue with Conveyor.";
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

		private void Server_DataReceive(object sender, TcpServerListenerEventArgs e)
		{
			LoadingData objLoad = _socketBackgroundTask.GetObjLoad();

			var receivedData = string.Format($"{Encoding.ASCII.GetString(e.buffer)}");
			var ticks = e.ticks;

			//Write_Log($"Socket server received message Before Split : \"{receivedData}\"");

			if (!string.IsNullOrEmpty(receivedData) && receivedData.Contains(iffco_url) && !receivedData.ToUpper().StartsWith("MC"))
			{
				receivedData = receivedData.Substring(receivedData.IndexOf(iffco_url) + iffco_url.Length);

				var strQR = receivedData.Replace(iffco_url, "");
				var sb = new StringBuilder(strQR);

				for (int i = 0; i < sb.Length; i++)
				{
					if (sb[i] == '/')
						sb[i] = (i % 2 == 0) ? '(' : ')';
				}
				receivedData = Regex.Replace(sb.ToString(), @"[^\w:/\(/\)\.\-]", "");
			}

			//Write_Log($"Socket server received message After Split : \"{receivedData}\"");

			receivedData = receivedData.Trim().Replace(" ", "");

			var (IsSuccess, response, Id) = (false, "NOK", 0M);

			if (receivedData.ToUpper().Contains("MCSTOP") && _socketBackgroundTask.IsRunning())
			{
				_socketBackgroundTask.IsRunning(false);

				_hubContext.Clients.All.SendAsync("ReceiveMessage", "SERVER_STOP");

				_socketBackgroundTask.DisconnectToServer();
			}
			else if (receivedData.ToUpper().Contains("MCSTART"))
			{
				_socketBackgroundTask.IsRunning(true);

				_hubContext.Clients.All.SendAsync("ReceiveMessage", "SERVER_START");

			}
			else if (!receivedData.ToUpper().Contains("MCIDEL"))
			{
				if (!string.IsNullOrEmpty(receivedData) && receivedData.Trim().ToUpper().Replace(" ", "") == "<#>") return;
				else if (!string.IsNullOrEmpty(receivedData) && receivedData.Trim().ToUpper().Replace(" ", "") == "<@>")
				{
					//Write_Log($"ReceivedData : {receivedData} | <@> Response : continue");

					receivedData = "##########";

					return;
				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_QR_CODE", MySqlDbType.VarString) { Value = receivedData });
				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = objLoad.Id });
				oParams.Add(new MySqlParameter("P_DI_NO", MySqlDbType.VarString) { Value = Convert.ToString(objLoad.Data1) });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.LoggedUser_Plant_Id });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_SHIPPER_QRCODE_CHECK", oParams, true);

				long requiredShipper = Convert.ToInt64(response.Split("#")[1]);
				long loaddedShipper = Convert.ToInt64(response.Split("#")[2]);
				long rejectShipper = Convert.ToInt64(response.Split("#")[3]);
				bool isInsert = Convert.ToBoolean(Convert.ToInt16(response.Split("#")[4]));

				objLoad.RequiredShipper = requiredShipper;
				objLoad.LoaddedShipper = loaddedShipper;
				objLoad.RejectShipper = rejectShipper;

				objLoad.QRCode = receivedData;
				objLoad.Ticks = ticks;

				_socketBackgroundTask.SetObjLoad(objLoad);

				response = response.Split("#")[0].ToString();

				CommonViewModel.IsConfirm = !IsSuccess;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response.Contains('_') ? response.Split('_')[0] : response;

				CommonViewModel.Data1 = new
				{
					Id = Id,
					Text = receivedData,
					Success = response.Contains('_') ? response.Split('_')[0] : response,
					RequiredShipper = requiredShipper,
					LoaddedShipper = loaddedShipper,
					RejectShipper = rejectShipper,
					IsInsert = isInsert
				};

				CommonViewModel.Data2 = response.Contains('_') ? response.Split('_')[1] : null;

				bool serverResponse = _socketBackgroundTask.SendToClient(CommonViewModel.Data1.Success);

				if (serverResponse) _hubContext.Clients.All.SendAsync("ReceiveMessage", "DATA:" + JsonConvert.SerializeObject(CommonViewModel, new JsonSerializerSettings
				{ ContractResolver = new FirstCharLowerCaseContractResolver(), Formatting = Formatting.Indented }));

				//if (requiredShipper <= loaddedShipper) _hubContext.Clients.All.SendAsync("ReceiveMessage", "COMPLETE");
			}

			//_hubContext.Clients.All.SendAsync("ReceiveMessage", receivedData);
			//Console.WriteLine($"Socket server received message Before Split : \"{receivedData}\"");

		}

		private void Server_ServerStarted(object sender, EventArgs e)
		{
			//Console.WriteLine($"Socket connection started.");

			//_socketBackgroundTask.SendToClient("STOP");
			_socketBackgroundTask.SendToClient("START");

			threadConnectionStatus = new Thread(ConnectionStatus);
			threadConnectionStatus.Start();

		}

		private void Server_ConnectionClosed(object sender, EventArgs e)
		{
			//Console.WriteLine($"Socket connection closed.");
			threadConnectionStatus = null;
		}

		#region Pallate

		public IActionResult Index()
		{
			return View();
		}

		[HttpGet]
		public IActionResult GetDI(string type, string searchTerm, int id = -1)
		{
			var list = new List<MDA>();

			try
			{
				if (_socketBackgroundTask.IsConnect())
				{
					_socketBackgroundTask.IsRunning(false);

					_socketBackgroundTask.DisconnectToServer();

					_hubContext.Clients.All.SendAsync("ReceiveMessage", "SERVER_STOP");

				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = (!string.IsNullOrEmpty(searchTerm)) ? searchTerm : "" });
				oParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_DISPLAY_LENGTH", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_DISPLAY_START", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				DataTable dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_PALLATE_DI_GET", oParams);

				if (dt != null && dt.Rows.Count > 0)
					foreach (DataRow dr in dt.Rows)
						list.Add(new MDA()
						{
							di_no = dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "",
							bag_nos = dr["BAG_NOS"] != DBNull.Value ? Convert.ToInt64(dr["BAG_NOS"]) : 0,
							Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToInt64(dr["Required_Shipper"]) : 0
						});

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (list != null && list.Count > 0)
				if (!string.IsNullOrEmpty(type) && type == "S") return Json(list);
				else return PartialView("_Partial_DI", list);
			else return Json(null);
		}

		[HttpGet]
		public IActionResult Load_Pallate(Int64 Id = 0, string DI_No = "", bool GetShipper = false, bool IsDataTable = false, JqueryDatatableParam param = null)
		{
			var iTotalRecords = 0;

			var list = new List<dynamic>();

			try
			{
				if (_socketBackgroundTask.IsConnect())
				{
					_socketBackgroundTask.IsRunning(false);

					_socketBackgroundTask.DisconnectToServer();

					_hubContext.Clients.All.SendAsync("ReceiveMessage", "SERVER_STOP");

				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Id });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = DI_No ?? "" });
				oParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.VarString) { Value = param != null && param.sSearch != null ? param.sSearch : "" });
				oParams.Add(new MySqlParameter("P_DISPLAY_LENGTH", MySqlDbType.Int64) { Value = param != null ? param.iDisplayLength : 10 });
				oParams.Add(new MySqlParameter("P_DISPLAY_START", MySqlDbType.Int64) { Value = param != null ? param.iDisplayStart : 0 });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_PALLATE_DI_GET", oParams);

				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
					foreach (DataRow dr in ds.Tables[1].Rows)
						list.Add(new
						{
							Id = dr["ID"] != DBNull.Value ? Convert.ToInt64(dr["ID"]) : 0,
							Sr_No = dr["Sr_No"] != DBNull.Value ? Convert.ToInt32(dr["Sr_No"]) : 0,
							DI_No = dr["DI_No"] != DBNull.Value ? Convert.ToString(dr["DI_No"]) : "",
							SSCC = dr["SSCC"] != DBNull.Value ? Convert.ToString(dr["SSCC"]) : "",
							Pallate_No = dr["Pallate_No"] != DBNull.Value ? Convert.ToString(dr["Pallate_No"]) : "",
							Pallate_Type = dr["Pallate_Type"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type"]) : "",
							Shipper_Qty = dr["Shipper_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Shipper_Qty"]) : 0,
							Bottle_Qty = dr["Bottle_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Bottle_Qty"]) : 0,
							//Shipper_QR_Code = dr["Shipper_QR_Code"] != DBNull.Value ? Convert.ToString(dr["Shipper_QR_Code"]) : "",
							Dispatch_Mode = dr["Dispatch_Mode"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode"]) : "",
							Pallate_Type_Text = dr["Pallate_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type_Text"]) : "",
							Dispatch_Mode_Text = dr["Dispatch_Mode_Text"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode_Text"]) : "",
							Shipper_QR_Code = new List<Pallate_Shipper>()
						});

				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
					iTotalRecords = ds.Tables[1].Rows[0]["Count"] != DBNull.Value ? Convert.ToInt32(ds.Tables[1].Rows[0]["Count"]) : 0;

				list = list.Distinct().ToList();

				if (GetShipper == true && ds != null && ds.Tables.Count > 2 && ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
				{
					foreach (DataRow dr in ds.Tables[2].Rows)
					{
						try
						{
							var index = list.FindIndex(x => x.Id == (dr["Pallate_Id"] != DBNull.Value ? Convert.ToInt64(dr["Pallate_Id"]) : 0));

							if (index >= 0)
							{
								if (list[index].Shipper_QR_Code == null)
									list[index].Shipper_QR_Code = new List<Pallate_Shipper>();

								list[index].Shipper_QR_Code.Add(new Pallate_Shipper()
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
						}
						catch { continue; }

					}

				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			if (!IsDataTable)
				return Json(list);
			else
				return Json(new
				{
					param.sEcho,
					iTotalRecords = iTotalRecords,
					iTotalDisplayRecords = list.Count(),
					aaData = list
				});

		}

		[HttpGet]
		public IActionResult Partial_AddEditForm(Int64 id, string DI_No = "")
		{
			var obj = new Pallate() { DI_No = DI_No, Pallate_Type = "WOODEN", Dispatch_Mode = "ROAD" };

			var list = new List<SelectListItem_Custom>();

			var oParams = new List<MySqlParameter>();

			try
			{
				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = DI_No });
				oParams.Add(new MySqlParameter("P_SEARCH_TERM", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_DISPLAY_LENGTH", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_DISPLAY_START", MySqlDbType.Int64) { Value = 0 });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				var ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_PALLATE_DI_GET", oParams, true);

				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
					obj = new Pallate()
					{
						Id = ds.Tables[1].Rows[0]["ID"] != DBNull.Value ? Convert.ToInt64(ds.Tables[1].Rows[0]["ID"]) : 0,
						DI_No = ds.Tables[1].Rows[0]["DI_No"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["DI_No"]) : "",
						SSCC = ds.Tables[1].Rows[0]["SSCC"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["SSCC"]) : "",
						Pallate_No = ds.Tables[1].Rows[0]["Pallate_No"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["Pallate_No"]) : "",
						Pallate_Type = ds.Tables[1].Rows[0]["Pallate_Type"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["Pallate_Type"]) : "",
						Shipper_Qty = ds.Tables[1].Rows[0]["Shipper_Qty"] != DBNull.Value ? Convert.ToInt64(ds.Tables[1].Rows[0]["Shipper_Qty"]) : 0,
						//Shipper_QR_Code = ds.Tables[1].Rows[0]["Shipper_QR_Code"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["Shipper_QR_Code"]) : "",
						Dispatch_Mode = ds.Tables[1].Rows[0]["Dispatch_Mode"] != DBNull.Value ? Convert.ToString(ds.Tables[1].Rows[0]["Dispatch_Mode"]) : ""
					};

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			oParams = new List<MySqlParameter>();

			oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "DISPATCH_MODE" });
			oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
			oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			var dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["LOV_CODE"].ToString(), dr["LOV_DESC"].ToString(), "D"));

			oParams = new List<MySqlParameter>();

			oParams.Add(new MySqlParameter("P_LOV_COLUMN", MySqlDbType.VarString) { Value = "Pallate_Type" });
			oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "Y" });
			oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
			oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
			oParams.Add(new MySqlParameter("P_ROLE_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
			oParams.Add(new MySqlParameter("P_MENU_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

			dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_LOV_GET", oParams, true);

			if (dt != null && dt.Rows.Count > 0)
				foreach (DataRow dr in dt.Rows)
					list.Add(new SelectListItem_Custom(dr["LOV_CODE"].ToString(), dr["LOV_DESC"].ToString(), "T"));

			CommonViewModel.SelectListItems = list;

			CommonViewModel.Obj = obj;

			return PartialView("_Partial_AddEditForm", CommonViewModel);

		}

		[HttpPost]
		public IActionResult Save(Pallate viewModel)
		{
			try
			{
				if (viewModel == null)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid Pallate details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.DI_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid DI details.";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Pallate_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Pallate Number";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Pallate_Type))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Pallate Type";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (viewModel.Shipper_Qty <= 0)
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter Shipper Qty";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;
					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(viewModel.Dispatch_Mode))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Dispatch Mode";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = viewModel.Id });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = viewModel.DI_No });
				oParams.Add(new MySqlParameter("P_Pallate_No", MySqlDbType.VarString) { Value = viewModel.Pallate_No });
				oParams.Add(new MySqlParameter("P_Pallate_Type", MySqlDbType.VarString) { Value = viewModel.Pallate_Type });
				oParams.Add(new MySqlParameter("P_Shipper_Qty", MySqlDbType.Int64) { Value = viewModel.Shipper_Qty });
				oParams.Add(new MySqlParameter("P_Dispatch_Mode", MySqlDbType.VarString) { Value = viewModel.Dispatch_Mode });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;
				//CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
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

		[HttpGet]
		public IActionResult Check_QR_Code(string QR_Code = "", Int64 Pallate_Id = 0, string DI_No = "")
		{
			try
			{
				if (!string.IsNullOrEmpty(QR_Code) && Pallate_Id > 0 && !string.IsNullOrEmpty(DI_No))
				{
					List<MySqlParameter> oParams = new List<MySqlParameter>();

					oParams.Add(new MySqlParameter("P_QR_CODE", MySqlDbType.VarString) { Value = QR_Code });
					oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Pallate_Id });
					oParams.Add(new MySqlParameter("P_DI_NO", MySqlDbType.VarString) { Value = DI_No });
					oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.LoggedUser_Plant_Id });
					oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

					var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_SHIPPER_QRCODE_CHECK", oParams, true);

					long requiredShipper = Convert.ToInt64(response.Split("#")[1]);
					long loaddedShipper = Convert.ToInt64(response.Split("#")[2]);
					long rejectShipper = Convert.ToInt64(response.Split("#")[3]);

					response = response.Split("#")[0].ToString();

					CommonViewModel.IsConfirm = !IsSuccess;
					CommonViewModel.IsSuccess = IsSuccess;
					CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
					CommonViewModel.Message = response.Contains('_') ? response.Split('_')[0] : response;

					CommonViewModel.Data1 = new
					{
						Id = Id,
						Text = QR_Code,
						Success = response.Contains('_') ? response.Split('_')[0] : response,
						RequiredShipper = requiredShipper,
						LoaddedShipper = loaddedShipper,
						RejectShipper = rejectShipper
					};

					CommonViewModel.Data2 = response.Contains('_') ? response.Split('_')[1] : null;

					return Json(CommonViewModel);
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			CommonViewModel.IsSuccess = false;
			CommonViewModel.StatusCode = ResponseStatusCode.Error;
			CommonViewModel.Message = ResponseStatusMessage.Error;

			return Json(CommonViewModel);
		}

		[HttpPost]
		public JsonResult ClosePallate(Int64 Pallate_Id, string DI_No = "")
		{
			try
			{
				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Pallate_Id });
				oParams.Add(new MySqlParameter("P_DI_NO", MySqlDbType.VarString) { Value = DI_No });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_CLOSE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

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
		public JsonResult DeleteConfirmed(long id = 0, long mda_load_id = 0)
		{
			try
			{
				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = id });
				oParams.Add(new MySqlParameter("P_MDA_LOD_SYS_ID", MySqlDbType.Int64) { Value = mda_load_id });
				oParams.Add(new MySqlParameter("P_ISACTIVE", MySqlDbType.VarString) { Value = "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_DELETE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

				CommonViewModel.Data1 = mda_load_id;
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


		public JsonResult Delete_QR_Code(Int64 Pallate_Id = 0, string DI_No = "", string QR_Code_type = "", Int64 QR_Code_Id = -1)
		{
			try
			{
				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_Pallate_Id", MySqlDbType.Int64) { Value = Pallate_Id });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = DI_No });
				oParams.Add(new MySqlParameter("P_QR_Code_Id", MySqlDbType.Int64) { Value = QR_Code_Id });
				oParams.Add(new MySqlParameter("P_QR_Code_type", MySqlDbType.VarString) { Value = QR_Code_type });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_SHIPPER_QRCODE_DELETE", oParams, true);

				long requiredShipper = Convert.ToInt64(response.Split("#")[1]);
				long loaddedShipper = Convert.ToInt64(response.Split("#")[2]);
				long rejectShipper = Convert.ToInt64(response.Split("#")[3]);
				bool isDelete = Convert.ToBoolean(Convert.ToInt16(response.Split("#")[4]));

				response = response.Split("#")[0].ToString();

				CommonViewModel.IsConfirm = !IsSuccess;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response.Contains('_') ? response.Split('_')[0] : response;

				CommonViewModel.Data1 = new
				{
					Id = QR_Code_Id,
					Text = QR_Code_type,
					Success = response.Contains('_') ? response.Split('_')[0] : response,
					RequiredShipper = requiredShipper,
					LoaddedShipper = loaddedShipper,
					RejectShipper = rejectShipper,
					IsDelete = isDelete
				};

				CommonViewModel.Data2 = response.Contains('_') ? response.Split('_')[1] : null;

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

		#region Pallate-Load

		public IActionResult Load()
		{
			return View();
		}


		//[HttpGet]
		//public JsonResult GetMDA(string DI_No)
		//{
		//    var list = new List<MDA>();

		//    try
		//    {
		//        DataTable dt = new DataTable();

		//        List<MySqlParameter> oParams = new List<MySqlParameter>();

		//        oParams.Add(new MySqlParameter("P_Gate_In_Id", MySqlDbType.Int64) { Value = 0 });
		//        oParams.Add(new MySqlParameter("P_MDA_Id", MySqlDbType.Int64) { Value = 0 });
		//        oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = DI_No ?? "" });
		//        oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

		//        dt = DataContext.ExecuteStoredProcedure_DataTable_SQL("PC_EXP_DI_MDA_GET", oParams);

		//        if (dt != null && dt.Rows.Count > 0)
		//            foreach (DataRow dr in dt.Rows)
		//                list.Add(new MDA()
		//                {
		//                    sr_no = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
		//                    Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
		//                    GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
		//                    vehicle_no = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
		//                    mda_no = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
		//                    di_no = dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "",
		//                    plant_cd = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
		//                    mda_dt = dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
		//                    driver = dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "",
		//                    mobile_no = dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "",
		//                    dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
		//                    wh_cd = dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "",
		//                    party_name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
		//                    tptr_cd = dr["TRANS_CD"] != DBNull.Value ? Convert.ToString(dr["TRANS_CD"]) : "",
		//                    tptr_name = dr["TRANS_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANS_NAME"]) : "",
		//                    prod_cd = dr["PROD_CD"] != DBNull.Value ? Convert.ToString(dr["PROD_CD"]) : "",
		//                    prod_name = dr["PROD_NAME"] != DBNull.Value ? Convert.ToString(dr["PROD_NAME"]) : "",
		//                    bag_nos = dr["bag_nos"] != DBNull.Value ? Convert.ToInt64(dr["bag_nos"]) : 0,
		//                    Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
		//                    Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
		//                    Expected_Shipper = dr["Expected_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Expected_Shipper"]) : 0
		//                });

		//    }
		//    catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

		//    return Json(list);
		//}

		[HttpGet]
		public JsonResult GetMDAPallate(Int64 GateInId, Int64 MDAId, string DI_No)
		{
			var list = new List<dynamic>();
			var listPallate = new List<dynamic>();

			try
			{
				DataSet ds = new DataSet();

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				oParams.Add(new MySqlParameter("P_Gate_In_Id", MySqlDbType.Int64) { Value = GateInId });
				oParams.Add(new MySqlParameter("P_MDA_Id", MySqlDbType.Int64) { Value = MDAId });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = DI_No ?? "" });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

				ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_EXP_MDA_PALLATE_GET", oParams);

				if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
				{
					foreach (DataRow dr in ds.Tables[0].Rows)
						list.Add(new
						{
							sr_no = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
							Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
							GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
							vehicle_no = dr["VEHICLE_NO"] != DBNull.Value ? Convert.ToString(dr["VEHICLE_NO"]) : "",
							mda_no = dr["MDA_NO"] != DBNull.Value ? Convert.ToString(dr["MDA_NO"]) : "",
							di_no = dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "",
							plant_cd = dr["Plant_CD"] != DBNull.Value ? Convert.ToString(dr["Plant_CD"]) : "",
							mda_dt = dr["MDA_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dr["MDA_DT"]), "dd/MM/yyyy", CultureInfo.InvariantCulture).ToString("dd/MM/yyyy").Replace("-", "/") : "",
							driver = dr["DRIVER"] != DBNull.Value ? Convert.ToString(dr["DRIVER"]) : "",
							mobile_no = dr["MOBILE_NO"] != DBNull.Value ? Convert.ToString(dr["MOBILE_NO"]) : "",
							dist = dr["DIST"] != DBNull.Value ? Convert.ToInt64(dr["DIST"]) : 0,
							wh_cd = dr["WH_CD"] != DBNull.Value ? Convert.ToString(dr["WH_CD"]) : "",
							party_name = dr["PARTY_NAME"] != DBNull.Value ? Convert.ToString(dr["PARTY_NAME"]) : "",
							tptr_cd = dr["TRANS_CD"] != DBNull.Value ? Convert.ToString(dr["TRANS_CD"]) : "",
							tptr_name = dr["TRANS_NAME"] != DBNull.Value ? Convert.ToString(dr["TRANS_NAME"]) : "",
							prod_cd = dr["PROD_CD"] != DBNull.Value ? Convert.ToString(dr["PROD_CD"]) : "",
							prod_name = dr["PROD_NAME"] != DBNull.Value ? Convert.ToString(dr["PROD_NAME"]) : "",
							bag_nos = dr["bag_nos"] != DBNull.Value ? Convert.ToInt64(dr["bag_nos"]) : 0,
							Required_Shipper = dr["Required_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Required_Shipper"]) : 0,
							Loaded_Shipper = dr["Loaded_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Shipper"]) : 0,
							Expected_Shipper = dr["Expected_Shipper"] != DBNull.Value ? Convert.ToDecimal(dr["Expected_Shipper"]) : 0,
							Loaded_Bottle = dr["Loaded_Bottle"] != DBNull.Value ? Convert.ToDecimal(dr["Loaded_Bottle"]) : 0,
							Expected_Bottle = dr["Expected_Bottle"] != DBNull.Value ? Convert.ToDecimal(dr["Expected_Bottle"]) : 0
						});

				}

				if (ds != null && ds.Tables.Count > 1 && ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0 && GateInId > 0 && MDAId > 0)
				{
					foreach (DataRow dr in ds.Tables[1].Rows)
						listPallate.Add(new
						{
							Sr_No = dr["SR_NO"] != DBNull.Value ? Convert.ToInt64(dr["SR_NO"]) : 0,
							Id = dr["MDA_LOD_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_LOD_SYS_ID"]) : 0,
							Pallate_Id = dr["Pallate_Id"] != DBNull.Value ? Convert.ToInt64(dr["Pallate_Id"]) : 0,
							MDA_Id = dr["MDA_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["MDA_SYS_ID"]) : 0,
							GateInOut_Id = dr["GATE_SYS_ID"] != DBNull.Value ? Convert.ToInt64(dr["GATE_SYS_ID"]) : 0,
							DI_No = dr["DI_NO"] != DBNull.Value ? Convert.ToString(dr["DI_NO"]) : "",
							SSCC = dr["SSCC"] != DBNull.Value ? Convert.ToString(dr["SSCC"]) : "",
							Pallate_No = dr["PALLATE_NO"] != DBNull.Value ? Convert.ToString(dr["PALLATE_NO"]) : "",
							Pallate_Type = dr["Pallate_Type_Text"] != DBNull.Value ? Convert.ToString(dr["Pallate_Type_Text"]) : "",
							Shipper_Qty = dr["Shipper_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Shipper_Qty"]) : 0,
							Bottle_Qty = dr["Bottle_Qty"] != DBNull.Value ? Convert.ToInt64(dr["Bottle_Qty"]) : 0,
							Dispatch_Mode = dr["Dispatch_Mode_Text"] != DBNull.Value ? Convert.ToString(dr["Dispatch_Mode_Text"]) : ""
						});

				}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return Json(new { DI_Details = list, Pallate_Details = listPallate });
		}

		[HttpPost]
		public IActionResult Save_Pallate(Int64 GateInId, Int64 MDAId, string DI_No, string PallateId)
		{
			try
			{
				if (GateInId <= 0 || MDAId <= 0 || string.IsNullOrEmpty(DI_No))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please enter valid MDA details";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				if (string.IsNullOrEmpty(PallateId))
				{
					CommonViewModel.IsSuccess = false;
					CommonViewModel.Message = "Please select Pallate(s).";
					CommonViewModel.StatusCode = ResponseStatusCode.Error;

					return Json(CommonViewModel);
				}

				List<MySqlParameter> oParams = new List<MySqlParameter>();

				var (IsSuccess, response, Id) = (false, ResponseStatusMessage.Error, 0M);

				oParams.Add(new MySqlParameter("P_MDA_ID", MySqlDbType.Int64) { Value = MDAId });
				oParams.Add(new MySqlParameter("P_GATEIN_ID", MySqlDbType.Int64) { Value = GateInId });
				oParams.Add(new MySqlParameter("P_DI_No", MySqlDbType.VarString) { Value = DI_No });
				oParams.Add(new MySqlParameter("P_Pallate_Id", MySqlDbType.VarString) { Value = PallateId });
				oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new MySqlParameter("P_USER_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });

				(IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure_SQL("PC_PALLATE_MDA_SAVE", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;
				//CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";
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
