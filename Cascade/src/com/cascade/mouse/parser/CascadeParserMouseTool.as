package com.cascade.mouse.parser
{
	import com.cascade.base.parser.CascadeParser;

	public class CascadeParserMouseTool extends CascadeParser implements ICascadeParserMouseTool
	{
		public static const TYPE:String = "MouseTool";
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override public function parse(source:String):*
		{
			var words:Array = source.split(" ");
			var mouseToolType:String = null;
			var priority:Number = NaN;
			
			for (var wordIndex:int = 0; wordIndex < words.length; ++wordIndex)
			{
				var word:String = words[wordIndex];
				if (word.length == 0)
					continue;
				
				// try to parse as priority
				var p:Number = parsePriority(word);
				if (!isNaN(p))
				{
					if (!isNaN(priority))
						return throwCantParse(source);
					
					priority = p;
					continue;
				}
				
				// parse as mouse tool type
				if (mouseToolType)
					return throwCantParse(source);
				
				mouseToolType = word;
			}
			
			if (!mouseToolType || isNaN(priority))
				return throwCantParse(source);
			
			return new CascadeParserMouseToolParam(mouseToolType, priority);
		}
		
		override public function format(value:*):String
		{
			var param:ICascadeParserMouseToolParam = value;
			return param.type + " " + param.priority.toString() + "p";
		}
		
		private function parsePriority(word:String):Number
		{
			if (word.charAt(word.length - 1) != "p")
				return NaN;
			
			var result:Number;
			try
			{
				result = parseFloat(word.substr(0, word.length - 1));
			}
			catch(e:Error)
			{
				return NaN;
			}
			
			return result;
		}
	}
}