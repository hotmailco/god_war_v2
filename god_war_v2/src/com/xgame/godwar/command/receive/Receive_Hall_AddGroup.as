package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Hall_AddGroup extends ReceiveBase
	{
		public var groupId: int = int.MIN_VALUE;
		public var groupName: String = null;
		
		public function Receive_Hall_AddGroup()
		{
			super(SocketContextConfig.INFO_CREATE_GROUP);
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
							if(groupId == int.MIN_VALUE)
							{
								groupId = data.readInt();
							}
							break;
						case TYPE_STRING:
							if (StringUtils.empty(groupName))
							{
								groupName = data.readUTFBytes(length);
							}
							break;
					}
				}
			}
		}
	}
}