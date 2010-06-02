using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Compilation
{
    public class PreCompiler
    {
        public string Compile(string source)
        {
            StringBuilder builder = new StringBuilder();
            int from = 0;
            while (true)
            {
                int index = source.IndexOf('{', from);
                if (index == -1)
                    break;

                builder.Append(source.Substring(from, index - from));
                builder.Append(" ");
                from = source.IndexOf('}', index) + 1;

                int lineBreakIndex = index;
                while (true)
                {
                    lineBreakIndex = source.IndexOf('\n', lineBreakIndex + 1);
                    if (lineBreakIndex == -1 || lineBreakIndex >= from)
                        break;

                    builder.Append("\n");
                }

                if (from == 0)
                    throw new CompilationException("Unclosed comment detected.", -1);
            }

            builder.Append(source.Substring(from));

            return builder.ToString();
        }
    }
}
