package com.xgame.godwar.core.login.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.xgame.godwar.core.general.mediator.BaseMediator;
	import com.xgame.godwar.core.login.command.ShowLoginMediatorCommand;
	import com.xgame.godwar.core.login.command.ShowRegisterMediatorCommand;
	import com.xgame.util.UIUtils;
	
	import flash.events.MouseEvent;
	
	import game.ui.StartViewUI;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class WelcomeMediator extends BaseMediator
	{
		public static const NAME: String = "WelcomeMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function WelcomeMediator()
		{
			super(NAME, new StartViewUI());
			
			component.btnStart.addEventListener(MouseEvent.CLICK, onButtonStartClick);
			component.btnLogin.addEventListener(MouseEvent.CLICK, onButtonLoginClick);
			component.btnRegister.addEventListener(MouseEvent.CLICK, onButtonRegisterClick);
		}
		
		public function get component(): StartViewUI
		{
			return viewComponent as StartViewUI;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					show(notification.getBody() as Function);
					break;
				case HIDE_NOTE:
					hide(notification.getBody() as Function);
					break;
			}
		}
		
		override protected function show(callback:Function=null):void
		{
			if(!UIManager.uiLayer.contains(component))
			{
				UIManager.uiLayer.addChild(component);
			}
			
			component.btnStart.scale = 2;
			UIUtils.center(component.btnStart);
			
			component.btnStart.alpha = 0;
			component.btnRegister.y += 50;
			component.btnRegister.alpha = 0;
			component.btnLogin.y += 50;
			component.btnLogin.alpha = 0;
			
			TweenLite.to(component.btnStart, .5, {transformAroundCenter: { scale: 1, alpha: 1 }, ease: Strong.easeOut});
			TweenLite.to(component.btnRegister, .5, {delay: .3, y: "-50", alpha: 1, ease: Strong.easeOut});
			TweenLite.to(component.btnLogin, .5, {delay: .4, y: "-50", alpha: 1, ease: Strong.easeOut});
		}
		
		private function onButtonStartClick(evt: MouseEvent): void
		{
			
		}
		
		private function onButtonLoginClick(evt: MouseEvent): void
		{
			hide(function(): void
			{
				if(!facade.hasCommand(ShowLoginMediatorCommand.SHOW_NOTE))
				{
					facade.registerCommand(ShowLoginMediatorCommand.SHOW_NOTE, ShowLoginMediatorCommand);
				}
				facade.sendNotification(ShowLoginMediatorCommand.SHOW_NOTE);
			});
		}
		
		private function onButtonRegisterClick(evt: MouseEvent): void
		{
			hide(function(): void
			{
				if(!facade.hasCommand(ShowRegisterMediatorCommand.SHOW_NOTE))
				{
					facade.registerCommand(ShowRegisterMediatorCommand.SHOW_NOTE, ShowRegisterMediatorCommand);
				}
				facade.sendNotification(ShowRegisterMediatorCommand.SHOW_NOTE);
			});
		}
	}
}