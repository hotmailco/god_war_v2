package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	import flash.utils.ByteArray;

	public class Receive_Info_BindSession extends ReceiveBase
	{
		public var result: int = int.MIN_VALUE;
		
		public function Receive_Info_BindSession()
		{
			super(SocketContextConfig.INFO_BIND_SESSION);
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
						case TYPE_INT:
							if (result == int.MIN_VALUE)
							{
								result = bytes.readInt();
							}
							break;
					}
				}
			}
		}
	}
}