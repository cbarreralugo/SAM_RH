using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using ConnectorLibrary.FamiliaConector;
using System.Configuration;

namespace ConnectorLibrary
{
    public class MyApplication
    {
        private static readonly object _mutex = new object();

    
        private static IFamiliaConector connector = null;
       
        public static IFamiliaConector GetCurrentConnector()
        {
            lock (_mutex)
            {
                if (connector == null)
                {
                    connector = new FamiliaConector.Sql.Conector(ConfigurationManager.ConnectionStrings["DEV"].ConnectionString);
                }
            }
            return connector;
        }
    }
}
 