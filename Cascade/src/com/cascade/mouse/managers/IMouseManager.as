package com.cascade.mouse.managers
{
	import com.cascade.mouse.action.ICascadeActionMouseTool;
	import com.cascade.mouse.action.ICascadeActionMouseToolFactory;
	import com.cascade.mouse.parser.ICascadeParserMouseTool;
	import com.cascade.mouse.style.ICascadeStyleMouseToolFactory;
	
	import flash.events.IEventDispatcher;
	
	public interface IMouseManager extends IEventDispatcher
	{
		function get mouseToolFactoryManager():IMouseToolFactoryManager;
		
		function get parser			():ICascadeParserMouseTool;
		function get actionFactory	():ICascadeActionMouseToolFactory;
		function get styleFactory	():ICascadeStyleMouseToolFactory;
		
		function addAction		(action:ICascadeActionMouseTool):void;
		function removeAction	(action:ICascadeActionMouseTool):void;
		
		function updateMouseTool():void;
	}
}