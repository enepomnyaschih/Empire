using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class WriteCommand : Command
    {
        private bool breakLine;

        public WriteCommand(bool breakLine)
        {
            this.breakLine = breakLine;
        }

        public bool BreakLine
        {
            get
            {
                return breakLine;
            }

            set
            {
                breakLine = value;
            }
        }

        public override void Run(Processor processor)
        {
            processor.Write(GetText(processor), BreakLine);
        }

        virtual protected string GetText(Processor processor)
        {
            return "";
        }
    }
}
