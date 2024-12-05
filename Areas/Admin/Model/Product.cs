namespace Dispatch_System
{
	public class Product
	{
		public int Id { get; set; }
		public int Plant_id { get; set; }
		public string Plant_cd { get; set; }
		public string Sku_code { get; set; }
		public string Sku_name { get; set; }
		public string Prd_cd { get; set; }
		public string Prd_desc { get; set; }
		public int Is_posted { get; set; }
		public decimal Prd_wt_fill { get; set; }
		public decimal Ship_wt_fill { get; set; }
		public decimal Prod_per_shipper { get; set; }
		public decimal Tolerance_per { get; set; }
		public decimal Pal_wt_fill { get; set; }
		public decimal Ship_per_pallet { get; set; }
		public string Note { get; set; }
		public string Prd_desc_h { get; set; }
		public string Print_order { get; set; }
		public string Prd_desc_short { get; set; }
		public string Extra1 { get; set; }
		public string Extra2 { get; set; }
		public string Extra3 { get; set; }
		public string Prd_type { get; set; }
		public string Sub_plant_cd { get; set; }
		public string Prd_category { get; set; }
		public string Active { get; set; }
		public string Hsn_code { get; set; }
		public string Prd_cd_group_app { get; set; }
		public string Uom { get; set; }
		public string Gtin { get; set; }
		public long ConvFactor { get; set; }
		public string UomEvikas { get; set; }
		public string Qr_last_serial_no { get; set; }
		public string BPEX { get; set; }
		public bool Isactive { get; set; }
		public int Createdby { get; set; }
		public DateTime Createddate { get; set; }
		public int Lastmodifiedby { get; set; }
		public DateTime Lastmodifieddate { get; set; }
		public int? ValidMonth { get; set; }
	}
}
