namespace Dispatch_System
{
    public class RFID
    {
        public long Id { get; set; }
        public long Plant_Id { get; set; }
        public long Station_Id { get; set; }
        public string RfidSrno { get; set; }
        public string RfidCode { get; set; }
        public string Status { get; set; }
        public string ReasonforEdit { get; set; }
        public bool IsActive { get; set; }
        public bool Is_Posted { get; set; }
    }
}
