using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;

namespace Dispatch_System
{
	[Area("Vendor")]
	public class ChangePasswordController : BaseController<ResponseModel<VendorChangePassword>>
	{
		public IActionResult Index()
		{
			return View();
		}

		[HttpPost]
		public JsonResult Save(ChangePassword viewModel)
		{
			try
			{
				viewModel.CurrentPassword = Common.Encrypt(viewModel.CurrentPassword);
				viewModel.NewPassword = Common.Encrypt(viewModel.NewPassword);
				viewModel.ConfirmPassword = Common.Encrypt(viewModel.ConfirmPassword);

				List<OracleParameter> oParams = new List<OracleParameter>();

				oParams.Add(new OracleParameter("P_VENDOR_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
				oParams.Add(new OracleParameter("P_OLD_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.CurrentPassword });
				oParams.Add(new OracleParameter("P_CONFIRM_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.ConfirmPassword });
				oParams.Add(new OracleParameter("P_NEW_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.NewPassword });
				oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
				oParams.Add(new OracleParameter("P_SITE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.SITE_ID) });
				oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
				oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

				var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_VENDOR_CHANGEPASSWORD", oParams, true);

				CommonViewModel.IsConfirm = true;
				CommonViewModel.IsSuccess = IsSuccess;
				CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
				CommonViewModel.Message = response;

				Common.Clear_Session();

				CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + "Home/VendorLogin" : "";
			}
			catch (Exception ex)
			{
				LogService.LogInsert(GetCurrentAction(), "", ex);

				CommonViewModel.IsSuccess = false;
				CommonViewModel.StatusCode = ResponseStatusCode.Error;
				CommonViewModel.Message = ResponseStatusMessage.Error + " | " + ex.Message;
			}

			return Json(CommonViewModel);
		}
	}
}
