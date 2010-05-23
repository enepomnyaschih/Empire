package app
{
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.element.mouse.CascadeMouseElement;
	
	import mx.containers.Canvas;

	public class MegaCanvas extends Canvas
	{
		private var _cascadeElement:ICascadeElement;
		
		public function MegaCanvas()
		{
			super();
			
			x		= 10;
			y		= 10;
			
			width	= 100;
			height	= 100;
			
			setStyle("backgroundColor", 0x00FF00);
			setStyle("backgroundAlpha", 1.0);
			
			_cascadeElement = new CascadeMouseElement(this, "MegaCanvas");
		}
		
		public function get cascadeElement():ICascadeElement
		{
			return _cascadeElement;
		}
	}
}