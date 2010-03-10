package util
{
	public class MathUtil
	{
		public static function sgn(value:Number):Number
		{
			if (value > 0)
				return 1;
			if (value < 0)
				return -1;
			return 0;
		}
		
		public static function sgnnz(value:Number):Number
		{
			return (value >= 0) ? 1 : -1;
		}
	}
}