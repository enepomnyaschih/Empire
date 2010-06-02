using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class Block
    {
        private Command command;
        private int lineIndex;

        public Block(Command command, int lineIndex)
        {
            this.command = command;
            this.lineIndex = lineIndex;
        }

        public Command Command
        {
            get
            {
                return command;
            }

            set
            {
                command = value;
            }
        }

        public int LineIndex
        {
            get
            {
                return lineIndex;
            }

            set
            {
                lineIndex = value;
            }
        }
    }
}
