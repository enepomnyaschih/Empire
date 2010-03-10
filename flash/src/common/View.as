package common
{
	import mx.core.UIComponent;
	
	public class View extends UIComponent
	{
		private var _isValidGraphics:Boolean = true;
		private var _isValidPosition:Boolean = true;
		
		public function View()
		{
			super();
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
	}
}