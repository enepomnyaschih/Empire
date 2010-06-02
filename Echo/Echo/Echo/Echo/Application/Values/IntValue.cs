using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class IntValue : Value
    {
        public const string TYPE = "Int";

        private int val;

        public IntValue(int val)
        {
            this.val = val;
        }

        public override string Type
        {
            get
            {
                return TYPE;
            }
        }

        public int Val
        {
            get
            {
                return val;
            }

            set
            {
                val = value;
            }
        }

        public override Value Back()
        {
            return new IntValue(-Val);
        }

        public override Value Round()
        {
            return new IntValue(Val);
        }

        public override Value Trunc()
        {
            return new IntValue(Val);
        }

        public override Value Div(Value y)
        {
            switch (y.Type)
            {
                case IntValue.TYPE:
                    int yiVal = ((IntValue)y).Val;
                    if (yiVal == 0)
                        throw new CommandRunException("Division by zero.");
                    else if (Val % yiVal == 0)
                        return new IntValue(Val / yiVal);
                    else
                        return new RealValue((double)Val / (double)yiVal);

                case RealValue.TYPE:
                    double ydVal = ((RealValue)y).Val;
                    if (ydVal == 0)
                        throw new CommandRunException("Division by zero.");

                    return new RealValue((double)Val / ydVal);
            }

            ThrowBinaryOperationException(y, "/");
            return null;
        }

        public override Value Mod(Value y)
        {
            switch (y.Type)
            {
                case IntValue.TYPE:
                    int yVal = ((IntValue)y).Val;
                    if (yVal == 0)
                        throw new CommandRunException("Division by zero.");

                    return new IntValue(Val % yVal);
            }

            ThrowBinaryOperationException(y, "%");
            return null;
        }

        public override string GetText()
        {
            return Val.ToString();
        }

        protected override Value CalculateArithmetic(Value y, ArithmeticOperation op)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new IntValue(op.III(Val, ((IntValue)y).Val));
                case RealValue.TYPE: return new RealValue(op.DDD((double)Val, ((RealValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        protected override Value CalculateComparing(Value y, ComparingOperation op)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new BoolValue(op.IIB(Val, ((IntValue)y).Val));
                case RealValue.TYPE: return new BoolValue(op.DDB((double)Val, ((RealValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        protected override Value CalculateOrdering(Value y, OrderingOperation op)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new BoolValue(op.IIB(Val, ((IntValue)y).Val));
                case RealValue.TYPE: return new BoolValue(op.DDB((double)Val, ((RealValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }
    }
}
