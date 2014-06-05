package com.xgame.godwar.core.scene.command
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	import com.xgame.godwar.core.scene.mediator.InstanceMediator;
	import com.xgame.manager.ResourceManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class ShowInstanceMediatorCommand extends SimpleCommand
	{
		public static const SHOW_NOTE: String = "ShowInstanceMediatorCommand.ShowNote";
		
		public function ShowInstanceMediatorCommand()
		{
			super();
		}
		
		override public function execute(notification: INotification):void
		{
			var _mediator: InstanceMediator = facade.retrieveMediator(InstanceMediator.NAME) as InstanceMediator;
			if (_mediator != null)
			{
				facade.sendNotification(InstanceMediator.SHOW_NOTE, notification.getBody());
			}
			else
			{
				facade.sendNotification(LoaderMediator.SHOW_LOADER_NOTE);
				ResourceManager.instance.load("scene_instance_ui", {callback: notification.getBody()}, onLoadComplete, onLoadProgress);
			}
		}
		
		private function onLoadComplete(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.HIDE_LOADER_NOTE);
			
			facade.registerMediator(new InstanceMediator());
			facade.sendNotification(InstanceMediator.SHOW_NOTE, loader.vars.vars.callback);
		}
		
		private function onLoadProgress(evt: LoaderEvent): void
		{
			var loader: LoaderCore = evt.currentTarget as LoaderCore;
			facade.sendNotification(LoaderMediator.SET_LOADER_PERCENT_NOTE, loader.progress);
		}
	}
}