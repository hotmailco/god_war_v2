package com.xgame.common.display
{
	import com.xgame.common.behavior.Behavior;
	import com.xgame.enum.Action;
	import com.xgame.ns.NSCamera;
	import com.xgame.util.StringUtils;
	
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import morn.core.components.Label;

	public class ActionDisplay extends BitmapMovieDispaly
	{
		protected var _action: int;
		protected var _name: String;
		private var _follow: ActionDisplay;
		private var _followDistance: Number;
		private var _additionalDisplay: Sprite;
		private var _lblName: Label;
		
		public function ActionDisplay(behavior: Behavior = null)
		{
			super(behavior);
			
			_additionalDisplay = new Sprite();
			addChild(_additionalDisplay);
		}
		
		protected function configLoop(): void
		{
			switch(_action)
			{
				case Action.CAUTION:
				case Action.MOVE:
					loop = true;
					break;
				default:
					loop = false;
			}
		}
		
		protected function rebuildNameLabel(): void
		{
			_lblName.x = -(_lblName.width >> 1);
			if(graphic != null)
			{
				_lblName.y = -(graphic.frameHeight + _lblName.height);
			}
		}
		
		override public function rebuild():void
		{
			super.rebuild();
			rebuildNameLabel();
		}
		
		override public function set graphic(value:ResourceData):void
		{
			super.graphic = value;
			
			rebuildNameLabel();
		}
		
		public function get action():int
		{
			return _action;
		}
		
		public function set action(value:int):void
		{
			if(_action == value || _action == Action.DIE)
			{
				return;
			}
			if(value == Action.DIE)
			{
				canBeAttack = false;
			}
			else
			{
				canBeAttack = true;
			}
			_currentFrame = 0;
			_action = value;
			_graphic.currentAction = value;
			
			configLoop();
			rebuild();
		}

		public function get follow():ActionDisplay
		{
			return _follow;
		}

		public function set follow(value:ActionDisplay):void
		{
			_follow = value;
			_followDistance = 40;
		}

		public function get followDistance():Number
		{
			return _followDistance;
		}

		public function set followDistance(value:Number):void
		{
			_followDistance = value;
		}
		
		public function get followed(): Boolean
		{
			return (_follow != null);
		}
		
		override public function get name():String
		{
			return _name;
		}
		
		override public function set name(value:String):void
		{
			if(_name != value)
			{
				_name = value;
				
				if(_lblName == null)
				{
					_lblName = new Label();
					_lblName.color = 0xFFFFFF;
					_lblName.stroke = "0x000000,1,3,3,5";
					_lblName.autoSize = TextFieldAutoSize.LEFT;
					_additionalDisplay.addChild(_lblName);
				}
				_lblName.text = _name;
				rebuildNameLabel();
			}
		}
		
		public function addAdditionalDisplay(value: Sprite): void
		{
			_additionalDisplay.addChild(value);
		}
		
		public function removeAdditionalDisplay(value: Sprite): void
		{
			_additionalDisplay.removeChild(value);
		}
		
		public function clearAdditionalDisplay(): void
		{
			_additionalDisplay.removeChildren();
		}
	}
}