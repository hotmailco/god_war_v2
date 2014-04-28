package com.xgame.godwar.command.receive
{
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.StringUtils;
	
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	public class Receive_Move_SendPath extends ReceiveBase
	{
		public var guid: String;
		public var path: Array;
		
		public function Receive_Move_SendPath()
		{
			super(SocketContextConfig.SEND_PATH);
		}
		
		override public function fill(data:ByteArray):void
		{
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				var x: int = int.MIN_VALUE;
				var y: int = int.MIN_VALUE;
				path = new Array();
				while (data.bytesAvailable > 8)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case TYPE_STRING:
							if(StringUtils(guid))
							{
								guid = data.readUTFBytes(length);
							}
							break;
						case TYPE_INT:
							if(x == int.MIN_VALUE)
							{
								x = data.readInt();
								break;
							}
							if(y == int.MIN_VALUE)
							{
								y = data.readInt();
								break;
							}
					}
					
					if(x != int.MIN_VALUE && y != int.MIN_VALUE)
					{
						path.push(new Point(x, y));
						x = int.MIN_VALUE;
						y = int.MIN_VALUE;
					}
				}
			}
		}
	}
}