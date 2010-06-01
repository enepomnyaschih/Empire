package com.cascade.base.managers
{
	import com.cascade.base.parser.ICascadeParser;
	import com.manager.Manager;
	
	public class CascadeParserManager extends Manager implements ICascadeParserManager
	{
		public function getParser(type:String):ICascadeParser
		{
			return ICascadeParser(getItem(type));
		}
	}
}