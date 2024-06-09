namespace ProyectoTelefoneria.Models
{
    public class EstadosDeCuenta
    {
        public int id { get; set; }

        public int TotalMinIN {  get; set; }

        public int TotalMinOUT { get; set; }

        public DateOnly FechaCorte { get; set; }

        public string NumeroDe { get; set; }

        public string NumeroA { get; set;}

        public string TipoLlamada { get; set;}

        public DateTime FechaHora_Inicio { get; set; }

        public DateTime FechaHora_Fin { get; set; }

        public int Duracion { get; set; }

    }
}
