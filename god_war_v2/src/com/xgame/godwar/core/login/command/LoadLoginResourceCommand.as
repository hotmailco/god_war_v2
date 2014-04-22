package com.xgame.godwar.core.login.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.InitLoginServerCommand;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.login.mediator.StartBackgroundMediator;
	import com.xgame.godwar.core.login.mediator.WelcomeMediator;
	import com.xgame.manager.LanguageManager;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadLoginResourceCommand extends SimpleCommand
	{
		public static const LOAD_NOTE: String = "LoadLoginResourceCommand.LoadNote";
		
		public function LoadLoginResourceCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			ResourceManager.instance.load("login_ui_batch", null, onLoadComplete, onLoadProgress, onLoadIOError);
			facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
			facade.sendNotification(LoaderMediator.SET_LOADER_TITLE_NOTE, LanguageManager.getInstance().lang("load_loagin_ui"));
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			facade.removeCommand(LOAD_NOTE);
			facade.registerCommand(InitLoginServerCommand.LOAD_NOTE, InitLoginServerCommand);
			facade.registerMediator(new WelcomeMediator());
			facade.registerMediator(new StartBackgroundMediator());
			
			facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
			facade.sendNotification(InitLoginServerCommand.LOAD_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
		
		private function onLoadIOError(evt: LoaderEvent): void
		{
			facade.sendNotification(LoaderMediator.SET_LOADER_TITLE_NOTE, evt.text);
		}
	}
}