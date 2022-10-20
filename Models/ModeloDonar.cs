using static System.Net.Mime.MediaTypeNames;
using System.Diagnostics.CodeAnalysis;

namespace Proyecto_integrador.Models
{
    public class ModeloDonar
    {
        public int Id_creador { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Paypal { get; set; }
    }
}