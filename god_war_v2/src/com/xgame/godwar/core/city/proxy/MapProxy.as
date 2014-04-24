package com.xgame.godwar.core.city.proxy
{
	
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Base_VerifyMap;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.manager.CommandManager;
	import com.xgame.util.debug.Debug;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MapProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "MapProxy";
		
		public function MapProxy(data:Object=null)
		{
			super(NAME, data);
			ProtocolList.getInstance().bind(SocketContextConfig.BASE_VERIFY_MAP, Receive_Base_VerifyMap);
			CommandManager.getInstance().add(SocketContextConfig.BASE_VERIFY_MAP, onMapDataReceive);
		}
		
		private function onMapDataReceive(protocol: Receive_Base_VerifyMap): void
		{
			if(protocol.mapId != int.MIN_VALUE)
			{
				setData(protocol);
			}
			else
			{
				Debug.error(this, "地图验证信息错误，未获取到MapID");
			}
		}
	}
}