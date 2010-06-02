using System;
using System.Collections.Generic;
using System.Text;
using Echo.Application;
using System.Collections;

namespace Echo.Compilation
{
    public class Compiler
    {
        public Program Compile(string source)
        {
            Console.WriteLine(source);
            Console.WriteLine("----");
            string preCompiledSource    = new PreCompiler() .Compile(source);
            Console.WriteLine(preCompiledSource);
            Console.WriteLine("----");
            ArrayList lexems            = new Lexer()       .Compile(preCompiledSource);
            for (int i = 0; i < lexems.Count; ++i)
            {
                Lexem lexem = (Lexem)lexems[i];
                switch (lexem.Type)
                {
                    case Lexem.Types.ASSIGNMENT : Console.Write("ASSIGNMENT "); break;
                    case Lexem.Types.IDENTIFIER : Console.Write("IDENTIFIER "); break;
                    case Lexem.Types.LBRACKET   : Console.Write("LBRACKET   "); break;
                    case Lexem.Types.OPERATOR   : Console.Write("OPERATOR   "); break;
                    case Lexem.Types.RBRACKET   : Console.Write("RBRACKET   "); break;
                    case Lexem.Types.SEMICOLON  : Console.Write("SEMICOLON  "); break;
                    case Lexem.Types.STRING     : Console.Write("STRING     "); break;
                    case Lexem.Types.INT        : Console.Write("INT        "); break;
                    case Lexem.Types.REAL       : Console.Write("REAL       "); break;
                    case Lexem.Types.BOOL       : Console.Write("BOOL       "); break;
                }

                Console.WriteLine(lexem.Value);
            }
            return new Builder().Compile(lexems);
        }
    }
}
