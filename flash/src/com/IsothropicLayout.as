package com
{
	import flash.display.DisplayObject;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import util.ConfigUtil;

	public class IsothropicLayout extends UIComponent
	{
		private var _layoutOnCreationComplete:Boolean = false;
		private var _layoutOnResize:Boolean = false;
		private var _wh:Number = 1;
		
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
		
		[Bindable]
		public function get wh():Number
		{
			return _wh;
		}
		
		public function set wh(value:Number):void
		{
			_wh = value;
		}
		
		public function doLayout():void
		{
			var w:Number = Math.min(width, height * wh);
			var h:Number = w / wh;
			
			for (var i:int = 0; i < numChildren; ++i)
			{
				var child:DisplayObject = this.getChildAt(i);
				
				child.x			= (width - w) / 2;
				child.y			= (height - h) / 2;
				child.width		= w;
				child.height	= h;
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