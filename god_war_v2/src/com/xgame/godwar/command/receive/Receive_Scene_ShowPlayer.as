package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Scene_ShowPlayer extends ReceiveBase
	{
		public var guid: String;
		public var accountId: Int64;
		public var roleId: Int64;
		public var nickName: String;
		public var accountCash: Int64;
		public var direction: int;
		public var speed: Number;
		public var currentHealth: int;
		public var maxHealth: int;
		public var currentMana: int;
		public var maxMana: int;
		public var currentEnergy: int;
		public var maxEnergy: int;
		public var x: Number;
		public var y: Number;
		
		public function Receive_Scene_ShowPlayer()
		{
			super(SocketContextConfig.SCENE_SHOW_PLAYER);
			direction = int.MIN_VALUE;
			speed = Number.MIN_VALUE;
			currentHealth = int.MIN_VALUE;
			maxHealth = int.MIN_VALUE;
			currentMana = int.MIN_VALUE;
			maxMana = int.MIN_VALUE;
			currentEnergy = int.MIN_VALUE;
			maxEnergy = int.MIN_VALUE;
			x = Number.MIN_VALUE;
			y = Number.MIN_VALUE;
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
								break;
							}
							else if(roleId == null)
							{
								roleId = new Int64();
								roleId.high = data.readInt();
								roleId.low = data.readUnsignedInt();
								break;
							}
							else if(accountCash == null)
							{
								accountCash = new Int64();
								accountCash.high = data.readInt();
								accountCash.low = data.readUnsignedInt();
								break;
							}
						case TYPE_STRING:
							if(StringUtils.empty(guid))
							{
								guid = data.readUTFBytes(length);
								break;
							}
							else if(StringUtils.empty(nickName))
							{
								nickName = data.readUTFBytes(length);
								break;
							}
							break;
						case TYPE_INT:
							if(direction == int.MIN_VALUE)
							{
								direction = data.readInt();
								break;
							}
							else if(currentHealth == int.MIN_VALUE)
							{
								currentHealth = data.readInt();
								break;
							}
							else if(maxHealth == int.MIN_VALUE)
							{
								maxHealth = data.readInt();
								break;
							}
							else if(currentMana == int.MIN_VALUE)
							{
								currentMana = data.readInt();
								break;
							}
							else if(maxMana == int.MIN_VALUE)
							{
								maxMana = data.readInt();
								break;
							}
							else if(currentEnergy == int.MIN_VALUE)
							{
								currentEnergy = data.readInt();
								break;
							}
							else if(maxEnergy == int.MIN_VALUE)
							{
								maxEnergy = data.readInt();
								break;
							}
						case TYPE_FLOAT:
							if(speed == Number.MIN_VALUE)
							{
								speed = data.readFloat();
								break;
							}
						case TYPE_DOUBLE:
							if(x == Number.MIN_VALUE)
							{
								x = data.readDouble();
								break;
							}
							else if(y == Number.MIN_VALUE)
							{
								y = data.readDouble();
								break;
							}
					}
				}
			}
		}
	}
}