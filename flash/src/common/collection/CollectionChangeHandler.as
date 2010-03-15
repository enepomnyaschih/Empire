package common.collection
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	public class CollectionChangeHandler extends EventDispatcher
	{
		public static const EVENT_BEFORE_CHANGE	:String = "beforeChange";
		public static const EVENT_AFTER_CHANGE	:String = "afterChange";
		
		/**
		 * Target collection.
		 */
		private var _collection:ArrayCollection;
		
		/**
		 * Callback functions.
		 */
		private var _createFunction		:Function;
		private var _insertFunction		:Function;
		private var _removeFunction		:Function;
		private var _freeFunction		:Function;
		private var _isEmptyFunction	:Function;
		
		
		
		
		
		
		public function CollectionChangeHandler(config:Object)
		{
			super();
			
			var mapConfig:Object = {
				create		: "createFunction",
				insert		: "insertFunction",
				remove		: "removeFunction",
				free		: "freeFunction",
				isEmpty		: "isEmptyFunction"
			};
			
			ConfigUtil.config(this, ConfigUtil.map(config, mapConfig));
		}
		
		/**
		 * Target collection - the collection to listen.
		 */
		[Bindable]
		public function get collection():ArrayCollection
		{
			return _collection;
		}
		
		public function set collection(value:ArrayCollection):void
		{
			freeCollection();
			_collection = value;
			initCollection();
		}
		
		/**
		 * Called when new item is added to collection.
		 * Must create item controller instance by data and return it.
		 * 
		 * createFunction(model:*):*;
		 */
		[Bindable]
		public function get createFunction():Function
		{
			return _createFunction;
		}
		
		public function set createFunction(value:Function):void
		{
			_createFunction = value;
		}
		
		/**
		 * Called when existing item is inserted into collection.
		 * Must insert item controller into controllers collection and
		 * insert all views into their containers.
		 * 
		 * insertFunction(controller:*, index:int):void;
		 */
		[Bindable]
		public function get insertFunction():Function
		{
			return _insertFunction;
		}
		
		public function set insertFunction(value:Function):void
		{
			_insertFunction = value;
		}
		
		/**
		 * Called when existing item is removed from collection.
		 * Must remove item controller from controllers collection,
		 * remove all views from their containers
		 * and return the controller.
		 * 
		 * removeFunction(index:int):*;
		 */
		[Bindable]
		public function get removeFunction():Function
		{
			return _removeFunction;
		}
		
		public function set removeFunction(value:Function):void
		{
			_removeFunction = value;
		}
		
		/**
		 * Called when existing item is removed from collection.
		 * Must free item controller and views.
		 * 
		 * freeFunction(controller:*):void;
		 */
		[Bindable]
		public function get freeFunction():Function
		{
			return _freeFunction;
		}
		
		public function set freeFunction(value:Function):void
		{
			_freeFunction = value;
		}
		
		/**
		 * Called when collection is cleared.
		 * Tests controllers list whether it is empty.
		 * 
		 * isEmptyFunction():Boolean;
		 */
		[Bindable]
		public function get isEmptyFunction():Function
		{
			return _isEmptyFunction;
		}
		
		public function set isEmptyFunction(value:Function):void
		{
			_isEmptyFunction = value;
		}
		
		
		
		
		
		
		/**
		 * Collection management.
		 */
		private function initCollection():void
		{
			if (!_collection)
				return;
			
			_collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, onChange, false, 0, true);
		}
		
		private function freeCollection():void
		{
			if (!_collection)
				return;
			
			_collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onChange);
		}
		
		/**
		 * Callback functions wrappers.
		 */
		private function callCreate(model:*):*
		{
			return _createFunction(data);
		}
		
		private function callInsert(controller:*, index:int):void
		{
			_insertFunction(controller, index);
		}
		
		private function callRemove(index:int):*
		{
			return _removeFunction(index);
		}
		
		private function callFree(controller:*):void
		{
			_freeFunction(controller);
		}
		
		private function callIsEmpty():void
		{
			return _isEmptyFunction();
		}
		
		/**
		 * Supply methods.
		 */
		private function createItem(index:int):void
		{
			callInsert(callCreate(_collection.getItemAt(index)), index);
		}
		
		private function freeItem(index:int):void
		{
			callFree(callRemove(index));
		}
		
		/**
		 * Global collection change handler.
		 */
		private function onChange(e:CollectionEvent):void
		{
			dispatchEvent(new CollectionEvent(
				EVENT_BEFORE_CHANGE, false, false, e.kind, e.location, e.oldLocation, e.items));
			
			switch (e.kind)
			{
				case CollectionEventKind.ADD:
				{
					for (var i:int = 0; i < e.items.length; ++i)
						createItem(i + e.location);
					
					break;
				}
				
				case CollectionEventKind.REMOVE:
				{
					for (var i:int = 0; i < e.items.length; ++i)
						freeItem(e.location);
					
					break;
				}
				
				case CollectionEventKind.MOVE:
				{
					callInsert(callRemove(e.oldLocation), e.location);
					
					break;
				}
				
				case CollectionEventKind.REPLACE:
				{
					freeItem(e.location);
					createItem(e.location);
					
					break;
				}
				
				case CollectionEventKind.REFRESH:
				case CollectionEventKind.RESET;
				{
					while (!callIsEmpty())
						freeItem(0);
					
					for (var i = 0; i < _collection.length; ++i)
						createItem(i);
					
					break;
				}
			}
			
			dispatchEvent(new CollectionEvent(
				EVENT_AFTER_CHANGE, false, false, e.kind, e.location, e.oldLocation, e.items));
		}
	}
}