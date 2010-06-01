package ui
{
	import com.mvc.View;
	
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import util.ConfigUtil;

	public class Layout extends View
	{
		private var _layoutOnCreationComplete:Boolean = false;
		private var _layoutOnResize:Boolean = false;
		
		public function Layout(config:Object = null)
		{
			super();
			
			var defaults:Object = {
				layoutOnCreationComplete	: true,
				layoutOnResize				: true
			};
			
			ConfigUtil.config(this, config, defaults);
		}
		
		[Bindable]
		public function get layoutOnCreationComplete():Boolean
		{
			return _layoutOnCreationComplete;
		}
		
		public function set layoutOnCreationComplete(value:Boolean):void
		{
			if (_layoutOnCreationComplete == value)
				return;
			
			if (_layoutOnCreationComplete)
				removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete_layout);
			
			_layoutOnCreationComplete = value;
			
			if (_layoutOnCreationComplete)
				addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete_layout, false, 0, true);
		}
		
		[Bindable]
		public function get layoutOnResize():Boolean
		{
			return _layoutOnResize;
		}
		
		public function set layoutOnResize(value:Boolean):void
		{
			if (_layoutOnResize == value)
				return;
			
			if (_layoutOnResize)
				removeEventListener(ResizeEvent.RESIZE, this.onResize_layout);
			
			_layoutOnResize = value;
			
			if (_layoutOnResize)
				addEventListener(ResizeEvent.RESIZE, this.onResize_layout, false, 0, true);
		}
		
		virtual public function doLayout():void
		{
		}
		
		private function onCreationComplete_layout(e:FlexEvent):void
		{
			doLayout();
		}
		
		private function onResize_layout(e:ResizeEvent):void
		{
			doLayout();
		}
	}
}