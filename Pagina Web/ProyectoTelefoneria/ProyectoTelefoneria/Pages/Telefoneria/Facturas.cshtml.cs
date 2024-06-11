using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
using System.Data;

namespace ProyectoTelefoneria.Pages.Telefoneria
{
    public class FacturasModel : BasePageModel
    {
        [BindProperty]
        public string Numero { get; set; }

        public int OutResultCodeValue = 0;
        public string ErrorMessage { get; set; }

        public List<Models.Factura> listaFacturas = new List<Models.Factura>();

        public void OnGet(string Numero)
        {       
            if (TempData.ContainsKey("Numero"))
                this.Numero = TempData["Numero"].ToString();
            else
                this.Numero = Numero;

            obtenerFacturas();
        }

        public IActionResult OnPost(string Numero)
        {
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

                        SqlParameter OutResultCode = new SqlParameter("@OutResultCode", SqlDbType.Int);
                        OutResultCode.Direction = ParameterDirection.Output;

                        command.Parameters.AddWithValue("@inNumero", Numero);
                        command.Parameters.Add(OutResultCode);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                var fechaFactura = reader.GetDateTime(0);
                                var fechaLimitePago = reader.IsDBNull(4) ? DateTime.MinValue : reader.GetDateTime(4);

                                Models.Factura f = new Models.Factura
                                {
                                    FechaFactura = new DateOnly(fechaFactura.Year, fechaFactura.Month, fechaFactura.Day),
                                    MultaAtrasoPago = reader.GetInt32(1),
                                    TotalAntesIVA = reader.GetInt32(2),
                                    TotalAPagar = Convert.ToSingle(reader.GetDouble(3)),
                                    FechaLimitePago = fechaLimitePago == DateTime.MinValue ? DateOnly.MinValue : new DateOnly(fechaLimitePago.Year, fechaLimitePago.Month, fechaLimitePago.Day)
                                };
                                listaFacturas.Add(f);
                            }
                        }

                        OutResultCodeValue = (int)OutResultCode.Value;

                        switch (OutResultCodeValue)
                        {
                            case 0:
                                ErrorMessage = string.Empty;
                                break;
                            case 50007:
                                ErrorMessage = "El numero no existe";
                                break;
                            case 50011:
                                ErrorMessage = "Error en ObtenerFactura";
                                break;
                            default:
                                ErrorMessage = "Error desconocido";
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorMessage = "Excepción: " + ex.Message;
            }
        }
    }
}
