using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class ReadCommand : Command
    {
        private string varName;

        public ReadCommand(string varName)
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

        public override void Run(Processor processor)
        {
            processor.Read(VarName);
        }
    }
}
