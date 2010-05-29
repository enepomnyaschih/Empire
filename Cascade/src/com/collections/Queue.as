package com.collections
{
	public class Queue
	{
		private var _buf:Array = new Array();
		private var _from:int = 0;
		
		public function push(el:*):void
		{
			_buf.push(el);
		}
		
		public function pop():*
		{
			var value:* = top;
			++_from;
			return value;
		}
		
		public function get top():*
		{
			return _buf[_from];
		}
		
		public function get empty():Boolean
		{
			return _from == _buf.length;
		}
	}
}