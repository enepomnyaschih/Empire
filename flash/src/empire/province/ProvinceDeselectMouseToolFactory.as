package empire.province
{
	import com.cascade.mouse.mousetool.MouseToolFactory;

	public class ProvinceDeselectMouseToolFactory extends MouseToolFactory
	{
		override public function get type():String
		{
			return ProvinceDeselectMouseTool.TYPE;
		}
		
		override public function get cls():Class
		{
			return ProvinceDeselectMouseTool;
		}
	}
}