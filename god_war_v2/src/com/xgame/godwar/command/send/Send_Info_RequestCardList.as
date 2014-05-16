package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	public class Send_Info_RequestCardList extends SendBase
	{
		public function Send_Info_RequestCardList()
		{
			super(SocketContextConfig.INFO_REQUEST_CARD_LIST);
		}
	}
}