package empire.orders
{
	import common.mvc.Model;
	
	import util.ErrorUtil;

	public class Order extends Model
	{
		private var _orderId:int;
		
		public function Order(data:Object)
		{
			super();
			
			_orderId = data.orderId;
		}
		
		public function get type():String
		{
			return ErrorUtil.throwMsg(ErrorUtil.MUST_OVERRIDE);
		}
		
		public function get orderId():int
		{
			return _orderId;
		}
	}
}