package paint.metrics.base
{
	import com.ITyped;
	
	import flash.events.IEventDispatcher;
	import flash.geom.Point;

	public interface IMetrics extends IEventDispatcher, ITyped
	{
		function get center():Point;
		function set center(value:Point):void;
	}
}