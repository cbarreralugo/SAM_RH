using SAM_RH_DALC.Datos;
using SAM_RH_Negocio.Modelo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SAM_RH_.Controllers
{
    public class EvaluacionController : Controller
    {
        // GET: Evaluacion
        Evaluacion_Datos datos = new Evaluacion_Datos(); 
        public ActionResult Index()
        {
            IEnumerable<Evaluacion_Modelo> lista = datos.ConsultarTodasLasEvaluaciones();
            return View(lista);
        }
        public ActionResult Crear()
        {
            return View();
        }

        public ActionResult Nuevo(Evaluacion_Modelo modelo)
        {
            datos.Crear(modelo);
            return View("Index", modelo);
        }

        public ActionResult Detalles(int id)
        {
            Evaluacion_Modelo evaluacion = datos.ConsultarEvaluacionPorId(id);

            if (evaluacion == null)
            {
                return HttpNotFound();
            }

            return View(evaluacion);
        }
    }
}