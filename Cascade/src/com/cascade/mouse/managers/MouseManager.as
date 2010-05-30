package com.cascade.mouse.managers
{
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.mouse.action.CascadeActionMouseToolFactory;
	import com.cascade.mouse.action.ICascadeActionMouseTool;
	import com.cascade.mouse.action.ICascadeActionMouseToolFactory;
	import com.cascade.mouse.mousetool.IMouseTool;
	import com.cascade.mouse.mousetool.IMouseToolFactory;
	import com.cascade.mouse.parser.CascadeParserMouseTool;
	import com.cascade.mouse.parser.ICascadeParserMouseTool;
	import com.cascade.mouse.parser.ICascadeParserMouseToolParam;
	import com.cascade.mouse.style.CascadeStyleMouseToolFactory;
	import com.cascade.mouse.style.ICascadeStyleMouseToolFactory;
	
	import flash.events.EventDispatcher;
	
	import util.ArrayUtil;
	import util.ErrorUtil;

	public class MouseManager extends EventDispatcher implements IMouseManager
	{
		private static var _instance:MouseManager;
		
		private var _mouseToolFactoryManager:IMouseToolFactoryManager;
		
		private var _parser			:ICascadeParserMouseTool;
		private var _actionFactory	:ICascadeActionMouseToolFactory;
		private var _styleFactory	:ICascadeStyleMouseToolFactory;
		
		private var _actions:Array = new Array();
		
		private var _activeAction:ICascadeActionMouseTool;
		private var _activeMouseTool:IMouseTool;
		
		public function MouseManager()
		{
			super();
			
			if (_instance)
				throw ErrorUtil.throwSingletonInstantiated("MouseManager");
			
			_instance = this;
			
			_mouseToolFactoryManager = new MouseToolFactoryManager();
			
			_parser			= new CascadeParserMouseTool();
			_actionFactory	= new CascadeActionMouseToolFactory();
			_styleFactory	= new CascadeStyleMouseToolFactory();
			
			CascadeManager.instance.parserManager			.register(_parser);
			CascadeManager.instance.actionFactoryManager	.register(_actionFactory);
			CascadeManager.instance.styleFactoryManager		.register(_styleFactory);
		}
		
		public static function get instance():MouseManager
		{
			if (!_instance)
				new MouseManager();
			
			return _instance;
		}
		
		public function get mouseToolFactoryManager():IMouseToolFactoryManager
		{
			return _mouseToolFactoryManager;
		}
		
		public function get parser():ICascadeParserMouseTool
		{
			return _parser;
		}
		
		public function get actionFactory():ICascadeActionMouseToolFactory
		{
			return _actionFactory;
		}
		
		public function get styleFactory():ICascadeStyleMouseToolFactory
		{
			return _styleFactory;
		}
		
		public function addAction(action:ICascadeActionMouseTool):void
		{
			_actions.push(action);
			updateMouseTool();
		}
		
		public function removeAction(action:ICascadeActionMouseTool):void
		{
			ArrayUtil.removeItem(_actions, action);
			updateMouseTool();
		}
		
		public function updateMouseTool():void
		{
/*			var acts:Array = new Array();
			for (var actionIndex:int = 0; actionIndex < _actions.length; ++actionIndex)
			{
				var ac:ICascadeActionMouseTool = _actions[actionIndex];
				acts.push(ac.element.name + "." + ac.element.statuses.join("."));
			}
			
			if (acts.length == 5)
			{
				ErrorUtil.log("!");
			}
			
			ErrorUtil.log("Active actions: ", acts.join(" "));*/
			
			var newAction:ICascadeActionMouseTool;
			for (var actionIndex:int = 0; actionIndex < _actions.length; ++actionIndex)
			{
				var curAction:ICascadeActionMouseTool = _actions[actionIndex];
				
				if (!newAction)
				{
					newAction = curAction;
					continue;
				}
				
				var curParam:ICascadeParserMouseToolParam = curAction.style.param;
				var newParam:ICascadeParserMouseToolParam = newAction.style.param;
				
				if (newParam.priority >= curParam.priority)
					newAction = curAction;
			}
			
			if (newAction == _activeAction)
				return;
			
			if (_activeAction)
				_activeMouseTool.free();
			
			_activeAction = newAction;
			
			if (!_activeAction)
				return;
			
			var styleParam:ICascadeParserMouseToolParam = _activeAction.style.param;
			var mouseToolFactory:IMouseToolFactory = mouseToolFactoryManager.getMouseToolFactory(styleParam.type);
			_activeMouseTool = mouseToolFactory.createMouseTool(_activeAction.element);
			_activeMouseTool.init();
		}
		
/*		private function sortActionsByDepth():void
		{
			var items:Array = new Array();
			for (var actionIndex:int = 0; actionIndex < _actions.length; ++actionIndex)
			{
				var action:ICascadeActionMouseTool = _actions[actionIndex];
				
				var depth:int = 0;
				var target:ICascadeElement = action.element;
				while (target)
				{
					++depth;
					target = target.parent;
				}
				
				items.push({
					index	: actionIndex,
					depth	: depth
				});
			}
			
			items.sortOn("depth");
			
			var result:Array = new Array();
			for (var itemIndex:int = 0; itemIndex < items.length; ++itemIndex)
				result.push(_actions[items[itemIndex].index]);
			
			_actions = result;
		}*/
	}
}