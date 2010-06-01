package com.cascade.stdparser.enum
{
	import com.cascade.stdparser.enumbase.CascadeBaseEnumParser;

	public class CascadeEnumParser extends CascadeBaseEnumParser implements ICascadeEnumParser
	{
		private var _type	:String;
		private var _values	:Array;
		
		public function CascadeEnumParser(type:String, values:Array)
		{
			super();
			
			_type	= type;
			_values	= values;
		}
		
		override public function get type():String
		{
			return _type;
		}
		
		override public function get values():Array
		{
			return _values;
		}
	}
}