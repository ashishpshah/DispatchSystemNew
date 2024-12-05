using Humanizer;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace Dispatch_System
{
	public class MDA
	{
		public long Id { get; set; }
		public long GateInOut_Id { get; set; }
		public long Inward_Sys_Id { get; set; }
		public string Inward_Type { get; set; }
		public string mda_no { get; set; }
		public string di_no { get; set; }
		public string plant_cd { get; set; }
		public string gatein_dt { get; set; }
		public string mda_dt { get; set; }
		public string tptr_cd { get; set; }
		public string tptr_name { get; set; }
		public string wh_cd { get; set; }
		public string party_name { get; set; }
		public string vendor_code { get; set; }
		public string driver { get; set; }
		public string vehicle_no { get; set; }
		public string mobile_no { get; set; }
		public long dist { get; set; }
		public long bag_nos { get; set; }
		public double Tare_Wt { get; set; }
		public double nett_qty { get; set; }
		public double gross_qty { get; set; }
		public string echit_no { get; set; }
		public string gst_no { get; set; }
		public decimal Out_Tolerance_Weight { get; set; }
		public string out_time { get; set; }
		public string Remarks { get; set; }
		public string Allow_Out_Tolerance { get; set; }
		public string desp_place { get; set; }
		public string Driver_Id_Type { get; set; }
		public string Driver_Id_Number { get; set; }
		public int mda_order { get; set; }
        [JsonIgnore] public Int64 sr_no { get; set; }
        [JsonIgnore] public string prod_cd { get; set; }
        [JsonIgnore] public string prod_name { get; set; }
        [JsonIgnore] public string Vehicle_Shippers { get; set; }
        [JsonIgnore] public decimal Required_Shipper { get; set; }
        [JsonIgnore] public decimal Loaded_Shipper { get; set; }
        [JsonIgnore] public decimal Expected_Shipper { get; set; }
    }

	public class MDA_Status
	{

		public long PlantId { get; set; }
		public string PlantName { get; set; }
		public string SrNo { get; set; }
		public string MDANo { get; set; }
		public string MDAStatus { get; set; }
		public string TransactionType { get; set; }
		public string ArticleCode { get; set; }
		public string ArticleName { get; set; }
		public string MDAReceiveDate { get; set; }
		public string TruckNo { get; set; }
		public string DriverName { get; set; }
		public string DriverContact { get; set; }
		public string CustomerName { get; set; }
		public string Transporter { get; set; }
		public string SKUCode { get; set; }
		public string SkuDesc { get; set; }
		public string Destination { get; set; }
		public string BatchNo { get; set; }
		public string ShipperBatchNo { get; set; }
		public string ManufacturingDate { get; set; }
		public string ExpiryDate { get; set; }
		public string RFID { get; set; }
		public string LoadingInDateTimePrintedFrom { get; set; }
		public string LoadingOutDateTimePrintedFrom { get; set; }
		public string LoadingBayPrintedTo { get; set; }
		public string LoadingBayOperatorTo { get; set; }
		public long TotalShipperQTY { get; set; }
		public long MDAQty { get; set; }
		public long MDAUpdateQty { get; set; }
		public long LoadedQty { get; set; }
		public string DispatchDateTime { get; set; }
		public string DispatchFromType { get; set; }
		public string DispatchFromCodeAndName { get; set; }
		public string DispatchToType { get; set; }
		public string DispatchToCodeAndName { get; set; }
		public long DispatchedQtyKL { get; set; }
		public long DispatchedQtyShipper { get; set; }
		public long DispatchedQtyUnits { get; set; }
		public string InvoiceQrCode { get; set; }
		public string QRCode { get; set; }
		public string GateInDateTime { get; set; }
		public string GateOutDispatch { get; set; }
		public string TATHHMM { get; set; }
		public string WeighInDateTime { get; set; }
		public string WeighOutDateTime { get; set; }
		public string OutofTolerance { get; set; }
		public string Reason { get; set; }
		public long TareWeight { get; set; }
		public long NetWeight { get; set; }
		public long OutofToleranceWeight { get; set; }
	}


	public class MDA_Header
	{
		public long Id { get; set; }
		public long GateInOut_Id { get; set; }
		public string Mda_No { get; set; }
		public string Di_No { get; set; }
		public long Plant_Id { get; set; }
		public string Plant_Cd { get; set; }
		public string Gate_In_Dt { get; set; }
		public DateTime? Mda_Dt { get; set; }
		public long Trans_Sys_Id { get; set; }
		public string tptr_cd { get; set; }
		public string tptr_name { get; set; }
		public string Wh_Cd { get; set; }
		public string Party_Name { get; set; }
		public string Driver { get; set; }
		public string Vehicle_No { get; set; }
		public string Mobile_No { get; set; }
		public decimal Dist { get; set; }
		public decimal Bag_Nos { get; set; }
		public decimal Tare_Wt { get; set; }
		public decimal Nett_Qty { get; set; }
		public decimal Gross_Qty { get; set; }
		public decimal Out_Tolerance_Weight { get; set; }
		public string Echit_No { get; set; }
		public string Gst_No { get; set; }
		public string Remarks { get; set; }
		public string Allow_Out_Tolerance { get; set; }
		public DateTime? Out_Time { get; set; }
		public long dist { get; set; }
		public string Desp_Place { get; set; }
		public bool Is_Posted { get; set; }

	}


	public class MDA_Dtls
	{
		public long Id { get; set; }
		public long Mda_Id { get; set; }
		public long GateInOut_Id { get; set; }
		public string Mda_No { get; set; }
		public string Vehicle_No { get; set; }
		public string Common_No { get; set; }
		public long Prod_Sno { get; set; }
		public DateTime? Mda_Dt { get; set; }
		public long Prod_Sys_Id { get; set; }
		public long Shipment_No { get; set; }
		public string sku_code { get; set; }
		public string sku_name { get; set; }
		public string prd_cd { get; set; }
		public string prd_desc { get; set; }
		public decimal Bag_Nos { get; set; }
		public decimal Nett_Qty { get; set; }
		public decimal Gross_Qty { get; set; }
		public long Plant_Id { get; set; }
		public string Plant_Name { get; set; }
		public string Plant_Address { get; set; }
		public bool Is_Posted { get; set; }
		public bool Is_BypassWMS { get; set; }
		public string Party_Name { get; set; }


		public decimal Carton_Qty { get; set; }
		public decimal Required_Shipper { get; set; }
		public decimal Loaded_Shipper { get; set; }
		public int mda_order { get; set; }
		public long dist { get; set; }
		public string Wh_Cd { get; set; }
		public string Reason { get; set; }
		public string Comments { get; set; }
		public string Desp_Place { get; set; }
		public string PlantName { get; set; }

		public List<ShipperBatch> listShipperBatch { get; set; }
	}

	public class ProductAPI
	{
		[JsonIgnore]
		public Int64 prd_id { get; set; }
		public string prd_cd { get; set; }
		public string prd_desc { get; set; }
		public string prd_desc_h { get; set; }
		public string plant_cd { get; set; }
		public int print_order { get; set; }
		public string prd_desc_short { get; set; }
		public string extra1 { get; set; }
		public string extra2 { get; set; }
		public string extra3 { get; set; }
		public string prd_type { get; set; }
		public string sub_plant_cd { get; set; }
		public string prd_category { get; set; }
		public string active { get; set; }
		public long hsn_code { get; set; }
		public string uom { get; set; }
		public double conv_factor { get; set; }
		public string uom_evikas { get; set; }
		public string prd_cd_group_app { get; set; }
	}

	public class PlantAPI
	{
		[JsonIgnore]
		public Int64 plant_id { get; set; }
		public string plant_cd { get; set; }
		public string plant_name { get; set; }
		public string plant_name_h { get; set; }
		public string state_cd { get; set; }
		public string extra1 { get; set; }
	}

	public class WarehouseAPI
	{
		public string party_cd { get; set; }
		public string party_name { get; set; }
		public string addr1 { get; set; }
		public string tehsil_cd { get; set; }
		public string party_name_h { get; set; }
		public string pin_cd { get; set; }
		public string tin_no { get; set; }
		public string email { get; set; }
		public string warehousing { get; set; }
		public string handling { get; set; }
		public string sales { get; set; }
		public string tptn { get; set; }
		public string inv { get; set; }
		public string agency_cd { get; set; }
		public string distt_cd { get; set; }
		public string state_cd { get; set; }
		public string wh_capacity { get; set; }
		public string consignee { get; set; }
		public string party_fas_cd { get; set; }
		public string fsc { get; set; }
		public string port_wh { get; set; }
		public string active { get; set; }
		public string retailer_license_no { get; set; }
		public string dealer_type { get; set; }
		public string dealer_nature { get; set; }
		public string wholesales_license_no { get; set; }
		public string pan_no { get; set; }
		public string mobile_no { get; set; }
		public string panchayat { get; set; }
		public string urban_name { get; set; }
		public string ward_name { get; set; }
		public string village_name { get; set; }
		public string tin_no_effective_dt { get; set; }
		public string rkvy { get; set; }
		public string fertiliser_lecence_validity { get; set; }
		public string virtual_entity { get; set; }
		public string gstin { get; set; }
		public string gstin_effective_dt { get; set; }
		public string longitude { get; set; }
		public string latitude { get; set; }
		public string stocking_point_flag { get; set; }
		public string speciality_fertiliser_activist { get; set; }
	}
	public class WholesalerAPI
	{
		public string party_cd { get; set; }
		public string party_name { get; set; }
		public string addr1 { get; set; }
		public string tehsil_cd { get; set; }
		public string pin_cd { get; set; }
		public string phone_no_1 { get; set; }
		public string tin_no { get; set; }
		public string email { get; set; }
		public string warehousing { get; set; }
		public string handling { get; set; }
		public string sales { get; set; }
		public string tptn { get; set; }
		public string inv { get; set; }
		public string agency_cd { get; set; }
		public string distt_cd { get; set; }
		public string state_cd { get; set; }
		public string wh_capacity { get; set; }
		public string consignee { get; set; }
		public string fsc { get; set; }
		public string port_wh { get; set; }
		public string active { get; set; }
		public string dealer_type { get; set; }
		public string dealer_nature { get; set; }
		public string wholesales_license_no { get; set; }
		public string pan_no { get; set; }
		public string mobile_no { get; set; }
		public string panchayat { get; set; }
		public string village_cd { get; set; }
		public string village_name { get; set; }
		public string nic_village_cd { get; set; }
		public string text { get; set; }
		public string mfms_id_wholesaler { get; set; }
		public string tin_no_effective_dt { get; set; }
		public string rkvy { get; set; }
		public string fertiliser_lecence_validity { get; set; }
		public string virtual_entity { get; set; }
		public string gstin { get; set; }
		public string gstin_effective_dt { get; set; }
		public string speciality_fertiliser_activist { get; set; }
	}

	public class RetailerAPI
	{
		public string party_cd { get; set; }
		public string party_name { get; set; }
		public string addr1 { get; set; }
		public string tehsil_cd { get; set; }
		public string party_name_h { get; set; }
		public string pin_cd { get; set; }
		public string tin_no { get; set; }
		public string credit_limit { get; set; }
		public string warehousing { get; set; }
		public string handling { get; set; }
		public string sales { get; set; }
		public string tptn { get; set; }
		public string inv { get; set; }
		public string agency_cd { get; set; }
		public string distt_cd { get; set; }
		public string state_cd { get; set; }
		public string wh_capacity { get; set; }
		public string reserved_by_iffco { get; set; }
		public string consignee { get; set; }
		public string addr2 { get; set; }
		public string fsc { get; set; }
		public string port_wh { get; set; }
		public string active { get; set; }
		public string retailer_license_no { get; set; }
		public string dealer_type { get; set; }
		public string dealer_nature { get; set; }
		public string pan_no { get; set; }
		public string mobile_no { get; set; }
		public string panchayat { get; set; }
		public string village_cd { get; set; }
		public string village_name { get; set; }
		public string nic_village_cd { get; set; }
		public string text { get; set; }
		public string mfms_id { get; set; }
		public string tin_no_effective_dt { get; set; }
		public string rkvy { get; set; }
		public string fertiliser_lecence_validity { get; set; }
		public string virtual_entity { get; set; }
		public string contact_person { get; set; }
		public string gstin { get; set; }
		public string gstin_effective_dt { get; set; }
		public string gstin_effective_to_dt { get; set; }
	}


}
