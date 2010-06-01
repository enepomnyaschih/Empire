package com.cascade.base.styles.base
{
	import com.cascade.base.parser.ICascadeParser;
	import com.factory.IBaseFactory;
	
	public interface ICascadeStyleFactory extends IBaseFactory
	{
		function get styleName():String;
		function get parser():ICascadeParser;
		
		function get styleCls():Class;
		
		function createStyle(source:String):ICascadeStyle;
	}
}