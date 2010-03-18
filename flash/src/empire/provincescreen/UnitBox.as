package empire.provincescreen
{
	import common.mvc.View;
	
	import empire.army.UnitView;
	
	import util.ColorUtil;

	public class UnitBox extends View
	{
		private static const GAP:Number = 5;
		
		public function UnitBox()
		{
			super();
			
			width  = 700;
			height = 50;
			
			graphics.beginFill(ColorUtil.WHITE, 0.5);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		public function addItem(item:View):void
		{
			item.x = height / 2 + numChildren * (UnitView.IMAGE_SIZE + GAP);
			item.y = height / 2;
			
			addChild(item);
		}
	}
}