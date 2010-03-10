package game.player
{
	import common.Model;

	public class Player extends Model
	{
		private var _index:int;
		private var _memberId:String;
		private var _isPlaying:Boolean;
		private var _gold:int;
		
		
		
		
		
		
		[Bindable]
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		[Bindable]
		public function get memberId():String
		{
			return _memberId;
		}
	}
}