using System;
using Proyecto_integrador.Models;
using Npgsql;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Proyecto_integrador.Data;
using System.Runtime.CompilerServices;

using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Session;

namespace Proyecto_integrador.Datos
{
    public class SP
    {

        public bool Registro(ModeloRegistro oFormulario)
        {
            bool flag = false;
            var con = new conection();
            string spCrearUsuario;
            string spCrearCreador;
            NpgsqlCommand com;
            if (oFormulario.Creador == true)
            {
                spCrearUsuario = "CALL sp_usuarios_insert ('" + "A" + "','" + oFormulario.Usuario + "','" + oFormulario.Nombre + "','" + oFormulario.Apellido + "','" + oFormulario.Email + "','" + oFormulario.Password + "')";
                spCrearCreador = "CALL sp_creadores_insert('" + oFormulario.Usuario + "','" + oFormulario.Paypal  + "')";
                com = new NpgsqlCommand(spCrearUsuario, con.OpenCon());

                flag = true;
                try { com.ExecuteNonQuery(); }
                catch (Exception ex) { flag = false; }
                if (flag != false)
                {
                    flag = true;
                }

                con.CloseCon();

                con = new conection();

                com = new NpgsqlCommand(spCrearCreador, con.OpenCon());

                flag = true;
                try { com.ExecuteNonQuery(); }
                catch (Exception ex) { flag = false; }
                if (flag != false)
                {
                    flag = true;
                }

            }
            else
            {
                spCrearUsuario = "CALL sp_usuarios_insert ('" + "B" + "','" + oFormulario.Usuario + "','" + oFormulario.Nombre + "','" + oFormulario.Apellido + "','" + oFormulario.Email + "','" + oFormulario.Password + "')";
                com = new NpgsqlCommand(spCrearUsuario, con.OpenCon());

                flag = true;
                try { com.ExecuteNonQuery(); }
                catch (Exception ex) { flag = false; }
                if (flag != false)
                {
                    flag = true;
                }
            }
            
            
            con.CloseCon();
            return flag;
        }


        public int ValidarBandera(string usuario, string pass) 
        {
            int band = 0;
            var cn = new conection();

            NpgsqlCommand cmd = new NpgsqlCommand("fun_usuarios_validar_bandera", cn.OpenCon());
            cmd.Parameters.AddWithValue("nomusu_i", usuario);
            cmd.Parameters.AddWithValue("contraseña_i", pass);
            cmd.CommandType = CommandType.StoredProcedure;

            using (var dr = cmd.ExecuteReader()) 
            { 
                while (dr.Read()) 
                {
                    band = Convert.ToInt32(dr["bandera"]);
                }
            }
            return band;
        }

        public string ValidarTipoUsuario(string usuario, string pass)
        {
            string tipoU = "";
            var cn = new conection();

            NpgsqlCommand cmd = new NpgsqlCommand("fun_usuarios_validar_tipo_usuario", cn.OpenCon());
            cmd.Parameters.AddWithValue("nomusu_i", usuario);
            cmd.Parameters.AddWithValue("contraseña_i", pass);
            cmd.CommandType = CommandType.StoredProcedure;

            using (var dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    tipoU = dr["tipo_usuario"].ToString();
                }
            }
            return tipoU;
        }

        public List<ModeloCursos> Listar()
        {
            var oLista = new List<ModeloCursos>();

            var con = new conection();

            NpgsqlCommand com = new NpgsqlCommand("fun_cursos_obtener", con.OpenCon());
            com.CommandType = CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oLista.Add(new ModeloCursos()
                    {
                        Id_curso = Convert.ToInt32(dr["Id_curso"]),
                        Id_creador = Convert.ToInt32(dr["Id_creador"]),
                        Nombre = dr["Nombre"].ToString(),
                        Area = dr["Area"].ToString(),
                        Tema = dr["Tema"].ToString(),
                        Dificultad = dr["Dificultad"].ToString(),
                        Titulo = dr["Titulo"].ToString(),
                        Frase_inicio = dr["Frase_inicio"].ToString(),
                        Subtitulo_1 = dr["Subtitulo_1"].ToString(),
                        Contenido_sub_1 = dr["Contenido_sub_1"].ToString(),
                        Subtitulo_2 = dr["Subtitulo_2"].ToString(),
                        Contenido_sub_2 = dr["Contenido_sub_2"].ToString(),
                        Subtitulo_3 = dr["Subtitulo_3"].ToString(),
                        Contenido_sub_3 = dr["Contenido_sub_3"].ToString(),
                        Frase_1 = dr["Frase_1"].ToString(),
                        Frase_2 = dr["Frase_2"].ToString(),
                        Video_1 = "https://www.youtube.com/embed/" + dr["Video_1"].ToString().Split('=')[1].ToString(),
                        Video_2 = "https://www.youtube.com/embed/" + dr["Video_2"].ToString().Split('=')[1].ToString(),
                        Img = dr["Img"].ToString()
                    });
                }
            }
            return oLista;
        }

        public List<ModeloCursos> Contenido(int id_curso)
        {
            var oCurso = new List<ModeloCursos>();

            var con = new conection();
            NpgsqlCommand com = new NpgsqlCommand("fun_cursos_obtener_completo", con.OpenCon());
            com.Parameters.AddWithValue("idcurso_i", id_curso);
            com.CommandType = CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oCurso.Add(new ModeloCursos()
                    {
                        Id_curso = Convert.ToInt32(dr["Id_curso"]),
                        Id_creador = Convert.ToInt32(dr["Id_creador"]),
                        Nombres = dr["Nombres"].ToString(),
                        Apellidos = dr["Apellidos"].ToString(),
                        Nombre = dr["Nombre"].ToString(),
                        Area = dr["Area"].ToString(),
                        Tema = dr["Tema"].ToString(),
                        Dificultad = dr["Dificultad"].ToString(),
                        Titulo = dr["Titulo"].ToString(),
                        Frase_inicio = dr["Frase_inicio"].ToString(),
                        Subtitulo_1 = dr["Subtitulo_1"].ToString(),
                        Contenido_sub_1 = dr["Contenido_sub_1"].ToString(),
                        Subtitulo_2 = dr["Subtitulo_2"].ToString(),
                        Contenido_sub_2 = dr["Contenido_sub_2"].ToString(),
                        Subtitulo_3 = dr["Subtitulo_3"].ToString(),
                        Contenido_sub_3 = dr["Contenido_sub_3"].ToString(),
                        Frase_1 = dr["Frase_1"].ToString(),
                        Frase_2 = dr["Frase_2"].ToString(),
                        Video_1 = "https://www.youtube.com/embed/" + dr["Video_1"].ToString().Split('=')[1].ToString(),
                        Video_2 = "https://www.youtube.com/embed/" + dr["Video_2"].ToString().Split('=')[1].ToString(),
                        Img = dr["Img"].ToString()
                    });
                }
            }
            return oCurso;
        }


        public bool NuevoCurso(ModeloCursosRegistro oCurso)
        {
            bool flag = false;
            var con = new conection();
            string spguardar;

            spguardar = "CALL sp_guardar_cursos ('" + oCurso.Id_creador + "','" + oCurso.Nombre + "','" + oCurso.Area + "','" + oCurso.Tema + "','" + oCurso.Dificultad + "','" + oCurso.Titulo + "','" + oCurso.Frase_inicio + "','" + oCurso.Subtitulo_1 + "','" + oCurso.Contenido_sub_1 + "','" + oCurso.Subtitulo_2 + "','" + oCurso.Contenido_sub_2 + "','" + oCurso.Subtitulo_3 + "','" + oCurso.Contenido_sub_3 + "','" + oCurso.Frase_1 + "','" + oCurso.Frase_2 + "','" + oCurso.Video_1 + "','" + oCurso.Video_2 + "','" + oCurso.Img + "')";
            
            NpgsqlCommand com = new NpgsqlCommand(spguardar, con.OpenCon());
            flag = true;
            try { com.ExecuteNonQuery(); }
            catch (Exception ex) { flag = false; }
            if (flag != false)
            {
                flag = true;
            }
            con.CloseCon();
            return flag;
        }


        public List<ModeloDonar> ListarDonaciones()
        {
            var oLista = new List<ModeloDonar>();

            var con = new conection();

            NpgsqlCommand com = new NpgsqlCommand("fun_creadores_obtener", con.OpenCon());
            com.CommandType = CommandType.StoredProcedure;

            using (var dr = com.ExecuteReader())
            {
                while (dr.Read())
                {
                    oLista.Add(new ModeloDonar()
                    {
                        Id_creador = Convert.ToInt32(dr["Id_creador"]),
                        Nombres = dr["Nombres"].ToString(),
                        Apellidos = dr["Apellidos"].ToString(),
                        Paypal = dr["Paypal"].ToString(),


                    });
                }
            }
            return oLista;
        }



    }
}