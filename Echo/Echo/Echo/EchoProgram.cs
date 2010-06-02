using System;
using System.Collections.Generic;
using System.Text;
using Echo.Application;
using System.IO;
using Echo.Compilation;
using System.Globalization;

namespace Echo
{
    class EchoProgram
    {
        static void Main(string[] args)
        {
            /*
            Program program = new Program();
            program.Blocks.Add(new Block(new WriteTextCommand("x=", false), 0));
            program.Blocks.Add(new Block(new ReadCommand("x"), 1));
            program.Blocks.Add(
                new Block(
                    new AssignmentCommand(
                        "y",
                        new MultExpression(
                            new PlusExpression(
                                new BackExpression(new VarExpression("x")),
                                new ValueExpression(new RealValue(1.5))
                            ),
                            new ValueExpression(new IntValue(2))
                        )
                    ),
                    2
                )
            );
            program.Blocks.Add(new Block(new WriteTextCommand("результат=", false), 3));
            program.Blocks.Add(
                new Block(
                    new ConditionCommand(
                        new LessExpression(
                            new VarExpression("y"),
                            new ValueExpression(new IntValue(0))
                        ),
                        new WriteExpressionCommand(
                            new BackExpression(new VarExpression("y")),
                            true
                        ),
                        new WriteExpressionCommand(
                            new VarExpression("y"),
                            true
                        )
                    ),
                    4
                )
            );

            Processor processor = new Processor();
            processor.Execute(program);
            */

            if (args.Length != 1)
            {
                Console.WriteLine("USAGE: EchoProgram <source_file>");
                return;
            }

            string source;

            try
            {
                source = File.ReadAllText(args[0], Encoding.Default);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                return;
            }

            Program program = null;

            try
            {
                program = new Compiler().Compile(source);
            }
            catch (CompilationException e)
            {
                if (e.Line == -1)
                    Console.WriteLine("Compilation error: " + e.Message);
                else
                    Console.WriteLine("Compilation error, line " + e.Line.ToString() + ": " + e.Message);
            }

            new Processor().Execute(program);
        }
    }
}
