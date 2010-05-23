package com.mouse
{
	import flash.events.EventDispatcher;
	
	import util.ArrayUtil;
	import util.ErrorUtil;
	
	public class MouseManager
	{
		private static const DEBUG:Boolean = false;
		
		private static var _instance:MouseManager;
		
		private var _rules:Array = new Array();
		private var _activeWrappers:Array = new Array();
		private var _activeRule:MouseRule = null;
		
		public function MouseManager()
		{
		}
		
		public static function get instance():MouseManager
		{
			if (!_instance)
				_instance = new MouseManager();
			
			return _instance;
		}
		
		public function getActiveWrapper(name:String):MouseWrapper
		{
			return ArrayUtil.getBy(_activeWrappers, "name", name);
		}
		
		public function getActiveTarget(name:String):EventDispatcher
		{
			return getActiveWrapper(name).target;
		}
		
		public function activateWrapper(wrapper:MouseWrapper):void
		{
			if (_activeWrappers.indexOf(wrapper) != -1)
				return;
			
			_activeWrappers.push(wrapper);
			wrapper.activate();
			update();
		}
		
		public function deactivateWrapper(wrapper:MouseWrapper):void
		{
			if (ArrayUtil.removeItem(_activeWrappers, wrapper) == -1)
				return;
			
			wrapper.deactivate();
			update();
		}
		
		public function addRule(expression:String, tool:MouseTool, priority:Number = 0):void
		{
			var i:int = 0;
			while (i < _rules.length)
			{
				var rule:MouseRule = _rules[i];
				if (rule.priority > priority)
					break;
				
				++i;
			}
			
			_rules.push(new MouseRule(expression, tool, priority));
		}
		
		public function update():void
		{
			if (DEBUG)
				ErrorUtil.log("Update MouseManager: " + _activeWrappers.join(" "));
			
			var index:int = -1;
			for (var i:int = 0; i < _rules.length; ++i)
			{
				if (checkExpression(_rules[i].expression))
				{
					index = i;
					break;
				}
			}
			
			var rule:MouseRule = (index == -1) ? null : _rules[index];
			
			if (rule == _activeRule)
				return;
			
			if (_activeRule)
				_activeRule.tool.deactivate();
			
			_activeRule = rule;
			
			if (_activeRule)
				_activeRule.tool.activate();
		}
		
		private function checkExpression(expression:String):Boolean
		{
			return expression.split(" ").every(checkWord);
		}
		
		private function checkWord(word:String, index:int = 0, array:Array = null):Boolean
		{
			if (word == "")
				return true;
			
			var parts:Array = word.split(".");
			var name:String = parts[0];
			var status:String = (parts.length == 1) ? null : parts[1];
			
			function checkWrapper(wrapper:MouseWrapper, index:int = 0, array:Array = null):Boolean
			{
				if (name)
				{
					if (!wrapper.name)
						return false;
					
					if (wrapper.name != name)
						return false;
				}
				
				if (status && !wrapper.isStatus(status))
					return false;
				
				return true;
			}
			
			return _activeWrappers.some(checkWrapper, this);
		}
	}
}