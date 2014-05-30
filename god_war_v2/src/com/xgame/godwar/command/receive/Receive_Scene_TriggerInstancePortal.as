package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	import flash.utils.ByteArray;
	
	public class Receive_Scene_TriggerInstancePortal extends ReceiveBase
	{
		public var instanceList: Vector.<int>;
		
		public function Receive_Scene_TriggerInstancePortal()
		{
			super(SocketContextConfig.SCENE_TRIGGER_INSTANCE_PORTAL);
			
			instanceList = new Vector.<int>();
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while (data.bytesAvailable > 8)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case TYPE_INT:
							instanceList.push(data.readInt());
							break;	
					}
				}
			}
		}
	}
}