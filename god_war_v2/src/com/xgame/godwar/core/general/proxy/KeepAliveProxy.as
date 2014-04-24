package com.xgame.godwar.core.general.proxy
{
	
	import com.xgame.godwar.command.send.Send_Info_HeartBeat;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.TimerManager;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class KeepAliveProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "KeepAliveProxy";
		private var sendProtocol: Send_Info_HeartBeat;
		
		public function KeepAliveProxy()
		{
			super(NAME, null);
			sendProtocol = new Send_Info_HeartBeat();
		}
		
		public function startHeatbeat(): void
		{
			TimerManager.instance.add(5000, onHeartbeat);
		}
		
		public function stopHearbeat(): void
		{
			TimerManager.instance.remove(onHeartbeat);
		}
		
		private function onHeartbeat(): void
		{
			if(CommandManager.getInstance().connected)
			{
				CommandManager.getInstance().send(sendProtocol);
			}
		}
	}
}