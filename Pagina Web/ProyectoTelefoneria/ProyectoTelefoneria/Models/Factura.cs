namespace ProyectoTelefoneria.Models
{
    public class Factura
    {
        //public int ValorDocumentoIdentidad { get; set; }

        public int Id { get; set; }

        public int IdContrato { get; set; }

        public DateOnly FechaFactura { get; set; }

        public DateOnly FechaLimitePago { get; set; }

        public DateOnly FechaPago { get; set; }

        public int MultaAtrasoPago { get; set; }

        public int TotalAntesIVA { get; set; }

        public float MontoIVA { get; set; }

        public float TotalAPagar { get; set; }

        public int QTotalMinutosZ { get; set; }

        public int QTotalMinutosZNoche { get; set; }

        public int QTotalMinutosAdicionales { get; set; }

        public int QTotalMinutosAdicionalesNoche { get; set; }

        public int QTotalMinutosFamiliares { get; set; }

        public float QTotalGigasBase { get; set; }

        public float QTotalGigasAdicionales { get; set; }

        public int QTotalMinutos110 { get; set; }

        public int QTotalLlamadas911 { get; set; }

        public int QTotalMinutosEmpresaX { get; set; }

        public int QTotalMinutosEmpresaY { get; set; }

        public int QTotalMinutos800Marcados { get; set; }

        public int QTotalMinutos900Marcados { get; set; }

        public int QTotalMinutos800Recibidos { get; set; }

        public int QTotalMinutos900Recibidos { get; set; }

        public int TarifaBasica { get; set; }

        public int TotalCobro911 { get; set; }

        public  int TotalCobro110 { get; set; }

        public int TotalCobro900 { get; set; }

        public int TotalCobro800 { get; set; }

    }
}
