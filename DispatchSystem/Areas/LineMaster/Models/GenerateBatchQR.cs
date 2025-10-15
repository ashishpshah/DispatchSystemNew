namespace Dispatch_System
{
    public class GenerateBatchQR
    {
        public int SrNo { get; set; }
        public string MFG_Date { get; set; }
        public string Plant_Code { get; set; }
        public string Prod_Code { get; set; }
        public int Current_Year { get; set; }
        public int Julian_Day { get; set; }
        public long Serial_No { get; set; }
        public string Batch_No { get; set; }
        public string APID1_Val { get; set; }
        public string APID2_Val { get; set; }
        public string QrCodeText { get; set; }
        public string QrCodeImage { get; set; }
    }
}
