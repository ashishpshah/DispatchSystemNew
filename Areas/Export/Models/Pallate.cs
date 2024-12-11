namespace Dispatch_System
{
    public class Pallate
    {
        public long Id { get; set; }
        public int Sr_No { get; set; }
        public string DI_No { get; set; }
        public string Pallate_No { get; set; }
        public string Pallate_Type { get; set; }
        public long Shipper_Qty { get; set; }
        public string Dispatch_Mode { get; set; }
        public string Pallate_Type_Text { get; set; }
        public string Dispatch_Mode_Text { get; set; }
        public DateTime? Created_Datetime { get; set; }
        public string Plant_Id { get; set; }

        public List<Pallate_Shipper> Shipper_QR_Code { get; set; }

    }

    public class Pallate_Shipper
    {
        public long Id { get; set; }
        public int Sr_No { get; set; }
        public long Pallate_Id { get; set; }
        public string DI_No { get; set; }
        public string QR_Code { get; set; }
        public string Status { get; set; }
        public string Reason { get; set; }
        public DateTime? Created_Datetime { get; set; }

    }
}
