using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class DivExpression : Expression
    {
        private Expression x;
        private Expression y;

        public DivExpression(Expression x, Expression y)
        {
            this.x = x;
            this.y = y;
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
            return x.Calculate(processor).Div(y.Calculate(processor));
        }
    }
}
