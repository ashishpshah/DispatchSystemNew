using System.ComponentModel.DataAnnotations;

namespace Dispatch_System
{
    public class User
    {
        public long Id { get; set; }
        //public string UserId { get; set; }
        public string Username { get; set; }
        public string First_Name { get; set; }
        public string Middle_Name { get; set; }
        public string Last_Name { get; set; }
        public string Unit_Code { get; set; }
        public long Plant_Id { get; set; }
        public long Role_Id { get; set; }
        public string Plant_Name { get; set; }
        public string Role_Name { get; set; }
        public bool Is_Active { get; set; }
        public bool Is_Admin { get; set; }
        public bool Is_Lock { get; set; }
        public bool IsPassword_Reset { get; set; }
        public int Country_Id { get; set; }
        public int State_Id { get; set; }
        public int District_Id { get; set; }
        public string Password { get; set; }
        public string MobileNo { get; set; }
        public string Alt_Mobile_No { get; set; }
        public string Email_Id { get; set; }
        public string Alt_Email_Id { get; set; }
        public string Full_Address { get; set; }
        public string City { get; set; }
        public int Postal_Code { get; set; }
        public string User_Code { get; set; }
        public string Plant_Role { get; set; }
        public long Default_Plant { get; set; }

        public string Fullname { get { return (!string.IsNullOrEmpty(First_Name) ? First_Name : "") + (!string.IsNullOrEmpty(Last_Name) ? " " + Last_Name : ""); } }
    }
}
