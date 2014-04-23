package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;

	public class Send_Info_HeartBeat extends SendBase
	{
		public function Send_Info_HeartBeat()
		{
			super(SocketContextConfig.INFO_HEART_BEAT);
		}
	}
}