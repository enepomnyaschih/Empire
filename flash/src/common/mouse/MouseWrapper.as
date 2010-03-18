package common.mouse
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import util.ArrayUtil;
	
	public class MouseWrapper
	{
		private var _target:EventDispatcher;
		private var _name:String;
		private var _statuses:Array = new Array();
		
		private var _isActive:Boolean = false;
		
		public function MouseWrapper(target:EventDispatcher = null, name:String = null)
		{
			_target = target;
			_name = name;
			
			initTarget();
		}
		
		public function free():void
		{
			deactivate();
			freeTarget();
		}
		
		public function get target():EventDispatcher
		{
			return _target;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get isActive():Boolean
		{
			return _isActive;
		}
		
		public function isStatus(status:String):Boolean
		{
			return _statuses.indexOf(status) != -1;
		}
		
		public function addStatus(status:String):void
		{
			if (!status)
				return;
			
			if (isStatus(status))
				return;
			
			_statuses.push(status);
			
			if (_isActive)
				MouseManager.instance.update();
		}
		
		public function removeStatus(status:String):void
		{
			if (_isActive && ArrayUtil.removeItem(_statuses, status) != -1)
				MouseManager.instance.update();
		}
		
		public function setStatus(status:String, active:Boolean):void
		{
			if (active)
				addStatus(status);
			else
				removeStatus(status);
		}
		
		public function activate():void
		{
			if (_isActive)
				return;
			
			_isActive = true;
			MouseManager.instance.activateWrapper(this);
		}
		
		public function deactivate():void
		{
			if (!_isActive)
				return;
			
			_isActive = false;
			MouseManager.instance.deactivateWrapper(this);
		}
		
		private function initTarget():void
		{
			if (!_target)
				return;
			
			_target.addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
			_target.addEventListener(MouseEvent.ROLL_OUT,  onRollOut,  false, 0, true);
		}
		
		private function freeTarget():void
		{
			if (!_target)
				return;
			
			_target.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			_target.removeEventListener(MouseEvent.ROLL_OUT,  onRollOut);
		}
		
		private function onRollOver(e:MouseEvent):void
		{
			activate();
		}
		
		private function onRollOut(e:MouseEvent):void
		{
			deactivate();
		}
	}
}