package empire.provincescreen
{
	import common.mvc.View;
	
	import util.ColorUtil;

	public class UnitBox extends View
	{
		private static const ITEM_WIDTH:Number = 30;
		private static const ITEM_HEIGHT:Number = 50;
		
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
			item.x = height / 2 + numChildren * ITEM_WIDTH;
			item.y = height / 2;
			
			item.graphics.beginFill(0, 0);
			item.graphics.drawRect(-ITEM_WIDTH / 2, -ITEM_HEIGHT / 2, ITEM_WIDTH, ITEM_HEIGHT);
			item.graphics.endFill();
			
			addChild(item);
		}
	}
}