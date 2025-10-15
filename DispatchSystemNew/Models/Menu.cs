namespace Dispatch_System
{
	public class Menu
	{
		public int Id { get; set; }
		public string Area { get; set; }
		public string Controller { get; set; }
		public string Menu_Name { get; set; }
		public string Display_Name { get; set; }
		public string Url { get; set; }
		public int DisplayOrder { get; set; }
		public int Parent_Id { get; internal set; }
		public bool IsActive { get; internal set; }
	}
}
