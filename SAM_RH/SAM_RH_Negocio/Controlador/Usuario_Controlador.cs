using SAM_RH_Negocio.Modelo;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SAM_RH_Negocio.Controlador
{
    public class Usuario_Controlador
    {
        private static Usuario_Controlador _instancia;
        public static Usuario_Controlador Instancia
        {
            get
            {
                if (_instancia == null)
                {
                    _instancia = new Usuario_Controlador();
                }
                return _instancia;
            }
        }
        public DataTable Usuario_MostarTodosLosUsuarios()
        {
            DataTable dt = new DataTable();

            try
            {
                dt = ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Usuario.sp_sam_mostrar_usuarios);
                return dt;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return new DataTable();
            }
            finally { dt = null; }
        }
        public void Usuario_CrearNuevoUsuario(Usuario_Modelo modelo)
        {
            DataTable dt = new DataTable();
            string[,] parametro =
            {
                {"@p_ID_Usuario","0" }, 
                {"@p_Nombre",modelo.Nombre.ToString() },
                {"@p_Puesto",modelo.Puesto.ToString() },
                {"@p_Departamento",modelo.Departamento.ToString() },
                {"@p_UsrLocal",modelo.UsrLocal.ToString() },
                {"@p_Habilitado","1" },
            };
            try
            {
                ConnectorLibrary.App.GetCurrentConnector().Tabla(SAM_RH_Negocio.Utilidades.SP_Usuario.sp_sam_crear_actualizar_usuario,parametro);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally { dt = null; }
        }
    }
}
