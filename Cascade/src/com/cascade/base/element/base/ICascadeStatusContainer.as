package com.cascade.base.element.base
{
	public interface ICascadeStatusContainer
	{
		function isStatus(status:String):Boolean;
		function areStatuses(statuses:Array):Boolean;
		function addStatus(status:String):void;
		function removeStatus(status:String):void;
		function setStatus(status:String, value:Boolean):void;
		
		function get statuses():Array; // for debug only
	}
}