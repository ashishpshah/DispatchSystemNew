namespace Dispatch_System
{
	public class Plant
	{
		public long PlantID { get; set; }
		public long UnitCode { get; set; }
		public string PlantCode { get; set; }
		public string Plant_Name { get; set; }
		public string PlantAddress { get; set; }
		public bool IsActive { get; set; }
		public string? CREATED_BY { get; internal set; }
		public object CREATED_DATETIME { get; internal set; }
		public string? MODIFIED_BY { get; internal set; }
		public object MODIFIED_DATE { get; internal set; }

	}
}


