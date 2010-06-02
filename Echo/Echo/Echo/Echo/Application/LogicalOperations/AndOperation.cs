using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class AndOperation : LogicalOperation
    {
        public override string Type
        {
            get
            {
                return "'and'";
            }
        }

        public override bool BBB(bool x, bool y)
        {
            return x && y;
        }
    }
}
