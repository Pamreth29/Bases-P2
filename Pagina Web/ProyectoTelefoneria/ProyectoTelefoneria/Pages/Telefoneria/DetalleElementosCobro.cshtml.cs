using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
using System.Data;

namespace ProyectoTelefoneria.Pages.Telefoneria
{
    public class DetalleElementosCobroModel : BasePageModel
    {
        [BindProperty]
        public string Numero { get; set; }

        public List<Models.Factura> listaDetalleEC = new List<Models.Factura>();

        public List<Models.Llamadas> listaLlamadas = new List<Models.Llamadas>();

        public List<Models.UsoDatos> listaUsoDatos = new List<Models.UsoDatos>();

        public void OnGet(string Numero)
        {
            if (TempData.ContainsKey("Numero"))
                this.Numero = TempData["Numero"].ToString();
            else
                this.Numero = Numero;

            obtenerDEC();
            obtenerLlamadas();
            obtenerUsoDatos();
        }

        private void obtenerDEC()
        {
            try
            {
                using (SqlConnection connection = GetSqlConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ObtenerDetalleEC", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        SqlParameter OutResultCode = new SqlParameter("@OutResultCode", SqlDbType.Int);
                        OutResultCode.Direction = ParameterDirection.Output;

                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@inNumero", Numero);
                        command.Parameters.Add(OutResultCode);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {

                                Models.Factura f = new Models.Factura
                                {
                                    TarifaBasica = reader.GetInt32(0),
                                    QTotalGigasAdicionales = Convert.ToSingle(reader.GetDouble(2)),
                                    QTotalMinutosFamiliares = reader.GetInt32(3),
                                    TotalCobro911 = reader.GetInt32(4),
                                    TotalCobro110 = reader.GetInt32(5),
                                    TotalCobro900 = reader.GetInt32(6),
                                    TotalCobro800 = reader.GetInt32(7),
                                };
                                listaDetalleEC.Add(f);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        private void obtenerLlamadas()
        {
            try
            {
                using (SqlConnection connection = GetSqlConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ObtenerLlamadas", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        SqlParameter OutResultCode = new SqlParameter("@OutResultCode", SqlDbType.Int);
                        OutResultCode.Direction = ParameterDirection.Output;

                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@inNumero", Numero);
                        command.Parameters.Add(OutResultCode);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {

                                Models.Llamadas l = new Models.Llamadas
                                {
                                    FechaHora_Inicio = reader.GetDateTime(0),
                                    FechaHora_Fin = reader.GetDateTime(1),
                                    NumeroA = reader.GetString(2),
                                    Duracion = reader.GetInt32(3),
                                    EsGratis = reader.GetInt32(4)
                                };
                                listaLlamadas.Add(l);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
        }

        private void obtenerUsoDatos()
        {
            try
            {
                using (SqlConnection connection = GetSqlConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ObtenerUsoDatos", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        SqlParameter OutResultCode = new SqlParameter("@OutResultCode", SqlDbType.Int);
                        OutResultCode.Direction = ParameterDirection.Output;

                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@inNumero", Numero);
                        command.Parameters.Add(OutResultCode);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {

                                var fechaUsoDatos = reader.GetDateTime(0);

                                Models.UsoDatos ud = new Models.UsoDatos
                                {
                                    Fecha = new DateOnly(fechaUsoDatos.Year, fechaUsoDatos.Month, fechaUsoDatos.Day),
                                    TotalQGigas = Convert.ToSingle(reader.GetDouble(1)) // Convertir el double a float
                                };
                                listaUsoDatos.Add(ud);
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
