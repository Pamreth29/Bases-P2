using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Data.SqlClient;
using System.Data;

namespace ProyectoTelefoneria.Pages.Telefoneria
{
    public class EstadoCuentaXModel : BasePageModel
    {

        public int Id;

        public List<Models.EstadosDeCuenta> listaEstadosCuenta = new List<Models.EstadosDeCuenta>();


        public void OnGet()
        {
            obtenerEstadoCuenta();
        }

        public IActionResult OnPost(int Id)
        {
            // Lógica para manejar el detalle de elementos de cobro
            // Aquí puedes redirigir a otra página o procesar la información según tus necesidades
            TempData["Id"] = Id;
            return RedirectToPage("/Telefoneria/DetalleEstadoCuentaX", new { id = Id });
        }

        private void obtenerEstadoCuenta()
        {
            try
            {
                using (SqlConnection connection = GetSqlConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ObtenerEstadosCuentaXEmpresa", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@inNombreEmpresa", "Empresa X");

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                // Assuming the column indices match the order returned by the stored procedure
                                var fecha = reader.GetDateTime(3); // Reads the DATE column as DateTime

                                Models.EstadosDeCuenta ec = new Models.EstadosDeCuenta
                                {
                                    id = reader.GetInt32(0),
                                    TotalMinIN = reader.GetInt32(1),
                                    TotalMinOUT = reader.GetInt32(2),
                                    FechaCorte = new DateOnly(fecha.Year, fecha.Month, fecha.Day),
                                };
                                listaEstadosCuenta.Add(ec);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

    }
}
