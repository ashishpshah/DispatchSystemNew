namespace Dispatch_System
{
    public class RFID_Lost
    {
        public long Id { get; set; }
        public long RefSysId { get; set; }
        public long GateId { get; set; }
        public long Inward_Sys_Id { get; set; }
        public long RefSysIdOld { get; set; }
        public long Plant_Id { get; set; }
        public long Station_Id { get; set; }
        public string Reason { get; set; }
        public string RfidCode { get; set; }
        public string RfidSrNo { get; set; }
        public string Remark { get; set; }
        public string Status { get; set; }
        public string RfidLostDate { get; set; }
        public bool IsActive { get; set; }
        public bool Is_Posted { get; set; }
    }
}
