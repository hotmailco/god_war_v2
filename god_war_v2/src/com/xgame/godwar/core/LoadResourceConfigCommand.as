package com.xgame.godwar.core
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.login.command.LoadLoginResourceCommand;
	import com.xgame.manager.LanguageManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class LoadResourceConfigCommand extends SimpleCommand
	{
		public static const LOAD_NOTE: String = "LoadResourceConfigCommand.LoadNote";
		
		public function LoadResourceConfigCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _loader: XMLLoader = new XMLLoader("config/" + LanguageManager.language + "/resources.xml", {name:"resourcesConfig", onComplete:onLoadComplete, onProgress: onLoadProgress, onError: onLoadIOError});
			_loader.load();
			facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
			facade.sendNotification(LoaderMediator.SET_LOADER_TITLE_NOTE, LanguageManager.getInstance().lang("load_resource_config"));
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			facade.removeCommand(LOAD_NOTE);
			facade.registerCommand(LoadLoginResourceCommand.LOAD_NOTE, LoadLoginResourceCommand);
			
			facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
			facade.sendNotification(LoadLoginResourceCommand.LOAD_NOTE);
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