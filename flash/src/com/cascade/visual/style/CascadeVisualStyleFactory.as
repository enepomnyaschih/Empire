package com.cascade.visual.style
{
	import com.cascade.base.styles.base.CascadeStyleFactory;
	import com.cascade.base.styles.base.ICascadeStyle;

	public class CascadeVisualStyleFactory extends CascadeStyleFactory implements ICascadeVisualStyleFactory
	{
		private var _styleName:String;
		private var _flexStyleName:String;
		private var _parserType:String;
		
		public function CascadeVisualStyleFactory(styleName:String, flexStyleName:String, parserType:String)
		{
			super();
			
			_styleName		= styleName;
			_flexStyleName	= flexStyleName;
			_parserType		= parserType;
		}
		
		override public function get type():String
		{
			return _styleName;
		}
		
		public function get flexStyleName():String
		{
			return _flexStyleName;
		}
		
		override public function get cls():Class
		{
			return CascadeVisualStyle;
		}
		
		override public function createStyle(source:String):ICascadeStyle
		{
			return new cls(_styleName, _flexStyleName, parser.parse(source));
		}
		
		override protected function get parserType():String
		{
			return _parserType;
		}
	}
}