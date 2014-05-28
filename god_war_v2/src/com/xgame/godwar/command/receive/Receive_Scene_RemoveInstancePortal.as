package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Scene_RemoveInstancePortal extends ReceiveBase
	{
		public var guid: String;
		
		public function Receive_Scene_RemoveInstancePortal()
		{
			super(SocketContextConfig.SCENE_REMOVE_INSTANCE_PORTAL);
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
						case TYPE_STRING:
							if(StringUtils.empty(guid))
							{
								guid = data.readUTFBytes(length);
								break;
							}
							break;
					}
				}
			}
		}
	}
}