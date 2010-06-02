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
                    int yVal = ((IntValue)y).Val;
                    if (Val % yVal == 0)
                        return new IntValue(Val / yVal);
                    else
                        return new RealValue((double)Val / (double)yVal);

                case RealValue.TYPE:
                    return new RealValue((double)Val / ((RealValue)y).Val);
            }

            ThrowBinaryOperationException(y, "/");
            return null;
        }

        public override Value Mod(Value y)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new IntValue(Val % ((IntValue)y).Val);
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
