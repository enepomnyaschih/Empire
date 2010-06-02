using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class RoundExpression : Expression
    {
        private Expression x;

        public RoundExpression(Expression x)
        {
            this.x = x;
        }

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

        public override Value Calculate(Processor processor)
        {
            return x.Calculate(processor).Round();
        }
    }
}
