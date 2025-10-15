using Newtonsoft.Json;
using System.Text.Json.Serialization;

namespace Dispatch_System
{
	public class WeighmentInSlip
	{
		public long SrNo { get; set; }
		public long Id { get; set; }
		public long Gate_In_Id { get; set; }
		public long Inward_sys_id { get; set; }
		public string Plant_Name { get; set; }
		public string Plant_Address { get; set; }
		public string Gross_Wt { get; set; }
		public string RFID_No { get; set; }
		public string Status { get; set; }
		public string Gate_In_Dt { get; set; }
		public string Gate_Out_Dt { get; set; }
		public string Driver_Name { get; set; }
		public string Driver_Contact { get; set; }
		public decimal Loaded_Shipper { get; set; }
		public decimal Required_Shipper { get; set; }
		public DateTime? Gross_Wt_Dt { get; set; }
		public bool Gross_Wt_Manually { get; set; }
		public string Gross_Wt_Note { get; set; }
		public string Tare_Wt { get; set; }
		public DateTime? Tare_Wt_Dt { get; set; }
		public DateTime? MDA_dt { get; set; }
		public bool Tare_Wt_Manually { get; set; }
		public string Tare_Wt_Note { get; set; }
		public string Net_Wt { get; set; }
		public bool Out_Of_Tolerance_Wt { get; set; }
		public decimal Tolerance_Wt { get; set; }
		public bool Allow_Tolerance_Wt { get; set; }
		public long Station_Id { get; set; }
		public long Plant_Id { get; set; }
		public bool Is_Posted { get; set; }
		public string MDA_No { get; set; }
		public string Truck_No { get; set; }
		public string Transporter_Name { get; set; }
		public string Vehicle_No { get; set; }
		public string Report_Title { get; set; }
		public List<ListDtls> listDtls { get; set; }
		public string UOM { get; set; }
	}

	public class ListDtls
	{
		public int Mda_Id { get; set; }
		public int SrNo { get; set; }
		public DateTime? MDA_dt { get; set; }
		public string MDA_No { get; set; }
		public string prd_cd { get; set; }
		public string prd_desc { get; set; }
		public int no_of_Box { get; set; }
		public int no_of_bottle { get; set; }
		//public string Vehicle_No { get; set; }
		public string Tare_Wt_Note { get; set; }
		public long dist { get; set; }
		public string desp_place { get; set; }

	}


	public class Weighment
	{
		public long Plant_Id { get; set; }
		public long Station_Id { get; set; }
		public long SrNo { get; set; }
		public long Id { get; set; }
		public long Gate_In_Id { get; set; }
		public long Common_Id { get; set; }
		public string Vehicle_No { get; set; }
		public string Common_No { get; set; }
		public string Common_Dt { get; set; }

		public string Gross_Wt { get; set; }
		public string RFID_No { get; set; }
		public string Status { get; set; }
		public string Gate_In_Dt { get; set; }
		public string Gate_Out_Dt { get; set; }
		public string Driver_Name { get; set; }
		public string Driver_Contact { get; set; }

		public string Transporter_Name { get; set; }
		public string Party_Name { get; set; }
		public string UOM { get; set; }

		public decimal Loaded_Shipper { get; set; }
		public decimal Required_Shipper { get; set; }

		public double WeighIn_Wt { get; set; }
		public string WeighIn_Wt_Dt { get; set; }
		public string WeighIn_Wt_Note { get; set; }
		public double WeighOut_Wt { get; set; }
		public string WeighOut_Wt_Dt { get; set; }
		public string WeighOut_Wt_Note { get; set; }
		public string Skip_LILO_Remarks { get; set; }
		public double Net_Wt { get; set; }

		public bool Out_Of_Tolerance_Wt { get; set; }
		public decimal Tolerance_Wt { get; set; }
		public bool Allow_Tolerance_Wt { get; set; }

		public string Plant_Name { get; set; }
		public string Plant_Address { get; set; }
		public string Report_Title { get; set; }

		public List<WeighmentDtls> listWeighmentDtls { get; set; }
	}

	public class WeighmentDtls
	{
		public long SrNo { get; set; }
		public long Id { get; set; }
		public long Common_Id { get; set; }
		public string Common_No { get; set; }
		public string Common_Dt { get; set; }

		public long Weighment_Id { get; set; }

		public long Product_Id { get; set; }
		public string Product_Code { get; set; }
		public string Product_Desc { get; set; }
		public int No_of_Box { get; set; }
		public int No_of_Box_Loaded { get; set; }
		public int No_of_bottle { get; set; }

		public int Qty { get; set; }
		public string UOM { get; set; }

		public long Distance { get; set; }
		public string Desp_Place { get; set; }
	}
}
