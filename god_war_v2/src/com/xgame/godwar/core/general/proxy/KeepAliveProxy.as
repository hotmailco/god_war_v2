package com.xgame.godwar.core.general.proxy
{
	
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Info_HeartBeatEcho;
	import com.xgame.godwar.command.send.Send_Info_HeartBeat;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.TimerManager;
	import com.xgame.util.debug.Stats;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class KeepAliveProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "KeepAliveProxy";
		public static var delay_time: int = 0;
		
		private var sendProtocol: Send_Info_HeartBeat;
		
		public function KeepAliveProxy()
		{
			super(NAME, null);
			sendProtocol = new Send_Info_HeartBeat();
			
			ProtocolList.instance.bind(SocketContextConfig.INFO_HEART_BEAT_ECHO, Receive_Info_HeartBeatEcho);
			CommandManager.instance.add(SocketContextConfig.INFO_HEART_BEAT_ECHO, onHeartbeatEcho);
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
			if(CommandManager.instance.connected)
			{
				sendProtocol.flag++;
				CommandManager.instance.send(sendProtocol);
			}
		}
		
		private function onHeartbeatEcho(protocol: Receive_Info_HeartBeatEcho): void
		{
			if(sendProtocol.flag == protocol.flag)
			{
				var lastTime: Number = protocol.stamp.toNumber();
				var currentTime: Number = new Date().time;
				delay_time = currentTime - lastTime;
				Stats.ping = delay_time;
			}
		}
	}
}