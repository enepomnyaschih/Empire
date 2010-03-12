package common
{
	import mx.collections.ArrayCollection;
	
	public class Collection extends ArrayCollection
	{
		public function fillItems(items:Array):void
		{
			removeAll();
			for (var i:int = 0; i < items.length; ++i)
				addItem(items[i]);
		}
		
		public function setLength(value:int):void
		{
			while (length > value)
				removeItemAt(length - 1);
			
			while (length < value)
				addItem(null);
		}
	}
}