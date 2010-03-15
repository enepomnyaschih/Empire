package empire.game
{
	import common.mvc.View;

	public class GameView extends View
	{
		private var _game:Game;
		
		public function GameView(game:Game)
		{
			super();
			
			_game = game;
		}
	}
}