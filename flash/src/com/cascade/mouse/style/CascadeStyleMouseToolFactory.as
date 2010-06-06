package com.cascade.mouse.style
{
	import com.cascade.base.styles.base.CascadeStyleFactory;
	import com.cascade.mouse.parser.CascadeParserMouseTool;
	
	public class CascadeStyleMouseToolFactory extends CascadeStyleFactory implements ICascadeStyleMouseToolFactory
	{
		override public function get type():String
		{
			return CascadeStyleMouseTool.STYLE_NAME;
		}
		
		override public function get cls():Class
		{
			return CascadeStyleMouseTool;
		}
		
		override protected function get parserType():String
		{
			return CascadeParserMouseTool.TYPE;
		}
	}
}