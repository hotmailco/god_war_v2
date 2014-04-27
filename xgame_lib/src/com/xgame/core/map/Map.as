package com.xgame.core.map
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.loading.utils.LoaderUtils;
	import com.xgame.Global;
	import com.xgame.common.display.ActionDisplay;
	import com.xgame.core.Camera;
	import com.xgame.enum.Action;
	import com.xgame.event.map.MapEvent;
	import com.xgame.manager.ResourceManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Map implements IEventDispatcher
	{
		/**
		 * 地图大小
		 */
		public static var MapSize: Point = new Point();
		/**
		 * 地图碎片大小
		 */
		public static var TileSize: Point = new Point();
		/**
		 * 地图碎片数量
		 */
		public static var TileNum: Point = new Point();
		/**
		 * 寻路格子大小
		 */
		public static var BlockSize: Point = new Point();
		/**
		 * 寻路格子数量
		 */
		public static var BlockNum: Point = new Point();
		
		private var _mapId: uint = 0;
		private var _astar: SilzAstar;
		private var _negativePath: Array;
		protected var _mapBuffer: BitmapData;
		protected var _mapDrawArea: Shape;
		private var _availableTileX: uint;
		private var _availableTileY: uint;
		private var _tileToLoad: Array;
		protected var _roadMap: BitmapData;
		protected var _roadScale: Number;
		protected var _alphaMap: BitmapData;
		protected var _mapLoopBg: BitmapData;
		protected var _currentStartX: uint;
		protected var _currentStartY: uint;
		protected var _smallMap: BitmapData;
		protected var _smallScale: Number;
		protected var _smallMapBuffer: BitmapData;
		protected static var _instance: Map;
		protected static var _allowInstance: Boolean = false;
		private var _loaderList: Vector.<LoaderCore>;
		private var _eventDispatcher: EventDispatcher;
		
		public function Map(mapId: uint)
		{
			if(!_allowInstance)
			{
				throw new IllegalOperationError("不能直接实例化");
				return;
			}
			_mapId = mapId;
			_eventDispatcher = new EventDispatcher(this);
			_loaderList = new Vector.<LoaderCore>();
		}
		
		public static function initilization(mapId: uint): Map
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new Map(mapId);
				_allowInstance = false;
			}
			return _instance;
		}
		
		public static function get instance(): Map
		{
			return _instance;
		}
		
		public function dispose(): void
		{
			_instance = null;
			_eventDispatcher = null;
		}
		
		public function loadMapData(): void
		{
			ResourceManager.instance.load(Global.resource_server_ip + Global.MAP_RES_PATH + _mapId + '/config.xml', {}, onMapDataLoadComplete);
		}
		
		protected function onMapDataLoadComplete(evt: LoaderEvent): void
		{
			var _xmlLoader: XMLLoader = evt.target as XMLLoader;
			var _xml: XML = _xmlLoader.content as XML;
			
			if(int(_xml.id) != _mapId)
			{
				throw new IllegalOperationError("MapId与配置不一致");
				return;
			}
			else
			{
				MapSize.x = _xml.width;
				MapSize.y = _xml.height;
				
				TileNum.x = _xml.tileNumWidth;
				TileNum.y = _xml.tileNumHeight;
				
				TileSize.x = Math.floor(MapSize.x / TileNum.x);
				TileSize.y = Math.floor(MapSize.y / TileNum.y);
				
				BlockNum.x = _xml.blockNumWidth;
				BlockNum.y = _xml.blockNumHeight;
				
				BlockSize.x = Math.floor(MapSize.x / BlockNum.x);
				BlockSize.y = Math.floor(MapSize.y / BlockNum.y);
				
				_availableTileX = Math.ceil(UIManager.stage.stageWidth / TileSize.x) + 2;
				_availableTileY = Math.ceil(UIManager.stage.stageHeight / TileSize.y) + 2;
				
				Camera.instance.x = 0;
				Camera.instance.y = 0;
				
				loadRoadMap();
				loadAlphaMap();
				
				dispatchEvent(new MapEvent(MapEvent.MAP_DATA_COMPLETE));
			}
		}
		
		private function initializeAstar(): void
		{
			_astar = new SilzAstar(_negativePath);
		}
		
		private function resetNegativePath(): void
		{
			if(_negativePath != null)
			{
				_negativePath.splice(0, _negativePath.length);
				_negativePath = null
			}
			_negativePath = new Array();
			
			for(var y: int = 0; y < BlockNum.x; y++)
			{
				var temp: Array = new Array();
				for(var x: int = 0; x < BlockNum.y; x++)
				{
					temp.push(true);
				}
				_negativePath.push(temp);
			}
		}
		
		protected function loadRoadMap(): void
		{
			var url: String = Global.resource_server_ip + Global.MAP_RES_PATH + _mapId + "/road.png";
			ResourceManager.instance.load(url, {}, onRoadMapLoadComplete);
		}
		
		private function onRoadMapLoadComplete(evt: LoaderEvent): void
		{
			resetNegativePath();
			_roadMap = ((evt.currentTarget as ImageLoader).rawContent as Bitmap).bitmapData;
			
			_roadScale = _roadMap.width / MapSize.x;
			
			for(var y: int = 0; y < BlockNum.x; y++)
			{
				for(var x: int = 0; x < BlockNum.y; x++)
				{
					_negativePath[y][x] = _roadMap.getPixel32(int(BlockSize.x * x * _roadScale), int(BlockSize.y * y * _roadScale)) == 0x00000000 ? true : false;
				}
			}
			initializeAstar();
		}
		
		protected function loadAlphaMap(): void
		{
			var url: String = Global.resource_server_ip + Global.MAP_RES_PATH + _mapId + "/alpha.png";
			ResourceManager.instance.load(url, {}, onAlphaMapLoadComplete);
		}
		
		private function onAlphaMapLoadComplete(evt: LoaderEvent): void
		{
			if(_alphaMap != null)
			{
				_alphaMap.dispose();
				_alphaMap = null;
			}
			
			_alphaMap = ((evt.currentTarget as ImageLoader).rawContent as Bitmap).bitmapData;
		}
		
		public function initializeBuffer(): void
		{
			_mapBuffer = new BitmapData(
				UIManager.stage.stageWidth + 2 * TileSize.x,
				UIManager.stage.stageHeight + 2 * TileSize.y,
				false
			);
		}
		
		public function prepareMap(): void
		{
			var _smallMapPath: String = Global.resource_server_ip +
				Global.MAP_RES_PATH +
				_mapId + '/thumbnail.jpg';
			ResourceManager.instance.load(_smallMapPath, {}, onSmallMapComplete);
		}
		
		private function onSmallMapComplete(evt: LoaderEvent): void
		{
			_smallMap = ((evt.target as ImageLoader).rawContent as Bitmap).bitmapData;
			
			_smallScale = _smallMap.width / MapSize.x;
			_smallMapBuffer = new BitmapData(_mapBuffer.width * _smallScale, _mapBuffer.height * _smallScale, false, 0);
			
			update(true);
		}
		
		public function getWorldPosition(x: Number, y: Number): Point
		{
			var _returnPoint: Point = new Point();
			_returnPoint.x = Camera.instance.x + x;
			_returnPoint.y = Camera.instance.y + y;
			
			return _returnPoint;
		}
		
		public function getScreenPosition(x: Number, y: Number): Point
		{
			var _returnPoint: Point = new Point();
			_returnPoint.x = x - Camera.instance.x;
			_returnPoint.y = y - Camera.instance.y;
			
			return _returnPoint;
		}
		
		public function block2WorldPosition(x: Number, y: Number): Point
		{
			var _returnPoint: Point = new Point();
			_returnPoint.x = (x + .5) * BlockSize.x;
			_returnPoint.y = (y + .5) * BlockSize.y;
			
			return _returnPoint;
		}
		
		public function worldPosition2Block(x: Number, y: Number): Point
		{
			var _returnPoint: Point = new Point();
			_returnPoint.x = int(x / BlockSize.x);
			_returnPoint.y = int(y / BlockSize.y);
			
			return _returnPoint;
		}
		
		public function worldPosition2Tile(x: Number, y: Number): Point
		{
			var _returnPoint: Point = new Point();
			_returnPoint.x = int(x / TileSize.x);
			_returnPoint.y = int(y / TileSize.y);
			
			return _returnPoint;
		}
		
		public function update(force: Boolean = false): void
		{
			if(Camera.instance.focus != null && !force)
			{
				if(Camera.instance.focus is ActionDisplay)
				{
					if((Camera.instance.focus as ActionDisplay).action == Action.STOP)
					{
						return;
					}
				}
				else
				{
					return;
				}
			}
			_mapDrawArea.x = -(Camera.instance.x % TileSize.x);
			_mapDrawArea.y = -(Camera.instance.y % TileSize.y);
			
			var _startPoint : Point = worldPosition2Tile(Camera.instance.x, Camera.instance.y);
			var _startX: int = _startPoint.x;
			var _startY: int = _startPoint.y;
			if(_currentStartX == _startX && _currentStartY == _startPoint.y && !force)
			{
				return;
			}
			
			prepareBlock(_startX, _startY, force);
			
			_currentStartX = _startX;
			_currentStartY = _startY;
		}
		
		protected function prepareBlock(startX: int = -1, startY: int = -1, force: Boolean = false): void
		{
			if(startX == -1 || startY == -1)
			{
				startX = int(Camera.instance.x / TileSize.x);
				startY = int(Camera.instance.y / TileSize.y);
			}
			
			if(_currentStartX == startX && _currentStartY == startY && !force)
			{
				return;
			}
			
			drawSmallMap(startX, startY);
			if(_tileToLoad != null)
			{
				_tileToLoad.splice(0, _tileToLoad.length);
			}
			_tileToLoad = new Array();
			
			var maxBlockX: int = Math.min(TileNum.x, startX + _availableTileX);
			var maxBlockY: int = Math.min(TileNum.y, startY + _availableTileY);
			for(var j: int = startY; j < maxBlockY; j++)
			{
				var tempPos: Array = new Array();
				for(var i: int = startX; i < maxBlockX; i++)
				{
					tempPos.push(j + "_" + i);
				}
				_tileToLoad.push(tempPos);
			}
			loadTiles();
		}
		
		protected function drawSmallMap(startX: int, startY: int): void
		{
			if(_smallMap != null && _smallMapBuffer != null)
			{
				_smallMapBuffer.fillRect(_smallMapBuffer.rect, 0);
				var rect: Rectangle = new Rectangle(
					startX * TileSize.x * _smallScale,
					startY * TileSize.y * _smallScale,
					_smallMapBuffer.width,
					_smallMapBuffer.height
				);
				_smallMapBuffer.copyPixels(_smallMap, rect, new Point());
				
				var per: Number = 1 / _smallScale;
				_mapBuffer.draw(_smallMapBuffer, new Matrix(per, 0, 0, per));
			}
		}
		
		protected function loadTiles(): void
		{
			if(_tileToLoad == null)
			{
				return;
			}
//			_mapDrawArea.cacheAsBitmap = false;
			var _bm: BitmapData;
			var _temp: Array;
			for(var i: int = 0; i < _tileToLoad.length; i++)
			{
				for(var j: int = 0; j < _tileToLoad[i].length; j++)
				{
					_bm = ResourceManager.instance.get(_mapId + "_" + _tileToLoad[i][j]) as BitmapData;
					_temp = _tileToLoad[i][j].split("_");
					if(_bm != null)
					{
						//缓存中存在，直接Copy
						var _point: Point = new Point(j * TileSize.x, i * TileSize.y);
						_mapBuffer.copyPixels(_bm, _bm.rect, _point);
					}
					else
					{
						var options: Object = {
							positionX: int(_temp[1]),
							positionY: int(_temp[0])
						};
						var _loader: LoaderCore = LoaderUtils.generateLoader(Global.resource_server_ip + Global.MAP_RES_PATH + _mapId + '/assets/' + _tileToLoad[i][j] + '.jpg');
						_loader.autoDispose = true;
						_loader.vars = options;
						_loaderList.push(_loader);
					}
				}
			}
			
			startLoad();
		}
		
		protected function startLoad(): void
		{
			if(_loaderList.length == 0)
			{
				return;
			}
			
			for(var i: int = 0; i<_loaderList.length; i++)
			{
				var _loader: LoaderCore = _loaderList[0];
				_loader.addEventListener(LoaderEvent.COMPLETE, onTileLoadComplete);
				_loader.load();
				_loaderList.splice(0, 1);
			}
//			var _loader: LoaderCore = _loaderList[0];
//			_loader.addEventListener(LoaderEvent.COMPLETE, onTileLoadComplete);
//			_loader.load();
//			_loaderList.splice(0, 1);
		}
		
		protected function onTileLoadComplete(evt: LoaderEvent): void
		{
			var _loader: LoaderCore = evt.currentTarget as LoaderCore;
			_loader.removeEventListener(LoaderEvent.COMPLETE, onTileLoadComplete);
			if(_loader is ImageLoader)
			{
				var _options: Object = (_loader as ImageLoader).vars;
				var _bm: BitmapData = ((_loader as ImageLoader).rawContent as Bitmap).bitmapData;
				ResourceManager.instance.add(_mapId + "_" + _options.positionY + "_" + _options.positionX, _bm);
				
				var _point: Point = new Point((_options.positionX - _currentStartX) * TileSize.x, (_options.positionY - _currentStartY) * TileSize.y);
				_mapBuffer.copyPixels(_bm, _bm.rect, _point);
			}
			_loader.unload();
			_loader.dispose();
			_loader = null;
//			if(_loaderList.length > 0)
//			{
//				startLoad();
//			}
//			else
//			{
//				_mapDrawArea.cacheAsBitmap = true;
//			}
		}
		
		public function inAlphaArea(x: uint, y: uint): Boolean
		{
			if(_alphaMap != null)
			{
				return _alphaMap.getPixel32(int(_alphaMap.width / MapSize.x * x), int(_alphaMap.height / MapSize.y * y)) != 0x00000000;
			}
			else
			{
				return false;
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _eventDispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _eventDispatcher.willTrigger(type);
		}

		public function get mapId():uint
		{
			return _mapId;
		}

		public function get mapDrawArea():Shape
		{
			return _mapDrawArea;
		}
		
		public function get astar():SilzAstar
		{
			return _astar;
		}
		
		public function get negativePath():Array
		{
			return _negativePath;
		}

		public function set mapDrawArea(value:Shape):void
		{
			_mapDrawArea = value;
			_mapDrawArea.graphics.beginBitmapFill(_mapBuffer);
			_mapDrawArea.graphics.drawRect(0, 0, _mapBuffer.width, _mapBuffer.height);
			_mapDrawArea.graphics.endFill();
		}


	}
}