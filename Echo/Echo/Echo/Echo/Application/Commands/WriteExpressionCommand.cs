using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class WriteExpressionCommand : WriteCommand
    {
        private Expression expression;

        public WriteExpressionCommand(Expression expression, bool breakLine) : base(breakLine)
        {
            this.expression = expression;
        }

        public Expression Expression
        {
            get
            {
                return expression;
            }

            set
            {
                expression = value;
            }
        }

        protected override string GetText(Processor processor)
        {
            return expression.Calculate(processor).GetText();
        }
    }
}
