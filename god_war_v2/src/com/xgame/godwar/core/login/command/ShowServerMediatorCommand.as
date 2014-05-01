package com.xgame.godwar.core.login.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.InitGameSocketCommand;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.login.mediator.ServerMediator;
	import com.xgame.godwar.core.login.proxy.ServerListProxy;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowServerMediatorCommand extends SimpleCommand
	{
		public static const SHOW_NOTE: String = "ShowServerMediatorCommand.ShowNote";
		
		public function ShowServerMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification):void
		{
			facade.removeCommand(SHOW_NOTE);
			
			if(!facade.hasProxy(ServerListProxy.NAME))
			{
				facade.registerProxy(new ServerListProxy());
			}
			if(!facade.hasCommand(InitGameSocketCommand.CONNECT_SOCKET_NOTE))
			{
				facade.registerCommand(InitGameSocketCommand.CONNECT_SOCKET_NOTE, InitGameSocketCommand);
			}
			
			var _mediator: ServerMediator = facade.retrieveMediator(ServerMediator.NAME) as ServerMediator;
			if (_mediator != null)
			{
				facade.sendNotification(ServerMediator.SHOW_NOTE);
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
			
			facade.registerMediator(new ServerMediator());
			facade.sendNotification(ServerMediator.SHOW_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
	}
}