using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SAM_RH_Negocio;
using SAM_RH_Negocio.Controlador;
using SAM_RH_Negocio.Modelo;

namespace SAM_RH_DALC.Datos
{
    public class Usuario_Datos
    {
        public IEnumerable<Usuario_Modelo> Consultar()
        {
            List<Usuario_Modelo> lista = new List<Usuario_Modelo>();
            DataTable dataTable = new DataTable();
            try
            {
                dataTable = Usuario_Controlador.Instancia.Usuario_MostarTodosLosUsuarios();
                if(dataTable.Rows.Count > 0)
                {
                    for (int i = 0; i < dataTable.Rows.Count; i++)
                    {
                        Usuario_Modelo modelo = new Usuario_Modelo()
                        {
                            ID_Usuario = int.Parse(dataTable.Rows[i]["ID"].ToString()),
                            Tipo_Usuario = dataTable.Rows[i]["Tipo de usuario"].ToString(),
                            Nombre = dataTable.Rows[i]["Nombre de usuario"].ToString(),
                            Puesto = dataTable.Rows[i]["Puesto"].ToString(),
                            Departamento = dataTable.Rows[i]["Departamento"].ToString(),
                            UsrLocal = dataTable.Rows[i]["UsrLocal"].ToString(),
                            Fecha_Creacion = dataTable.Rows[i]["Ultima actualización"].ToString(),
                            Nombre_Estatus = dataTable.Rows[i]["Estatus de evaluacion"].ToString(),
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

        public void Crear(Usuario_Modelo modelo)
        {  
            try
            {
                 Usuario_Controlador.Instancia.Usuario_CrearNuevoUsuario(modelo); 
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.StackTrace);
            } 
        }
    }
}
