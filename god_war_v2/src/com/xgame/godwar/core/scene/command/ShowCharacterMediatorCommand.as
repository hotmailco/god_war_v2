package com.xgame.godwar.core.scene.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.scene.mediator.CardMediator;
	import com.xgame.godwar.core.scene.mediator.CharacterMediator;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowCharacterMediatorCommand extends SimpleCommand
	{
		public static const SHOW_NOTE: String = "ShowCharacterMediatorCommand.ShowNote";
		
		public function ShowCharacterMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification):void
		{
			var _mediator: CharacterMediator = facade.retrieveMediator(CharacterMediator.NAME) as CharacterMediator;
			if (_mediator != null)
			{
				facade.sendNotification(CharacterMediator.SHOW_NOTE);
			}
			else
			{
				facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
				ResourceManager.instance.load("scene_character_ui", null, onLoadComplete, onLoadProgress);
			}
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
			
			facade.registerMediator(new CharacterMediator());
			facade.sendNotification(CharacterMediator.SHOW_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
	}
}