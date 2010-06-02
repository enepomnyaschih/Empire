using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Compilation
{
    public class OperationInfo
    {
        private string symbol;
        private int priority;
        private bool unary;

        public OperationInfo(string symbol, int priority, bool unary)
        {
            this.symbol = symbol;
            this.priority = priority;
            this.unary = unary;
        }

        public string Symbol
        {
            get
            {
                return symbol;
            }

            set
            {
                symbol = value;
            }
        }

        public int Priority
        {
            get
            {
                return priority;
            }

            set
            {
                priority = value;
            }
        }

        public bool Unary
        {
            get
            {
                return unary;
            }

            set
            {
                unary = value;
            }
        }

        public bool Binary
        {
            get
            {
                return !Unary;
            }

            set
            {
                Unary = !value;
            }
        }
    }
}
