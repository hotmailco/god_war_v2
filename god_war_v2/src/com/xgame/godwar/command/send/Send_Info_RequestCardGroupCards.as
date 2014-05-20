package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	public class Send_Info_RequestCardGroupCards extends SendBase
	{
		public var groupId: int;
		
		public function Send_Info_RequestCardGroupCards()
		{
			super(SocketContextConfig.INFO_REQUEST_CARD_GROUP_CARDS);
		}
		
		override public function fill():void
		{
			super.fill();
			
			_byteData.writeInt(4);
			_byteData.writeByte(TYPE_INT);
			_byteData.writeInt(groupId);
		}
	}
}