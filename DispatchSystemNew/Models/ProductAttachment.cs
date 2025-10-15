using DocumentFormat.OpenXml.Office2010.Excel;

namespace VendorQRGeneration.Models
{
    public class ProductAttachment
    {
        public long Id { get; set; }
        public long PrdInfoId { get; set; }
        public string FileName { get; set; }
        public string FileType { get; set; }
        public string FileDisplayname { get; set; }
        public string ContentType { get; set; }
        public string Extension { get; set; }
        public byte[] FileData { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedDatetime { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedDatetime { get; set; }
    }
}
