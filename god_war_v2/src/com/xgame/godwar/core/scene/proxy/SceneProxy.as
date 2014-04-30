package com.xgame.godwar.core.scene.proxy
{
	
	import com.greensock.TweenLite;
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.common.renders.Render;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.core.scene.Scene;
	import com.xgame.godwar.command.receive.Receive_Scene_RemovePlayer;
	import com.xgame.godwar.command.receive.Receive_Scene_ShowPlayer;
	import com.xgame.godwar.command.send.Send_Base_UpdatePlayerStatus;
	import com.xgame.godwar.config.GlobalContextConfig;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.ResourceManager;
	import com.xgame.util.debug.Debug;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SceneProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "SceneProxy";
		
		public function SceneProxy(data:Object=null)
		{
			super(NAME, data);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_SHOW_PLAYER, onPlayerShow);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_SHOW_PLAYER, Receive_Scene_ShowPlayer);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_REMOVE_PLAYER, onPlayerRemove);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_REMOVE_PLAYER, Receive_Scene_RemovePlayer);
		}
		
		public function updatePlayerStatus(): void
		{
			var _p: RoleProxy = facade.retrieveProxy(RoleProxy.NAME) as RoleProxy;
			if(_p == null)
			{
				Debug.error(this, "RequestRoleProxy为空，无法获取AccountId");
				return;
			}
			var _protocol: Send_Base_UpdatePlayerStatus = new Send_Base_UpdatePlayerStatus();
			_protocol.roleId = _p.roleId;
			CommandManager.instance.send(_protocol);
		}
		
		private function onPlayerShow(protocol: Receive_Scene_ShowPlayer): void
		{
			var _player: PlayerDisplay = new PlayerDisplay();
			_player.objectId = protocol.guid;
			_player.accountId = protocol.accountId;
			_player.roleId = protocol.roleId;
			_player.name = protocol.nickName;
			_player.speed = protocol.speed / GlobalContextConfig.FrameRate;
			_player.positionX = protocol.x;
			_player.positionY = protocol.y;
			_player.graphic = ResourceManager.instance.getResourceData("assets.character.char4");
			var _render: Render = new Render();
			_player.render = _render;
			
			Scene.instance.addObject(_player);
		}
		
		private function onPlayerRemove(protocol: Receive_Scene_RemovePlayer): void
		{
			var player: PlayerDisplay = Scene.instance.getDisplayByGuid(protocol.guid) as PlayerDisplay;
			if(player != null)
			{
				TweenLite.to(player, .5, {alpha: 0, onComplete: function(): void
				{
					Scene.instance.removeObject(player);
				}});
			}
		}
	}
}