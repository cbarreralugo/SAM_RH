using SAM_RH_DALC.Datos;
using SAM_RH_Negocio.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAM_RH_.Controllers
{
    public class UsuarioController : Controller
    {
        // GET: Usuario
        Usuario_Datos datos = new Usuario_Datos();
        public ActionResult Index()
        {
            IEnumerable<Usuario_Modelo>lista= datos.Consultar();
            return View(lista);
        }

        public ActionResult Crear()
        {
            return View();
        }

        public ActionResult Nuevo(Usuario_Modelo modelo) { 
        datos.Crear(modelo);
            return View("Index",modelo);  
        }

        
    }
}