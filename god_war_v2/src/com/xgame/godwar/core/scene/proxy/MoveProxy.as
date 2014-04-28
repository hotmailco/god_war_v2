package com.xgame.godwar.core.scene.proxy
{
	import com.xgame.common.behavior.PlayerBehavior;
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.core.scene.Scene;
	import com.xgame.godwar.command.receive.Receive_Move_RequestFindPath;
	import com.xgame.godwar.command.receive.Receive_Move_Sync;
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
			
			CommandManager.instance.add(SocketContextConfig.SYNC_MOVE, onSyncMove);
			ProtocolList.instance.bind(SocketContextConfig.SYNC_MOVE, Receive_Move_Sync);
		}
		
		private function onRequestFindPath(protocol: Receive_Move_RequestFindPath): void
		{
			var player: PlayerDisplay = Scene.instance.player;
			var behavior: PlayerBehavior = player.behavior as PlayerBehavior;
			behavior.move(protocol.path);
		}
		
		private function onSyncMove(protocol: Receive_Move_Sync): void
		{
			Scene.instance.player.positionX = protocol.x;
			Scene.instance.player.positionY = protocol.y;
			trace("移动同步 x=" + protocol.x + ", y=" + protocol.y);
		}
	}
}