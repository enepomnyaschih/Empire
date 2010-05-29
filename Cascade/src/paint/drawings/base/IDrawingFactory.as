package paint.drawings.base
{
	import com.factory.IBaseFactory;
	
	public interface IDrawingFactory extends IBaseFactory
	{
		function get properties():Array;
	}
}