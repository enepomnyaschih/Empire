using System;
using System.Collections.Generic;
using System.Text;
using Echo.Application;
using System.Collections;
using Echo.Util;

namespace Echo.Compilation
{
    public class Builder
    {
        private Program program;

        private ArrayList blocks;
        private int blockIndex;

        public Program Compile(ArrayList lexems)
        {
            program = new Program();

            blocks = SplitBySemicolon(lexems);
            for (blockIndex = 0; blockIndex < blocks.Count; ++blockIndex)
            {
                Command command = BuildBlock((ArrayList)blocks[blockIndex]);
                // TODO: номера строчек в программе
                if (null != command)
                    program.Blocks.Add(new Block(command, 0));
            }

            return program;
        }

        private ArrayList SplitBySemicolon(ArrayList lexems)
        {
            ArrayList result = new ArrayList();
            int from = 0;
            while (true)
            {
                int index;
                for (index = from; index < lexems.Count; ++index)
                {
                    Lexem lexem = (Lexem)lexems[index];
                    if (lexem.Type == Lexem.Types.SEMICOLON)
                        break;
                }

                if (index == lexems.Count)
                    break;

                result.Add(ArrayListUtil.Sub(lexems, from, index - from));
                from = index + 1;
            }

            return result;
        }

        private Command BuildBlock(ArrayList block)
        {
            Command result;

            if (block.Count == 0)
                return null;

            result = BuildBlockIf(block);
            if (null != result)
                return result;

            result = BuildBlockWrite(block, "write", false);
            if (null != result)
                return result;

            result = BuildBlockWrite(block, "writeln", true);
            if (null != result)
                return result;

            result = BuildBlockRead(block);
            if (null != result)
                return result;

            result = BuildBlockAssign(block);
            if (null != result)
                return result;

            // TODO: номера строчек ошибок семантической компиляции
            throw new CompilationException("Can't understand what the instruction means.", -1);
        }

        private Command BuildBlockIf(ArrayList block)
        {
            if (GetLexem(block, 0).Type != Lexem.Types.IDENTIFIER ||
                GetLexem(block, 0).Value != "if")
                return null;

            int thenIndex;
            for (thenIndex = 1; thenIndex < block.Count; ++thenIndex)
            {
                if (GetLexem(block, thenIndex).Type == Lexem.Types.IDENTIFIER &&
                    GetLexem(block, thenIndex).Value == "then")
                    break;
            }

            if (thenIndex == block.Count)
                throw new CompilationException("'then' expected.", 0);

            Expression expression = BuildExpression(ArrayListUtil.Sub(block, 1, thenIndex - 1));
            Command thenCommand = BuildBlock(ArrayListUtil.Sub(block, thenIndex + 1, block.Count - thenIndex - 1));
            Command elseCommand = null;

            if (blockIndex < blocks.Count - 1)
            {
                ArrayList nextBlock = (ArrayList)blocks[blockIndex + 1];
                if (GetLexem(nextBlock, 0).Type == Lexem.Types.IDENTIFIER &&
                    GetLexem(nextBlock, 0).Value == "else")
                {
                    ++blockIndex;
                    elseCommand = BuildBlock(ArrayListUtil.Sub(nextBlock, 1, nextBlock.Count - 1));
                }
            }

            return new ConditionCommand(expression, thenCommand, elseCommand);
        }

        private Command BuildBlockWrite(ArrayList block, string keyword, bool breakLine)
        {
            if (GetLexem(block, 0).Type != Lexem.Types.IDENTIFIER ||
                GetLexem(block, 0).Value != keyword)
                return null;

            if (GetLexem(block, 1).Type != Lexem.Types.LBRACKET ||
                GetLexem(block, 1).Value != "(")
                throw new CompilationException("'(' expected.", 0);

            if (GetLexem(block, block.Count - 1).Type != Lexem.Types.RBRACKET ||
                GetLexem(block, block.Count - 1).Value != ")")
                throw new CompilationException("')' expected.", 0);

            if (block.Count == 4 && GetLexem(block, 2).Type == Lexem.Types.STRING)
                return new WriteTextCommand(GetLexem(block, 2).Value, breakLine);

            return new WriteExpressionCommand(BuildExpression(ArrayListUtil.Sub(block, 2, block.Count - 3)), breakLine);
        }

        private Command BuildBlockRead(ArrayList block)
        {
            if (GetLexem(block, 0).Type != Lexem.Types.IDENTIFIER ||
                GetLexem(block, 0).Value != "read")
                return null;

            if (GetLexem(block, 1).Type != Lexem.Types.LBRACKET ||
                GetLexem(block, 1).Value != "(")
                throw new CompilationException("'(' expected.", 0);

            if (GetLexem(block, block.Count - 1).Type != Lexem.Types.RBRACKET ||
                GetLexem(block, block.Count - 1).Value != ")")
                throw new CompilationException("')' expected.", 0);

            if (block.Count != 4 ||
                GetLexem(block, 2).Type != Lexem.Types.IDENTIFIER)
                throw new CompilationException("Identifier expected.", 0);

            return new ReadCommand(GetLexem(block, 2).Value);
        }

        private Command BuildBlockAssign(ArrayList block)
        {
            if (GetLexem(block, 0).Type != Lexem.Types.IDENTIFIER)
                return null;

            if (GetLexem(block, 1).Type != Lexem.Types.ASSIGNMENT ||
                GetLexem(block, 1).Value != ":=")
                throw new CompilationException("':=' expected.", 0);

            return new AssignmentCommand(GetLexem(block, 0).Value, BuildExpression(ArrayListUtil.Sub(block, 2, block.Count - 2)));
        }

        private Expression BuildExpression(ArrayList block)
        {
            return new Calculator().Compile(block);
        }

        private Lexem GetLexem(ArrayList block, int index)
        {
            if (index >= block.Count)
                return new Lexem(Lexem.Types.SEMICOLON, ";");

            return (Lexem)block[index];
        }
    }
}
