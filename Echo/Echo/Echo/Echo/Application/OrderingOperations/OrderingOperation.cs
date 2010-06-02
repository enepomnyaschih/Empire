using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class OrderingOperation : Operation
    {
        virtual public bool IIB(int x, int y)
        {
            return false;
        }

        virtual public bool DDB(double x, double y)
        {
            return false;
        }
    }
}
