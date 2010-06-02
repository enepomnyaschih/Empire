using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class OrExpression : Expression
    {
        private Expression x;
        private Expression y;

        public Expression X
        {
            get
            {
                return x;
            }

            set
            {
                x = value;
            }
        }

        public Expression Y
        {
            get
            {
                return y;
            }

            set
            {
                y = value;
            }
        }

        public override Value Calculate(Processor processor)
        {
            return x.Calculate(processor).Or(y.Calculate(processor));
        }
    }
}
