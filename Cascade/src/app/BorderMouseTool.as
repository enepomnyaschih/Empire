package app
{
	import com.cascade.mouse.mousetool.MouseTool;

	public class BorderMouseTool extends MouseTool
	{
		public static const TYPE:String = "Border";
		
		override public function init():void
		{
			element.target.setStyle("borderColor", 0);
			element.target.setStyle("borderStyle", "solid");
			element.target.setStyle("borderThickness", 1);
		}
		
		override public function free():void
		{
			element.target.setStyle("borderStyle", "none");
		}
		
		override public function get type():String
		{
			return TYPE;
		}
	}
}