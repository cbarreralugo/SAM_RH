using SAM_RH_Negocio.Controlador;
using SAM_RH_Negocio.Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_DALC.Datos
{
    public class Evaluacion_Datos
    {
        public Evaluacion_Modelo ConsultarEvaluacionPorId(int id)
        {
            Evaluacion_Modelo modelo = null;
            DataTable dataTable = Evaluacion_Controlador.Instancia.Evaluacion_ConsultarEvaluacionPorId(id);

            if (dataTable.Rows.Count > 0)
            {
                DataRow fila = dataTable.Rows[0];
                modelo = new Evaluacion_Modelo()
                {
                    ID_Evaluacion = int.Parse(fila["ID"].ToString()),
                    Tipo_evaluacion = fila["Tipo de evaluación"].ToString(),
                    Nombre_evaluacion = fila["Nombre de evaluación"].ToString(),
                    Version = int.Parse(fila["Año de versión"].ToString()),
                    Fecha_Creacion = fila["Ultima actualización"].ToString(),
                    Estatus = fila["Estatus"].ToString(),
                };
            }

            return modelo;
        }

        public IEnumerable<Evaluacion_Modelo> ConsultarTodasLasEvaluaciones()
        {
            List<Evaluacion_Modelo> lista = new List<Evaluacion_Modelo>();
            DataTable dataTable = new DataTable();
            try
            {
                dataTable = Evaluacion_Controlador.Instancia.Evaluacion_MostrarTodasLasEvaluaciones();
                if (dataTable.Rows.Count > 0)
                {
                    for (int i = 0; i < dataTable.Rows.Count; i++)
                    {
                        Evaluacion_Modelo modelo = new Evaluacion_Modelo()
                        {
                            ID_Evaluacion = int.Parse(dataTable.Rows[i]["ID"].ToString()),
                            Tipo_evaluacion = dataTable.Rows[i]["Tipo de evaluación"].ToString(),
                            Nombre_evaluacion = dataTable.Rows[i]["Nombre de evaluación"].ToString(),
                            Version = int.Parse(dataTable.Rows[i]["Año de versión"].ToString()),
                            Fecha_Creacion = dataTable.Rows[i]["Ultima actualización"].ToString(),
                            Estatus = dataTable.Rows[i]["Estatus"].ToString(),
                        };
                        lista.Add(modelo);
                    }

                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
            finally { dataTable = new DataTable(); }
            return lista;
        }

        public void Crear(Evaluacion_Modelo modelo)
        {
            try
            {
                Evaluacion_Controlador.Instancia.Evaluacion_CrearEvaluacion(modelo);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
        }

        public void Crear_Pregunta(Evaluacion_Preguntas_Modelo modelo)
        {
            try
            {
                Evaluacion_Controlador.Instancia.Evaluacion_CrearPreguntaEvaluacion(modelo);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
        }

        public void Crear_Respuesta(Evaluacion_Respuestas_Modelo modelo)
        {
            try
            {
                Evaluacion_Controlador.Instancia.Evaluacion_CrearRespuestaEvaluacion(modelo);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            }
        }
    }
}
