package com.xgame.godwar.core.login.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.login.mediator.CreateRoleMediator;
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowCreateRoleMediatorCommand extends SimpleCommand
	{
		public static const SHOW_NOTE: String = "ShowCreateRoleMediatorCommand.ShowNote";
		
		public function ShowCreateRoleMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification):void
		{
			facade.removeCommand(SHOW_NOTE);
			
			if(!facade.hasProxy(RoleProxy.NAME))
			{
				facade.registerProxy(new RoleProxy());
			}
			
			var _mediator: CreateRoleMediator = facade.retrieveMediator(CreateRoleMediator.NAME) as CreateRoleMediator;
			if (_mediator != null)
			{
				facade.sendNotification(CreateRoleMediator.SHOW_NOTE);
			}
			else
			{
				facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
				ResourceManager.instance.load("login_ui_batch", null, onLoadComplete, onLoadProgress);
			}
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
			
			facade.registerMediator(new CreateRoleMediator());
			facade.sendNotification(CreateRoleMediator.SHOW_NOTE);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
	}
}