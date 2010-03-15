package common.mvc
{
	import mx.core.UIComponent;
	
	public class View extends UIComponent
	{
		private var _isValidGraphics:Boolean = true;
		private var _isValidPosition:Boolean = true;
		
		private var _initialWidth	:Number = 0;
		private var _initialHeight	:Number = 0;
		
		public function View()
		{
			super();
			
			_initialWidth	= width;
			_initialHeight	= height;
		}
		
		override public function set width(value:Number):void
		{
			_initialWidth = value;
			super.width = value;
		}
		
		override public function set height(value:Number):void
		{
			_initialHeight = value;
			super.height = value;
		}
		
		public function get initialWidth():Number
		{
			return _initialWidth;
		}
		
		public function get initialHeight():Number
		{
			return _initialHeight;
		}
		
		public function get isValidGraphics():Boolean
		{
			return _isValidGraphics;
		}
		
		public function get isValidPosition():Boolean
		{
			return _isValidPosition;
		}
		
		public function invalidateGraphics():void
		{
			if (!_isValidGraphics)
				return;
			
			_isValidGraphics = false;
			ViewManager.instance.addInvalidGraphicsView(this);
		}
		
		public function invalidatePosition():void
		{
			if (!_isValidPosition)
				return;
			
			_isValidPosition = false;
			ViewManager.instance.addInvalidPositionView(this);
		}
		
		virtual public function validateGraphics():void
		{
			_isValidGraphics = true;
		}
		
		virtual public function validatePosition():void
		{
			_isValidPosition = true;
		}
		
		public function removeAllChildren():void
		{
			while (numChildren != 0)
				removeChildAt(0);
		}
		
		virtual public function animate():void
		{
		}
	}
}