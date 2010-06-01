package empire.ordermodel
{
	import com.mvc.Model;
	
	import empire.game.Game;
	import empire.orders.BuildOrder;
	import empire.orders.MoveOrder;
	import empire.orders.Order;
	import empire.orders.OrderEvent;
	import empire.orders.TrainOrder;
	
	import flash.utils.Dictionary;

	public class OrderModel extends Model
	{
		public static const EVENT_ORDER_ADDED:String = "orderAdded";
		
		private var _game:Game;
		private var _turn:int;
		
		private var _orders:Array = new Array();
		private var _addOrderHandlers:Dictionary = new Dictionary();
		
		private var _provinces:Array;
		private var _moveOrders:Array = new Array();
		
		public function OrderModel(game:Game, turn:int)
		{
			super();
			
			_game = game;
			_turn = turn;
			
			_provinces = new Array(_game.map.provinces.length);
			for (var i:int = 0; i < _game.map.provinces.length; ++i)
				_provinces[i] = new ProvinceOrderModel(_game, i, _turn);
			
			_addOrderHandlers[MoveOrder .TYPE] = addMoveOrder;
			_addOrderHandlers[TrainOrder.TYPE] = addTrainOrder;
			_addOrderHandlers[BuildOrder.TYPE] = addBuildOrder;
		}
		
		public function get orders():Array
		{
			return _orders;
		}
		
		public function get moveOrders():Array
		{
			return _moveOrders;
		}
		
		public function get provinces():Array
		{
			return _provinces;
		}
		
		public function addOrder(order:Order):void
		{
			_orders.push(order);
			
			var handler:Function = _addOrderHandlers[order.type];
			if (handler != null)
				handler(order);
			
			dispatchEvent(new OrderEvent(EVENT_ORDER_ADDED, order));
		}
		
		/**
		 * Add orders block.
		 */
		private function addMoveOrder(order:MoveOrder):void
		{
			getProvinceOrderModel(order.provinceFrom).leaveUnits(order.units);
			if (_game.getProvinceState(_turn, order.provinceFrom).owner ==
				_game.getProvinceState(_turn, order.provinceTo  ).owner)
				getProvinceOrderModel(order.provinceTo  ).comeUnits (order.units);
			
			_moveOrders.push(order);
		}
		
		private function addTrainOrder(order:TrainOrder):void
		{
			getProvinceOrderModel(order.province).trainRecruit(order.recruit);
		}
		
		private function addBuildOrder(order:BuildOrder):void
		{
			getProvinceOrderModel(order.province).buildFort();
		}
		
		/**
		 * Miscellaneous.
		 */
		private function getProvinceOrderModel(index:int):ProvinceOrderModel
		{
			return _provinces[index];
		}
	}
}