package util
{
	public class ArrayUtil
	{
		public static function removeItem(array:Array, item:Object):void
		{
			var index:int = array.indexOf(item);
			if (index != -1)
				array.splice(index, 1);
		}
		
		public static function removeAll(array:Array):void
		{
			array.splice(0, array.length);
		}
		
		public static function findBy(array:Array, field:String, value:*):int
		{
			for (var i:int = 0; i < array.length; ++i)
				if (array[i][field] === value)
					return i;
			
			return -1;
		}
		
		public static function getBy(array:Array, field:String, value:*):*
		{
			return array[findBy(array, field, value)];
		}
		
		public static function removeBy(array:Array, field:String, value:*):void
		{
			array.splice(findBy(array, field, value), 1);
		}
	}
}