using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class Value
    {
        virtual public string Type
        {
            get
            {
                return "";
            }
        }

        virtual public Value Back()
        {
            ThrowUnaryOperationException("-");
            return null;
        }

        virtual public Value Round()
        {
            ThrowUnaryOperationException("'round'");
            return null;
        }

        virtual public Value Trunc()
        {
            ThrowUnaryOperationException("'trunc'");
            return null;
        }

        virtual public Value Not()
        {
            ThrowUnaryOperationException("'not'");
            return null;
        }

        virtual public Value Plus(Value y)
        {
            return CalculateArithmetic(y, new PlusOperation());
        }

        virtual public Value Minus(Value y)
        {
            return CalculateArithmetic(y, new MinusOperation());
        }

        virtual public Value Mult(Value y)
        {
            return CalculateArithmetic(y, new MultOperation());
        }

        virtual public Value Div(Value y)
        {
            return CalculateArithmetic(y, new DivideOperation());
        }

        virtual public Value Mod(Value y)
        {
            ThrowBinaryOperationException(y, "%");
            return null;
        }

        virtual public Value Equal(Value y)
        {
            return CalculateComparing(y, new EqualOperation());
        }

        virtual public Value NotEqual(Value y)
        {
            return CalculateComparing(y, new NotEqualOperation());
        }

        virtual public Value Less(Value y)
        {
            return CalculateOrdering(y, new LessOperation());
        }

        virtual public Value LessOrEqual(Value y)
        {
            return CalculateOrdering(y, new LessOrEqualOperation());
        }

        virtual public Value More(Value y)
        {
            return CalculateOrdering(y, new MoreOperation());
        }

        virtual public Value MoreOrEqual(Value y)
        {
            return CalculateOrdering(y, new MoreOrEqualOperation());
        }

        virtual public Value And(Value y)
        {
            return CalculateLogical(y, new AndOperation());
        }

        virtual public Value Or(Value y)
        {
            return CalculateLogical(y, new OrOperation());
        }

        virtual public string GetText()
        {
            throw new CommandRunException("Can't write value of " + Type + " type.");
        }

        virtual protected Value CalculateArithmetic(Value y, ArithmeticOperation op)
        {
            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        virtual protected Value CalculateComparing(Value y, ComparingOperation op)
        {
            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        virtual protected Value CalculateOrdering(Value y, OrderingOperation op)
        {
            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        virtual protected Value CalculateLogical(Value y, LogicalOperation op)
        {
            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        protected void ThrowUnaryOperationException(string opType)
        {
            throw new CommandRunException("Can't apply operation " + opType + " to value of " + Type + " type.");
        }

        protected void ThrowBinaryOperationException(Value y, string opType)
        {
            throw new CommandRunException("Can't apply operation " + opType + " to values of " + Type + " and " + y.Type + " types.");
        }
    }
}
