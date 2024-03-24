using System.Configuration;
using System.Diagnostics;
using ConnectorLibrary.FamiliaConector; 

namespace ConnectorLibrary
{
    public class App
    {
        private static readonly object _mutex = new object();

    
        private static IFamiliaConector connector = null;
       
        public static IFamiliaConector GetCurrentConnector()
        {
            lock (_mutex)
            {
                if (connector == null)
                {
                    connector = new ConnectorLibrary.FamiliaConector.Sql.Conector(ConfigurationManager.AppSettings["DEV"].ToString());
                }
            }
            return connector;
        }
    }
}
 