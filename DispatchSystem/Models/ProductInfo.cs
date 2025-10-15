using DocumentFormat.OpenXml.Office2010.Excel;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Drawing;
using System.Linq;
using System.Threading.Tasks;
using VendorQRGeneration.Models;

namespace Dispatch_System
{
    public class ProductInfo
    {
        public long Id { get; set; }
        public string PlantName { get; set; }
        public string QrCode_Type { get; set; }
        public string QrCode { get; set; }
        public string CompanyName { get; set; }
        public string MfgBy { get; set; }
        public string MfgFacilityDtls { get; set; }
        public string RegnNo { get; set; }
        public string MarketedBy { get; set; }
        public DateTime ExpDate { get; set; }
        public DateTime MfgDate { get; set; }
        public string ExpDateTxt { get; set; }
        public string MfgDateTxt { get; set; }
        public string BatchDesc { get; set; }
        public string CustomerCareNo { get; set; }
        public decimal Mrp { get; set; }
        public decimal NetWeight { get; set; }
        public string NetContent { get; set; }
        public string PromotionalLink { get; set; }
        public string IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedDatetime { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedDatetime { get; set; }

        public string PrdDesc { get; set; }
        public string Status { get; set; }
        public string MDA_No { get; set; }
        public string DispatchDate { get; set; }
        public string PartyName { get; set; }
        public string Destination { get; set; }
        public decimal No_Of_Bottle { get; set; }
        public string Bottle_QR_Codes { get; set; }
        public List<ProductAttachment> productAttachments { get; set; }

    }
}
