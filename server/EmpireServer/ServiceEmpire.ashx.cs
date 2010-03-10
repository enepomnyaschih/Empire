using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using Jayrock;
using Jayrock.Json;
using Jayrock.JsonRpc;
using Jayrock.JsonRpc.Web;


namespace EmpireServer
{
    [JsonRpcService]
    [ToolboxItem(false)]
  
    public class ServiceEmpire : JsonRpcHandler
    {
        [JsonRpcMethod]
        public object LoginRequest(string login, string password, bool remember)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["ticket"] = 123456;
            
            return hashtable;
        }

        [JsonRpcMethod]
        public object GetMemberInfo(int ticket)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["memberID"] = "qwertqqwes";

            return hashtable;
        }

        [JsonRpcMethod]
        public object LogoffRequest(int ticket)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            
            return hashtable;
        }

       [JsonRpcMethod]
        public object RegisterRequest(string memberID, string password)
        {
            Hashtable hashtable = new Hashtable();

            hashtable["success"] = true;
            hashtable["errorID"] = "qwertqqwes";

            return hashtable;
        }

    
    }
}
