package app
{
	import com.cascade.mouse.mousetool.MouseToolFactory;

	public class BorderMouseToolFactory extends MouseToolFactory
	{
		override public function get type():String
		{
			return BorderMouseTool.TYPE;
		}
		
		override public function get cls():Class
		{
			return BorderMouseTool;
		}
	}
}