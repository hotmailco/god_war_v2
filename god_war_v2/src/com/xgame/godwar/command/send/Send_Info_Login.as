package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	public class Send_Info_Login extends SendBase
	{
		public var userName: String;
		public var userPass: String;
		
		public function Send_Info_Login()
		{
			super(SocketContextConfig.INFO_LOGIN);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(userName.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(userName);
			
			_byteData.writeInt(userPass.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(userPass);
		}
	}
}