using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class BoolValue : Value
    {
        public const string TYPE = "Bool";

        private bool val;

        public BoolValue(bool val)
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

        public bool Val
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

        public override Value Not()
        {
            return new BoolValue(!val);
        }

        protected override Value CalculateComparing(Value y, ComparingOperation op)
        {
            switch (y.Type)
            {
                case BoolValue.TYPE: return new BoolValue(op.BBB(Val, ((BoolValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }

        protected override Value CalculateLogical(Value y, LogicalOperation op)
        {
            switch (y.Type)
            {
                case BoolValue.TYPE: return new BoolValue(op.BBB(Val, ((BoolValue)y).Val));
            }

            ThrowBinaryOperationException(y, op.Type);
            return null;
        }
    }
}
