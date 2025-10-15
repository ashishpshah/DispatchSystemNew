namespace Dispatch_System
{
	public class VendorPO
	{
		public long SrNo { get; set; }
		public long Id { get; set; }
		public long SiteId { get; set; }
		public long PlantId { get; set; }
		public long? VendorId { get; set; }
		public long? VendorCode { get; set; }
		public string VendorName { get; set; }
		public string VendorSite { get; set; }
		public string PoNo { get; set; }
		public DateTime? PoDate { get; set; }
		public string PoDate_Text { get; set; }
		public string PoDesc { get; set; }
		public bool IsActive { get; set; }
		public bool IsLock { get; set; }
		public decimal? Print_Label_Qty { get; set; }
        public long Remaining_Qty { get; set; }

        public List<VendorPoDtls> listVendorPoDtls { get; set; }

	}
}
