package com.xgame.godwar.core.login.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.login.mediator.StartBackgroundMediator;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowBackgroundMediatorCommand extends SimpleCommand
	{
		public static const SHOW_NOTE: String = "ShowBackgroundMediatorCommand.ShowNote";
		
		public function ShowBackgroundMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification):void
		{
			facade.removeCommand(SHOW_NOTE);
			var _mediator: StartBackgroundMediator = facade.retrieveMediator(StartBackgroundMediator.NAME) as StartBackgroundMediator;
			if (_mediator != null)
			{
				var id: int = 0;
				if(notification.getBody() != null)
				{
					id = int(notification.getBody());
				}
				facade.sendNotification(StartBackgroundMediator.SHOW_NOTE, id);
			}
			else
			{
				facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
				ResourceManager.instance.load("login_ui", null, onLoadComplete, onLoadProgress);
			}
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
			
			facade.registerMediator(new StartBackgroundMediator());
			facade.sendNotification(StartBackgroundMediator.SHOW_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
	}
}