package com.cascade.base.managers
{
	import com.cascade.base.parser.ICascadeParser;
	import com.manager.IManager;

	public interface ICascadeParserManager extends IManager
	{
		function getParser(type:String):ICascadeParser;
	}
}