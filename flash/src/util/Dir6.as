package util
{
	import flash.geom.Point;
	
	public class Dir6
	{
		private static const COS	:Array = [ 1,  1,  0, -1,  0,  1];
		private static const SIN	:Array = [ 0, -1, -1,  0,  1,  1];
		private static const COS_D	:Array = [ 0, -1, -1,  0, -1, -1];
		
		public static function getTargetX(x:int, y:int, d:int):int
		{
			return x + COS[d] + COS_D[d] * (y % 2);
		}
		
		public static function getTargetY(x:int, y:int, d:int):int
		{
			return y + SIN[d];
		}
	}
}