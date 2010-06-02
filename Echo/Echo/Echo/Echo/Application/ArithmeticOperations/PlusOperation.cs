using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class PlusOperation : ArithmeticOperation
    {
        public override string Type
        {
            get
            {
                return "+";
            }
        }

        public override int III(int x, int y)
        {
            return x + y;
        }

        public override double DDD(double x, double y)
        {
            return x + y;
        }
    }
}
