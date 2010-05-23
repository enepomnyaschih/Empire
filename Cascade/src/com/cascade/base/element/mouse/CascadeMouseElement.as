package com.cascade.base.element.mouse
{
	import com.cascade.base.element.base.CascadeElement;
	import com.cascade.base.managers.CascadeManager;
	
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	public class CascadeMouseElement extends CascadeElement implements ICascadeMouseElement
	{
		public static const STATUS_HOVER:String = "hover";
		
		public function CascadeMouseElement(target:UIComponent, name:String)
		{
			super(target, name);
			
			target.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
			target.addEventListener(MouseEvent.ROLL_OUT,  onRollOut,  false, 0, true);
		}
		
		override public function free():void
		{
			target.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			target.removeEventListener(MouseEvent.ROLL_OUT,  onRollOut);
			
			super.free();
		}
		
		public function get isHover():Boolean
		{
			return isStatus(STATUS_HOVER);
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			addStatus(STATUS_HOVER);
			CascadeManager.instance.elementValidationManager.validateAllElementsStyle();
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			removeStatus(STATUS_HOVER);
			CascadeManager.instance.elementValidationManager.validateAllElementsStyle();
		}
	}
}