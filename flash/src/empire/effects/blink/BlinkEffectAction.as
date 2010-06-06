package empire.effects.blink
{
	import com.cascade.base.actions.style.CascadeStyleAction;
	import com.cascade.base.styles.base.ICascadeStyle;
	
	import empire.effects.blink.IBlinkable;

	public class BlinkEffectAction extends CascadeStyleAction
	{
		public static const TYPE:String = "BlickEffect";
		
		override public function free():void
		{
			target.isBlick = false;
		}
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override protected function update(oldStyle:ICascadeStyle):void
		{
			target.isBlick = style.param == true;
		}
		
		private function get target():IBlinkable
		{
			return IBlinkable(element.target);
		}
	}
}