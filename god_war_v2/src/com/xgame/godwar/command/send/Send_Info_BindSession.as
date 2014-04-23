package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	public class Send_Info_BindSession extends SendBase
	{
		public var accountName: String;
		
		public function Send_Info_BindSession()
		{
			super(SocketContextConfig.INFO_BIND_SESSION);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(accountName.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(accountName);
		}
	}
}