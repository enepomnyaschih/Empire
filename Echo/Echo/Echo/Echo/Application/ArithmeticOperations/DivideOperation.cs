using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class DivideOperation : ArithmeticOperation
    {
        public override string Type
        {
            get
            {
                return "/";
            }
        }

        public override int III(int x, int y)
        {
            if (y == 0)
                throw new CommandRunException("Division by zero.");

            return x / y;
        }

        public override double DDD(double x, double y)
        {
            if (y == 0)
                throw new CommandRunException("Division by zero.");
            
            return x / y;
        }
    }
}
