package ui
{
	import flash.display.Graphics;
	
	public class LineLoop
	{
		private var _graphics:Graphics;
		private var _started:Boolean = false;
		private var _x:Number;
		private var _y:Number;
		
		public function LineLoop(graphics:Graphics)
		{
			_graphics = graphics;
		}
		
		public function loopTo(x:Number, y:Number):void
		{
			if (_started)
				_graphics.lineTo(x, y);
			else
			{
				_graphics.moveTo(x, y);
				_started = true;
				_x = x;
				_y = y;
			}
		}
		
		public function loopEnd():void
		{
			if (!_started)
				return;
			
			_graphics.lineTo(_x, _y);
			_started = false;
		}
	}
}