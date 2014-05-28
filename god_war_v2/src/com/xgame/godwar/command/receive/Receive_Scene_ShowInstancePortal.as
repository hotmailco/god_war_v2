package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Scene_ShowInstancePortal extends ReceiveBase
	{
		public var guid: String;
		public var resource: String;
		public var x: Number;
		public var y: Number;
		public var instance: Vector.<int>;
		
		public function Receive_Scene_ShowInstancePortal()
		{
			super(SocketContextConfig.SCENE_SHOW_INSTANCE_PORTAL);
			x = Number.MIN_VALUE;
			y = Number.MIN_VALUE;
			instance = new Vector.<int>();
		}
		
		/**
		 * 
		 * @param data
		 * 
		 */
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				var instanceId: int = int.MIN_VALUE;
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
							break;
						case TYPE_INT:
							if(instanceId == int.MIN_VALUE)
							{
								instanceId = data.readInt();
								instance.push(instanceId);
								instanceId = int.MIN_VALUE;
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