using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.Globalization;

namespace Echo.Compilation
{
    public class Lexer
    {
        private ArrayList lexems;

        /**
         * 0 - whitespace
         * 1 - identifier
         * 2 - operator
         * 3 - string
         */
        private string source;
        private int state;
        private int nextState;
        private int start;
        private int symbolIndex;
        private int lineIndex;
        private char symbol;
        private char lastOperatorSymbol;

        public ArrayList Compile(string source)
        {
            this.source = source;

            lexems = new ArrayList();

            state = 0;
            start = 0;
            lineIndex = 1;
            lastOperatorSymbol = (char)0;

            for (symbolIndex = 0; symbolIndex < source.Length; ++symbolIndex)
            {
                symbol = source[symbolIndex];
                if (symbol == '\n')
                    ++lineIndex;

                nextState = PreHandle();
                SelectState();
                ExitState();
                HandleState();
            }

            nextState = 0;
            ExitState();

            return lexems;
        }

        private int PreHandle()
        {
            switch (state)
            {
                case 3: return (symbol == '\'') ? 0 : 3;
            }

            return -1;
        }

        private void SelectState()
        {
            if (nextState != -1)
                return;

            if (IsWhitespace(symbol))
                nextState = 0;
            else if (IsIdentifier(symbol))
                nextState = 1;
            else if (IsOperator(symbol))
                nextState = 2;
            else if (symbol == '\'')
                nextState = 3;
            else
                throw new CompilationException("Unexpected symbol '" + symbol + "'.", lineIndex);
        }

        private void ExitState()
        {
            if (nextState == state)
                return;

            switch (state)
            {
                case 1:
                    string s = source.Substring(start, symbolIndex - start);
                    if (s == "and" || s == "or" || s == "not" || s == "round" || s == "trunc")
                    {
                        lexems.Add(new Lexem(Lexem.Types.OPERATOR, s, lineIndex));
                        break;
                    }

                    if (s == "true" || s == "false")
                    {
                        lexems.Add(new Lexem(Lexem.Types.BOOL, s, lineIndex));
                        break;
                    }

                    if (TryParseInt(s))
                        break;

                    if (TryParseDouble(s))
                        break;

                    if (s.IndexOf('.') != -1)
                        throw new CompilationException("'.' is not allowed in identifier.", lineIndex);

                    if (IsNumber(s[0]))
                        throw new CompilationException("Identifier can't start from number.", lineIndex);

                    lexems.Add(new Lexem(Lexem.Types.IDENTIFIER, s, lineIndex));
                    break;

                case 2:
                    if (lastOperatorSymbol == ':')
                        throw new CompilationException("'=' expected after ':'", lineIndex);
                    lexems.Add(new Lexem(Lexem.Types.OPERATOR, lastOperatorSymbol.ToString(), lineIndex));
                    break;

                case 3:
                    lexems.Add(new Lexem(Lexem.Types.STRING, source.Substring(start + 1, symbolIndex - start - 1), lineIndex));
                    break;
            }

            start = symbolIndex;
            state = nextState;
        }

        private void HandleState()
        {
            switch (state)
            {
                case 2:
                    if (lastOperatorSymbol == '<' && symbol == '>')
                    {
                        lastOperatorSymbol = (char)0;
                        lexems.Add(new Lexem(Lexem.Types.OPERATOR, "<>", lineIndex));
                        state = 0;
                        break;
                    }

                    if (lastOperatorSymbol == '<' && symbol == '=')
                    {
                        lastOperatorSymbol = (char)0;
                        lexems.Add(new Lexem(Lexem.Types.OPERATOR, "<=", lineIndex));
                        state = 0;
                        break;
                    }

                    if (lastOperatorSymbol == '>' && symbol == '=')
                    {
                        lastOperatorSymbol = (char)0;
                        lexems.Add(new Lexem(Lexem.Types.OPERATOR, ">=", lineIndex));
                        state = 0;
                        break;
                    }

                    if (lastOperatorSymbol == ':' && symbol == '=')
                    {
                        lastOperatorSymbol = (char)0;
                        lexems.Add(new Lexem(Lexem.Types.ASSIGNMENT, ":=", lineIndex));
                        state = 0;
                        break;
                    }

                    if (symbol == '<' || symbol == '>' || symbol == ':')
                    {
                        lastOperatorSymbol = symbol; 
                        break;
                    }

                    Lexem.Types type = Lexem.Types.OPERATOR;

                    if (symbol == '+' || symbol == '-' || symbol == '*' || symbol == '/' || symbol == '%' || symbol == '=')
                        type = Lexem.Types.OPERATOR;

                    if (symbol == ';')
                        type = Lexem.Types.SEMICOLON;

                    if (symbol == '(')
                        type = Lexem.Types.LBRACKET;

                    if (symbol == ')')
                        type = Lexem.Types.RBRACKET;

                    lexems.Add(new Lexem(type, symbol.ToString(), lineIndex));

                    state = 0;
                    break;
            }
        }

        private bool IsWhitespace(char c)
        {
            return
                (c == ' ') ||
                (c == '\r') ||
                (c == '\n') ||
                (c == '\t');
        }

        private bool IsIdentifier(char c)
        {
            return
                ((c >= 'a') && (c <= 'z')) ||
                ((c >= 'A') && (c <= 'Z')) ||
                ((c >= '0') && (c <= '9')) ||
                (c == '_') ||
                (c == '.');
        }

        private bool IsNumber(char c)
        {
            return (c >= '0') && (c <= '9');
        }

        private bool IsOperator(char c)
        {
            return
                (c == '+') ||
                (c == '-') ||
                (c == '*') ||
                (c == '/') ||
                (c == '%') ||
                (c == '>') ||
                (c == '<') ||
                (c == '=') ||
                (c == ':') ||
                (c == ';') ||
                (c == '(') ||
                (c == ')');
        }

        private bool TryParseInt(string s)
        {
            try
            {
                Convert.ToInt32(s);
            }
            catch (FormatException)
            {
                return false;
            }
            catch (OverflowException)
            {
                return false;
            }

            lexems.Add(new Lexem(Lexem.Types.INT, s, lineIndex));
            return true;
        }

        private bool TryParseDouble(string s)
        {
            try
            {
                Convert.ToDouble(s, new CultureInfo("en-US"));
            }
            catch (FormatException)
            {
                return false;
            }

            lexems.Add(new Lexem(Lexem.Types.REAL, s, lineIndex));
            return true;
        }
    }
}
