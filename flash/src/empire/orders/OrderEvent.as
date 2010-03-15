package empire.orders
{
	import flash.events.Event;

	public class OrderEvent extends Event
	{
		private var _order:Order;
		
		public function OrderEvent(type:String, order:Order)
		{
			super(type);
			
			_order = order;
		}
		
		public function get order():Order
		{
			return _order;
		}
		
		override public function clone():Event
		{
			return new OrderEvent(type, order);
		}
	}
}