package ui
{
	public class FitLayout extends Layout
	{
		override public function doLayout():void
		{
			for (var i:int = 0; i < numChildren; ++i)
			{
				var child:DisplayObject = this.getChildAt(i);
				child.width  = width;
				child.height = height;
			}
		}
	}
}