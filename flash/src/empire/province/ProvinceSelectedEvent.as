package empire.province
{
	import flash.events.Event;

	public class ProvinceSelectedEvent extends Event
	{
		private var _provinceView:ProvinceView;
		
		public function ProvinceSelectedEvent(type:String, provinceView:ProvinceView)
		{
			super(type);
			
			_provinceView = provinceView;
		}
		
		public function get provinceView():ProvinceView
		{
			return _provinceView;
		}
		
		override public function clone():Event
		{
			return new ProvinceSelectedEvent(type, provinceView);
		}
	}
}