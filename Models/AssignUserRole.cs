namespace Dispatch_System
{
	public class AssignUserRole
	{
		public long Id { get; set; } = 0!;
		public long User_Id { get; set; } = 0!;
		public long Role_Id { get; set; } = 0!;
		public string User_Name { get; set;}
		public string Role_Name { get; set;} = string.Empty;
	}
}
