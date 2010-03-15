package empire.orders
{
	import common.Collection;

	public class OrderCollection extends Collection
	{
		public function getOrderAt(index:int):Order
		{
			return Order(getItemAt(index));
		}
	}
}