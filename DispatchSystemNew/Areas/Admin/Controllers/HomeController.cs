using Dispatch_System;
using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace VendorQRGeneration.Areas.Admin.Controllers
{
	[Area("Admin")]
	public class HomeController : BaseController<ResponseModel<LoginViewModel>>
	{
		public HomeController() { }

		public IActionResult Index()
		{
			if (!Common.IsUserLogged())
				return RedirectToAction("Login", "Home", new { Area = "" });

			try
			{
				CommonViewModel.ListObj = new List<LoginViewModel>();
				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var dt = DataContext.ExecuteStoredProcedure_DataTable("PC_DASHBOARDADMIN", oParams, true);

				if (dt != null && dt.Rows.Count > 0)
				{
					foreach (DataRow dr in dt.Rows)
					{
						CommonViewModel.ListObj.Add(new LoginViewModel()
						{
							ColName = dr["Colname"] != DBNull.Value ? Convert.ToString(dr["Colname"]) : "",
							TodayGeneration = dr["QR_Generated"] != DBNull.Value ? Convert.ToInt32(dr["QR_Generated"]) : 0,
							TodayRecevied = dr["QR_Recived"] != DBNull.Value ? Convert.ToInt32(dr["QR_Recived"]) : 0
						});
					}
				}

			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

			return View(CommonViewModel);
		}

	}
}
