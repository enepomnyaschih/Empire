package empire.effects.darken
{
	import com.cascade.base.actions.style.CascadeStyleActionFactory;

	public class DarkenEffectActionFactory extends CascadeStyleActionFactory
	{
		override public function get type():String
		{
			return DarkenEffectAction.TYPE;
		}
		
		override public function get cls():Class
		{
			return DarkenEffectAction;
		}
	}
}