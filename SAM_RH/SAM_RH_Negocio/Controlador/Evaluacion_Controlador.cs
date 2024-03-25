using SAM_RH_Negocio.Modelo;
using System;
using System.Collections.Generic;
using SAM_RH_Negocio.Utilidades;
using System.Data;
using System.Linq;
using System.Text;
using ConnectorLibrary;
using System.Threading.Tasks;
using System.Reflection;

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

        //VISTA GENERAL
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

        public DataTable Evaluacion_MostrarTodasLasEvaluaciones()
        {
            DataTable dt = new DataTable();
            
            try
            {
                dt = ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Evaluacion.sp_sam_mostrar_evaluaciones);
                return dt;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new DataTable();
            }
            finally { dt = null; }
        }

        public void Evaluacion_CrearEvaluacion(Evaluacion_Modelo modelo)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_Evaluacion","0" },
                {"@p_ID_TipoEvaluacion",modelo.ID_TipoEvaluacion.ToString() },
                {"@p_Nombre_Evaluacion",modelo.Nombre_evaluacion.ToString() }, 
                {"@p_Habilitada","1" },
            };
            try
            {
                ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Evaluacion.sp_sam_crear_actualizar_evaluacion, parametro);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally { dt = null; }
        }

        // PREGUNTAS 
        public DataTable Evaluacion_MostrarPreguntasDeEvaluacion(Evaluacion_Modelo modelo)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_Evaluacion",modelo.ID_Evaluacion.ToString() }
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
            }
            finally { dt = null; }
        }

        public void Evaluacion_CrearPreguntaEvaluacion(Evaluacion_Preguntas_Modelo modelo)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_Pregunta","0" },
                {"@p_ID_Evaluacion",modelo.ID_Evaluacion.ToString() },
                {"@p_Pregunta",modelo.Pregunta.ToString() },
                {"@p_Puntaje",modelo.Puntaje.ToString() }
            };
            try
            {
                ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Evaluacion.sp_sam_crear_pregunta_a_evaluacion, parametro);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally { dt = null; }
        }
        public void Evaluacion_CrearRespuestaEvaluacion(Evaluacion_Respuestas_Modelo modelo)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_Respuesta","0" },
                {"@p_ID_Pregunta",modelo.ID_Pregunta.ToString() },
                {"@p_Respuesta",modelo.Respuesta.ToString() },
                {"@p_EsCorrecta",modelo.EsCorrecta.ToString() }
            };
            try
            {
                ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Evaluacion.sp_sam_crear_respuesta_a_evaluacion, parametro);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally { dt = null; }
        }

        public DataTable Evaluacion_ConsultarEvaluacionPorId(int id)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_Evaluacion",id.ToString() }
            };

            try
            {
                dt = ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Evaluacion.sp_sam_mostrar_evaluacion_por_id, parametro);
                return dt;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new DataTable();
            }
            finally { dt = null; }
        }
    }
}
