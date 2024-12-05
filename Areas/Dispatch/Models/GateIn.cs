using System.Text.Json.Serialization;

namespace Dispatch_System
{
	public class GateIn
	{
		public long Id { get; set; }
		public long Sr_No { get; set; }
		public DateTime? Gate_In_Dt { get; set; }
		public DateTime? Gate_Out_Dt { get; set; }
		public string Inward_Sys_Id { get; set; }
		public long Common_Sys_Id { get; set; }
		[JsonIgnore] public string Common_Sys_Id_Multi { get; set; }
		public string MDA_No { get; set; }
		public string Common_No { get; set; }
		public string Common_Date { get; set; }
		public string Vendor_Code { get; set; }
		public string Vendor_Name { get; set; }
		public bool Is_Common_Dtls_Manually { get; set; }
		public string Truck_No { get; set; }
		public string Transporter_Code { get; set; }
		public string Transporter_Name { get; set; }
		public string Driver_Id_Type { get; set; }
		public string Driver_Id_Number { get; set; }
		public string Driver_Name { get; set; }
		public string Driver_Contact { get; set; }
		public bool Driver_Changed { get; set; }
		public string Driver_Name_New { get; set; }
		public string Driver_Contact_New { get; set; }
		public bool Truck_Validation { get; set; }
		public long RefSysId { get; set; }
		public long RefSysIdOld { get; set; }
		public string RFID_Number { get; set; }
		public string Status { get; set; }
		public string RFID_Serial_Number { get; set; }
		public bool Verified_Documents { get; set; }
		public bool Rfid_Receive { get; set; }
		public string Verified_Officer_Id { get; set; }
		public string Verified_Officer_Name { get; set; }
		public bool Cancel_Gate_In { get; set; }
		public string Cancel_Gate_Reason { get; set; }
		public long Gate_Sys_Id_Old { get; set; }
		public bool Is_Goods_Transfer { get; set; }
		public long Station_Id { get; set; }
		public long Plant_Id { get; set; }
		public string Plant_CD { get; set; }
		public long Created_By_Id { get; set; }
		public DateTime? Created_Datetime { get; set; }
		public bool Is_Posted { get; set; }
		public string UOM { get; set; }
		public string TransactionType { get; set; }

		public long GateIn_Id { get; set; }
		public long WeightIn_Id { get; set; }
		public double Tare_Wt { get; set; }
		public DateTime? Tare_Wt_Dt { get; set; }
		public double Gross_Wt { get; set; }
		public DateTime? Gross_Wt_Dt { get; set; }
		public double Net_Wt { get; set; }
		public string Gate_Out_Note { get; set; }


		public double WeighIn_Wt { get; set; }
		public string WeighIn_Wt_Dt { get; set; }
		public string WeighIn_Wt_Note { get; set; }
		public double WeighOut_Wt { get; set; }
		public string WeighOut_Wt_Dt { get; set; }
		public string WeighOut_Wt_Note { get; set; }


        public int Expected_Shipper { get; set; }
        public int Loaded_Shipper { get; set; }


        public bool Transporter_Changed { get; set; }
        public string Transporter_Code_New { get; set; }
    }

	public class KnowYourBatch
	{
		public long Plant_Id { get; set; }
		public long Mda_Sys_Id { get; set; }
		public long Shipper_QR_Code_Id { get; set; }
		public string Mda_No { get; set; }
		public string Batch_Start_Date { get; set; }
		public string Batch_No { get; set; }
		public string Loaded_Shipper { get; set; }
		public string PlantName { get; set; }
		public string Mfg_Date { get; set; }
		public string Exp_Date { get; set; }
		public string Mda_Date { get; set; }
		public string Status { get; set; }
		public string InvoiceQrCode { get; set; }
		public string Product { get; set; }
		public string Shipper_QrCode { get; set; }
		public string Bottle_QrCode { get; set; }
		public string Desp_Place { get; set; }
		public string Party_Name { get; set; }
		public List<string> listShipper_QrCode { get; set; }
	}

	public class KnowYourInvoice
	{
		public long Plant_Id { get; set; }
		public long Mda_Sys_Id { get; set; }
		public long Shipper_QR_Code_Id { get; set; }
		public string Mda_No { get; set; }
		public string Batch_No { get; set; }
		public string PlantName { get; set; }
		public decimal NoOfBox { get; set; }
		public decimal Required_Shipper { get; set; }
		public decimal Loaded_Shipper { get; set; }
		public string Gate_In_Date { get; set; }
		public string Gate_Out_Date { get; set; }
		public string Mda_Date { get; set; }
		public string Status { get; set; }
		public string InvoiceQrCode { get; set; }
		public string Desp_Place { get; set; }
		public string Truck_No { get; set; }
		public string Transporter_Name { get; set; }
		public string Prod_Desc { get; set; }
		public string Driver_Id_Type { get; set; }
		public string Driver_Id_Number { get; set; }
		public string Driver_Name { get; set; }
		public string Driver_Contact { get; set; }
		public double Tare_Wt { get; set; }
		public string Tare_Wt_Dt { get; set; }
		public double Gross_Wt { get; set; }
		public string Gross_Wt_Dt { get; set; }
		public double Net_Wt { get; set; }
		public string Gate_Out_Note { get; set; }

		public List<ShipperBatch> listShipperBatch { get; set; }
	}

    public class ShipperData
    {
        [JsonIgnore]
        public decimal Id { get; set; }
        public string ServiceID { get; set; }
        public string Token { get; set; }
        public string PlantCd { get; set; }
        public string Batch_no { get; set; }
        public string Mfg_Date { get; set; }
        public string Expiry_Date { get; set; }
        public string ManufacturedBy { get; set; }
        public string MarketedBy { get; set; }

        public List<ShipperEvent> ShipperQRCode_Data { get; set; }
    }

    public class ShipperEvent
    {
        [JsonIgnore]
        public decimal Id { get; set; }
        [JsonIgnore]
        public decimal ShipperId { get; set; }
        public string EventTime { get; set; }
        public string ShipperQRCode { get; set; }
        public string OldShipperQRCode { get; set; }
        public string Action { get; set; }
        public string BottlesQuantity { get; set; }

        public List<string> BottleQRCode { get; set; }
    }

    public class ShipperBottle
    {
        public decimal Id { get; set; }
        [JsonIgnore]
        public decimal ShipperEventId { get; set; }
        public string BottleQRCode { get; set; }
    }

    public class ShipperBatch
	{
		public Int64 SrNo { get; set; }
		public long Id { get; set; }
		public string ShipperQRCode { get; set; }
		public string Batch_no { get; set; }
		public string mfg_dt { get; set; }
		public string expiry_dt { get; set; }
		public string QR_Codes { get; set; }
		public string Reject_Reason { get; set; }
		public string Status { get; set; }

	}

	public class ShipperQRCodeModel
	{
		public long Id { get; set; }
		public string ShipperQRCode { get; set; }
		public string Action { get; set; }
		public int Count { get; set; }
		public int Length { get; set; }
	}

	public class ShipperQRCodeDetails
	{
		public long Id { get; set; }
		public long Shipper_QrCode_Id { get; set; }
		public string ShipperQRCode { get; set; }
		public string BottleQRCode { get; set; }
		public int Count { get; set; }
		public int Length { get; set; }
	}

	public class BatchLogFile
	{
		public long SrNo { get; set; }
		public string FileName { get; set; }
		public string StartDate { get; set; }
		public string EndDate { get; set; }
		public long QRCode_Count { get; set; }
		public string Status { get; set; }
		public string Remark { get; set; }
		public string Batch_no { get; set; }
		public string mfg_dt { get; set; }
		public string expiry_dt { get; set; }
		public string total_shipper_qty { get; set; }
	}

	public class WeightIn
	{
		public long Id { get; set; }
		public long Gate_In_Id { get; set; }
		public string Truck_No { get; set; }
		public long Inward_Sys_Id { get; set; }
		public double Gross_Wt { get; set; }
		public double Gross_Wt_1 { get; set; }
		public DateTime? Gross_Wt_Dt { get; set; }
		public bool Gross_Wt_Manually { get; set; }
		public string Gross_Wt_Note { get; set; }
		public double Tare_Wt { get; set; }
		public double Tare_Wt_1 { get; set; }
		public double Tare_Wt_Manually { get; set; }
		public DateTime? Tare_Wt_Dt { get; set; }
		public bool Is_Tare_Wt_Manually { get; set; }
		public string Tare_Wt_Note { get; set; }
		public double Net_Wt { get; set; }
		public bool Net_Wt_Manually { get; set; }
		public bool Out_Of_Tolerance_Wt { get; set; }
		public DateTime? Tolerance_Wt { get; set; }
		public bool Allow_Tolerance_Wt { get; set; }
		public long Station_Id { get; set; }
		public long Plant_Id { get; set; }
		public bool Is_Posted { get; set; }
		public long Created_By_Id { get; set; }
		public DateTime? Created_Datetime { get; set; }
		public string UOM { get; set; }


		public double WeighIn_Wt { get; set; }
		public string WeighIn_Wt_Dt { get; set; }
		public string WeighIn_Wt_Note { get; set; }
		public double WeighOut_Wt { get; set; }
		public string WeighOut_Wt_Dt { get; set; }
		public string WeighOut_Wt_Note { get; set; }
	}


	public class PO
	{
		public long SrNo { get; set; }
		public long Gate_In_Id { get; set; }
		public long Id { get; set; }
		public string PoNo { get; set; }
		public DateTime? PoDate { get; set; }
		public string PoDate_Text { get; set; }
		public string PoDesc { get; set; }
		public long? VendorId { get; set; }
		public long? SiteId { get; set; }
		public long? CostCenter { get; set; }
		public long TransId { get; set; }
		public string TruckNo { get; set; }
		public string VendorName { get; set; }
		public string SelectedSiteName { get; set; }
		public string SiteName { get; set; }
		public string Transporter_Code { get; set; }
		public string Transporter_Name { get; set; }
		public bool Is_PO_Manually { get; set; }
		public bool IsPosted { get; set; }
		public long PlantId { get; set; }
		public string Plant_CD { get; set; }
		public List<PODtls> listPoDtls { get; set; }

	}
	public class PODtls
	{
		public long Id { get; set; }
		public long PO_Id { get; set; }
		public string LineNo { get; set; }
		public string LineDesc { get; set; }
		public string UOM { get; set; }
		public string ReceiveUOM { get; set; }
		public long LineQty { get; set; }
		public long Remaining_Qty { get; set; }
		public long Requested_Qty { get; set; }
		public long ReceiveQty { get; set; }
		public long ShortQty { get; set; }
		public bool IsPosted { get; set; }
	}

	public class SO
	{
		public long Id { get; set; }
		public long Gate_In_Id { get; set; }
		public string SoNo { get; set; }
		public DateTime? SoDate { get; set; }
		public string SoDate_Text { get; set; }
		public DateTime? SoReleaseDate { get; set; }
		public string SoReleaseDate_Text { get; set; }
		public DateTime? SoValidDate { get; set; }
		public string SoValidDate_Text { get; set; }
		public string Truck_No { get; set; }
		public string Transporter_Code { get; set; }
		public string Transporter_Name { get; set; }
		public string Loading_Gate { get; set; }
		public string Driver_Id_Type { get; set; }
		public string Driver_Id_Number { get; set; }
		public string Driver_Name { get; set; }
		public string Driver_Contact { get; set; }
		public long SequenceNo { get; set; }
		public string TenderNo { get; set; }
		public DateTime? TenderDate { get; set; }
		public string TenderDate_Text { get; set; }
		public long VendorId { get; set; }
		public long CustCd { get; set; }
		public string SiteId { get; set; }
		public string CustName { get; set; }
		public long CustSiteCd { get; set; }
		public string SiteName { get; set; }
		public string Add1 { get; set; }
		public string Add2 { get; set; }
		public string Add3 { get; set; }
		public string City { get; set; }
		public long Pin { get; set; }
		public string State { get; set; }
		public string StateCd { get; set; }
		public string GstnNo { get; set; }
		public string PanNo { get; set; }
		public long CustNonGst { get; set; }
		public string TelNo { get; set; }
		public string SoRemarks { get; set; }
		public string Status { get; set; }
		public DateTime? StatusDate { get; set; }
		public string StatusDate_Text { get; set; }
		public string StatusRemarks { get; set; }
		public string TermsPymtTerm { get; set; }
		public string TermsLiftingPeriodDays { get; set; }
		public string TenderType { get; set; }
		public string AmendNo { get; set; }
		public string EmdAmt { get; set; }
		public string TermsPrice { get; set; }
		public DateTime? AmendReleaseDate { get; set; }
		public string AmendReleaseDate_Text { get; set; }
		public DateTime? CreatedDatetime { get; set; }
		public bool IsPosted { get; set; }
		public long PlantId { get; set; }
		public string Rivision { get; set; }

		public List<SODtls> listSoDtls { get; set; }

	}

	public class SODtls
	{
		public long Id { get; set; }
		public long SO_Id { get; set; }
		public long UnitCode { get; set; }
		public long SoNo { get; set; }
		public long SlNo { get; set; }
		public long ScrapCd { get; set; }
		public string ScrapDesc { get; set; }
		public string Uom { get; set; }
		public string LoadingUom { get; set; }
		public long ErpUomcd { get; set; }
		public long SoQty { get; set; }
		public long LoadingQty { get; set; }
		public long BasicAmt { get; set; }
		public long PlantId { get; set; }
		public bool IsPosted { get; set; }
	}


	public class OtherMaterial
	{
		public long Id { get; set; }
		public long Gate_In_Id { get; set; }
		public string OrderNo { get; set; }
		public DateTime? OrderDate { get; set; }
		public string OrderDate_Text { get; set; }
		public string Truck_No { get; set; }
		public string Transporter_Code { get; set; }
		public string Transporter_Name { get; set; }
		public string Driver_Id_Type { get; set; }
		public string Driver_Id_Number { get; set; }
		public string Driver_Name { get; set; }
		public string Driver_Contact { get; set; }

		public List<OtherMaterialDtls> listOtherMaterialDtls { get; set; }

	}

	public class OtherMaterialDtls
	{
		public long Id { get; set; }
		public long OM_Id { get; set; }
		public long SrNo { get; set; }
		public string Material { get; set; }
		public string MaterialDesc { get; set; }
		public string UOM { get; set; }
		public decimal Qty { get; set; }
	}

}
