package com.collections
{
	public interface ISet
	{
		function isItem(item:*):Boolean;
		function addItem(item:*):void;
		function removeItem(item:*):void;
		function setItem(item:*, value:Boolean):void;
		function clear():void;
		function isWeakReferences():Boolean;
	}
}