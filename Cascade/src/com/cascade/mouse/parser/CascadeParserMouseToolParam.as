package com.cascade.mouse.parser
{
	public class CascadeParserMouseToolParam implements ICascadeParserMouseToolParam
	{
		private var _type:String;
		private var _priority:Number;
		
		public function CascadeParserMouseToolParam(type:String, priority:Number)
		{
			_type		= type;
			_priority	= priority;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get priority():Number
		{
			return _priority;
		}
	}
}