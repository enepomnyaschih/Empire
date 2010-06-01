package empire.province
{
	import com.cascade.mouse.mousetool.MouseToolFactory;

	public class ProvinceSelectMouseToolFactory extends MouseToolFactory
	{
		override public function get type():String
		{
			return ProvinceSelectMouseTool.TYPE;
		}
		
		override public function get cls():Class
		{
			return ProvinceSelectMouseTool;
		}
	}
}