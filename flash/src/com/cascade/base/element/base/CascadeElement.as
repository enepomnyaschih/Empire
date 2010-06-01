// TODO: secure exceptions interception while reading and else
// TODO: support of "inherit" style values
// TODO: support commentaries in CSS file
// TODO: test all source files
// TODO: inherit everything from EventDispatcher
// TODO: add possibility to configure MouseTools, like { mouseTool: MapMouseTool(1, 2, 3); }

package com.cascade.base.element.base
{
	import com.cascade.base.actions.style.ICascadeStyleAction;
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.rule.ICascadeRule;
	import com.cascade.base.selector.ICascadeSelector;
	import com.cascade.base.styles.base.ICascadeStyle;
	
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	
	import util.ArrayUtil;
	import util.ConfigUtil;
	
	public class CascadeElement implements ICascadeElement
	{
		public static const STATUS_HOVER:String = "hover";
		
		private var _target		:UIComponent;
		private var _parent		:ICascadeElement;
		private var _name		:String;
		
		private var _isHover	:Boolean;
		
		private var _statuses	:Array = new Array();
		
		private var _children	:Array = new Array();
		
		private var _styles			:Dictionary = new Dictionary();
		private var _actions		:Dictionary = new Dictionary();
		private var _customStyles	:Dictionary = new Dictionary();
		
		private var _autoValidate:Boolean = true;
		
		private var _isStyleValid:Boolean = true;
		
		public function CascadeElement(target:UIComponent, name:String, autoValidate:Boolean = true)
		{
			_target			= target;
			_name			= name;
			_autoValidate	= autoValidate;
			
			invalidateStyle();
		}
		
		public function free():void
		{
			_isStyleValid = true;
			
			for (var styleName:String in _actions)
			{
				var action:ICascadeStyleAction = _actions[styleName];
				action.free();
			}
			
			_parent = null;
		}
		
		public function get target():UIComponent
		{
			return _target;
		}
		
		public function get parent():ICascadeElement
		{
			return _parent;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get isHover():Boolean
		{
			return _isHover;
		}
		
		public function set isHover(value:Boolean):void
		{
			_isHover = value;
			setStatus(STATUS_HOVER, value);
		}
		
		// for debug only
		public function get statuses():Array
		{
			return _statuses;
		}
		
		public function getCustomStyle(styleName:String):ICascadeStyle
		{
			return _customStyles[styleName];
		}
		
		public function setCustomStyle(style:ICascadeStyle):void
		{
			var styleName:String = style.styleName;
			if (!style)
			{
				resetCustomStyle(styleName);
				return;
			}
			
			_customStyles[styleName] = style;
			updateStyle(styleName);
		}
		
		public function resetCustomStyle(styleName:String):void
		{
			delete _customStyles[styleName];
			updateStyle(styleName);
		}
		
		public function getElementsChain():Array
		{
			var chain:Array = new Array();
			fillElementsChain(chain);
			return chain;
		}
		
		public function fillElementsChain(chain:Array):void
		{
			if (parent)
				parent.fillElementsChain(chain);
			
			chain.push(this);
		}
		
		[Bindable]
		public function get autoValidate():Boolean
		{
			return _autoValidate;
		}
		
		public function set autoValidate(value:Boolean):void
		{
			_autoValidate = value;
		}
		
		public function setParent(parent:ICascadeElement):void
		{
			_parent = parent;
			invalidateStyle();
		}
		
		public function isStatus(status:String):Boolean
		{
			if (!status || !status.length)
				return true;
			
			return _statuses.indexOf(status) != -1;
		}
		
		public function areStatuses(statuses:Array):Boolean
		{
			if (!statuses)
				return true;
			
			for (var statusIndex:int = 0; statusIndex < statuses.length; ++statusIndex)
			{
				var status:String = statuses[statusIndex];
				if (!isStatus(status))
					return false;
			}
			
			return true;
		}
		
		public function addStatus(status:String):void
		{
			if (!status)
				return;
			
			if (isStatus(status))
				return;
			
			_statuses.push(status);
			
			invalidateStyle();
		}
		
		public function removeStatus(status:String):void
		{
			if (ArrayUtil.removeItem(_statuses, status) != -1)
				invalidateStyle();
		}
		
		public function setStatus(status:String, value:Boolean):void
		{
			if (value)
				addStatus(status);
			else
				removeStatus(status);
		}
		
		public function addChild(element:ICascadeElement):ICascadeElement
		{
			return addChildAt(element, _children.length);
		}
		
		public function addChildAt(element:ICascadeElement, index:int):ICascadeElement
		{
			_children.splice(index, 0, element);
			element.setParent(this);
			return element;
		}
		
		public function contains(element:ICascadeElement):Boolean
		{
			return getChildIndex(element) != -1;
		}
		
		public function getChildAt(index:int):ICascadeElement
		{
			return _children[index];
		}
		
		public function getChildIndex(element:ICascadeElement):int
		{
			return _children.indexOf(element);
		}
		
		public function removeChild(element:ICascadeElement):ICascadeElement
		{
			return removeChildAt(getChildIndex(element));
		}
		
		public function removeChildAt(index:int):ICascadeElement
		{
			var element:ICascadeElement = _children[index];
			_children.splice(index, 1);
			element.setParent(null);
			return element;
		}
		
		public function get isStyleValid():Boolean
		{
			return _isStyleValid;
		}
		
		public function invalidateStyle():void
		{
			_isStyleValid = false;
			CascadeManager.instance.elementValidationManager.invalidateElementStyle(this);
			
			if (_autoValidate)
				CascadeManager.instance.elementValidationManager.validateAllElementsStyle();
		}
		
		public function validateStyle():void
		{
			_isStyleValid = true;
			
			var elements:Array = getElementsChain();
			var rules:Array = CascadeManager.instance.ruleManager.rules;
			var newStyles:Dictionary = new Dictionary();
			var updatedStyles:Dictionary = new Dictionary();
			
			// Determine new styles to apply
			for (var ruleIndex:int = 0; ruleIndex < rules.length; ++ruleIndex)
			{
				var rule:ICascadeRule = rules[ruleIndex];
				for (var selectorIndex:int = 0; selectorIndex < rule.selectors.length; ++selectorIndex)
				{
					var selector:ICascadeSelector = rule.selectors[selectorIndex];
					if (selector.fits(elements))
					{
						ConfigUtil.apply(newStyles, rule.styles);
						break;
					}
				}
			}
			
			// Find and remember obsolete styles
			var obsoleteStyles:Array = new Array();
			for (var oldStyleName:String in _styles)
			{
				updatedStyles[oldStyleName] = true;
				if (!newStyles[oldStyleName])
					obsoleteStyles.push(oldStyleName);
			}
			
			// Reset obsolete styles
			for (var obsoleteStyleIndex:int = 0; obsoleteStyleIndex < obsoleteStyles.length; ++obsoleteStyleIndex)
				delete _styles[obsoleteStyles[obsoleteStyleIndex]];
			
			// Remember new styles
			for (var newStyleName:String in newStyles)
			{
				updatedStyles[newStyleName] = true;
				_styles[newStyleName] = newStyles[newStyleName];
			}
			
			// Update actions
			for (var updatedStyleName:String in updatedStyles)
				updateStyle(updatedStyleName);
			
			// Validate children recursively
			for (var childIndex:int = 0; childIndex < _children.length; ++childIndex)
			{
				var child:ICascadeElement = _children[childIndex];
				child.validateStyle();
			}
		}
		
		public function toString():String
		{
			return (_name || "") + (_statuses.length ? ("." + _statuses.join(".")) : "");
		}
		
		private function updateStyle(styleName:String):void
		{
			var newStyle:ICascadeStyle = _customStyles[styleName];
			if (!newStyle)
				newStyle = _styles[styleName];
			
			var oldAction:ICascadeStyleAction = _actions[styleName];
			if (!oldAction)
			{
				_actions[styleName] = newStyle.createAction(this);
				return;
			}
			
			if (newStyle)
			{
				oldAction.style = newStyle;
				return;
			}
			
			oldAction.free();
			delete _actions[styleName];
		}
	}
}