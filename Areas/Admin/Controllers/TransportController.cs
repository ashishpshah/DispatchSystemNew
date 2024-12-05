using Dispatch_System.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Security.Policy;

namespace Dispatch_System.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class TransportController : BaseController<ResponseModel<Transport>>
    {
        #region Loading
        public IActionResult Index()
        {
            try
            {
                CommonViewModel.ListObj = new List<Transport>();

                //var parameters = new SqlParameter[] { new SqlParameter("Id", SqlDbType.Int) { Value = 0, Direction = ParameterDirection.Input } };
                //var dt = DataContext.ExecuteStoredProcedure_DataTable("SP_Transport_Master_Get", parameters);

                //if (dt != null && dt.Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dt.Rows)
                //    {
                //        CommonViewModel.ListObj.Add(new Transport()
                //        {
                //            Id = dr["Id"] != DBNull.Value ? Convert.ToInt32(dr["Id"]) : 0,
                //            tptr_cd = dr["tptr_cd"] != DBNull.Value ? Convert.ToString(dr["tptr_cd"]) : "",
                //            tptr_name = dr["tptr_name"] != DBNull.Value ? Convert.ToString(dr["tptr_name"]) : "",
                //            IS_ENTRY_MANUAL = dr["IS_ENTRY_MANUAL"] != DBNull.Value ? Convert.ToBoolean(dr["IS_ENTRY_MANUAL"]) : false,
                //            plant_Id = dr["plant_Id"] != DBNull.Value ? Convert.ToInt32(dr["plant_Id"]) : 0,
                //            IS_POSTED = dr["IS_POSTED"] != DBNull.Value ? Convert.ToBoolean(dr["IS_POSTED"]) : false,
                //        });
                //    }
                //}
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return View(CommonViewModel);
        }

        #endregion

        #region Methods

        [HttpGet]
        public IActionResult Partial_AddEditForm(int id)
        {
            try
            {
                var obj = new Transport();
                var dt = new DataTable();

                //if (id > 0)
                //{
                //    // database query
                //    var parameters = new SqlParameter[] { new SqlParameter("Id", SqlDbType.Int) { Value = id, Direction = ParameterDirection.Input } };

                //    dt = DataContext.ExecuteStoredProcedure_DataTable("SP_Transport_Master_Get", parameters);

                //    if (dt != null && dt.Rows.Count > 0)
                //    {
                //        obj = new Transport()
                //        {

                //            Id = dt.Rows[0]["Id"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["Id"]) : 0,
                //            tptr_cd = dt.Rows[0]["tptr_cd"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["tptr_cd"]) : "",
                //            tptr_name = dt.Rows[0]["tptr_name"] != DBNull.Value ? Convert.ToString(dt.Rows[0]["tptr_name"]) : "",
                //            IS_ENTRY_MANUAL = dt.Rows[0]["IS_ENTRY_MANUAL"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_ENTRY_MANUAL"]) : false,
                //            plant_Id = dt.Rows[0]["plant_Id"] != DBNull.Value ? Convert.ToInt32(dt.Rows[0]["plant_Id"]) : 0,
                //            IS_POSTED = dt.Rows[0]["IS_POSTED"] != DBNull.Value ? Convert.ToBoolean(dt.Rows[0]["IS_POSTED"]) : false,
                //        };
                //    }
                //}

                CommonViewModel.Obj = obj;
            }

            catch (Exception ex) { LogService.LogInsert(GetCurrentAction(), "", ex); }

            return PartialView("_Partial_AddEditForm", CommonViewModel);

        }

        #endregion

        #region Events
        [HttpPost]
        public JsonResult Save(Transport obj)
        {
            try
            {
                //if (obj == null)
                //{
                //    CommonViewModel.IsSuccess = false;
                //    CommonViewModel.Message = "Please enter Transport details";
                //    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                //    return Json(CommonViewModel);
                //}

                //if (string.IsNullOrEmpty(obj.tptr_name))
                //{
                //    CommonViewModel.IsSuccess = false;
                //    CommonViewModel.Message = "Please enter Transport Name";
                //    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                //    return Json(CommonViewModel);
                //}

                //if (string.IsNullOrEmpty(obj.tptr_cd))
                //{
                //    CommonViewModel.IsSuccess = false;
                //    CommonViewModel.Message = "Please enter Transport Name";
                //    CommonViewModel.StatusCode = ResponseStatusCode.Error;

                //    return Json(CommonViewModel);
                //}

                //SqlParameter[] spCol = new SqlParameter[] {
                //    new SqlParameter("@Id",SqlDbType.Int) { Value = obj.Id, Direction = ParameterDirection.Input },
                //    new SqlParameter("@tptr_cd",SqlDbType.VarChar) { Value = obj.tptr_cd, Direction = ParameterDirection.Input },
                //    new SqlParameter("@Plant_Id",SqlDbType.Int) { Value = obj.plant_Id , Direction = ParameterDirection.Input },
                //    new SqlParameter("@tptr_name",SqlDbType.VarChar) { Value = obj.tptr_name, Direction = ParameterDirection.Input },
                //    new SqlParameter("@Operated_By",SqlDbType.BigInt) { Value = obj.Id, Direction = ParameterDirection.Input },
                //    new SqlParameter("@Action", obj.Id > 0 ? "UPDATE":"INSERT"),
                //    new SqlParameter("@response", SqlDbType.NVarChar, 1000) { Direction = ParameterDirection.Output }
                //};

                //var response = DataContext.ExecuteStoredProcedure("SP_Transport_Master_Insert_Update", spCol);

                //string[] strmsg = response.Split('|');
                //var msgtype = strmsg[0];
                //var message = strmsg[1].Replace("\"", "");


                //if (msgtype.Contains("E"))
                //{
                //    CommonViewModel.IsSuccess = false;
                //    CommonViewModel.StatusCode = ResponseStatusCode.Error;
                //    CommonViewModel.Message = message;

                //    return Json(CommonViewModel);
                //}

                //CommonViewModel.IsConfirm = true;
                //CommonViewModel.IsSuccess = true;
                //CommonViewModel.StatusCode = ResponseStatusCode.Success;
                //CommonViewModel.Message = message;
                //CommonViewModel.RedirectURL = Url.Content("~/") + GetCurrentControllerUrl() + "/Index";

                return Json(CommonViewModel);
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

        #endregion

    }
}
