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
    public abstract class LogoffResponse
    {
    }

    [Serializable]
    public class LogoffResponseTrue : LogoffResponse
    {
        public bool success;
        public LogoffResponseTrue(bool vsuccess)
        {
            success = vsuccess;
        }
    }

    public class LogoffResponseFalse : LogoffResponse
    {
        public bool success;
        public string errorID;
        public LogoffResponseFalse(bool vsuccess, string verrorID)
        {
            success = vsuccess;
            errorID = verrorID;
        }
    }
}
