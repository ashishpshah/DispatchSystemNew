using System.ComponentModel.DataAnnotations;

namespace Dispatch_System
{
	public class Vendor
	{
		public long Id { get; set; }
		public long PlantId { get; set; }
		public long UserId { get; set; }
		public long? VendorCode { get; set; }
		public long? VendorCode_Temp { get; set; }
		public string VendorType { get; set; }
		public string SiteCode { get; set; }
		public string SiteName { get; set; }
		public string Organization_Name { get; set; }
		public string First_Name { get; set; }
		public string Middle_Name { get; set; }
		public string Last_Name { get; set; }
		public string MobileNo { get; set; }
		public string Alt_Mobile_No { get; set; }
		public string Email_Id { get; set; }
		public string Alt_Email_Id { get; set; }
		public string Full_Address { get; set; }
		public int Country_Id { get; set; }
		public int State_Id { get; set; }
		public int District_Id { get; set; }
		public string City { get; set; }
		public int Postal_Code { get; set; }
		public int Print_Label_Qty { get; set; }
		public bool Is_System_User { get; set; }
		public bool Is_Lock { get; set; }
		public bool Is_Posted { get; set; }
		public bool Is_Active { get; set; }
		public string Password { get; set; }
		public string ConfirmPassword { get; set; }

		public string SelectedPlants { get; set; }
		public List<Vendor> listSite { get; set; }

		public bool IsPassword_Reset { get; set; }
		public string Country_Name { get; set; }
		public string State_Name { get; set; }
		public string District_Name { get; set; }
		public string Plant_Name { get; set; }

        public int Open { get; set; }
        public int Downloaded { get; set; }
        public int Printed { get; set; }
        public int Dispatched { get; set; }
        public string Is_ERP_Vendor { get; set; }
        public string Fullname { get { return (!string.IsNullOrEmpty(First_Name) ? First_Name : "") + (!string.IsNullOrEmpty(Last_Name) ? " " + Last_Name : ""); } }
	}
}
