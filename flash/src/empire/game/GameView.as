package empire.game
{
	import com.cascade.base.switcher.CascadeSwitcher;
	import com.cascade.base.switcher.ICascadeSwitcher;
	import com.mvc.View;

	public class GameView extends View
	{
		private var _game:Game;
		
		/**
		 * Possible statuses:
		 * select	- possible to select provinces and control them
		 * move		- required to select province to move selected units into
		 */
		private var _cascadeSwitcher:ICascadeSwitcher;
		
		public function GameView(game:Game)
		{
			super();
			
			_game = game;
			
			_cascadeSwitcher = new CascadeSwitcher(Frame.instance.permanentCascadeElement, "select");
		}
		
		public function get cascadeSwitcher():ICascadeSwitcher
		{
			return _cascadeSwitcher;
		}
	}
}