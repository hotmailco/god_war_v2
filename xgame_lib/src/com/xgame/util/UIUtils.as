package com.xgame.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class UIUtils
	{
		public function UIUtils()
		{
		}
		
		public static function remove(child: DisplayObject): void
		{
			if(child.parent != null)
			{
				child.parent.removeChild(child);
			}
		}
		
		public static function getSkinSize(target: DisplayObject): Point
		{
			var source: Point = new Point(target.width, target.height);
			var zero: Point = new Point(0, 0);
			
			if(target.parent != null)
			{
				source = target.parent.localToGlobal(source);
				zero = target.parent.localToGlobal(zero);
			}
			
			return source.subtract(zero);
		}
		
		public static function restoreSkinSize(target: DisplayObject): void
		{
			var _size: Point = getSkinSize(target);
			if(_size.x == 0 || _size.y == 0)
			{
				return;
			}
			target.width = _size.x;
			target.height = _size.y;
		}
		
		private static function get stageCenter(): Point
		{
			var _stage: Stage = UIManager.stage;
			
			return new Point(_stage.stageWidth / 2, _stage.stageHeight / 2);
		}
		
		public static function center(comp: DisplayObject, width: Number = NaN, height: Number = NaN): void
		{
			var _stage: Stage = UIManager.stage;
			var _rect: Rectangle = comp.getBounds(comp);
			
			if(!isNaN(width))
			{
				_rect.width = width;
			}
			if(!isNaN(height))
			{
				_rect.height = height;
			}
			
			comp.x = (_stage.stageWidth - _rect.width * comp.scaleX) / 2;
			comp.y = (_stage.stageHeight - _rect.height * comp.scaleY) / 2;
		}
		
		public static function setBrightness(obj:DisplayObject, value:Number): void
		{
			var colorTransformer:ColorTransform = obj.transform.colorTransform
			var backup_filters:* = obj.filters
			if (value >= 0)
			{
				colorTransformer.blueMultiplier = 1 - value
				colorTransformer.redMultiplier = 1 - value
				colorTransformer.greenMultiplier = 1 - value
				colorTransformer.redOffset = 255 * value
				colorTransformer.greenOffset = 255 * value
				colorTransformer.blueOffset = 255 * value
			}
			else
			{
				value = Math.abs(value)
				colorTransformer.blueMultiplier = 1 - value
				colorTransformer.redMultiplier = 1 - value
				colorTransformer.greenMultiplier = 1 - value
				colorTransformer.redOffset = 0
				colorTransformer.greenOffset = 0
				colorTransformer.blueOffset = 0
			}
			obj.transform.colorTransform = colorTransformer
			obj.filters = backup_filters
		}
		
		public static function setGray(obj: DisplayObject, value: Boolean): void
		{
			if(obj != null)
			{
				var filterArray: Array;
				if(value)
				{
					var matrix: Array = [
						0.3086, 0.6094, 0.0820, 0, 0,
						0.3086, 0.6094, 0.0820, 0, 0,
						0.3086, 0.6094, 0.0820, 0, 0,
						0,      0,      0,      1, 0
					];
					var filter: ColorMatrixFilter = new ColorMatrixFilter(matrix);
					filterArray = obj.filters;
					filterArray.push(filter);
					obj.filters = filterArray;
				}
				else
				{
					filterArray = obj.filters;
					for(var i: int = 0; i<filterArray.length; i++)
					{
						if(filterArray[i] is ColorMatrixFilter)
						{
							filterArray.splice(i, 1);
						}
					}
					obj.filters = filterArray;
				}
			}
		}
	}
}