using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class MoreOperation : OrderingOperation
    {
        public override string Type
        {
            get
            {
                return ">";
            }
        }

        public override bool IIB(int x, int y)
        {
            return x > y;
        }

        public override bool DDB(double x, double y)
        {
            return x > y;
        }
    }
}
