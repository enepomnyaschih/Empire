package com.cascade.base.styles.base
{
	import com.cascade.base.actions.style.ICascadeStyleAction;
	import com.cascade.base.actions.style.ICascadeStyleActionFactory;
	import com.cascade.base.element.base.ICascadeElement;
	import com.cascade.base.managers.CascadeManager;
	
	import util.ErrorUtil;
	
	public class CascadeStyle implements ICascadeStyle
	{
		private var _param:*;
		
		public function CascadeStyle(param:* = null)
		{
			_param = param;
		}
		
		virtual public function get styleName():String
		{
			return ErrorUtil.throwMustOverride();
		}
		
		public function get param():*
		{
			return _param;
		}
		
		public function get actionFactory():ICascadeStyleActionFactory
		{
			return CascadeManager.instance.actionFactoryManager.getActionFactory(actionType);
		}
		
		public function createAction(element:ICascadeElement):ICascadeStyleAction
		{
			return actionFactory.createActionStyle(element, this);
		}
		
		virtual protected function get actionType():String
		{
			return ErrorUtil.throwMustOverride();
		}
	}
}