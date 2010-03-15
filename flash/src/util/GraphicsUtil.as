package util
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import ui.LineLoop;
	
	public class GraphicsUtil
	{
		public static function drawHexoid(graphics:Graphics, x1:Number, y1:Number, x2:Number, y2:Number):void
		{
			var px:Array = getHexoidPxArray(x1, x2);
			var py:Array = getHexoidPyArray(y1, y2);
			
			var loop:LineLoop = new LineLoop(graphics);
			
			for (var d:int = 0; d < 6; ++d)
				loop.loopTo(px[d], py[d]);
			
			loop.loopEnd();
		}
		
		public static function drawHexoidSegment(graphics:Graphics, x1:Number, y1:Number, x2:Number, y2:Number, d:int, w:Number):void
		{
			var px:Array = getHexoidPxArray(x1, x2);
			var py:Array = getHexoidPyArray(y1, y2);
			
			var d0:int = (d + 0) % 6;
			var d1:int = (d + 1) % 6;
			var d2:int = (d + 2) % 6;
			var d3:int = (d + 3) % 6;
			
			var px0:Number = px[d1] * (1 - w) + px[d0] * w;
			var py0:Number = py[d1] * (1 - w) + py[d0] * w;
			var px1:Number = px[d1];
			var py1:Number = py[d1];
			var px2:Number = px[d2];
			var py2:Number = py[d2];
			var px3:Number = px[d2] * (1 - w) + px[d3] * w;
			var py3:Number = py[d2] * (1 - w) + py[d3] * w;
			
			var loop:LineLoop = new LineLoop(graphics);
			
			loop.loopTo(px0, py0);
			loop.loopTo(px1, py1);
			loop.loopTo(px2, py2);
			loop.loopTo(px3, py3);
			
			loop.loopEnd();
		}
		
		private static function getHexoidPxArray(x1:Number, x2:Number):Array
		{
			var xa:Number = (x1 + x2) / 2;
			
			return [xa, x2, x2, xa, x1, x1];
		}
		
		private static function getHexoidPyArray(y1:Number, y2:Number):Array
		{
			var ya:Number = y1 * ( 7/6) + y2 * (-1/6);
			var yb:Number = y1 * ( 5/6) + y2 * ( 1/6);
			var yc:Number = y1 * ( 1/6) + y2 * ( 5/6);
			var yd:Number = y1 * (-1/6) + y2 * ( 7/6);
			
			return [yd, yc, yb, ya, yb, yc];
		}
		
		public static function drawArrow(graphics:Graphics, x1:Number, y1:Number, x2:Number, y2:Number, w:Number = 0.3, l:Number = 0.7):void
		{
			var dv:Point = new Point(x2 - x1, y2 - y1);
			var pv:Point = new Point(y1 - y2, x2 - x1);
			
			pv.x *= w;
			pv.y *= w;
			
			var loop:LineLoop = new LineLoop(graphics);
			
			loop.loopTo(x2, y2);
			loop.loopTo(x1 + dv.x * l - pv.x * 0.6, y1 + dv.y * l - pv.y * 0.6);
			loop.loopTo(x1 + dv.x * l - pv.x * 0.4, y1 + dv.y * l - pv.y * 0.4);
			loop.loopTo(x1 - pv.x, y1 - pv.y);
			loop.loopTo(x1 + pv.x, y1 + pv.y);
			loop.loopTo(x1 + dv.x * l + pv.x * 0.4, y1 + dv.y * l + pv.y * 0.4);
			loop.loopTo(x1 + dv.x * l + pv.x * 0.6, y1 + dv.y * l + pv.y * 0.6);
			
			loop.loopEnd();
		}
	}
}