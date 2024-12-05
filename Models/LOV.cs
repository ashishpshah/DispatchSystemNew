namespace Dispatch_System
{
	public class LOV
	{
		public string Lov_Column { get; set; }
		public string Lov_Code { get; set; }
		public string Column_For { get; set; }
		public string Lov_Desc { get; set; }
		public string Lovs { get; set; }
		public long Display_Seq_No { get; set; }
		public long MaxDisplay_Seq_No { get; set; }
		public string Action { get; set; }
		public string Tag_Data_Type { get; set; }
		public string Tag_Data_Input_Mask { get; set; }
		public string Tag_Default_Values { get; set; }
		public string Tag_Min_Len { get; set; }
		public string Tag_Max_Len { get; set; }
		public string Tag_Min_Value { get; set; }
		public string Tag_Max_Value { get; set; }
		public bool IsActive { get; set; }
		public List<LOV> listLov { get; set; }
	}
}
