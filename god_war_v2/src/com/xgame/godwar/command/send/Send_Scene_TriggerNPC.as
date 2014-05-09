package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	public class Send_Scene_TriggerNPC extends SendBase
	{
		public var guid: String;
		public var step: int;
		
		public function Send_Scene_TriggerNPC()
		{
			super(SocketContextConfig.SCENE_TRIGGER_NPC);
		}
		
		override public function fill():void
		{
			super.fill();
			
			_byteData.writeInt(guid.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(guid);
			
			_byteData.writeInt(4);
			_byteData.writeByte(TYPE_INT);
			_byteData.writeInt(step);
		}
	}
}