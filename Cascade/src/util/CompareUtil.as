package util
{
	public class CompareUtil
	{
		public static function cmp(x:*, y:*):int
		{
			if (x > y)
				return 1;
			if (x < y)
				return -1;
			return 0;
		}
		
		public static function getFieldComparer(field:String):Function
		{
			return function(x:*, y:*):int
			{
				return cmp(x[field], y[field]);
			}
		}
	}
}