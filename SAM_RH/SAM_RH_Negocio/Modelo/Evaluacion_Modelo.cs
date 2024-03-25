using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Modelo
{
    public class Evaluacion_Modelo
    {
        public int p_ID_EvaluacionAsignada { get; set; }
        public int ID_TipoEvaluacion { get; set; }
        public int ID_Evaluacion { get; set; }
        public string Tipo_evaluacion { get; set; }
        public string Nombre_evaluacion { get; set; }
        public int Version { get; set; }
        public string Fecha_Creacion { get; set; }
        public string Estatus { get; set; }
        

    }
}
