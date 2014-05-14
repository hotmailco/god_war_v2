package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.parameter.CardGroupParameter;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Hall_RequestCardGroup extends ReceiveBase
	{
		public var list: Vector.<CardGroupParameter>;
		
		public function Receive_Hall_RequestCardGroup()
		{
			super(SocketContextConfig.INFO_REQUEST_CARD_GROUP);
			list = new Vector.<CardGroupParameter>();
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				var parameter: CardGroupParameter = new CardGroupParameter();
				while (data.bytesAvailable > 8)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case TYPE_INT:
							if (parameter.groupId == int.MIN_VALUE)
							{
								parameter.groupId = data.readInt();
							}
							break;
						case TYPE_STRING:
							if (StringUtils.empty(parameter.groupName))
							{
								parameter.groupName = data.readUTFBytes(length);
							}
							break;
					}
					
					if(parameter.groupId != int.MIN_VALUE &&
						!StringUtils.empty(parameter.groupName))
					{
						list.push(parameter);
						parameter = new CardGroupParameter();
					}
				}
			}
		}
	}
}