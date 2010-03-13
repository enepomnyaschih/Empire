package empire.resources
{
	public class Resources
	{
		[Embed(source="../resources/legion.png")]
		public static const LEGION:Class;
		
		[Embed(source="../resources/phalanx.png")]
		public static const PHALANX:Class;
		
		[Embed(source="../resources/archers.png")]
		public static const ARCHERS:Class;
		
		[Embed(source="../resources/auxilian.png")]
		public static const AUXILIAN:Class;
		
		[Embed(source="../resources/akvistes.png")]
		public static const AKVISTES:Class;
		
		[Embed(source="../resources/chariot.png")]
		public static const CHARIOT:Class;
		
		[Embed(source="../resources/catapult.png")]
		public static const CATAPULT:Class;
		
		public static const UNITS:Array = [
			LEGION,
			PHALANX,
			ARCHERS,
			AUXILIAN,
			AKVISTES,
			CHARIOT,
			CATAPULT
		];
		
		[Embed(source="../resources/fort.png")]
		public static const FORT:Class;
		
		[Embed(source="../resources/citadel.png")]
		public static const CITADEL:Class;
		
		[Embed(source="../resources/fortress.png")]
		public static const FORTRESS:Class;
		
		public static const FORTS:Array = [
			FORT,
			CITADEL,
			FORTRESS
		];
		
		[Embed(source="../resources/gold.png")]
		public static const GOLD:Class;
	}
}