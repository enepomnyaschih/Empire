using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Compilation
{
    public class Lexem
    {
        public enum Types
        {
            IDENTIFIER,
            OPERATOR,
            LBRACKET,
            RBRACKET,
            ASSIGNMENT,
            STRING,
            SEMICOLON,
            INT,
            REAL,
            BOOL
        }

        private Types type;
        private string value;
        private int lineIndex;

        public Lexem(Types type, string value, int lineIndex)
        {
            this.type = type;
            this.value = value;
            this.lineIndex = lineIndex;
        }

        public Types Type
        {
            get
            {
                return type;
            }

            set
            {
                type = value;
            }
        }

        public string Value
        {
            get
            {
                return value;
            }

            set
            {
                this.value = value;
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
