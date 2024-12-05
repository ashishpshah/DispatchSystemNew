namespace Dispatch_System
{
	public class District
	{
		public string District_Name { get; set; }
		public string Country_Name { get; set; }
		public string State_Name { get; set; }
		public int CountryId { get; set; }
        public string Code { get; set; }
        public int State_Id { get; set; }
		public int Plant_Id { get; set; }
        public bool IsActive { get; set; }
        public string? CREATED_BY { get;  set; }
		public object CREATED_DATETIME { get;  set; }
		public string? MODIFIED_BY { get;  set; }
		public object MODIFIED_DATE { get; set; }
        public int Id { get; set; }
    }
}


