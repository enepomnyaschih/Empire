package app
{
	import com.cascade.base.element.base.CascadeElement;
	import com.cascade.base.element.base.ICascadeElement;
	
	import mx.core.UIComponent;

	public class Map extends UIComponent
	{
		private var _cascadeElement:ICascadeElement;
		private var _megaCanvas:MegaCanvas;
		
		public function Map()
		{
			super();
			
			_cascadeElement = new CascadeElement(this, "Map");
			
			_megaCanvas = new MegaCanvas();
			addChild(_megaCanvas);
			_cascadeElement.addChild(_megaCanvas.cascadeElement);
		}
		
		public function get cascadeElement():ICascadeElement
		{
			return _cascadeElement;
		}
		
		public function get megaCanvas():MegaCanvas
		{
			return _megaCanvas;
		}
	}
}