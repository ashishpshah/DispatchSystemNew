namespace Dispatch_System
{
	public class VendorPoDtls
	{
		public long Id { get; set; }
		public long VPO_Id { get; set; }
		public long PlantId { get; set; }
		public string LineNo { get; set; }
		public string LineDesc { get; set; }
		public string UOM { get; set; }
		public long LineQty { get; set; }
		public long Remaining_Qty { get; set; }
		public long Requested_Qty { get; set; }
		public long Adjusted_Qty { get; set; }
		public long Amendment_Qty { get; set; }
		public string Remark { get; set; }
		public bool IsPosted { get; set; }
		public bool IsActive { get; set; }
	}
}
