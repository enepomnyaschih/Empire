package empire.army
{
	import common.mvc.View;
	
	import empire.game.GameUtil;
	
	import flash.display.DisplayObject;

	public class UnitView extends View
	{
		private static const MAX_HEIGHT		:Number = 100;
		
		private static const IMAGE_SIZE		:Number = 25;
		
		private static const COUNT_WIDTH	:Number = 25;
		private static const COUNT_HEIGHT	:Number = 10;
		private static const COUNT_GAP		:Number = 3;
		
		private static const POWER_WIDTH	:Number = 25;
		
		private var _image:DisplayObject;
		
		public function UnitView(imageCls:Class, count:int, left:int, came:int, power:Number)
		{
			super();
			
			_image = new imageCls();
			_image.width  = IMAGE_SIZE;
			_image.height = IMAGE_SIZE;
			
			_image.x = -IMAGE_SIZE / 2;
			_image.y = -IMAGE_SIZE / 2;
			
			addChild(_image);
			
			drawCount(count, left, came);
			drawPower(power);
		}
		
		private function drawCount(count:int, left:int, came:int):void
		{
			var total:int = count + came;
			if (total <= 0)
				return;
			
			var ht:Number = total * (COUNT_HEIGHT + COUNT_GAP) - COUNT_GAP;
			var cf:Number = (ht > MAX_HEIGHT) ? (MAX_HEIGHT / ht) : 1;
			var ch:Number = cf * COUNT_HEIGHT;
			var cg:Number = cf * COUNT_GAP;
			
			for (var i:int = 0; i < total; ++i)
			{
				var index:int = GameUtil.getUnitCountIndex(i, count, left, came);
				
				graphics.beginFill(GameUtil.UNIT_COUNT_COLORS[index], GameUtil.UNIT_COUNT_ALPHAS[index]);
				graphics.drawRect(
					-COUNT_WIDTH / 2,
					_image.y - i * (ch + cg) - ch - 5,
					COUNT_WIDTH, ch
				);
				graphics.endFill();
			}
		}
		
		private function drawPower(power:Number):void
		{
			if (power <= 0)
				return;
			
			graphics.beginFill(GameUtil.getHealthColor(power));
			graphics.drawRect(
				-POWER_WIDTH / 2,
				_image.y - 5 - MAX_HEIGHT * power,
				POWER_WIDTH, MAX_HEIGHT * power
			);
			graphics.endFill();
		}
	}
}