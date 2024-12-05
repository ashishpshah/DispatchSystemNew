using Dispatch_System.Infra;
using Dispatch_System.Models;
using DocumentFormat.OpenXml.Spreadsheet;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Data;
using System.Data.SqlClient;

namespace Dispatch_System.Controllers
{
	public class BaseController<T> : Controller where T : class
	{
		//public readonly DataContext _context;
		public T CommonViewModel = default(T);

		public bool IsLogActive = false;

		public readonly DateTime? nullDateTime = null;
		public string ControllerName = "";
		public string ActionName = "";
		public string AreaName = "";

		public BaseController()
		{
			//_context = new DataContext();
			CommonViewModel = (dynamic)Activator.CreateInstance(typeof(T));
		}

		//public BaseController(DataContext context)
		//{
		//	_context = context;
		//	CommonViewModel = (dynamic)Activator.CreateInstance(typeof(T));
		//}

		public override void OnActionExecuting(ActionExecutingContext context)
		{
			try
			{
				ControllerName = Convert.ToString(context.RouteData.Values["controller"]);
				ActionName = Convert.ToString(context.RouteData.Values["action"]);

				if (context.RouteData.DataTokens != null)
					AreaName = Convert.ToString(context.RouteData.DataTokens["area"]);

				if (string.IsNullOrEmpty(AreaName))
					AreaName = Convert.ToString(context.RouteData.Values["area"]);


				if (!Common.IsUserLogged() && Convert.ToString(ControllerName).ToLower() != "home" && (Convert.ToString(ActionName).ToLower() != "login" || !Convert.ToString(ActionName).ToLower().Contains("sync")))
				{
					//	//context.Result = new RedirectResult(Url.Content("~/") + (string.IsNullOrEmpty(areaName) ? "" : areaName + "/") + "Home/Login");
					//	context.Result = new RedirectResult(Url.Content("~/") + "Home/Login");
					//	return;
					//}
					//else 
					//if (Common.IsUserLogged() && !Common.IsAdmin() && !string.IsNullOrEmpty(areaName))
					//{
					context.Result = new RedirectResult(Url.Content("~/") + "Home/Login");
					return;
				}



				Common.Set_Session_Int(SessionKey.MENU_ID, Common.GetCurrentMenuId(AreaName, ControllerName));

				//try
				//{
				//	if (Common.IsUserLogged())
				//		LogService.Log_User_Activity(ControllerName + " - " + ActionName, ActionName.Contains("Save"), ActionName.Contains("Modify"), ActionName.Contains("Delete"), (!ActionName.Contains("Save") && !ActionName.Contains("Modify") && !ActionName.Contains("Delete")), "", false, "INFO");
				//}
				//catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

				//Common.Set_SessionState(context.HttpContext.Session);
				//Common.Set_Controller_Action(controllerName + '_' + actionName);

				//IsLogActive = Convert.ToBoolean(ConfigurationManager.AppSettings["IsLogActive"]);

				//List<UserMenuAccess> listMenuAccess = Common.GetUserMenuPermission();

				//if (listMenuAccess != null && listMenuAccess.Count > 0)
				//{
				//	if (listMenuAccess.FindIndex(x => x.Controller == controllerName) > -1)
				//	{
				//		CommonViewModel.IsCreate = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsCreate;
				//		CommonViewModel.IsRead = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsRead;
				//		CommonViewModel.IsUpdate = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsUpdate;
				//		CommonViewModel.IsDelete = listMenuAccess[listMenuAccess.FindIndex(x => x.Controller == controllerName)].IsDelete;
				//	}
				//}

				//if (!Common.IsUserLogged() && Convert.ToString(controllerName).ToLower() != "home" && Convert.ToString(actionName).ToLower() != "login")
				//{
				//	context.Result = new RedirectResult(Url.Content("~/") + (string.IsNullOrEmpty(areaName) ? "" : areaName + "/") + "Home/Login");
				//	return;
				//}
				//else if (Common.IsUserLogged() && !Common.IsAdmin() && !string.IsNullOrEmpty(areaName))
				//{
				//	context.Result = new RedirectResult(Url.Content("~/") + "Home/Login");
				//	return;
				//}
			}
			catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }
		}


		public string GetCurrentAction() => string.IsNullOrEmpty(AreaName) ? "" : AreaName + " - " + ControllerName + " - " + ActionName;
		public string GetCurrentControllerUrl() => (string.IsNullOrEmpty(AreaName) ? "" : AreaName + "/") + ControllerName;
	}
}
