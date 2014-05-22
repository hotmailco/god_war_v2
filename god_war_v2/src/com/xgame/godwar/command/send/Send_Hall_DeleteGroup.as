package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	
	public class Send_Hall_DeleteGroup extends SendBase
	{
		public var groupId: int;
		
		public function Send_Hall_DeleteGroup()
		{
			super(SocketContextConfig.INFO_DELETE_GROUP);
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