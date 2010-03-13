package empire.army
{
	import common.View;
	
	import empire.game.GameUtil;
	
	import flash.display.DisplayObject;

	public class UnitView extends View
	{
		private static const MAX_HEIGHT:int = 200;
		
		private static const IMAGE_SIZE		:Number = 50;
		
		private static const COUNT_WIDTH	:Number = 50;
		private static const COUNT_HEIGHT	:Number = 20;
		private static const COUNT_GAP		:Number = 7;
		
		private static const POWER_WIDTH	:Number = 50;
		
		private var _image:DisplayObject;
		
		public function UnitView(imageCls:Class, count:int, power:Number)
		{
			super();
			
			_image = new imageCls();
			_image.width  = IMAGE_SIZE;
			_image.height = IMAGE_SIZE;
			
			_image.x = -IMAGE_SIZE / 2;
			_image.y = -IMAGE_SIZE / 2;
			
			addChild(_image);
			
			drawCount(count);
			drawPower(power);
		}
		
		private function drawCount(count:int):void
		{
			if (count <= 0)
				return;
			
			var ht:Number = count * (COUNT_HEIGHT + COUNT_GAP) - COUNT_GAP;
			var cf:Number = (ht > MAX_HEIGHT) ? (MAX_HEIGHT / ht) : 1;
			var ch:Number = cf * COUNT_HEIGHT;
			var cg:Number = cf * COUNT_GAP;
			
			for (var i:int = 0; i < count; ++i)
			{
				graphics.beginFill(GameUtil.UNIT_POWER_COLOR);
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