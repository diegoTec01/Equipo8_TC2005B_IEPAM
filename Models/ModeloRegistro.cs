using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Proyecto_integrador.Models
{
    public class ModeloRegistro
    {
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Usuario { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public bool Creador { get; set; }
        public string Paypal { get; set; }

    }
}
