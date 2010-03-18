package common.mouse
{
	public class MouseRule
	{
		public var expression:String;
		public var tool:MouseTool;
		public var priority:Number;
		
		public function MouseRule(expression:String, tool:MouseTool, priority:Number)
		{
			this.expression	= expression;
			this.tool		= tool;
			this.priority	= priority;
		}
	}
}