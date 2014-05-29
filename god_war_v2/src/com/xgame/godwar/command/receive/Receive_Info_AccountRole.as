package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.parameter.InstanceParameter;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Info_AccountRole extends ReceiveBase
	{
		public var guid: String;
		public var roleId: Int64;
		public var accountId: Int64;
		public var nickName: String;
		public var level: int = int.MIN_VALUE;
		public var accountCash: Int64;
		public var rolePicture: String;
		public var speed: Number = Number.MIN_VALUE;
		public var honor: int = int.MIN_VALUE;
		public var energy: int = int.MIN_VALUE;
		public var energyMax: int = int.MIN_VALUE;
		public var direction: int = int.MIN_VALUE;
		public var action: int = int.MIN_VALUE;
		public var mapId: int = int.MIN_VALUE;
		public var x: Number = Number.MIN_VALUE;
		public var y: Number = Number.MIN_VALUE;
		public var instanceList: Vector.<InstanceParameter>;
		
		public function Receive_Info_AccountRole()
		{
			super(SocketContextConfig.REGISTER_ACCOUNT_ROLE);
			
			instanceList = new Vector.<InstanceParameter>();
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				var parameter: InstanceParameter = new InstanceParameter();
				while (data.bytesAvailable > 8)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case TYPE_LONG:
							if (roleId == null)
							{
								roleId = new Int64();
								roleId.high = data.readInt();
								roleId.low = data.readUnsignedInt();
							}
							else if (accountId == null)
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
							else if(honor == int.MIN_VALUE)
							{
								honor = data.readInt();
							}
							else if(energy == int.MIN_VALUE)
							{
								energy = data.readInt();
							}
							else if(energyMax == int.MIN_VALUE)
							{
								energyMax = data.readInt();
							}
							else if(direction == int.MIN_VALUE)
							{
								direction = data.readInt();
							}
							else if(action == int.MIN_VALUE)
							{
								action = data.readInt();
							}
							else if(mapId == int.MIN_VALUE)
							{
								mapId = data.readInt();
							}
							else if(parameter.instanceId == int.MIN_VALUE)
							{
								parameter.instanceId = data.readInt();
							}
							else if(parameter.level == int.MIN_VALUE)
							{
								parameter.level = data.readInt();
							}
							break;
						case TYPE_FLOAT:
							if(speed == Number.MIN_VALUE)
							{
								speed = data.readFloat();
							}
							break;
						case TYPE_DOUBLE:
							if(x == Number.MIN_VALUE)
							{
								x = data.readDouble();
							}
							else if(y == Number.MIN_VALUE)
							{
								y = data.readDouble();
							}
							break;
					}
					if(parameter.instanceId != int.MIN_VALUE && parameter.level != int.MIN_VALUE)
					{
						instanceList.push(parameter);
						parameter = new InstanceParameter();
					}
				}
			}
		}
	}
}