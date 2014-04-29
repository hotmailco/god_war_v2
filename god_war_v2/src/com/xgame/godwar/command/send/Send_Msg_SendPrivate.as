package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	public class Send_Msg_SendPrivate extends SendBase
	{
		public var guid: String;
		public var content: String;
		
		public function Send_Msg_SendPrivate()
		{
			super(SocketContextConfig.MSG_SEND_PRIVATE);
		}
		
		override public function fill():void
		{
			super.fill();
			
			_byteData.writeInt(guid.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(guid);
			
			_byteData.writeInt(content.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(content);
		}
	}
}