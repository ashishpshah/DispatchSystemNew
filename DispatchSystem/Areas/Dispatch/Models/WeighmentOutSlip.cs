namespace Dispatch_System
{    public class WeighmentOutSlip
    {
        public string MDA_No { get; set; }
        public string Truck_No { get; set; }
        public string RFID_No { get; set; }
		public string Plant_Name { get; set; }
		public string Plant_Address { get; set; }
		public string Transporter_Name { get; set; }
        public decimal Tare_Wt { get; set; }
        public DateTime? Tare_Wt_Dt { get; set; }
        public decimal Gross_Wt { get; set; }
        public DateTime? Gross_Wt_Dt { get; set; }
        public string Gross_Wt_Note { get; set; }
        public decimal Tolerance_Wt { get; set; }
        public decimal Net_Wt { get; set; }
        public string Report_Title { get; set; }
        public string Skip_LILO_Remarks { get; set; }
        public List<WeighmentOutSliplistdtls> listdtls { get; set; }
    }
    public class WeighmentOutSliplistdtls
    {
        public int SrNo { get; set; }
        public int Mda_Id { get; set; }
        public string Mda_No { get; set; }
        public DateTime? Mda_Dt { get; set; }
        public string prd_cd { get; set; }
        public string prd_desc { get; set; }
        public int no_of_Box_Loaded { get; set; }
        public int no_of_Box { get; set; }
        public int no_of_bottle { get; set; }
    }
}
