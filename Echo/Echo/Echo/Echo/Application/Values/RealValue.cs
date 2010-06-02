using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class RealValue : Value
    {
        public const string TYPE = "Real";

        private double val;

        public RealValue(double val)
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

        public double Val
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
            return new RealValue(-Val);
        }

        public override Value Round()
        {
            return new IntValue(Convert.ToInt32(Math.Round(Val)));
        }

        public override Value Trunc()
        {
            return new IntValue(Convert.ToInt32(Math.Truncate(Val)));
        }

        public override string GetText()
        {
            return Val.ToString();
        }

        protected override Value CalculateArithmetic(Value y, ArithmeticOperation op)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new RealValue(op.DDD(Val, (double)((IntValue)y).Val));
                case RealValue.TYPE: return new RealValue(op.DDD(Val, ((RealValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        protected override Value CalculateComparing(Value y, ComparingOperation op)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new BoolValue(op.DDB(Val, (double)((IntValue)y).Val));
                case RealValue.TYPE: return new BoolValue(op.DDB(Val, ((RealValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        protected override Value CalculateOrdering(Value y, OrderingOperation op)
        {
            switch (y.Type)
            {
                case IntValue.TYPE: return new BoolValue(op.DDB(Val, (double)((IntValue)y).Val));
                case RealValue.TYPE: return new BoolValue(op.DDB(Val, ((RealValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }
    }
}
