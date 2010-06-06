package empire.effects.blink
{
	import com.cascade.base.styles.base.CascadeStyle;

	public class BlinkEffectStyle extends CascadeStyle
	{
		public static const TYPE:String = "blinkEffect";
		
		public function BlinkEffectStyle(param:*)
		{
			super(param);
		}
		
		override public function get styleName():String
		{
			return TYPE;
		}
		
		override protected function get actionType():String
		{
			return BlinkEffectAction.TYPE;
		}
	}
}