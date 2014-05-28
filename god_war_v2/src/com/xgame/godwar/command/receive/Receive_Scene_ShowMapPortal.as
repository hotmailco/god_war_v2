package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;

	public class Receive_Scene_ShowMapPortal extends ReceiveBase
	{
		public var guid: String;
		public var resource: String;
		public var x: Number;
		public var y: Number;
		public var destinationMapId: int = int.MIN_VALUE;
		public var destinationX: int = int.MIN_VALUE;
		public var destinationY: int = int.MIN_VALUE;
		
		public function Receive_Scene_ShowMapPortal()
		{
			super(SocketContextConfig.SCENE_SHOW_MAP_PORTAL);
		}
		
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
							}
							else if(StringUtils.empty(resource))
							{
								resource = data.readUTFBytes(length);
							}
							break;
						case TYPE_INT:
							if(destinationMapId == int.MIN_VALUE)
							{
								destinationMapId = data.readInt();
							}
							else if(destinationX == int.MIN_VALUE)
							{
								destinationX = data.readInt();
							}
							else if(destinationY == int.MIN_VALUE)
							{
								destinationY = data.readInt();
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
				}
			}
		}
	}
}