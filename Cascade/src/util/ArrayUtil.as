package util
{
	public class ArrayUtil
	{
		public static function removeItem(array:Array, item:Object):int
		{
			var index:int = array.indexOf(item);
			if (index != -1)
				array.splice(index, 1);
			
			return index;
		}
		
		public static function removeAll(array:Array):void
		{
			array.splice(0, array.length);
		}
		
		/**
		 * Shorthand to any of:
		 * findByEvery(array, [ { field: field, value: value, op: op } ], fromIndex);
		 * findByAny  (array, [ { field: field, value: value, op: op } ], fromIndex);
		 */
		public static function findBy(array:Array, field:String, value:*, op:String = "===", fromIndex:int = 0):int
		{
			return findBase(array, getFindByCallback(field, value, op), fromIndex);
		}
		
		public static function getBy(array:Array, field:String, value:*, op:String = "===", fromIndex:int = 0):*
		{
			return getBase(array, getFindByCallback(field, value, op), fromIndex);
		}
		
		public static function removeBy(array:Array, field:String, value:*, op:String = "==="):void
		{
			removeBase(array, getFindByCallback(field, value, op));
		}
		
		/**
		 * conds - conditions array.
		 * Condition is
		 * 	{
		 * 		field	: String,
		 * 		value	: *,
		 * 		op		: String // [optional] see ConditionUtil.check
		 * 	}
		 */
		public static function findByEvery(array:Array, conds:Array, fromIndex:int = 0):int
		{
			return findBase(array, getFindByEveryCallback(conds), fromIndex);
		}
		
		public static function getByEvery(array:Array, conds:Array, fromIndex:int = 0):*
		{
			return getBase(array, getFindByEveryCallback(conds), fromIndex);
		}
		
		public static function removeByEvery(array:Array, conds:Array):void
		{
			removeBase(array, getFindByEveryCallback(conds));
		}
		
		public static function findByAny(array:Array, conds:Array, fromIndex:int = 0):int
		{
			return findBase(array, getFindByAnyCallback(conds), fromIndex);
		}
		
		public static function getByAny(array:Array, conds:Array, fromIndex:int = 0):*
		{
			return getBase(array, getFindByAnyCallback(conds), fromIndex);
		}
		
		public static function removeByAny(array:Array, conds:Array):void
		{
			removeBase(array, getFindByAnyCallback(conds));
		}
		
		/**
		 * Base search functions.
		 */
		private static function findBase(array:Array, callback:Function, fromIndex:int):int
		{
			for (var i:int = fromIndex; i < array.length; ++i)
				if (callback(array[i]))
					return i;
			
			return -1;
		}
		
		private static function getBase(array:Array, callback:Function, fromIndex:int):*
		{
			var index:int = findBase(array, callback, fromIndex);
			return index == -1 ? null : array[index];
		}
		
		private static function removeBase(array:Array, callback:Function):void
		{
			var index:int = 0;
			while (true)
			{
				index = findBase(array, callback, index);
				if (index == -1)
					return;
				
				array.splice(index, 1);
			}
		}
		
		/**
		 * Search function callbacks.
		 */
		private static function getFindByCallback(field:String, value:*, op:String):Function
		{
			return function(item:*):Boolean
			{
				return ConditionUtil.check(ConfigUtil.getChild(item, field), value, op);
			}
		}
		
		private static function getFindByEveryCallback(conds:Array):Function
		{
			return function(item:*):Boolean
			{
				for (var i:int = 0; i < conds.length; ++i)
					if (!ConditionUtil.check(ConfigUtil.getChild(item, conds[i].field), conds[i].value, conds[i].op))
						return false;
				
				return true;
			}
		}
		
		private static function getFindByAnyCallback(conds:Array):Function
		{
			return function(item:*):Boolean
			{
				for (var i:int = 0; i < conds.length; ++i)
					if (ConditionUtil.check(ConfigUtil.getChild(item, conds[i].field), conds[i].value, conds[i].op))
						return true;
				
				return false;
			}
		}
	}
}