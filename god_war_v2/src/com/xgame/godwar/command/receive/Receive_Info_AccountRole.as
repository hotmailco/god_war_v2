package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Info_AccountRole extends ReceiveBase
	{
		public var guid: String;
		public var accountId: Int64;
		public var nickName: String;
		public var level: int = int.MIN_VALUE;
		public var accountCash: Int64;
		public var energy: int = int.MIN_VALUE;
		public var rolePicture: String;
		
		public function Receive_Info_AccountRole()
		{
			super(SocketContextConfig.REGISTER_ACCOUNT_ROLE);
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
						case TYPE_LONG:
							if (accountId == null)
							{
								accountId = new Int64();
								accountId.high = data.readInt();
								accountId.low = data.readUnsignedInt();
							}
							else if(accountCash == null)
							{
								accountCash = new Int64();
								accountCash.high = data.readInt();
								accountCash.low = data.readUnsignedInt();
							}
							break;
						case TYPE_STRING:
							if(StringUtils.empty(guid))
							{
								guid = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(nickName))
							{
								nickName = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(rolePicture))
							{
								rolePicture = data.readUTFBytes(length);
							}
							break;
						case TYPE_INT:
							if(level == int.MIN_VALUE)
							{
								level = data.readInt();
							}
							else if(energy == int.MIN_VALUE)
							{
								energy = data.readInt();
							}
							break;
					}
				}
			}
		}
	}
}