package paint.drawings.base
{
	import com.ITyped;
	
	import flash.events.IEventDispatcher;

	public interface IDrawing extends IEventDispatcher, ITyped
	{
		function get id():String;
		function get metrics():IMetrics;
		function get properties():Object;
	}
}