package empire.orders
{
	import com.mvc.Model;
	
	import util.ErrorUtil;

	public class Order extends Model
	{
		private var _orderId:String;
		
		public function Order(data:Object)
		{
			super();
			
			_orderId = data.orderId;
		}
		
		public function get type():String
		{
			return ErrorUtil.throwMsg(ErrorUtil.MUST_OVERRIDE);
		}
		
		public function get orderId():String
		{
			return _orderId;
		}
	}
}