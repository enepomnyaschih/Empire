package empire.orders
{
	public class TrainOrder extends Order
	{
		public static const TYPE:String = "Train";
		
		private var _province:int;
		private var _recruit:int;
		
		public function TrainOrder(data:Object)
		{
			super(data);
			
			_province	= data.province;
			_recruit	= data.recruit;
		}
		
		override public function get type():String
		{
			return TYPE;
		}
		
		public function get province():int
		{
			return _province;
		}
		
		public function get recruit():int
		{
			return _recruit;
		}
	}
}