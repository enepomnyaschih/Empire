package empire.army
{
	import com.mvc.View;

	public class UnitBoardView extends View
	{
		private var VIEW_WIDTH	:Number = 25;
		private var VIEW_GAP	:Number = 5;
		
		private var _views:Array = new Array();
		
		public function UnitBoardView()
		{
			super();
			
			buildViews(_views);
			
			var s:Number = (_views.length - 1) * (VIEW_WIDTH + VIEW_GAP) / 2;
			
			for (var i:int = 0; i < _views.length; ++i)
			{
				_views[i].x = i * (VIEW_WIDTH + VIEW_GAP) - s;
				addChild(_views[i]);
			}
			
			mouseChildren	= false;
			mouseEnabled	= false;
		}
		
		virtual protected function buildViews(views:Array):void
		{
		}
	}
}