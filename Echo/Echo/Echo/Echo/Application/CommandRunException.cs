using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class CommandRunException : Exception
    {
        public CommandRunException(string message) : base(message)
        {
        }
    }
}
