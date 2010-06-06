package empire.effects.darken
{
	import com.cascade.base.styles.base.CascadeStyle;

	public class DarkenEffectStyle extends CascadeStyle
	{
		public static const TYPE:String = "darkenEffect";
		
		public function DarkenEffectStyle(param:*)
		{
			super(param);
		}
		
		override public function get styleName():String
		{
			return TYPE;
		}
		
		override protected function get actionType():String
		{
			return DarkenEffectAction.TYPE;
		}
	}
}