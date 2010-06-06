package empire.effects.darken
{
	import com.cascade.base.actions.style.CascadeStyleAction;
	import com.cascade.base.styles.base.ICascadeStyle;

	public class DarkenEffectAction extends CascadeStyleAction
	{
		public static const TYPE:String = "DarkenEffect";
		
		override public function free():void
		{
			target.isDarken = false;
		}
		
		override public function get type():String
		{
			return TYPE;
		}
		
		override protected function update(oldStyle:ICascadeStyle):void
		{
			target.isDarken = style.param == true;
		}
		
		private function get target():IDarkenable
		{
			return IDarkenable(element.target);
		}
	}
}