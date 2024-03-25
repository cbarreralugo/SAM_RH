using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Utilidades
{
    public static class SP_Evaluacion
    {
        // EVALUACIONES
        public static string sp_sam_mostrar_resultados_evaluacion = "sp_sam_mostrar_resultados_evaluacion";
        public static string sp_sam_mostrar_evaluaciones = "sp_sam_mostrar_evaluaciones";
        public static string sp_sam_crear_actualizar_evaluacion = "sp_sam_crear_actualizar_evaluacion";

        // FORMULARIO DE PREGUNTAS Y RESPUESTAS
        public static string sp_sam_mostrar_evaluacion_por_id = "sp_sam_mostrar_evaluacion_por_id";
        public static string sp_sam_mostrar_preguntas_evaluacion = "sp_sam_mostrar_preguntas_evaluacion"; 
        public static string sp_sam_mostrar_respuestas_evaluacion = "sp_sam_mostrar_respuestas_evaluacion";
        public static string sp_sam_crear_pregunta_a_evaluacion = "sp_sam_crear_actualizar_pregunta_a_evaluacion";
        public static string sp_sam_crear_respuesta_a_evaluacion = "sp_sam_crear_actualizar_respuesta_a_evaluacion"; 
        public static string sp_sam_actualizar_pregunta_a_evaluacion = "sp_sam_crear_actualizar_pregunta_a_evaluacion";
        public static string sp_sam_actualizar_respuesta_a_evaluacion = "sp_sam_crear_actualizar_respuesta_a_evaluacion";
         
    }
    public static class SP_Usuario
    {
        // USUARIOS
        public static string sp_sam_mostrar_usuarios = "sp_sam_mostrar_usuarios";
        public static string sp_sam_crear_actualizar_usuario = "sp_sam_crear_actualizar_usuario";
    }

}
