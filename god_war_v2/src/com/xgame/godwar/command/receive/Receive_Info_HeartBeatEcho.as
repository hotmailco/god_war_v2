package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	
	import flash.utils.ByteArray;
	
	public class Receive_Info_HeartBeatEcho extends ReceiveBase
	{
		public var flag: int = int.MIN_VALUE;
		public var stamp: Int64;
		
		public function Receive_Info_HeartBeatEcho()
		{
			super(SocketContextConfig.INFO_HEART_BEAT_ECHO);
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
							if (flag == int.MIN_VALUE)
							{
								flag = bytes.readInt();
							}
							break;
						case TYPE_LONG:
							if(stamp == null)
							{
								stamp = new Int64();
								stamp.high = bytes.readInt();
								stamp.low = bytes.readUnsignedInt();
							}
							break;
					}
				}
			}
		}
	}
}