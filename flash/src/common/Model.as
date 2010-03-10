package common
{
	import flash.events.EventDispatcher;
	
	import util.ConfigUtil;

	public class Model extends EventDispatcher
	{
		public function Model(data:Object = null)
		{
			super();
			
			loadData(data);
		}
		
		virtual public function loadData(data:Object):void
		{
			ConfigUtil.apply(this, data);
		}
	}
}