package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	public class Send_Msg_SendWorld extends SendBase
	{
		public var content: String;
		
		public function Send_Msg_SendWorld()
		{
			super(SocketContextConfig.MSG_SEND_WORLD);
		}
		
		override public function fill():void
		{
			super.fill();
			
			_byteData.writeInt(content.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(content);
		}
	}
}