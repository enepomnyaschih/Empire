package ui
{
	import com.mvc.View;
	
	import flash.display.DisplayObject;

	public class IsothropicLayout extends Layout
	{
		override public function doLayout():void
		{
			for (var i:int = 0; i < numChildren; ++i)
			{
				var child:DisplayObject = this.getChildAt(i);
				if (!(child is View))
					continue;
				
				var view:View = View(child);
				
				var cw:Number = view.initialWidth;
				var ch:Number = view.initialHeight;
				
				if (cw == 0 || ch == 0)
					continue;
				
				var s:Number = Math.min(width / cw, height / ch);
				var w:Number = s * cw;
				var h:Number = s * ch;
				
				child.x			= (width  - w) / 2;
				child.y			= (height - h) / 2;
				child.scaleX	= s;
				child.scaleY	= s;
			}
		}
	}
}