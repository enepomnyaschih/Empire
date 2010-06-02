using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Compilation
{
    public class CompilationException : Exception
    {
        private int line;

        public CompilationException(string message, int line) : base(message)
        {
            this.line = line;
        }

        public int Line
        {
            get
            {
                return line;
            }
        }
    }
}
