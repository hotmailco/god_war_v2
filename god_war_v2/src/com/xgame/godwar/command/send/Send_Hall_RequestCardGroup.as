package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	public class Send_Hall_RequestCardGroup extends SendBase
	{
		public function Send_Hall_RequestCardGroup()
		{
			super(SocketContextConfig.INFO_REQUEST_CARD_GROUP);
		}
	}
}