package empire.orders
{
	public class BuildOrder extends Order
	{
		public static const TYPE:String = "Build";
		
		private var _province:int;
		
		public function BuildOrder(data:Object)
		{
			super(data);
			
			_province = data.province;
		}
		
		override public function get type():String
		{
			return TYPE;
		}
		
		public function get province():int
		{
			return _province;
		}
	}
}