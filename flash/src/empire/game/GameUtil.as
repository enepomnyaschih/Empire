package empire.game
{
	import util.ColorUtil;
	
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
		
		public static const UNIT_POWER_COLOR:uint = 0xB0FFB0;
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