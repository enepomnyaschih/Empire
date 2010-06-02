using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class Expression
    {
        virtual public Value Calculate(Processor processor)
        {
            return null;
        }
    }
}
