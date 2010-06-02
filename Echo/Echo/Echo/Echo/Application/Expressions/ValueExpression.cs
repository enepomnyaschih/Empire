using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class ValueExpression : Expression
    {
        private Value value;

        public ValueExpression(Value value)
        {
            this.value = value;
        }

        public Value Value
        {
            get
            {
                return this.value;
            }

            set
            {
                this.value = value;
            }
        }

        public override Value Calculate(Processor processor)
        {
            return value;
        }
    }
}
