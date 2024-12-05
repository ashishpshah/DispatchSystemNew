namespace Dispatch_System
{
	public class Menu1
	{
		public long Sr_No { get; set; }
		public long Id { get; set; }
		public long Parent_Id { get; set; }
		public string Area { get; set; }
		public string Controller { get; set; }
		public string Parent_Menu_Name { get; set; }
		public string Display_Name { get; set; }
		public string Url { get; set; }
		public long DisplayOrder { get; set; }
		public bool IsActive { get; set; }
		public bool IsAdmin { get; set; }
	}
}
