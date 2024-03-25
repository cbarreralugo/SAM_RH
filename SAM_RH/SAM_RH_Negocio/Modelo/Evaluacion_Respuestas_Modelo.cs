using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Modelo
{
    public class Evaluacion_Respuestas_Modelo
    {
        public int ID_Respuesta { get; set; }
        public int ID_Pregunta { get; set; }
        public string Respuesta { get; set; }
        public char EsCorrecta { get; set; }
    }
}
