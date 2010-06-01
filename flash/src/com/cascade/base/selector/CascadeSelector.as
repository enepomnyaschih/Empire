package com.cascade.base.selector
{
	import com.cascade.base.element.base.ICascadeElement;
	
	import mx.utils.StringUtil;
	
	import util.ErrorUtil;
	
	public class CascadeSelector implements ICascadeSelector
	{
		private var _words:Array;
		private var _hover:Boolean;
		
		public function CascadeSelector(words:Array, hover:Boolean)
		{
			_words = words;
			_hover = hover;
		}

		public function get words():Array
		{
			return _words;
		}
		
		public function get hover():Boolean
		{
			return _hover;
		}
		
		public function fits(elements:Array):Boolean
		{
			if (_hover)
			{
				if (elements.length == 0)
					return false;
				
				var lastElement:ICascadeElement = elements[elements.length - 1];
				if (!lastElement.isHover)
					return false;
			}
			
			var wordIndex:int = 0;
			for (var elementIndex:int = 0; elementIndex < elements.length; ++elementIndex)
			{
				if (wordIndex == _words.length)
					return true;
				
				var element:ICascadeElement = elements[elementIndex];
				var word:ICascadeSelectorWord = _words[wordIndex];
				
				if (word.fits(element))
					++wordIndex;
			}
			
			return wordIndex == _words.length;
		}
		
		public static function createByString(source:String):CascadeSelector
		{
			var hover:Boolean = false;
			var modifiers:Array = source.split(":");
			source = StringUtil.trim(modifiers[0]);
			
			for (var modifierIndex:int = 1; modifierIndex < modifiers.length; ++modifierIndex)
			{
				var modifier:String = StringUtil.trim(modifiers[modifierIndex]);
				switch (modifier)
				{
					case "hover": hover = true; break;
					default: return ErrorUtil.throwMsg("Can't parse '", source, "' as CSS selector: '", modifier, "' is not a modifier.");
				}
			}
			
			var wordSources:Array = source.split(" ");
			var words:Array = new Array();
			for (var wordIndex:int = 0; wordIndex < wordSources.length; ++wordIndex)
			{
				var wordSource:String = wordSources[wordIndex];
				if (!wordSource.length)
					continue;
				
				words.push(CascadeSelectorWord.createByString(wordSource));
			}
			
			return new CascadeSelector(words, hover);
		}
	}
}