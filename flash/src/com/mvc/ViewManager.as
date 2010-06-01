package com.mvc
{
	import flash.events.EventDispatcher;
	
	import util.ArrayUtil;

	public class ViewManager extends EventDispatcher
	{
		private static var _instance:ViewManager;
		
		/**
		 * Списки валидации
		 */
		private var _invalidGraphicsList:Array = new Array();
		private var _invalidPositionList:Array = new Array();
		
		public static function get instance():ViewManager
		{
			if (!_instance)
				_instance = new ViewManager();
			
			return _instance;
		}
		
		public function addInvalidGraphicsView(view:View):void
		{
			_invalidGraphicsList.push(view);
		}
		
		public function addInvalidPositionView(view:View):void
		{
			_invalidPositionList.push(view);
		}
		
		public function validateAllViewsGraphics():void
		{
			var list:Array = _invalidGraphicsList.concat();
			ArrayUtil.removeAll(_invalidGraphicsList);
			
			for each (var view:View in list)
				if (!view.isValidGraphics)
					view.validateGraphics();
		}
		
		public function validateAllViewsPosition():void
		{
			var list:Array = _invalidPositionList.concat();
			ArrayUtil.removeAll(_invalidPositionList);
			
			for each (var view:View in list)
				if (!view.isValidPosition)
					view.validatePosition();
		}
	}
}