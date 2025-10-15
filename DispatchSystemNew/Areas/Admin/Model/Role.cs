namespace Dispatch_System
{
	public class Role
	{
		public long Id { get; set; }
		public long Plant_Id { get; set; }
		public string Role_Name { get; set; }
		public string Plant_Name { get; set; }
		public bool IsActive { get; set; }
		public bool IsAdmin { get; set; }
		public string SelectedMenu { get; set; }
	}
}
