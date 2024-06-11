using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;
using System.Data;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace ProyectoTelefoneria.Pages.Telefoneria
{
    public class DetalleEstadoCuentaYModel : BasePageModel
    {
        public int Id;

        public List<Models.EstadosDeCuenta> listaEstadosDeCuenta = new List<Models.EstadosDeCuenta>();

        public void OnGet(int Id)
        {
            if (TempData.ContainsKey("Id"))
                this.Id = (int)TempData["Id"];
            else
                this.Id = Id;

            obtenerDEC();
        }

        private void obtenerDEC()
        {
            try
            {
                using (SqlConnection connection = GetSqlConnection())
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("ObtenerDetallesEstadosCuentaXEmpresa", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        SqlParameter OutResultCode = new SqlParameter("@OutResultCode", SqlDbType.Int);
                        OutResultCode.Direction = ParameterDirection.Output;

                        command.Parameters.AddWithValue("@inNombreEmpresa", "Empresa Y");
                        command.Parameters.AddWithValue("@inIDEstadoCuenta", Id);
                        command.Parameters.Add(OutResultCode);

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {

                                Models.EstadosDeCuenta ec = new Models.EstadosDeCuenta
                                {
                                    NumeroDe  = reader.GetString(1),
                                    NumeroA  = reader.GetString(2),
                                    TipoLlamada = reader.GetString(3),
                                    FechaHora_Inicio = reader.GetDateTime(4),
                                    FechaHora_Fin = reader.GetDateTime(5),
                                    Duracion = reader.GetInt32(6)
                                };
                                listaEstadosDeCuenta.Add(ec);
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

