package com.xgame.godwar.core.scene.proxy
{
	import com.xgame.common.behavior.PlayerBehavior;
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.core.scene.Scene;
	import com.xgame.godwar.command.receive.Receive_Move_RequestFindPath;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.manager.CommandManager;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MoveProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "MoveProxy";
		
		public function MoveProxy(data:Object=null)
		{
			super(NAME, data);
			
			CommandManager.instance.add(SocketContextConfig.REQUEST_FIND_PATH, onRequestFindPath);
			ProtocolList.instance.bind(SocketContextConfig.REQUEST_FIND_PATH, Receive_Move_RequestFindPath);
		}
		
		private function onRequestFindPath(protocol: Receive_Move_RequestFindPath): void
		{
			var player: PlayerDisplay = Scene.instance.player;
			var behavior: PlayerBehavior = player.behavior as PlayerBehavior;
			behavior.move(protocol.path);
		}
	}
}