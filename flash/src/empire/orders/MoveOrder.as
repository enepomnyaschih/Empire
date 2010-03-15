package empire.orders
{
	public class MoveOrder extends Order
	{
		public static const TYPE:String = "Move";
		
		private var _provinceFrom	:int;
		private var _provinceTo		:int;
		private var _units			:Array;
		
		public function MoveOrder(data:Object)
		{
			super(data);
			
			_provinceFrom	= data.provinceFrom;
			_provinceTo		= data.provinceTo;
			_units			= data.units;
		}
		
		override public function get type():String
		{
			return TYPE;
		}
		
		public function get provinceFrom():int
		{
			return _provinceFrom;
		}
		
		public function get provinceTo():int
		{
			return _provinceTo;
		}
		
		public function get units():Array
		{
			return _units;
		}
	}
}