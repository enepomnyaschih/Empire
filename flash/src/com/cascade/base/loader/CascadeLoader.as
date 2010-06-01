package com.cascade.base.loader
{
	import com.cascade.base.managers.CascadeManager;
	import com.cascade.base.managers.CascadeRuleManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.utils.StringUtil;
	
	import util.ErrorUtil;
	
	public class CascadeLoader extends EventDispatcher implements ICascadeLoader
	{
		private static const STATUS_INIT	:int = 0;
		private static const STATUS_LOAD	:int = 1;
		private static const STATUS_SUCCESS	:int = 2;
		private static const STATUS_FAILURE	:int = 3;
		
		private var _status:int = STATUS_INIT;
		private var _loader:URLLoader;
		
		public function load(request:URLRequest):void
		{
			if (_status != STATUS_INIT)
				ErrorUtil.throwMsg("Can't load two requests by the same loader.");
			
			_status = STATUS_LOAD;
			
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE,					onComplete,			false, 0, true);
			_loader.addEventListener(IOErrorEvent.IO_ERROR,				onIOError,			false, 0, true);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,	onSecurityError,	false, 0, true);
			_loader.load(request);
		}
		
		private function onComplete(e:Event):void
		{
			try
			{
				read(String(_loader.data));
			}
			catch(error:Error)
			{
				fail(error.message);
			}
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			fail("Input/Output error while loading CSS file.");
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			fail("Security error while loading CSS file.");
		}
		
		private function read(text:String):void
		{
			var from:int = 0;
			while (true)
			{
				var index:int = text.indexOf("}", from) + 1;
				if (index == 0)
				{
					if (StringUtil.trim(text.substr(from)).length != 0)
						ErrorUtil.throwMsg("Can't parse CSS file: unexpected symbols remaining at the end of file");
					
					break;
				}
				
				CascadeManager.instance.ruleManager.register(CascadeRuleManager.createByString(text.substr(from, index - from)));
				from = index;
			}
			
			dispatchEvent(new CascadeLoaderEvent(CascadeLoaderEvent.SUCCESS));
		}
		
		private function fail(message:String):void
		{
			dispatchEvent(new CascadeLoaderEvent(CascadeLoaderEvent.FAILURE, message));
		}
	}
}