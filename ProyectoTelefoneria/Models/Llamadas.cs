namespace ProyectoTelefoneria.Models
{
    public class Llamadas
    {
        public DateTime FechaHora_Inicio { get; set; }

        public DateTime FechaHora_Fin { get; set; }

        public string NumeroA { get; set; }

        public int Duracion { get; set; }

        public int EsGratis { get; set; }

    }
}
