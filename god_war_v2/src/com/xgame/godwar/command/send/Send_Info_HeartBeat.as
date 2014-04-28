package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	public class Send_Info_HeartBeat extends SendBase
	{
		public var flag: int = 0;
		
		public function Send_Info_HeartBeat()
		{
			super(SocketContextConfig.INFO_HEART_BEAT);
		}
		
		override public function fill():void
		{
			super.fill();
			_byteData.writeInt(4);
			_byteData.writeByte(TYPE_INT);
			_byteData.writeInt(flag);
		}
	}
}