package util
{
	public class ConditionUtil
	{
		public static function check(x:*, y:*, op:String):Boolean
		{
			switch (op)
			{
				case "=="	: return x ==  y;
				case "==="	: return x === y;
				case "!="	: return x !=  y;
				case "!=="	: return x !== y;
				case ">"	: return x >   y;
				case ">="	: return x >=  y;
				case "<"	: return x <   y;
				case "<="	: return x <=  y;
				default		: return x === y;
			}
		}
	}
}