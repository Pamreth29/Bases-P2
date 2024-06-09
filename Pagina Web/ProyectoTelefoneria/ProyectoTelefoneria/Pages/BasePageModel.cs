using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ProyectoTelefoneria.Pages
{
    public class BasePageModel : PageModel
    {
        protected SqlConnection GetSqlConnection()
        {
            string connectionString = "Data Source=HIATUSXHIATUS\\HIATUXHIATUSBD;Initial Catalog=NewTelefoneria;Persist Security Info=True;User ID=Admin;Password=minchus29.";
            return new SqlConnection(connectionString);
        }

    }
}
