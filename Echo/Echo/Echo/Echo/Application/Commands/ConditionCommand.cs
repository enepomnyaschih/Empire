using System;
using System.Collections.Generic;
using System.Text;

namespace Echo.Application
{
    public class ConditionCommand : Command
    {
        private Expression condition;
        private Command thenCommand;
        private Command elseCommand;

        public ConditionCommand(Expression condition, Command thenCommand, Command elseCommand)
        {
            this.condition = condition;
            this.thenCommand = thenCommand;
            this.elseCommand = elseCommand;
        }

        public Expression Condition
        {
            get
            {
                return condition;
            }

            set
            {
                condition = value;
            }
        }

        public Command ThenCommand
        {
            get
            {
                return thenCommand;
            }

            set
            {
                thenCommand = value;
            }
        }

        public Command ElseCommand
        {
            get
            {
                return elseCommand;
            }

            set
            {
                elseCommand = value;
            }
        }

        public override void Run(Processor processor)
        {
            Value value = condition.Calculate(processor);
            if (value.Type != BoolValue.TYPE)
                throw new CommandRunException("Can't execute conditional command, because condition expression value has " + value.Type + " type, Bool expected.");

            if (((BoolValue)value).Val)
            {
                if (null != thenCommand)
                    thenCommand.Run(processor);
            }
            else
            {
                if (null != elseCommand)
                    elseCommand.Run(processor);
            }
        }
    }
}
