package com.xgame.godwar.core.login.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.login.mediator.WelcomeMediator;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowWelcomeMediatorCommand extends SimpleCommand
	{
		public static const SHOW_NOTE: String = "ShowWelcomeMediatorCommand.ShowNote";
		
		public function ShowWelcomeMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification):void
		{
			facade.removeCommand(SHOW_NOTE);
			var _mediator: WelcomeMediator = facade.retrieveMediator(WelcomeMediator.NAME) as WelcomeMediator;
			if (_mediator != null)
			{
				facade.sendNotification(WelcomeMediator.SHOW_NOTE);
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
			
			facade.registerMediator(new WelcomeMediator());
			facade.sendNotification(WelcomeMediator.SHOW_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
	}
}