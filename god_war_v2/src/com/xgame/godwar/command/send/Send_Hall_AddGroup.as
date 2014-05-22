package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	public class Send_Hall_AddGroup extends SendBase
	{
		public var groupName: String;
		
		public function Send_Hall_AddGroup()
		{
			super(SocketContextConfig.INFO_CREATE_GROUP);
		}

		override public function fill():void
		{
			super.fill();
			
			_byteData.writeInt(groupName.length);
			_byteData.writeByte(TYPE_STRING);
			_byteData.writeUTF(groupName);
		}
	}
}