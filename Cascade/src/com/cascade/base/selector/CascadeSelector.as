package com.cascade.base.selector
{
	import com.cascade.base.element.base.ICascadeElement;
	
	public class CascadeSelector implements ICascadeSelector
	{
		private var _words:Array;
		
		public function CascadeSelector(words:Array)
		{
			_words = words;
		}

		public function get words():Array
		{
			return _words;
		}
		
		public function get hover():Boolean
		{
			return false;
		}
		
		public function fits(elements:Array):Boolean
		{
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
			var wordSources:Array = source.split(" ");
			var words:Array = new Array();
			for (var wordIndex:int = 0; wordIndex < wordSources.length; ++wordIndex)
			{
				var wordSource:String = wordSources[wordIndex];
				if (!wordSource.length)
					continue;
				
				words.push(CascadeSelectorWord.createByString(wordSource));
			}
			
			return new CascadeSelector(words);
		}
	}
}