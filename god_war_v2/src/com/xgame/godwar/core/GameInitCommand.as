package com.xgame.godwar.core
{
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.xgame.godwar.core.loader.mediator.LoaderMediator;
	
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class GameInitCommand extends SimpleCommand
	{
		public static const APP_START: String = "GameInitCommand.AppStartNote";
		
		public function GameInitCommand()
		{
			super();
			
			TweenPlugin.activate([TransformAroundCenterPlugin]);
		}
		
		override public function execute(notification:INotification):void
		{
			var _lc: LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			LoaderMax.activate([ImageLoader, SWFLoader]);
			LoaderMax.defaultContext = _lc;
			
			initCommand();
			initMediator();
			initProxy();
			
			facade.sendNotification(LoadResourceConfigCommand.LOAD_NOTE);
		}
		
		private function initCommand(): void
		{
			facade.registerCommand(LoadResourceConfigCommand.LOAD_NOTE, LoadResourceConfigCommand);
		}
		
		private function initMediator(): void
		{
			facade.registerMediator(new LoaderMediator());
		}
		
		private function initProxy(): void
		{
			
		}
	}
}