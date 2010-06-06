package empire.effects.blink
{
	import com.cascade.base.styles.base.CascadeStyleFactory;

	public class BlinkEffectStyleFactory extends CascadeStyleFactory
	{
		override public function get type():String
		{
			return BlinkEffectStyle.TYPE;
		}
		
		override public function get cls():Class
		{
			return BlinkEffectStyle;
		}
		
		override protected function get parserType():String
		{
			return "Boolean";
		}
	}
}