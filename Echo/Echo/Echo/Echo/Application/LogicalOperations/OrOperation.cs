using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class OrOperation : LogicalOperation
    {
        public override string Type
        {
            get
            {
                return "'or'";
            }
        }

        public override bool BBB(bool x, bool y)
        {
            return x || y;
        }
    }
}
