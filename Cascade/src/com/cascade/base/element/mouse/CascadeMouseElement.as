package com.cascade.base.element.mouse
{
	import com.cascade.base.element.base.CascadeElement;
	import com.cascade.base.managers.CascadeManager;
	
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	public class CascadeMouseElement extends CascadeElement implements ICascadeMouseElement
	{
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
		
		private function onRollOver(e:MouseEvent):void
		{
			isHover = true;
			
			if (!autoValidate)
				CascadeManager.instance.elementValidationManager.validateAllElementsStyle();
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			isHover = false;
			
			if (!autoValidate)
				CascadeManager.instance.elementValidationManager.validateAllElementsStyle();
		}
	}
}