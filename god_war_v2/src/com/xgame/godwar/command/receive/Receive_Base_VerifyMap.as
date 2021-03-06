package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	import flash.utils.ByteArray;

	public class Receive_Base_VerifyMap extends ReceiveBase
	{
		public var mapId: int;
		public var direction: int;
		
		public function Receive_Base_VerifyMap()
		{
			super(SocketContextConfig.BASE_VERIFY_MAP);
			mapId = int.MIN_VALUE;
			direction = int.MIN_VALUE;
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
							if (mapId == int.MIN_VALUE)
							{
								mapId = data.readInt();
								break;
							}
							if (direction == int.MIN_VALUE)
							{
								direction = data.readInt();
								break;
							}
					}
				}
			}
			
		}
	}
}