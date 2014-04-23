package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	/**
	 * ...
	 * @author johnnyeven
	 */
	public class Send_Info_QuickStart extends SendBase 
	{
		public var GameId: int;
		
		public function Send_Info_QuickStart() 
		{
			super(SocketContextConfig.QUICK_START);
		}
		
		override public function fill():void 
		{
			super.fill();
			
			_byteData.writeInt(4);
			_byteData.writeByte(TYPE_INT);
			_byteData.writeInt(GameId);
		}
	}

}