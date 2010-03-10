package ui
{
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import util.ConfigUtil;

	public class IsothropicLayout extends UIComponent
	{
		private var _layoutOnCreationComplete:Boolean = false;
		private var _layoutOnResize:Boolean = false;
		
		public function IsothropicLayout(config:Object = null)
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
		
		public function doLayout():void
		{
			for (var i:int = 0; i < numChildren; ++i)
			{
				var child:DisplayObject = this.getChildAt(i);
				var cw:Number = child.width  / child.scaleX;
				var ch:Number = child.height / child.scaleY;
				
				if (cw == 0 || ch == 0)
					throw new Error("All children in IsothropicLayout must have non-zero width and height.");
				
				var s:Number = Math.min(width / cw, height / ch);
				var w:Number = s * cw;
				var h:Number = s * ch;
				
				child.x			= (width  - w) / 2;
				child.y			= (height - h) / 2;
				child.scaleX	= s;
				child.scaleY	= s;
			}
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