using System;
using System.Collections.Generic;
using System.Text;
using Echo.Application;
using System.Collections;
using System.Globalization;

namespace Echo.Compilation
{
    public class Calculator
    {
        ArrayList block;

        List<OperationInfo> operations = new List<OperationInfo>();

        bool wasOperator;
        Stack<Lexem> stack;
        ArrayList record;

        public Calculator()
        {
            operations.Add(new OperationInfo("back", 0, true));
            operations.Add(new OperationInfo("not", 0, true));
            operations.Add(new OperationInfo("round", 0, true));
            operations.Add(new OperationInfo("trunc", 0, true));
            operations.Add(new OperationInfo("*", 1, false));
            operations.Add(new OperationInfo("/", 1, false));
            operations.Add(new OperationInfo("%", 1, false));
            operations.Add(new OperationInfo("+", 2, false));
            operations.Add(new OperationInfo("-", 2, false));
            operations.Add(new OperationInfo("=", 3, false));
            operations.Add(new OperationInfo("<>", 3, false));
            operations.Add(new OperationInfo("<=", 3, false));
            operations.Add(new OperationInfo(">=", 3, false));
            operations.Add(new OperationInfo(">", 3, false));
            operations.Add(new OperationInfo("<", 3, false));
            operations.Add(new OperationInfo("and", 4, false));
            operations.Add(new OperationInfo("or", 5, false));
        }

        public Expression Compile(ArrayList block)
        {
            this.block = block;

            BuildRecord();
            return BuildExpression();
        }

        private void BuildRecord()
        {
            wasOperator = true;
            stack = new Stack<Lexem>();
            record = new ArrayList();

            stack.Push(new Lexem(Lexem.Types.LBRACKET, "(", 0));
            for (int i = 0; i < block.Count; ++i)
            {
                Lexem lexem = (Lexem)block[i];
                if (wasOperator)
                {
                    if (lexem.Type == Lexem.Types.LBRACKET)
                    {
                        stack.Push(lexem);
                    }
                    else if (lexem.Type == Lexem.Types.OPERATOR)
                    {
                        if (lexem.Value == "-")
                            lexem.Value = "back";

                        OperationInfo op = GetOperation(lexem.Value);
                        if (!op.Unary)
                            throw new CompilationException("Value, unary operation or left bracket expected.", lexem.LineIndex);

                        stack.Push(lexem);
                    }
                    else if (IsValueType(lexem.Type))
                    {
                        record.Add(lexem);
                        wasOperator = false;
                    }
                    else
                    {
                        throw new CompilationException("Value, unary operation or left bracket expected.", lexem.LineIndex);
                    }
                }
                else
                {
                    if (lexem.Type == Lexem.Types.RBRACKET)
                    {
                        PurgeBracket();
                    }
                    else if (lexem.Type == Lexem.Types.OPERATOR)
                    {
                        OperationInfo op = GetOperation(lexem.Value);
                        if (op.Unary)
                            throw new CompilationException("Binary operation or right bracket expected.", lexem.LineIndex);

                        while (true)
                        {
                            Lexem top = PeekStack();
                            if (IsValueType(top.Type) || top.Type == Lexem.Types.LBRACKET)
                                break;

                            OperationInfo opt = GetOperation(top.Value);
                            if (opt.Priority > op.Priority)
                                break;

                            record.Add(stack.Pop());
                        }

                        stack.Push(lexem);
                        wasOperator = true;
                    }
                    else
                    {
                        throw new CompilationException("Binary operation or right bracket expected.", lexem.LineIndex);
                    }
                }
            }

            if (wasOperator)
                throw new CompilationException("Value, unary operation or left bracket expected.", ((Lexem)block[0]).LineIndex);

            PurgeBracket();
            if (stack.Count != 0)
                throw new CompilationException("More left brackets then right brackets.", ((Lexem)block[0]).LineIndex);
        }

        private void PurgeBracket()
        {
            while (PeekStack().Type != Lexem.Types.LBRACKET)
                record.Add(stack.Pop());

            stack.Pop();
        }

        private Lexem PeekStack()
        {
            if (stack.Count == 0)
                throw new CompilationException("More right brackets then left brackets.", ((Lexem)block[0]).LineIndex);

            return stack.Peek();
        }

        private Lexem PopStack()
        {
            Lexem lexem = PeekStack();
            stack.Pop();
            return lexem;
        }

        private OperationInfo GetOperation(string symbol)
        {
            for (int i = 0; i < operations.Count; ++i)
                if (operations[i].Symbol == symbol)
                    return operations[i];

            throw new CompilationException("Unknown operator detected: '" + symbol + "'.", ((Lexem)block[0]).LineIndex);
        }

        private bool IsValueType(Lexem.Types type)
        {
            return
                (type == Lexem.Types.IDENTIFIER) ||
                (type == Lexem.Types.INT) ||
                (type == Lexem.Types.REAL) ||
                (type == Lexem.Types.BOOL);
        }

        private Expression BuildExpression()
        {
            Stack<Expression> stack = new Stack<Expression>();
            for (int i = 0; i < record.Count; ++i)
            {
                Lexem lexem = (Lexem)record[i];
                if (lexem.Type == Lexem.Types.IDENTIFIER)
                    stack.Push(new VarExpression(lexem.Value));
                else if (lexem.Type == Lexem.Types.INT)
                    stack.Push(new ValueExpression(new IntValue(Convert.ToInt32(lexem.Value))));
                else if (lexem.Type == Lexem.Types.REAL)
                    stack.Push(new ValueExpression(new RealValue(Convert.ToDouble(lexem.Value, new CultureInfo("en-US")))));
                else if (lexem.Type == Lexem.Types.BOOL)
                    stack.Push(new ValueExpression(new BoolValue(lexem.Value == "true")));
                else
                {
                    OperationInfo op = GetOperation(lexem.Value);
                    if (op.Unary)
                    {
                        switch (op.Symbol)
                        {
                            case "back"     : stack.Push(new BackExpression         (stack.Pop())); break;
                            case "not"      : stack.Push(new NotExpression          (stack.Pop())); break;
                            case "round"    : stack.Push(new RoundExpression        (stack.Pop())); break;
                            case "trunc"    : stack.Push(new TruncExpression        (stack.Pop())); break;
                        }
                    }
                    else
                    {
                        Expression b = stack.Pop();
                        Expression a = stack.Pop();

                        switch (op.Symbol)
                        {
                            case "+"        : stack.Push(new PlusExpression         (a, b)); break;
                            case "-"        : stack.Push(new MinusExpression        (a, b)); break;
                            case "*"        : stack.Push(new MultExpression         (a, b)); break;
                            case "/"        : stack.Push(new DivExpression          (a, b)); break;
                            case "%"        : stack.Push(new ModExpression          (a, b)); break;
                            case "="        : stack.Push(new EqualExpression        (a, b)); break;
                            case "<>"       : stack.Push(new NotEqualExpression     (a, b)); break;
                            case "<"        : stack.Push(new LessExpression         (a, b)); break;
                            case ">"        : stack.Push(new MoreExpression         (a, b)); break;
                            case "<="       : stack.Push(new LessOrEqualExpression  (a, b)); break;
                            case ">="       : stack.Push(new MoreOrEqualExpression  (a, b)); break;
                            case "and"      : stack.Push(new AndExpression          (a, b)); break;
                            case "or"       : stack.Push(new OrExpression           (a, b)); break;
                        }
                    }
                }
            }

            return stack.Pop();
        }
    }
}
