using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Modelo
{
    public class Evaluacion_Preguntas_Modelo
    {
        public int ID_Pregunta { get; set; }
        public int ID_Evaluacion { get; set; }
        public string Pregunta { get; set; }
        public int Puntaje { get; set; }
    }
}
