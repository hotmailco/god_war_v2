package com.xgame.godwar.core
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.manager.LanguageManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitLoginServerCommand extends SimpleCommand
	{
		public static const LOAD_NOTE: String = "InitLoginServerCommand.LoadNote";
		
		public function InitLoginServerCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _loader: XMLLoader = new XMLLoader("config/" + LanguageManager.language + "/login_server.xml", {name:"loginServerConfig", onComplete:onLoadComplete, onProgress: onLoadProgress, onError: onLoadIOError});
			_loader.load();
			facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
			facade.sendNotification(LoaderMediator.SET_LOADER_TITLE_NOTE, LanguageManager.getInstance().lang("load_loagin_server_config"));
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			var _config: XML = (evt.currentTarget as XMLLoader).content;;
			
			if(_config.hasOwnProperty("server"))
			{
				SocketContextConfig.login_ip = _config.server[0].@ip;
				SocketContextConfig.login_port = parseInt(_config.server[0].@port);
				
				facade.removeCommand(LOAD_NOTE);
				facade.registerCommand(InitLoginSocketCommand.CONNECT_SOCKET_NOTE, InitLoginSocketCommand);
				
				facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
				facade.sendNotification(InitLoginSocketCommand.CONNECT_SOCKET_NOTE);
			}
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