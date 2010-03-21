package empire.army
{
	import common.mvc.View;
	
	import flash.geom.Point;
	
	import util.GraphicsUtil;

	public class ArrowView extends View
	{
		public function ArrowView(color:uint, alpha:Number, p1:Point, p2:Point, opposite:Boolean)
		{
			super();
			
			graphics.beginFill(color, alpha);
			GraphicsUtil.drawArrow(graphics, p1.x, p1.y, p2.x, p2.y, opposite);
			graphics.endFill();
		}
	}
}