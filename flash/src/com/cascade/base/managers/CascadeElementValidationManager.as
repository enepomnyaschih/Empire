package com.cascade.base.managers
{
	import com.cascade.base.element.base.ICascadeElement;
	
	import flash.utils.Dictionary;

	public class CascadeElementValidationManager implements ICascadeElementValidationManager
	{
		private var _invalidStyleElements:Array = new Array();
		
		public function invalidateElementStyle(element:ICascadeElement):void
		{
			_invalidStyleElements.push(element);
		}
		
		public function validateAllElementsStyle():void
		{
			// Find minimal subset of invalid elements to validate
			var invalidMap:Dictionary = new Dictionary();
			var elementsToValidate:Array = new Array();
			for (var invalidElementIndex:int = 0; invalidElementIndex < _invalidStyleElements.length; ++invalidElementIndex)
			{
				var invalidElement:ICascadeElement = _invalidStyleElements[invalidElementIndex];
				if (invalidMap[invalidElement])
					continue;
				
				invalidMap[invalidElement] = true;
				
				var parent:ICascadeElement = invalidElement.parent;
				while (parent)
				{
					if (!parent.isStyleValid)
						break;
					
					parent = parent.parent;
				}
				
				if (!parent)
					elementsToValidate.push(invalidElement);
			}
			
			// Validate selected elements
			_invalidStyleElements = new Array();
			
			for (var elementToValidateIndex:int = 0; elementToValidateIndex < elementsToValidate.length; ++elementToValidateIndex)
			{
				var elementToValidate:ICascadeElement = elementsToValidate[elementToValidateIndex];
				elementToValidate.validateStyle();
			}
		}
	}
}