using ClosedXML.Excel;
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using System.Data;
using System.Globalization;

namespace Dispatch_System.Areas.Dispatch.Controllers
{
    [Area("Dispatch")]
    public class RmSpWeighmentOutSlipController : BaseController<ResponseModel<WeighmentInSlip>>
    {
        #region Loading

        //[Route("WeighmentInSlip/Index/{Vehicle_No?}")]
        public IActionResult Index(string Vehicle_No = "", long Gate_In_Out_Id = 0, string Inward_Sys_Id = "")
        {
            if (!string.IsNullOrEmpty(Vehicle_No) || Gate_In_Out_Id > 0)
            {
                if (Inward_Sys_Id == "2")
                {
                    return Load_PO_Dtls(Vehicle_No, Gate_In_Out_Id, true);
                }
                else if (Inward_Sys_Id == "3")
                {
                    return Load_SO_Dtls(Vehicle_No, Gate_In_Out_Id, true);
                }
            }
            return View();
        }

        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Load_PO_Dtls(string Vehicle_No = "", long Gate_In_Out_Id = 0, bool IsPrint = false)
        {
            var obj = new WeighmentInSlip();

            if (!string.IsNullOrEmpty(Vehicle_No) || Gate_In_Out_Id > 0)
            {
                try
                {
                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_RM_WEIGHMENT_OUT_SLIP_GET", oParams);

                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];
                        DataTable dt1 = ds.Tables[1];

                        obj = new WeighmentInSlip()
                        {
                            Report_Title = "WEIGHMENT SLIP RAW MATERIAL - WEIGH OUT PRINT",
							Plant_Name = dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "",
							Plant_Address = dt.Rows[0]["PlantAddress"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PlantAddress"]) : "",
							MDA_No = dt.Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["COMMON_NO"]) : "",
                            Truck_No = dt.Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Truck_No"]) : "",
                            Transporter_Name = dt.Rows[0]["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TRANSPORTER_NAME"]) : "",
                            Net_Wt = dt.Rows[0]["NET_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NET_WT"]) : "",
                            Tare_Wt = dt.Rows[0]["TARE_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TARE_WT"]) : "",
                            Tare_Wt_Dt = dt.Rows[0]["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["TARE_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Gross_Wt = dt.Rows[0]["GROSS_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["GROSS_WT"]) : "",
                            Gross_Wt_Dt = dt.Rows[0]["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Tare_Wt_Note = dt.Rows[0]["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TARE_WT_NOTE"]) : "",
                            RFID_No = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : ""

                        };

                        obj.listDtls = new List<ListDtls>();

                        if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                        {
                            foreach (DataRow dr in ds.Tables[1].Rows)
                                obj.listDtls.Add(new ListDtls()
                                {
                                    SrNo = dr["PO_LINE_NO"] != DBNull.Value ? Convert.ToInt32(dr["PO_LINE_NO"]) : 0,
                                    Mda_Id = dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt32(dr["PO_SYS_ID"]) : 0,
                                    prd_desc = dr["LINE_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_DESC"]) : "",
                                    no_of_bottle = dr["LINE_QTY"] != DBNull.Value ? Convert.ToInt32(dr["LINE_QTY"]) : 0,
                                    desp_place = dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : "",
                                    prd_cd = dr["RECEIVE_UOM"] != DBNull.Value ? Convert.ToString(dr["RECEIVE_UOM"]) : "",
                                    no_of_Box = dr["RECEIVE_QTY"] != DBNull.Value ? Convert.ToInt32(dr["RECEIVE_QTY"]) : 0,
                                });
                        }
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            }

            if (IsPrint == true)
                return View("Index_Print", obj);
            else
                return PartialView("_Partial_ShipperQRList", obj);
        }


        [HttpGet]
        public IActionResult Load_SO_Dtls(string Vehicle_No = "", long Gate_In_Out_Id = 0, bool IsPrint = false)
        {
            var obj = new WeighmentInSlip();

            if (!string.IsNullOrEmpty(Vehicle_No) || Gate_In_Out_Id > 0)
            {
                try
                {
                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = Gate_In_Out_Id });
                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_SP_WEIGHMENT_OUT_SLIP_GET", oParams);

                    if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];
                        DataTable dt1 = ds.Tables[1];

                        obj = new WeighmentInSlip()
                        {
                            Report_Title = "WEIGHMENT SLIP SCRAP - WEIGH OUT PRINT",
							Plant_Name = dt.Rows[0]["PLANT_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PLANT_NAME"]) : "",
							Plant_Address = dt.Rows[0]["PlantAddress"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["PlantAddress"]) : "",
							MDA_No = dt.Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["COMMON_NO"]) : "",
                            Truck_No = dt.Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Truck_No"]) : "",
                            Transporter_Name = dt.Rows[0]["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TRANSPORTER_NAME"]) : "",
                            Net_Wt = dt.Rows[0]["NET_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["NET_WT"]) : "",
                            Tare_Wt = dt.Rows[0]["TARE_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TARE_WT"]) : "",
                            Tare_Wt_Dt = dt.Rows[0]["TARE_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["TARE_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Gross_Wt = dt.Rows[0]["GROSS_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["GROSS_WT"]) : "",
                            Gross_Wt_Dt = dt.Rows[0]["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                            Tare_Wt_Note = dt.Rows[0]["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["GROSS_WT_NOTE"]) : "",
                            RFID_No = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : ""

                        };

                        obj.listDtls = new List<ListDtls>();

                        if (dt1 != null && dt1.Rows.Count > 0)
                        {
                            foreach (DataRow dr in dt1.Rows)
                                obj.listDtls.Add(new ListDtls()
                                {
                                    SrNo = dr["SLNO"] != DBNull.Value ? Convert.ToInt32(dr["SLNO"]) : 0,
                                    Mda_Id = dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt32(dr["SO_SYS_ID"]) : 0,
                                    prd_desc = dr["SCRAP_DESC"] != DBNull.Value ? Convert.ToString(dr["SCRAP_DESC"]) : "",
                                    no_of_bottle = dr["SO_QTY"] != DBNull.Value ? Convert.ToInt32(dr["SO_QTY"]) : 0,
                                    desp_place = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : "",
                                    prd_cd = dr["LOADING_UOM"] != DBNull.Value ? Convert.ToString(dr["LOADING_UOM"]) : "",
                                    no_of_Box = dr["LOADING_QTY"] != DBNull.Value ? Convert.ToInt32(dr["LOADING_QTY"]) : 0,
                                });
                        }
                    }
                }
                catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
            }

            if (IsPrint == true)
                return View("Index_SP_Print", obj);
            else
                return PartialView("_SP_Partial_ShipperQRList", obj);
        }


        [Route("RmSpWeighmentOutSlip/Export/{Vehicle_No?}")]
        public FileResult Export(string Vehicle_No = "", string Inward_Sys_Id = "")
        {
            var obj = new WeighmentInSlip();
            var list = new List<ListDtls>();

            if (!string.IsNullOrEmpty(Vehicle_No))
            {
                try
                {
                    var oParams = new List<MySqlParameter>();

                    oParams.Add(new MySqlParameter("P_ID", MySqlDbType.Int64) { Value = 0 });
                    oParams.Add(new MySqlParameter("P_SEARCHTERM", MySqlDbType.VarChar) { Value = Vehicle_No ?? "" });
                    oParams.Add(new MySqlParameter("P_PLANT_ID", MySqlDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });

                    if (Inward_Sys_Id == "2")
                    {
                        DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_RM_WEIGHMENT_OUT_SLIP_GET", oParams);

                        if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable dt = ds.Tables[0];
                            DataTable dt1 = ds.Tables[1];

                            obj = new WeighmentInSlip()
                            {
                                Report_Title = Inward_Sys_Id == "2" ? "WEIGHMENT SLIP RAW MATERIAL - WEIGH OUT PRINT" : "WEIGHMENT SLIP SCRAP - WEIGH OUT PRINT",
                                MDA_No = dt.Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["COMMON_NO"]) : "",
                                Truck_No = dt.Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Truck_No"]) : "",
                                Transporter_Name = dt.Rows[0]["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TRANSPORTER_NAME"]) : "",
                                Tare_Wt = dt.Rows[0]["Tare_Wt"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Tare_Wt"]) : "",
                                Tare_Wt_Dt = dt.Rows[0]["Tare_Wt_Dt"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["Tare_Wt_Dt"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                                Tare_Wt_Note = dt.Rows[0]["TARE_WT_NOTE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TARE_WT_NOTE"]) : "",
                                RFID_No = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : ""

                            };

                            obj.listDtls = new List<ListDtls>();

                            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            {
                                foreach (DataRow dr in ds.Tables[1].Rows)
                                    list.Add(new ListDtls()
                                    {
                                        SrNo = dr["PO_LINE_NO"] != DBNull.Value ? Convert.ToInt32(dr["PO_LINE_NO"]) : 0,
                                        Mda_Id = dr["PO_SYS_ID"] != DBNull.Value ? Convert.ToInt32(dr["PO_SYS_ID"]) : 0,
                                        prd_desc = dr["LINE_DESC"] != DBNull.Value ? Convert.ToString(dr["LINE_DESC"]) : "",
                                        no_of_bottle = dr["LINE_QTY"] != DBNull.Value ? Convert.ToInt32(dr["LINE_QTY"]) : 0,
                                        desp_place = dr["UMO"] != DBNull.Value ? Convert.ToString(dr["UMO"]) : ""
                                    });
                            }
                        }

                    }
                    else if (Inward_Sys_Id == "3")
                    {
                        DataSet ds = DataContext.ExecuteStoredProcedure_DataSet_SQL("PC_SP_WEIGHMENT_OUT_SLIP_GET", oParams);

                        if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                        {
                            DataTable dt = ds.Tables[0];
                            DataTable dt1 = ds.Tables[1];

                            obj = new WeighmentInSlip()
                            {
                                Report_Title = "WEIGHMENT SLIP SCRAP - WEIGH OUT PRINT",
                                MDA_No = dt.Rows[0]["COMMON_NO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["COMMON_NO"]) : "",
                                Truck_No = dt.Rows[0]["Truck_No"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["Truck_No"]) : "",
                                Transporter_Name = dt.Rows[0]["TRANSPORTER_NAME"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["TRANSPORTER_NAME"]) : "",
                                Gross_Wt = dt.Rows[0]["GROSS_WT"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["GROSS_WT"]) : "",
                                Gross_Wt_Dt = dt.Rows[0]["GROSS_WT_DT"] != DBNull.Value ? DateTime.ParseExact(Convert.ToString(dt.Rows[0]["GROSS_WT_DT"]), "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture) : nullDateTime,
                                Gross_Wt_Note = dt.Rows[0]["GROSS_WT_NOTE"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["GROSS_WT_NOTE"]) : "",
                                RFID_No = dt.Rows[0]["RFIDSRNO"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["RFIDSRNO"]) : ""

                            };

                            obj.listDtls = new List<ListDtls>();

                            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                            {
                                foreach (DataRow dr in ds.Tables[1].Rows)
                                    obj.listDtls.Add(new ListDtls()
                                    {
                                        SrNo = dr["SLNO"] != DBNull.Value ? Convert.ToInt32(dr["SLNO"]) : 0,
                                        Mda_Id = dr["SO_SYS_ID"] != DBNull.Value ? Convert.ToInt32(dr["SO_SYS_ID"]) : 0,
                                        prd_desc = dr["SCRAP_DESC"] != DBNull.Value ? Convert.ToString(dr["SCRAP_DESC"]) : "",
                                        no_of_bottle = dr["SO_QTY"] != DBNull.Value ? Convert.ToInt32(dr["SO_QTY"]) : 0,
                                        desp_place = dr["UOM"] != DBNull.Value ? Convert.ToString(dr["UOM"]) : ""
                                    });
                            }
                        }
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
                ws.Cell("D2").Value = "Weigh Out Date & Time ";
                ws.Cell("E2").Value = obj.Tare_Wt_Dt;

                ws.Cell("A3").Value = "Vehicle No. ";
                ws.Cell("B3").Value = obj.Truck_No;
                ws.Cell("D3").Value = "Transporter Name ";
                ws.Cell("E3").Value = obj.Transporter_Name;

                ws.Cell("A4").Value = "Out Weight ";
                if (Inward_Sys_Id == "2") { ws.Cell("B4").Value = obj.Tare_Wt + " Kg"; } else { ws.Cell("B4").Value = obj.Gross_Wt + " Kg"; };

                if (Inward_Sys_Id == "3")
                    ws.Cell("A5").Value = "SO No ";
                else
                    ws.Cell("A5").Value = "PO No ";

                ws.Cell("B5").Value = obj.MDA_No;

                if (Inward_Sys_Id == "2")
                {
                    ws.Cell("A8").Value = "Sr No.";
                    ws.Cell("B8").Value = "Description";
                    ws.Cell("C8").Value = "Receive Qty";
                    ws.Cell("D8").Value = "UoM";
                    ws.Range("A8:Z8").Style.Font.SetBold();

                    DataTable dt = new DataTable("Grid");
                    dt.Columns.AddRange(new DataColumn[4] { new DataColumn("Sr No."),
                                            new DataColumn("Product Description"),
                                            new DataColumn("Receive Qty"),
                                            new DataColumn("UoM") });

                    foreach (var item in list)
                    {
                        dt.Rows.Add(item.SrNo, item.prd_desc, item.no_of_bottle, item.desp_place);
                    }

                    ws.Cell("A9").InsertData(dt);
                }
                else
                {
                    ws.Cell("A8").Value = "Sr No.";
                    ws.Cell("B8").Value = "Description";
                    ws.Cell("C8").Value = "UoM";
                    ws.Cell("D8").Value = "Qty";
                    ws.Range("A8:Z8").Style.Font.SetBold();

                    DataTable dt = new DataTable("Grid");
                    dt.Columns.AddRange(new DataColumn[4] { new DataColumn("Sr No."),
                                            new DataColumn("Description"),
                                            new DataColumn("UoM"),
                                            new DataColumn("Qty") });
                    foreach (var item in list)
                    {
                        dt.Rows.Add(item.SrNo, item.prd_desc, item.no_of_bottle, item.desp_place);
                    }

                    ws.Cell("A9").InsertData(dt);
                }


                //wb.Worksheets.Add(dt);
                using (MemoryStream stream = new MemoryStream())
                {
                    wb.SaveAs(stream);
                    return File(stream.ToArray(), "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", (obj != null && !string.IsNullOrEmpty(obj.Report_Title) ? obj.Report_Title : "Weighment Slip") + " - Weight In - " + obj.Truck_No + ".xlsx");
                }
            }

            //return null;
        }

        #endregion
    }
}
