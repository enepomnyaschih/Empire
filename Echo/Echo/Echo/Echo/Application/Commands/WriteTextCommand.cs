using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class WriteTextCommand : WriteCommand
    {
        private string text;

        public WriteTextCommand(string text, bool breakLine) : base(breakLine)
        {
            this.text = text;
        }

        public string Text
        {
            get
            {
                return text;
            }

            set
            {
                text = value;
            }
        }

        protected override string GetText(Processor processor)
        {
            return text;
        }
    }
}
