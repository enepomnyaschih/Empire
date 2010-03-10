package util
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Ticker extends EventDispatcher
	{
		private var _timer:Timer;
		
		private var _msLast:Number;
		private var _msPeriod:Number;
		
		private var _updating:Boolean = false;
		
		public function Ticker(msPeriod:Number, delay:Number = 10)
		{
			_timer = new Timer(delay);
			_timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			
			_msPeriod = msPeriod;
		}
		
		[Bindable]
		public function get msPeriod():Number
		{
			return _msPeriod;
		}
		
		public function set msPeriod(value:Number):void
		{
			_msPeriod = value;
			
			update();
		}
		
		public function start():void
		{
			_msLast = new Date().getTime();
			
			_timer.start();
		}
		
		public function stop():void
		{
			_timer.stop();
		}
		
		private function onTimer(e:TimerEvent):void
		{
			update();
		}
		
		private function update():void
		{
			if (_updating)
				return;
			
			_updating = true;
			
			var ticks:int = getTicks();
			for (var i:int = 0; i < ticks; ++i)
				dispatchEvent(new TimerEvent(TimerEvent.TIMER));
			
			_updating = false;
		}
		
		private function getTicks():Number
		{
			var ms:Number = new Date().getTime();
			var ticks:Number = Math.floor((ms - _msLast) / _msPeriod);
			_msLast += ticks * _msPeriod;
			return ticks;
		}
	}
}