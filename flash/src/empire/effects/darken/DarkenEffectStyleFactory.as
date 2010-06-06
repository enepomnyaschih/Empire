package empire.effects.darken
{
	import com.cascade.base.styles.base.CascadeStyleFactory;

	public class DarkenEffectStyleFactory extends CascadeStyleFactory
	{
		override public function get type():String
		{
			return DarkenEffectStyle.TYPE;
		}
		
		override public function get cls():Class
		{
			return DarkenEffectStyle;
		}
		
		override protected function get parserType():String
		{
			return "Boolean";
		}
	}
}