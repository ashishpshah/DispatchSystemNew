using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Dispatch_System
{
	public class QRCodeGeneration
	{
		[NotMapped] public long SrNo { get; set; }
		public long Id { get; set; }
		public long PlantId { get; set; }
		[NotMapped] public string PlantName { get; set; }
		public long VendorId { get; set; }
		[NotMapped] public long VendorCode { get; set; }
		[NotMapped] public string VendorName { get; set; }
		[NotMapped] public string Password { get; set; }
		[NotMapped] public string VendorEmail { get; set; }
		[NotMapped] public long SiteId { get; set; }
		[NotMapped] public string VendorSiteName { get; set; }
		public long VPO_Id { get; set; }
		public long VPO_Dtls_Id { get; set; }
		public string PO_Number { get; set; }
		public string PoNumber { get; set; }
		[NotMapped] public string PO_Date_Text { get; set; }
		public string RequestNo { get; set; }
		public DateTime? RequestDate { get; set; }
		[NotMapped] public string RequestDate_Text { get; set; }
		public string RequestStatus { get; set; }
		public DateTime? ExpectedDate { get; set; }
		[NotMapped] public string ExpectedDate_Text { get; set; }
		[NotMapped] public string Qr_Code { get; set; }
		public string ConsignmentNo { get; set; }

		public DateTime? ConsignmentDate { get; set; }
		[NotMapped] public string ConsignmentDate_Text { get; set; }
		public string ModeofDispatch { get; set; }
		public DateTime? EstimateDate { get; set; }
		[NotMapped] public string EstimateDate_Text { get; set; }
		public string Shipmentdetail { get; set; }

		public string LineItemDesc { get; set; }
		public long LineItemNo { get; set; }

		public string SkuDesc { get; set; }
		public long TotalQty { get; set; }
		public long RemainQty { get; set; }
		public string UOM { get; set; }
		public string ReceivedBy { get; set; }

		public long? RequestQty { get; set; }

		public long? QRCodeQtyPerFile { get; set; }
		public bool IsFileEmail { get; set; }
		[NotMapped] public string FileEmailSend { get; set; }
		public bool IsLock { get; set; }
		public bool IsPrintFinish { get; set; }
		public string LastDownloadBy { get; set; }
		public DateTime? LastDownloadDate { get; set; }
		public string LastDownloadDate_Text { get; set; }
		public long PrintQty { get; set; }

		public string SelectedPlants { get; set; }
		public string PrintNotes { get; set; }
		public string EmailNotes { get; set; }
		public string Created_By { get; set; }
		public string Serial_No_From { get; set; }
		public string Serial_No_To { get; set; }

		public long? Prodsysid { get; set; }

		public long? Nooffiles { get; set; }
		[NotMapped] public string CC_Email { get; set; }

		public List<QR_Code_Serial> listSerial { get; set; }

	}

	public class QR_Code_Serial
	{
		public long SrNo { get; set; }
		public long Id { get; set; }
		public long QR_Code_GenId { get; set; }
		public long? RequestQty { get; set; }
		public string FileName { get; set; }
		public bool IsDownload { get; set; }
		public bool IsLock { get; set; }
		public string Status_FileDownload { get; set; }

	}

}
