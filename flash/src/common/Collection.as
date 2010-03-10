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
	}
}