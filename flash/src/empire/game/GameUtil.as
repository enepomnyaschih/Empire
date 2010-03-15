package empire.game
{
	import util.ColorUtil;
	
	public class GameUtil
	{
		/**
		 * Game colors.
		 */
		public static const PLAYER_COLORS:Array = [
			0xB00000, 0x00B000, 0xB0A000, 0xB000A0, 0x009090,
			0xB04000, 0x0040B0, 0xA04141, 0x41A041, 0x909041,
			0x9B41A0, 0x41A080, 0x907860, 0x404380, 0x80A040
		];
		
		public static const NEUTRAL_COLOR:uint = 0x808080;
		
		public static function getOwnerColor(owner:int):uint
		{
			return (owner < 0 || owner >= PLAYER_COLORS.length) ? NEUTRAL_COLOR : PLAYER_COLORS[owner];
		}
		
		public static const UNIT_COUNT_COLORS:Array = [
			0xB0FFB0,	// awaiting
			0xFFB0B0,	// left
			0xB0FFB0	// came
		];
		
		public static const UNIT_COUNT_ALPHAS:Array = [
			1.0,		// awaiting
			0.5,		// left
			0.5			// came
		];
		
		public static function getUnitCountIndex(n:int, count:int, left:int, came:int):int
		{
			if (n < count - left)
				return 0;
			if (n < count)
				return 1;
			return 2;
		}
		
		public static const UNIT_HEALTH_MAX_COLOR:uint = 0x80FF80;
		public static const UNIT_HEALTH_MIN_COLOR:uint = 0xFF2040;
		
		public static function getHealthColor(amount:Number):uint
		{
			return ColorUtil.averageColor(UNIT_HEALTH_MIN_COLOR, UNIT_HEALTH_MAX_COLOR, amount);
		}
		
		/**
		 * Particular game rules.
		 */
		public static const UNIT_TYPE_COUNT:int = 7;
		
		public static const FORT_MAX_HEALTH:Array = [300, 700, 1200];
	}
}