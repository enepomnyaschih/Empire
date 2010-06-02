using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class VarExpression : Expression
    {
        private string varName;

        public VarExpression(string varName)
        {
            this.varName = varName;
        }

        public string VarName
        {
            get
            {
                return varName;
            }

            set
            {
                varName = value;
            }
        }

        public override Value Calculate(Processor processor)
        {
            Value var = processor.GetVar(varName);
            if (null == var)
                throw new CommandRunException("Can't calculate expression, variable " + varName + " is undefined.");

            return var;
        }
    }
}
