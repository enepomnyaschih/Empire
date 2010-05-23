package com.cascade.base.managers
{
	import com.cascade.base.parser.ICascadeParser;
	import com.factory.IFactoryManager;

	public interface ICascadeParserManager extends IFactoryManager
	{
		function getParser(type:String):ICascadeParser;
	}
}