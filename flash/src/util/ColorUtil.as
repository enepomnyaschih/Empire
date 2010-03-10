package util
{
	public class ColorUtil
	{
		public static const WHITE	:uint = 0xFFFFFF;
		public static const BLACK	:uint = 0x000000;
		public static const RED		:uint = 0xFF0000;
		public static const GREEN	:uint = 0x00FF00;
		public static const BLUE	:uint = 0x0000FF;
		
		/**
		 * Returns brighter color.
		 * coef is a number from 0 to 1.
		 * If coef = 0, then returns white color.
		 * If coef = 1, then returns the same color.
		 */
		public static function brightColor(color:uint, coef:Number):uint
		{
			return averageColor(WHITE, color, coef); 
		}
		
		/**
		 * Returns darker color.
		 * coef is a number from 0 to 1.
		 * If coef = 0, then returns black color.
		 * If coef = 1, then returns the same color.
		 */
		public static function darkColor(color:uint, coef:Number):uint
		{
			return averageColor(BLACK, color, coef);
		}
		
		/**
		 * Returns color between x and y.
		 * coef is a number from 0 to 1.
		 * If coef = 0, then returns x.
		 * If coef = 1, then returns y.
		 */
		public static function averageColor(x:uint, y:uint, coef:Number):uint
		{
			var xa:Array = decode(x);
			var ya:Array = decode(y);
			var za:Array = new Array(3);
			
			for (var i:int = 0; i < 3; ++i)
				za[i] = xa[i] * (1 - coef) + ya[i] * coef;
			
			return encode(za);
		}
		
		/**
		 * Decodes color into [r, g, b] array.
		 */
		public static function decode(color:uint):Array
		{
			return [
				(color >> 16) & 0xFF,
				(color >>  8) & 0xFF,
				(color >>  0) & 0xFF
			];
		}
		
		/**
		 * Encodes [r, g, b] array into color.
		 */
		public static function encode(array:Array):uint
		{
			return	(array[0] << 16) |
					(array[1] <<  8) |
					(array[2] <<  0);
		}
	}
}