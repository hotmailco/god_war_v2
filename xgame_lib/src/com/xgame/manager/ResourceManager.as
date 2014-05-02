package com.xgame.manager
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.utils.LoaderUtils;
	import com.xgame.common.display.BitmapFrame;
	import com.xgame.common.display.ResourceData;
	import com.xgame.util.Reflection;
	import com.xgame.util.debug.Debug;
	
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	public class ResourceManager extends BaseManager
	{
		private var _pool: Dictionary;
//		private var _showProgressBarIndex: Dictionary;
//		private var _progressBarTitle: Dictionary;
		private var _paramIndex: Dictionary;
		private static var _instance: ResourceManager;
		private static var _allowInstance: Boolean = false;
		
		public function ResourceManager()
		{
			super();
			if(!_allowInstance)
			{
				throw new IllegalOperationError("不能直接实例化");
				return;
			}
			
			_pool = new Dictionary();
			_paramIndex = new Dictionary();
		}
		
		public static function get instance(): ResourceManager
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new ResourceManager();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function add(key:Object, value:Object):void
		{
			_pool[key] = value;
		}
		
		public function get(key:Object):Object
		{
			return _pool[key];
		}
		
		public function remove(key:Object):void
		{
			_pool[key] = null;
			delete _pool[key];
		}
		
		public function removeAll():void
		{
			var _key: Object;
			for(_key in _pool)
			{
				remove(_key);
			}
			_pool = new Dictionary();
		}
		
		public function contain(key:Object):Boolean
		{
			return _pool.hasOwnProperty(key);
		}
		
		public function getBitmapData(name: String, domain: ApplicationDomain = null): BitmapData
		{
			var _cache: BitmapData = get(name) as BitmapData;
			if(_cache == null)
			{
				_cache = Reflection.createBitmapData(name, domain);
				if(_cache != null)
				{
					add(name, _cache);
				}
				else
				{
					CONFIG::DebugMode
					{
						Debug.error(this, "资源不存在 ( " + name + " )");
					}
				}
			}
			return _cache;
		}
		
		public function getResourceData(name: String): ResourceData
		{
			var _resourceData: ResourceData = new ResourceData();
			var _bitmapData: BitmapData;
			for(var i: int = 0; i < 9; i++)
			{
				_bitmapData = getBitmapData(name + "_" + i);
				if(_bitmapData != null)
				{
					_resourceData.getResource(_bitmapData, i, _bitmapData["frameLine"], _bitmapData["frameTotal"], _bitmapData["fps"]);
				}
				else
				{
					load(name + "_" + i, {resource: _resourceData, action: i}, onResourceDataLoaded);
				}
			}
			return _resourceData;
		}
		
		private function onResourceDataLoaded(evt: LoaderEvent): void
		{
			var _item: LoaderCore = evt.target as LoaderCore;
			var vars: Object = _item.vars;
			var resource: ResourceData = vars.vars.resource as ResourceData;
			
			if(resource != null)
			{
				var name: String = _item.name;
				var action: int = int(vars.vars.action);
				var _bitmapData: BitmapData = getBitmapData(name);
				if(_bitmapData != null)
				{
					resource.getResource(_bitmapData, action, _bitmapData["frameLine"], _bitmapData["frameTotal"], _bitmapData["fps"]);
					resource.syncActionResource();
					resource.target.rebuild();
				}
			}
		}
		
		public function getBitmapClip(name: String, domain: ApplicationDomain = null): Vector.<Vector.<BitmapFrame>>
		{
			return get(name) as Vector.<Vector.<BitmapFrame>>
		}
		
		public function cacheBitmapClip(name: String, value: Vector.<Vector.<BitmapFrame>>): void
		{
			add(name, value);
		}
		
		public static function clipBitmapData(data: BitmapData, frameLine: int, frameTotal: int, frameWidth: int, frameHeight: int, frameConfig: Array = null): Vector.<Vector.<BitmapFrame>>
		{
			var bmArray: Vector.<Vector.<BitmapFrame>> = new Vector.<Vector.<BitmapFrame>>();
			for(var y: uint = 0; y < frameLine; y++)
			{
				var line: Vector.<BitmapFrame> = new Vector.<BitmapFrame>();
				for(var x: uint = 0; x < frameTotal; x++)
				{
					var bm: BitmapData = new BitmapData(frameWidth, frameHeight, true, 0x00000000);
					var rect: Rectangle = new Rectangle(x * frameWidth, y * frameHeight, frameWidth, frameHeight);
					bm.copyPixels(data, rect, new Point(), null, null, true);
					
					var _frame: BitmapFrame = new BitmapFrame();
					_frame.bitmapData = bm;
					
					if(frameConfig != null)
					{
						_frame.offsetX = frameConfig[y][x].offsetX;
						_frame.offsetY = frameConfig[y][x].offsetY;
						_frame.label = frameConfig[y][x].label;
					}
					else
					{
						_frame.offsetX = 0;
						_frame.offsetY = 0;
						_frame.label = "";
					}
					line.push(_frame);
				}
				bmArray.push(line);
			}
			return bmArray;
		}
		
		public function load(
							name: String,
							vars: Object = null,
							onComplete: Function = null,
							onProgress: Function = null,
							onError: Function = null
		): void
		{
			if(onComplete != null)
			{
				addTrigger(name + "_complete", onComplete);
			}
			if(onProgress != null)
			{
				addTrigger(name + "_progress", onProgress);
			}
			if(onError != null)
			{
				addTrigger(name + "_error", onError);
			}
			var _item: LoaderCore = LoaderMax.getLoader(name);
			if(_item == null)
			{
				_item = LoaderUtils.generateLoader(name);
				if(_item != null)
				{
					_item.autoDispose = true;
					_item.name = name;
				}
				else
				{
					CONFIG::DebugMode
					{
						Debug.error(this, "加载资源失败 ( " + name + " )");
					}
					return;
				}
			}
			
			if(vars != null)
			{
				
				if(_paramIndex[name] == null)
				{
					_paramIndex[name] = new Array();
				}
				_paramIndex[name].push(vars);
			}
			
			_item.vars.onComplete = onComplete;
			_item.vars.onProgress = onProgress;
			_item.vars.onError = onError;
			_item.addEventListener(LoaderEvent.COMPLETE, onLoadComplete);
			_item.addEventListener(LoaderEvent.PROGRESS, onLoadProgress);
			_item.addEventListener(LoaderEvent.IO_ERROR, onLoadIOError);
			_item.load();
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			var _item: LoaderCore = evt.target as LoaderCore;
			var _name: String = _item.name;
			riseTrigger(_name + "_complete", evt);
			removeTrigger(_name + "_complete", _item.vars.onComplete);
			removeTrigger(_name + "_progress", _item.vars.onProgress);
			removeTrigger(_name + "_error", _item.vars.onError);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var _item: LoaderCore = evt.target as LoaderCore;
			var _name: String = _item.name;
			riseTrigger(_name + "_progress", evt);
			//TODO onProgress
		}
		
		private function onLoadIOError(evt: LoaderEvent): void
		{
			var _item: LoaderCore = evt.target as LoaderCore;
			var _name: String = _item.name;
			riseTrigger(_name + "_error", evt);
			removeTrigger(_name + "_complete", _item.vars.onComplete);
			removeTrigger(_name + "_progress", _item.vars.onProgress);
			removeTrigger(_name + "_error", _item.vars.onError);
		}
		
		override protected function riseTrigger(key:Object, param:Object=null):void
		{
			var _evt: LoaderEvent = param as LoaderEvent;
			if(_evt == null)
			{
				return;
			}
			var _loader: LoaderCore = _evt.currentTarget as LoaderCore;
			if(_loader == null)
			{
				return;
			}
			var vars: Array = _paramIndex[_loader.name];
			var _item: Array = trigger[key] as Array;
			if(_item == null)
			{
				return;
			}
			
			var func: Function;
			for(var i: int = 0; i<_item.length; i++)
			{
				func = _item[i];
				if(vars != null && i < vars.length)
				{
					_loader.vars.vars = vars[i];
				}
				if(_evt != null)
				{
					func(_evt);
				}
				else
				{
					func();
				}
			}
		}
	}
}