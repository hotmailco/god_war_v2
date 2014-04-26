package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.util.Int64;

	public class Send_Base_UpdatePlayerStatus extends SendBase
	{
		public var roleId: Int64;
		
		public function Send_Base_UpdatePlayerStatus()
		{
			super(SocketContextConfig.BASE_UPDATE_STATUS);
		}
		
		override public function fill():void
		{
			super.fill();
			
			if(roleId != null)
			{
				_byteData.writeInt(8);
				_byteData.writeByte(TYPE_LONG);
				_byteData.writeInt(roleId.high);
				_byteData.writeUnsignedInt(roleId.low);
			}
		}
	}
}