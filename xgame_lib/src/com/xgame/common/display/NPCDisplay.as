package com.xgame.common.display
{
	import com.xgame.common.behavior.Behavior;
	import com.xgame.common.behavior.NPCBehavior;
	import com.xgame.util.StringUtils;
	
	import flash.text.TextFieldAutoSize;
	
	import morn.core.components.Label;
	
	public class NPCDisplay extends ActionDisplay
	{
		private var _id: int;
		private var _prependName: String;
		private var _level: int;
		private var _health: int;
		private var _mana: int;
		
		public function NPCDisplay(behavior:Behavior=null)
		{
			super(behavior == null ? new NPCBehavior() : behavior);
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get prependName():String
		{
			return _prependName;
		}

		public function set prependName(value:String):void
		{
			_prependName = value;
			if(_prependName != value)
			{
				_prependName = value;
				
				if(_lblName == null)
				{
					_lblName = new Label();
					_lblName.isHtml = true;
					_lblName.color = 0xFFFFFF;
					_lblName.stroke = "0x000000,1,3,3,5";
					_lblName.autoSize = TextFieldAutoSize.LEFT;
					addAdditionalDisplay(_lblName);
				}
				_lblName.text = "&lt;<font color='#FFFF00'><b>" + _prependName + "</b></font>\>";
				
				if(!StringUtils.empty(_name))
				{
					_lblName.appendText(_name);
				}
				rebuildNameLabel();
			}
		}
		
		override public function set name(value:String):void
		{
			if(_name != value)
			{
				_name = value;
				
				if(_lblName == null)
				{
					_lblName = new Label();
					_lblName.isHtml = true;
					_lblName.color = 0xFFFFFF;
					_lblName.stroke = "0x000000,1,3,3,5";
					_lblName.autoSize = TextFieldAutoSize.LEFT;
					addAdditionalDisplay(_lblName);
				}
				if(!StringUtils.empty(_prependName))
				{
					_lblName.text = "&lt;<font color='#FFFF00'><b>" + _prependName + "</b></font>\>";
				}
				_lblName.appendText(_name);
				rebuildNameLabel();
			}
		}

		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get health():int
		{
			return _health;
		}

		public function set health(value:int):void
		{
			_health = value;
		}

		public function get mana():int
		{
			return _mana;
		}

		public function set mana(value:int):void
		{
			_mana = value;
		}
	}
}