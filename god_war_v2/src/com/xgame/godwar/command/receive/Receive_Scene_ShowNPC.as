package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Scene_ShowNPC extends ReceiveBase
	{
		public var guid: String;
		public var id: int;
		public var resource: String;
		public var prependName: String;
		public var name: String;
		public var level: int;
		public var health: int;
		public var mana: int;
		public var direction: int;
		public var action: int;
		public var x: Number;
		public var y: Number;
		
		public function Receive_Scene_ShowNPC()
		{
			super(SocketContextConfig.SCENE_SHOW_NPC);
			id = int.MIN_VALUE;
			level = int.MIN_VALUE;
			health = int.MIN_VALUE;
			mana = int.MIN_VALUE;
			direction = int.MIN_VALUE;
			action = int.MIN_VALUE;
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
						case TYPE_STRING:
							if(StringUtils.empty(guid))
							{
								guid = data.readUTFBytes(length);
								break;
							}
							else if(StringUtils.empty(resource))
							{
								resource = data.readUTFBytes(length);
								break;
							}
							else if(StringUtils.empty(prependName))
							{
								prependName = data.readUTFBytes(length);
								break;
							}
							else if(StringUtils.empty(name))
							{
								name = data.readUTFBytes(length);
								break;
							}
							break;
						case TYPE_INT:
							if(id == int.MIN_VALUE)
							{
								id = data.readInt();
								break;
							}
							else if(level == int.MIN_VALUE)
							{
								level = data.readInt();
								break;
							}
							else if(health == int.MIN_VALUE)
							{
								health = data.readInt();
								break;
							}
							else if(mana == int.MIN_VALUE)
							{
								mana = data.readInt();
								break;
							}
							else if(direction == int.MIN_VALUE)
							{
								direction = data.readInt();
								break;
							}
							else if(action == int.MIN_VALUE)
							{
								action = data.readInt();
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