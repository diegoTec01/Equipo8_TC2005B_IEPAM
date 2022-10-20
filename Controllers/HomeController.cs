using Microsoft.AspNetCore.Mvc;
using Proyecto_integrador.Models;
using System.Diagnostics;
using Proyecto_integrador.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using Proyecto_integrador.Datos;
using System.Data.Entity;

namespace Proyecto_integrador.Controllers
{
    public class HomeController : Controller
    {
        SP form = new SP();
        SP log  = new SP();
        SP cursos = new SP();
        SP formCurso = new SP();

        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Login(ModeloLogin oUsuario)
        {
            TempData["User"] = oUsuario.Usuario;
            var bandera = log.ValidarBandera(oUsuario.Usuario, oUsuario.Pass);
            var tipoU = log.ValidarTipoUsuario(oUsuario.Usuario, oUsuario.Pass);
            if (bandera > 0)
            {
                if (tipoU == "A")
                {
                    return RedirectToAction("IndexCreador");
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            else 
            {
                TempData["CuentaI"] = "Credenciales erroneas";
                return View();
            }
        }

        public IActionResult Signup()
        {
            return View();
        }
        [HttpPost]
        public IActionResult Signup(ModeloRegistro oformulario)
        {
            if (!ModelState.IsValid)
                return View();

            var resp = form.Registro(oformulario);
            if (resp == true)
            {
                TempData["SuccessAlert"] = "Cuenta creada";
                return RedirectToAction("Login");
            }
            else
            {
                TempData["FailAlert"] = "No se pudo crear la cuenta";
                return View();
            }
        }

        public IActionResult Index()
        {
            return View();
        }
        public IActionResult IndexCreador()
        {
            return View();
        }

        public IActionResult Curso(int Id_curso)
        {
            var oCurso = cursos.Contenido(Id_curso);
            return View(oCurso);
        }
        public IActionResult CursoCreador(int Id_curso)
        {
            var oCurso = cursos.Contenido(Id_curso);
            return View(oCurso);
        }

        public IActionResult Cursos()
        {
            var oLista = cursos.Listar();
            return View(oLista);
        }
        public IActionResult CursosCreador()
        {
            var oLista = cursos.Listar();
            return View(oLista);
        }



        public IActionResult Videojuego()
        {
            return View();
        }
        public IActionResult VideojuegoCreador()
        {
            return View();
        }

        public IActionResult VideojuegoPrueba()
        {
            return View();
        }

        public IActionResult Donar()
        {
            var oLista = cursos.ListarDonaciones();
            return View(oLista);
        }
        public IActionResult DonarCreador()
        {
            var oLista = cursos.ListarDonaciones();
            return View(oLista);
        }

        public IActionResult AportarConocimiento()
        {
            return View();
        }
        [HttpPost]
        public IActionResult AportarConocimiento(ModeloCursosRegistro oCurso)
        {
            if (!ModelState.IsValid)
                return View();

            var resp = formCurso.NuevoCurso(oCurso);
            if (resp == true)
            {
                return RedirectToAction("CursosCreador");
            }
            else
            {
                TempData["FailAlert"] = "No se pudo crear el curso.";
                return View();
            }
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}