using System;
using Npgsql;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Proyecto_integrador.Data
{
    public class conection
    {
        NpgsqlConnection conn = new NpgsqlConnection();

        static string servidor = "localhost";
        static string bd = "ProyectoFinal";
        static string user = "postgres";
        static string pass = "TC2005B";
        static string port = "5432";
        string CadenaConexion = "Server=" + servidor + ";Port=" + port + ";User Id=" + user + ";Password=" + pass + ";Database=" + bd + ";";

        public NpgsqlConnection OpenCon()
        {
            try
            {
                conn.ConnectionString = CadenaConexion;
                conn.Open();
            }
            catch (NpgsqlException e)
            {
                string error = e.Message;
            }
            return conn;
        }

        public void CloseCon()
        {
            try
            {
                conn.Close();
            }
            catch (NpgsqlException e)
            {
                string error = e.Message;
            }
        }

    }
}