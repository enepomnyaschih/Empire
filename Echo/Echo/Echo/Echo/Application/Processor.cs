using System;
using System.Collections.Generic;
using System.Text;
using System.Globalization;

namespace Echo.Application
{
    public class Processor
    {
        private Program program;
        private int blockIndex;
        private Dictionary<string, Value> vars;

        public Program Program
        {
            get
            {
                return program;
            }
        }

        public int BlockIndex
        {
            get
            {
                return blockIndex;
            }
        }

        public Block Block
        {
            get
            {
                return (Block)program.Blocks[blockIndex];
            }
        }

        public Value GetVar(string name)
        {
            Value value;
            return vars.TryGetValue(name, out value) ? value : null;
        }

        public void SetVar(string name, Value value)
        {
            vars[name] = value;
        }

        public void Write(string text, bool breakLine)
        {
            if (breakLine)
                Console.WriteLine(text);
            else
                Console.Write(text);
        }

        public void Read(string varName)
        {
            string text = Console.ReadLine();

            Value value;

            value = ParseInt(text);
            if (null != value)
            {
                SetVar(varName, value);
                return;
            }

            value = ParseReal(text);
            if (null != value)
            {
                SetVar(varName, value);
                return;
            }

            throw new CommandRunException("Can't parse '" + text + "' as Int or Real value.");
        }

        public void Execute(Program program)
        {
            this.program = program;
            vars = new Dictionary<string, Value>();

            Console.WriteLine("Executing program");
            for (blockIndex = 0; blockIndex < program.Blocks.Count; ++blockIndex)
                RunBlock();

            this.program = null;
            blockIndex = 0;
            vars = null;
        }

        private IntValue ParseInt(string text)
        {
            int value;

            try
            {
                value = Convert.ToInt32(text);
            }
            catch (FormatException)
            {
                return null;
            }

            return new IntValue(value);
        }

        private RealValue ParseReal(string text)
        {
            double value;

            try
            {
                value = Convert.ToDouble(text, new CultureInfo("en-US"));
            }
            catch (FormatException)
            {
                return null;
            }

            return new RealValue(value);
        }

        private void RunBlock()
        {
            try
            {
                Block.Command.Run(this);
            }
            catch (CommandRunException e)
            {
                Console.WriteLine("Runtime error, line " + Block.LineIndex.ToString() + ": " + e.Message);
            }
        }
    }
}
