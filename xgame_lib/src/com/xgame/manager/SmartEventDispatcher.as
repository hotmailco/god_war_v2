package com.xgame.manager
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	public class SmartEventDispatcher extends EventDispatcher
	{
		private var _listenerPool: Dictionary;
		private var _typeList: Array;
		
		public function SmartEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
			
			_listenerPool = new Dictionary();
			_typeList = new Array();
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			
			var listenerList: Array = _listenerPool[type] as Array;
			if(listenerList == null)
			{
				listenerList = new Array();
				_typeList.push(type);
			}
			listenerList.push(listener);
			_listenerPool[type] = listenerList;
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			super.removeEventListener(type, listener, useCapture);
			
			var listenerList: Array = _listenerPool[type] as Array;
			if(listenerList != null)
			{
				var i: int = listenerList.indexOf(listener);
				if(i >= 0)
				{
					listenerList.splice(i, 1);
					
					if(listenerList.length == 0)
					{
						_listenerPool[type] = null;
						delete _listenerPool[type];
						
						i = _typeList.indexOf(type);
						if(i >= 0)
						{
							_typeList.splice(i, 1);
						}
					}
				}
			}
		}
		
		public function removeEventListeners(type: String = null): void
		{
			if(type != null)
			{
				if(!hasEventListener(type))
				{
					return;
				}
				
				removeEventByType(type);
			}
			else
			{
				for(var m: int = 0; m<_typeList.length; m++)
				{
					type = _typeList[m];
					
					if(hasEventListener(type))
					{
						removeEventByType(type);
					}
				}
			}
		}
		
		private function removeEventByType(type: String): void
		{
			var listenerList: Array = _listenerPool[type] as Array;
			if(listenerList != null)
			{
				for(var i: int = 0; i<listenerList.length; i++)
				{
					super.removeEventListener(type, listenerList[i]);
				}
				
				listenerList.splice(0, listenerList.length);
				_listenerPool[type] = null;
				delete _listenerPool[type];
			}
		}
	}
}