using SAM_RH_Negocio.Modelo;
using System;
using System.Collections.Generic;
using SAM_RH_Negocio.Utilidades;
using System.Data;
using System.Linq;
using System.Text;
using ConnectorLibrary;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Controlador
{
    public class Evaluacion_Controlador
    {
        private static Evaluacion_Controlador _instancia;
        public static Evaluacion_Controlador Instancia
        {
            get
            {
                if (_instancia == null)
                {
                    _instancia = new Evaluacion_Controlador();
                }
                return _instancia;
            }
        }
        public DataTable Evaluacion_MostrarResultadoPorEvaluacion(Evaluacion_Modelo modelo)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_EvaluacionAsignada",modelo.p_ID_EvaluacionAsignada.ToString() }
            };

            try
            {
                dt = ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Evaluacion.sp_sam_mostrar_resultados_evaluacion, parametro);
                return dt;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new DataTable();
            }finally { dt = null; }
        }
    }
}
