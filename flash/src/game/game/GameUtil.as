package game.game
{
	public class GameUtil
	{
		/**
		 * Game colors.
		 */
		public static const PLAYER_COLORS:Array = [
			0xFF0000, 0x00FF00, 0xFFD800, 0xFF00DC, 0x00FFFF,
			0xFF6A00, 0x0072FF, 0xCE7171, 0x71CE71, 0xCECE71,
			0xC671CE, 0x71CEA4, 0xCE9171, 0x7179CE, 0xDAFF7F
		];
		
		public static const NEUTRAL_COLOR:uint = 0xC0C0C0;
		
		public static function getOwnerColor(owner:int):uint
		{
			return (owner < 0 || owner >= PLAYER_COLORS.length) ? NEUTRAL_COLOR : PLAYER_COLORS[owner];
		}
	}
}