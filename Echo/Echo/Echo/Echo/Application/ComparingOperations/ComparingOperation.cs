using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class ComparingOperation : Operation
    {
        virtual public bool IIB(int x, int y)
        {
            return false;
        }

        virtual public bool DDB(double x, double y)
        {
            return false;
        }

        virtual public bool BBB(bool x, bool y)
        {
            return false;
        }
    }
}
