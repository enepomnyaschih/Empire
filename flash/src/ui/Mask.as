package ui
{
	import mx.containers.Canvas;
	
	import util.ColorUtil;
	
	public class Mask extends Canvas
	{
		private var _counter:int = 0;
		
		public function Mask()
		{
			super();
			
			setStyle("backgroundColor", ColorUtil.BLACK);
			setStyle("backgroundAlpha", 0.3);
			
			visible = false;
		}
		
		public function show():void
		{
			++_counter;
			visible = true;
		}
		
		public function hide():void
		{
			if (--_counter == 0)
				visible = false;
		}
	}
}