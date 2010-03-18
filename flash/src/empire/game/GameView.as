package empire.game
{
	import common.mouse.MouseSwitcher;
	import common.mouse.MouseWrapper;
	import common.mvc.View;

	public class GameView extends View
	{
		private var _game:Game;
		
		/**
		 * Possible statuses:
		 * control	- control is enabled
		 */
		private var _mouseWrapper:MouseWrapper;
		
		/**
		 * Possible statuses:
		 * select	- possible to select provinces and control them
		 * move		- required to select province to move selected units into
		 */
		private var _mouseSwitcher:MouseSwitcher;
		
		public function GameView(game:Game)
		{
			super();
			
			_game = game;
			
			_mouseWrapper = new MouseWrapper(this, "Game");
			_mouseSwitcher = new MouseSwitcher(_mouseWrapper, "select");
		}
		
		public function get mouseSwitcher():MouseSwitcher
		{
			return _mouseSwitcher;
		}
	}
}