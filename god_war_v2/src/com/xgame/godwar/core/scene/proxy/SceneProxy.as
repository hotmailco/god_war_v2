package com.xgame.godwar.core.scene.proxy
{
	
	import com.greensock.TweenLite;
	import com.xgame.common.display.InstancePortalDisplay;
	import com.xgame.common.display.NPCDisplay;
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.common.renders.Render;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.core.scene.Scene;
	import com.xgame.godwar.command.receive.Receive_Scene_RemoveInstancePortal;
	import com.xgame.godwar.command.receive.Receive_Scene_RemoveMapPortal;
	import com.xgame.godwar.command.receive.Receive_Scene_RemoveNPC;
	import com.xgame.godwar.command.receive.Receive_Scene_RemovePlayer;
	import com.xgame.godwar.command.receive.Receive_Scene_ShowInstancePortal;
	import com.xgame.godwar.command.receive.Receive_Scene_ShowMapPortal;
	import com.xgame.godwar.command.receive.Receive_Scene_ShowNPC;
	import com.xgame.godwar.command.receive.Receive_Scene_ShowPlayer;
	import com.xgame.godwar.command.receive.Receive_Scene_TriggerNPC;
	import com.xgame.godwar.command.send.Send_Base_UpdatePlayerStatus;
	import com.xgame.godwar.command.send.Send_Scene_TriggerNPC;
	import com.xgame.godwar.config.GlobalContextConfig;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	import com.xgame.godwar.core.scene.mediator.NPCMediator;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.ResourceManager;
	import com.xgame.util.debug.Debug;
	
	import flash.events.MouseEvent;
	
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
			
			CommandManager.instance.add(SocketContextConfig.SCENE_SHOW_NPC, onNPCShow);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_SHOW_NPC, Receive_Scene_ShowNPC);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_REMOVE_NPC, onNPCRemove);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_REMOVE_NPC, Receive_Scene_RemoveNPC);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_TRIGGER_NPC, onNPCTrigger);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_TRIGGER_NPC, Receive_Scene_TriggerNPC);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_SHOW_INSTANCE_PORTAL, onInstancePortalShow);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_SHOW_INSTANCE_PORTAL, Receive_Scene_ShowInstancePortal);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_REMOVE_INSTANCE_PORTAL, onInstancePortalRemove);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_REMOVE_INSTANCE_PORTAL, Receive_Scene_RemoveInstancePortal);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_SHOW_MAP_PORTAL, onMapPortalShow);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_SHOW_MAP_PORTAL, Receive_Scene_ShowMapPortal);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_REMOVE_MAP_PORTAL, onMapPortalRemove);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_REMOVE_MAP_PORTAL, Receive_Scene_RemoveMapPortal);
		}
		
		public function updatePlayerStatus(): void
		{
			var _p: RoleProxy = facade.retrieveProxy(RoleProxy.NAME) as RoleProxy;
			if(_p == null)
			{
				if(CONFIG::DebugMode)
				{
					Debug.error(this, "RequestRoleProxy为空，无法获取AccountId");
				}
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
		
		private function onNPCShow(protocol: Receive_Scene_ShowNPC): void
		{
			var npc: NPCDisplay = new NPCDisplay();
			npc.objectId = protocol.guid;
			npc.id = protocol.id;
			npc.prependName = protocol.prependName;
			npc.name = protocol.name;
			npc.level = protocol.level;
			npc.health = protocol.health;
			npc.mana = protocol.mana;
//			npc.direction = protocol.direction;
//			npc.action = protocol.action;
			npc.positionX = protocol.x;
			npc.positionY = protocol.y;
			npc.graphic = ResourceManager.instance.getResourceData(protocol.resource);
			var _render: Render = new Render();
			npc.render = _render;
			
			npc.addEventListener(MouseEvent.CLICK, onNPCClick);
			
			Scene.instance.addObject(npc);
		}
		
		private function onNPCClick(evt: MouseEvent): void
		{
//			if(CommandManager.instance.connected)
//			{
//				var npc: NPCDisplay = evt.currentTarget as NPCDisplay;
//				var protocol: Send_Scene_TriggerNPC = new Send_Scene_TriggerNPC();
//				protocol.guid = npc.objectId;
//				protocol.step = npc.dialogueStep;
//				CommandManager.instance.send(protocol);
//			}
		}
		
		private function onNPCRemove(protocol: Receive_Scene_RemoveNPC): void
		{
			var npc: NPCDisplay = Scene.instance.getDisplayByGuid(protocol.guid) as NPCDisplay;
			if(npc != null)
			{
				Scene.instance.removeObject(npc);
			}
		}
		
		private function onNPCTrigger(protocol: Receive_Scene_TriggerNPC): void
		{
			var npc: NPCDisplay = Scene.instance.getDisplayByGuid(protocol.guid) as NPCDisplay;
			facade.sendNotification(NPCMediator.SET_NPC, npc);
			facade.sendNotification(NPCMediator.SHOW_CONTENT, protocol.content);
			facade.sendNotification(NPCMediator.SHOW_NOTE);
		}
		
		private function onInstancePortalShow(protocol: Receive_Scene_ShowInstancePortal): void
		{
			var portal: InstancePortalDisplay = new InstancePortalDisplay();
			portal.objectId = protocol.guid;
			portal.loop = true;
			portal.graphic = ResourceManager.instance.getResourceData(protocol.resource, true);
			portal.positionX = protocol.x;
			portal.positionY = protocol.y;
			portal.instanceList = protocol.instance;
			var _render: Render = new Render();
			portal.render = _render;
			
			Scene.instance.addObject(portal);
		}
		
		private function onInstancePortalRemove(protocol: Receive_Scene_RemoveInstancePortal): void
		{
			var portal: InstancePortalDisplay = Scene.instance.getDisplayByGuid(protocol.guid) as InstancePortalDisplay;
			if(portal != null)
			{
				Scene.instance.removeObject(portal);
			}
		}
		
		private function onMapPortalShow(protocol: Receive_Scene_ShowMapPortal): void
		{
			
		}
		
		private function onMapPortalRemove(protocol: Receive_Scene_RemoveMapPortal): void
		{
			
		}
	}
}