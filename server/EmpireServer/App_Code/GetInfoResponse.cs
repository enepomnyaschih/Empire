using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace EmpireServer
{
    public class GetInfoResponse
    {
        /*[JsonRpcMethod]
       public object LogoffRequest(int ticket)
       {            Hashtable hash1 = new Hashtable();
           Hashtable hash2 = new Hashtable();
           ArrayList al = new ArrayList();
           hash2["123"] = "4324";
           hash1["12344"] = hash2;
           hash1["al"] = al;
           al.Add(1);
           al.Add(2);
           al.Add(3);

           return hash1;//logoff;
       }*/
        public string   memberID;
        public bool     success;
    }
}
