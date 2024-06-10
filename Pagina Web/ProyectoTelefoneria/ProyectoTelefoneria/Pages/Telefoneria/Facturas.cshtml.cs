using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
using System.Data;
using System.Buffers.Text;

namespace ProyectoTelefoneria.Pages.Telefoneria
{
    public class FacturasModel : BasePageModel
    {
        [BindProperty]
        public string Numero { get; set; }

        public List<Models.Factura> listaFacturas = new List<Models.Factura>();

        public void OnGet()
        {
            if (TempData.ContainsKey("Numero"))
                Numero = TempData["Numero"].ToString();

            obtenerFacturas();
        }

        public IActionResult OnPost(string Numero)
        {
            // Lógica para manejar el detalle de elementos de cobro
            // Aquí puedes redirigir a otra página o procesar la información según tus necesidades
            TempData["Numero"] = Numero;
            return RedirectToPage("/Telefoneria/DetalleElementosCobro", new { numero = Numero });
        }

        private void obtenerFacturas()
        {
            try
            {
                using (SqlConnection connection = GetSqlConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ObtenerFacturas", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@inNumero", Numero);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                // Assuming the column indices match the order returned by the stored procedure
                                var fechaFactura = reader.GetDateTime(0); // Reads the DATE column as DateTime
                                var fechaLimitePago = reader.IsDBNull(4) ? DateTime.MinValue : reader.GetDateTime(4); // Handle NULL value

                                Models.Factura f = new Models.Factura
                                {
                                    FechaFactura = new DateOnly(fechaFactura.Year, fechaFactura.Month, fechaFactura.Day),
                                    MultaAtrasoPago = reader.GetInt32(1),
                                    TotalAntesIVA = reader.GetInt32(2),
                                    TotalAPagar = Convert.ToSingle(reader.GetDouble(3)), // Convertir el double a float
                                    FechaLimitePago = fechaLimitePago == DateTime.MinValue ? DateOnly.MinValue : new DateOnly(fechaLimitePago.Year, fechaLimitePago.Month, fechaLimitePago.Day)
                                };
                                listaFacturas.Add(f);
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
