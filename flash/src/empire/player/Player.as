package empire.player
{
	import common.Model;

	public class Player extends Model
	{
		private var _memberId:String;
		
		
		
		
		
		
		public function Player(data:Object)
		{
			super();
			
			_memberId = data.memberId;
		}
		
		public function get memberId():String
		{
			return _memberId;
		}
	}
}