package empire.effects.blink
{
	import com.cascade.base.actions.style.CascadeStyleActionFactory;
	
	public class BlinkEffectActionFactory extends CascadeStyleActionFactory
	{
		override public function get type():String
		{
			return BlinkEffectAction.TYPE;
		}
		
		override public function get cls():Class
		{
			return BlinkEffectAction;
		}
	}
}