using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Oracle.ManagedDataAccess.Client;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class ChangePasswordController : BaseController<ResponseModel<ChangePassword>>
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
                viewModel.ConfirmPassword = Common.Encrypt(viewModel.ConfirmPassword);
                viewModel.NewPassword = Common.Encrypt(viewModel.NewPassword);

                List<OracleParameter> oParams = new List<OracleParameter>();

                oParams.Add(new OracleParameter("P_USER_NAME", OracleDbType.Varchar2) { Value = Common.Get_Session(SessionKey.USER_NAME) });
                oParams.Add(new OracleParameter("P_OLD_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.CurrentPassword });
                oParams.Add(new OracleParameter("P_CONFIRM_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.ConfirmPassword });
                oParams.Add(new OracleParameter("P_NEW_PASSWORD", OracleDbType.Varchar2) { Value = viewModel.NewPassword });
                oParams.Add(new OracleParameter("P_PLANT_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.PLANT_ID) });
                oParams.Add(new OracleParameter("P_USER_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.USER_ID) });
                oParams.Add(new OracleParameter("P_ROLE_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.ROLE_ID) });
                oParams.Add(new OracleParameter("P_MENU_ID", OracleDbType.Int64) { Value = Common.Get_Session_Int(SessionKey.MENU_ID) });

                var (IsSuccess, response, Id) = DataContext.ExecuteStoredProcedure("PC_CHANGEPASSWORD", oParams, true);

                CommonViewModel.IsConfirm = true;
                CommonViewModel.IsSuccess = IsSuccess;
                CommonViewModel.StatusCode = IsSuccess ? ResponseStatusCode.Success : ResponseStatusCode.Error;
                CommonViewModel.Message = response;

                CommonViewModel.RedirectURL = IsSuccess ? Url.Content("~/") + GetCurrentControllerUrl() + "/Index" : "";

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
