package com.xgame.godwar.core
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.xgame.common.behavior.PlayerBehavior;
	import com.xgame.common.display.BitmapDisplay;
	import com.xgame.common.display.NPCDisplay;
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.common.renders.Render;
	import com.xgame.core.Camera;
	import com.xgame.core.map.Map;
	import com.xgame.core.scene.Scene;
	import com.xgame.event.scene.InteractionEvent;
	import com.xgame.godwar.command.receive.Receive_Info_AccountRole;
	import com.xgame.godwar.command.send.Send_Move_RequestFindPath;
	import com.xgame.godwar.config.GlobalContextConfig;
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	import com.xgame.godwar.core.scene.proxy.MoveProxy;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.HotkeyCenter;
	import com.xgame.manager.ResourceManager;
	import com.xgame.manager.TimerManager;
	
	import flash.geom.Point;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import com.xgame.godwar.command.send.Send_Scene_TriggerNPC;
	
	public class StartGameCommand extends SimpleCommand
	{
		public static const START_GAME_NOTE: String = "StartGameCommand.StartGameNote";
		private var scene: Scene;
		
		public function StartGameCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			facade.registerProxy(new MoveProxy());
			scene = notification.getBody() as Scene;
			if(scene != null)
			{
				createPlayer();
				TimerManager.instance.add(33, render);
				HotkeyCenter.GlobalEnabled = true;
			}
		}
		
		private function render(): void
		{
			scene.update();
		}
		
		private function createPlayer(): void
		{
			var _proxy: RoleProxy = facade.retrieveProxy(RoleProxy.NAME) as RoleProxy;
			if(_proxy != null)
			{
				var _protocol: Receive_Info_AccountRole = _proxy.getData() as Receive_Info_AccountRole;
				if(_protocol != null)
				{
					var _player: PlayerDisplay = new PlayerDisplay(new PlayerBehavior());
					_player.objectId = _protocol.guid;
					_player.accountId = _protocol.accountId;
					_player.roleId = _protocol.roleId;
					_player.name = _protocol.nickName;
					_player.speed = _protocol.speed / GlobalContextConfig.FrameRate;
					_player.positionX = _protocol.x;
					_player.positionY = _protocol.y;
					_player.graphic = ResourceManager.instance.getResourceData("assets.character.char4");
					var _render: Render = new Render();
					_player.render = _render;
					scene.addObject(_player);
					scene.player = _player;
					
					Camera.instance.focus = _player;
					_player.behavior.addEventListener(InteractionEvent.SCENE_CLICK, onPlayerClick);
				}
			}
		}
		
		private function onPlayerClick(evt: InteractionEvent): void
		{
			var clicker: BitmapDisplay = evt.clicker;
			if(clicker == null)
			{
				if(CommandManager.instance.connected)
				{
					var endPoint: Point = Map.instance.getWorldPosition(evt.stageX, evt.stageY);
					var protocol: Send_Move_RequestFindPath = new Send_Move_RequestFindPath();
					protocol.startX = Scene.instance.player.positionX;
					protocol.startY = Scene.instance.player.positionY;
					protocol.endX = endPoint.x;
					protocol.endY = endPoint.y;
					
					CommandManager.instance.send(protocol);
//					MonsterDebugger.trace(this, "start x=" + Scene.instance.player.positionX + ", y=" + Scene.instance.player.positionY + ", end x=" + endPoint.x + ", y=" + endPoint.y);
				}
			}
			else if(clicker is NPCDisplay)
			{
				if(CommandManager.instance.connected)
				{
					var npc: NPCDisplay = clicker as NPCDisplay;
					var trigger: Send_Scene_TriggerNPC = new Send_Scene_TriggerNPC();
					trigger.guid = npc.objectId;
					trigger.step = npc.dialogueStep;
					CommandManager.instance.send(trigger);
				}
			}
		}
	}
}