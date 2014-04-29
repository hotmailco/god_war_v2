package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class Receive_Msg_SendWorld extends ReceiveBase
	{
		public var guid: String;
		public var message: String;
		
		public function Receive_Msg_SendWorld()
		{
			super(SocketContextConfig.MSG_SEND_WORLD);
		}
		
		override public function fill(bytes: ByteArray):void
		{
			super.fill(bytes);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				while (bytes.bytesAvailable > 8)
				{
					length = bytes.readInt();
					type = bytes.readByte();
					switch(type)
					{
						case TYPE_STRING:
							if (StringUtils.empty(guid))
							{
								guid = bytes.readUTFBytes(length);
							}
							else if (StringUtils.empty(message))
							{
								message = bytes.readUTFBytes(length);
							}
							break;
					}
				}
			}
		}
	}
}