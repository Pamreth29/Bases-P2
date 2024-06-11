using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ProyectoTelefoneria.Pages
{
    public class IndexModel : BasePageModel
    {
        [BindProperty]
        public string Numero { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost(string FormType, string Numero, string Empresa)
        {
            if (FormType == "Facturas")
            {
                if (Numero != null)
                {
                    TempData["Numero"] = Numero;
                    return new JsonResult(new { success = true, redirectUrl = Url.Page("/Telefoneria/Facturas") });
                } else
                {
                    TempData["Numero"] = "";
                    return new JsonResult(new { success = true, redirectUrl = Url.Page("/Telefoneria/Facturas") });
                }
            }
            else if (FormType == "EstadoCuenta")
            {
                if (Empresa == "X")
                {
                    return new JsonResult(new { success = true, redirectUrl = Url.Page("/Telefoneria/EstadoCuentaX") });
                }
                else if (Empresa == "Y")
                {
                    return new JsonResult(new { success = true, redirectUrl = Url.Page("/Telefoneria/EstadoCuentaY") });
                }
                else
                {
                    return new JsonResult(new { success = false, message = "Invalid company selection" });
                }
            }

            return new JsonResult(new { success = false, message = "Invalid form type" });
        }




    }
}
