package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	import flash.utils.ByteArray;
	
	public class Receive_Move_Sync extends ReceiveBase
	{
		public var x: int = int.MIN_VALUE;
		public var y: int = int.MIN_VALUE;
		
		public function Receive_Move_Sync()
		{
			super(SocketContextConfig.SYNC_MOVE);
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
							if (x == int.MIN_VALUE)
							{
								x = bytes.readInt();
							}
							else if(y == int.MIN_VALUE)
							{
								y = bytes.readInt();
							}
							break;
					}
				}
			}
		}
	}
}