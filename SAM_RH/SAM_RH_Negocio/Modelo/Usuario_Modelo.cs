using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Modelo
{
    public class Usuario_Modelo
    {
        public int ID_Usuario { get; set; }
        public string Tipo_Usuario { get; set; }
        public string Nombre { get; set; }
        public string Puesto { get; set; }
        public string Departamento { get; set; }
        public string UsrLocal { get; set; }
        public string Fecha_Creacion { get; set; }
        public string Nombre_Estatus { get; set; }
    }
}
