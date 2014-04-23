package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;

	public class Send_Info_RequestAccountRole extends SendBase
	{
		public var GUID: Int64;
		
		public function Send_Info_RequestAccountRole()
		{
			super(SocketContextConfig.REQUEST_ACCOUNT_ROLE);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(8);
			_byteData.writeByte(TYPE_LONG);
			_byteData.writeInt(GUID.high);
			_byteData.writeUnsignedInt(GUID.low);
		}
	}
}