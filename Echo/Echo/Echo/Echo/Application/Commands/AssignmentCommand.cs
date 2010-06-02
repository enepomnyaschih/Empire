using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class AssignmentCommand : Command
    {
        private string target;
        private Expression expression;

        public AssignmentCommand(string target, Expression expression)
        {
            this.target = target;
            this.expression = expression;
        }

        string Target
        {
            get
            {
                return target;
            }

            set
            {
                target = value;
            }
        }

        Expression Expression
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

        public override void Run(Processor processor)
        {
            processor.SetVar(target, expression.Calculate(processor));
        }
    }
}
