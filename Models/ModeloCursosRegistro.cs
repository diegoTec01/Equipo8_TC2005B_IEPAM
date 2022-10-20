using static System.Net.Mime.MediaTypeNames;
using System.Diagnostics.CodeAnalysis;


namespace Proyecto_integrador.Models
{
    public class ModeloCursosRegistro
    {
        public int Id_creador { get; set; }
        public string Nombre { get; set; }
        public string Area { get; set; }
        public string Tema { get; set; }
        public string Dificultad { get; set; }
        public string Titulo { get; set; }
        public string Frase_inicio { get; set; }
        public string Subtitulo_1 { get; set; }
        public string Contenido_sub_1 { get; set; }
        public string Subtitulo_2 { get; set; }
        public string Contenido_sub_2 { get; set; }
        public string Subtitulo_3 { get; set; }
        public string Contenido_sub_3 { get; set; }
        public string Frase_1 { get; set; }
        public string Frase_2 { get; set; }
        public string Video_1 { get; set; }
        public string Video_2 { get; set; }
        public string Img { get; set; }
    }
}
