namespace Dispatch_System
{
	public class ChangePassword
	{
        public int VendorCode { get; set; }
        public int SiteId { get; set; }
        public string UserName { get; set; }
        public string CurrentPassword { get; set; }
		public string NewPassword { get; set; }
		public string ConfirmPassword { get; set; }

	}
}
