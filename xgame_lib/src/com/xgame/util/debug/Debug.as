package com.xgame.util.debug
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	public class Debug
	{
		private static var _btn: Sprite = new Sprite();
		private static var _container: Sprite = new Sprite();
		private static var _text: TextField = new TextField();
		private static var _logId: uint = 1;
		public static const LEVEL_INFO: Number = 0;
		public static const LEVEL_WARNING: Number = 1;
		public static const LEVEL_ERROR: Number = 2;
		private static const _levelArray: Array = ["INFO", "WARNING", "ERROR"];
		
		public function Debug()
		{
		}
		
		public static function init(): void
		{
			UIManager.debugLayer.addChild(_btn);
			_btn.graphics.beginFill(0xFF00FF);
			_btn.graphics.drawRect(0, 0, 120, 50);
			_btn.graphics.endFill();
			_btn.x = UIManager.stage.stageWidth - _btn.width;
			_btn.y = 0;
			
			_btn.addEventListener(MouseEvent.CLICK, function(evt: MouseEvent): void
			{
				if(_container.visible)
				{
					_container.visible = false;
				}
				else
				{
					_container.visible = true;
				}
			});
			
			UIManager.debugLayer.addChild(_container);
			_container.graphics.beginFill(0x000000, .5);
			_container.graphics.drawRect(0, 0, 600, 300);
			_container.graphics.endFill();
			_container.x = (UIManager.stage.stageWidth - 600) >> 1;
			_container.y = (UIManager.stage.stageHeight - 300) >> 1;
			
			var format: TextFormat = new TextFormat();
			format.size = 12;
			format.color = 0xFFFFFF;
			
			_text.defaultTextFormat = format;
			_text.wordWrap = true;
			_text.multiline = true;
			_text.width = 600;
			_text.height = 300;
			_container.addChild(_text);
		}
		
		private static function log(sender: *, content: *, level: Number): void
		{
			var output: String;
			output = 
				_logId + ". " +
				"[" + _levelArray[level] + "]" +
				"[" + getClassName(sender) + " - " +
//				getCodePosition() + " - " +
				getDate() + "]\n" + 
				getContent(content) + "\n";
			trace(output);
			_text.appendText(output);
			_logId++;
		}
		
		public static function info(sender: *, content: *): void
		{
			log(sender, content, LEVEL_INFO);
		}
		
		public static function warning(sender: *, content: *): void
		{
			log(sender, content, LEVEL_WARNING);
		}
		
		public static function error(sender: *, content: *): void
		{
			log(sender, content, LEVEL_ERROR);
		}
		
		private static function getClassName(sender: *): String
		{
			var name: String = getQualifiedClassName(sender);
			var array: Array = name.split("::");
			return array[1];
		}
		
		private static function getCodePosition(): String
		{
			var err: Error = new Error();
			var stack: Array = err.getStackTrace().split("\n");
			var i: int = 0;
			for(; i < stack.length; i++)
			{
				if(stack[i].indexOf("Debug$/log()") >= 0)
				{
					i += 2;
					break;
				}
			}
			var reg: RegExp=/\s*at\s+([^\/\$]+)\$?\/?(set|get)?\s?(\w+)?\(\)([^.]+\.(\w+):(\d+))?/;
			var result: Array = reg.exec(String(stack[i]));
			return result[4];
		}
		
		private static function getContent(content: *): String
		{
			if(content is String)
			{
				return content;
			}
			else if(content is ByteArray)
			{
				return byteToHex(content as ByteArray);
			}
			try
			{
				return content.toString();
			}
			catch(err: Error)
			{
				
			}
			return "";
		}
		
		private static function getDate(): String
		{
			var d: Date = new Date();
			return d.getFullYear() + "-" +
				(d.getMonth() + 1) + "-" +
				d.getDate() + " " +
				d.getHours() + ":" +
				d.getMinutes() + ":" +
				d.getSeconds() + "," + 
				d.getMilliseconds();
		}
		
		private static function byteToHex(content: ByteArray): String
		{
			var hex: String = "";
			var hexString: Array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];
			var low: uint;
			var high: uint;
			for(var i: uint = 0; i < content.length; i++)
			{
				low = content[i] & 0x0F;
				high = content[i] >> 4;
				
				hex += "0x" + hexString[high] + hexString[low] + " ";
				
				if((i+1) % 10 == 0)
				{
					hex += "\n";
				}
			}
			return hex;
		}
	}
}