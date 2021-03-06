package com.xgame.godwar.core
{
	import com.xgame.core.Camera;
	import com.xgame.core.scene.Scene;
	import com.xgame.event.scene.SceneEvent;
	import com.xgame.godwar.command.receive.Receive_Base_VerifyMap;
	import com.xgame.godwar.core.scene.command.ShowCardMediatorCommand;
	import com.xgame.godwar.core.scene.command.ShowCharacterMediatorCommand;
	import com.xgame.godwar.core.scene.command.ShowInstanceMediatorCommand;
	import com.xgame.godwar.core.scene.command.ShowItemMediatorCommand;
	import com.xgame.godwar.core.scene.command.ShowSceneMediatorCommand;
	import com.xgame.godwar.core.scene.mediator.NPCMediator;
	import com.xgame.godwar.core.scene.proxy.CardProxy;
	import com.xgame.godwar.core.scene.proxy.ChatProxy;
	import com.xgame.godwar.core.scene.proxy.MapProxy;
	import com.xgame.godwar.core.scene.proxy.SceneProxy;
	import com.xgame.util.debug.Debug;
	import com.xgame.util.debug.Stats;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitSceneCommand extends SimpleCommand
	{
		public static const INIT_SCENE_NOTE: String = "InitSceneCommand.InitSceneNote";
		
		public function InitSceneCommand()
		{
			super();
			
			if(!facade.hasCommand(StartGameCommand.START_GAME_NOTE))
			{
				facade.registerCommand(StartGameCommand.START_GAME_NOTE, StartGameCommand);
			}
			if(!facade.hasCommand(ShowSceneMediatorCommand.SHOW_NOTE))
			{
				facade.registerCommand(ShowSceneMediatorCommand.SHOW_NOTE, ShowSceneMediatorCommand);
			}
			if(!facade.hasCommand(ShowCharacterMediatorCommand.SHOW_NOTE))
			{
				facade.registerCommand(ShowCharacterMediatorCommand.SHOW_NOTE, ShowCharacterMediatorCommand);
			}
			if(!facade.hasCommand(ShowItemMediatorCommand.SHOW_NOTE))
			{
				facade.registerCommand(ShowItemMediatorCommand.SHOW_NOTE, ShowItemMediatorCommand);
			}
			if(!facade.hasCommand(ShowCardMediatorCommand.SHOW_NOTE))
			{
				facade.registerCommand(ShowCardMediatorCommand.SHOW_NOTE, ShowCardMediatorCommand);
			}
			if(!facade.hasCommand(ShowInstanceMediatorCommand.SHOW_NOTE))
			{
				facade.registerCommand(ShowInstanceMediatorCommand.SHOW_NOTE, ShowInstanceMediatorCommand);
			}
			if(!facade.hasProxy(CardProxy.NAME))
			{
				facade.registerProxy(new CardProxy());
			}
			if(!facade.hasProxy(SceneProxy.NAME))
			{
				facade.registerProxy(new SceneProxy());
			}
			if(!facade.hasMediator(NPCMediator.NAME))
			{
				facade.registerMediator(new NPCMediator());
			}
		}
		
		override public function execute(notification:INotification):void
		{
//			var _s: Starling = new Starling(Scene, UIManager.stage);
//			_s.start();
			var cardProxy: CardProxy = facade.retrieveProxy(CardProxy.NAME) as CardProxy;
			cardProxy.getConfig();
			cardProxy.requestCardList();
			var mapProxy: MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			mapProxy.getInstanceConfig();
			loadScene();
		}
		
		private function loadScene(): void
		{
			var _protocol: Receive_Base_VerifyMap;
			var _proxy: MapProxy = facade.retrieveProxy(MapProxy.NAME) as MapProxy;
			if(_proxy != null)
			{
				_protocol = _proxy.getData() as Receive_Base_VerifyMap;
			}
			if(_protocol == null)
			{
				if(CONFIG::DebugMode)
				{
					Debug.error(this, "没有获取到地图数据");
				}
				return;
			}
			
			var _scene: Scene = Scene.initialization(UIManager.stage, UIManager.sceneLayer);
			Camera.initialization(_scene);
			_scene.addEventListener(SceneEvent.SCENE_READY, onSceneReady);
			_scene.initializeMap(_protocol.mapId);
		}
		
		private function onSceneReady(evt: SceneEvent): void
		{
			loadDebug();
			
			var _scene: Scene = evt.currentTarget as Scene;
			_scene.removeEventListener(SceneEvent.SCENE_READY, onSceneReady);
			
			facade.sendNotification(ShowSceneMediatorCommand.SHOW_NOTE);
			facade.sendNotification(StartGameCommand.START_GAME_NOTE, _scene);
			
			if(!facade.hasProxy(ChatProxy.NAME))
			{
				facade.registerProxy(new ChatProxy());
			}
//			_proxy.updatePlayerStatus();
		}
		
		private function loadDebug(): void
		{
			var _debugLayer: Sprite = new Sprite();
			var _debugStats: Stats = new Stats();
			_debugLayer.addChild(_debugStats);
			UIManager.stage.addChild(_debugLayer);
		}
	}
}