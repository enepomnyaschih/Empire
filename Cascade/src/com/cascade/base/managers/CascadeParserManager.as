package com.cascade.base.managers
{
	import com.cascade.base.parser.ICascadeParser;
	import com.factory.FactoryManager;
	
	public class CascadeParserManager extends FactoryManager implements ICascadeParserManager
	{
		public function getParser(type:String):ICascadeParser
		{
			return ICascadeParser(getFactory(type));
		}
	}
}