using System;
using System.Collections.Generic;
using System.Text;
using Com;

namespace Echo.Application
{
    public class Operation : ITyped
    {
        virtual public string Type
        {
            get
            {
                return "";
            }
        }
    }
}
