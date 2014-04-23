package com.xgame.godwar.core.login.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.xgame.godwar.core.general.mediator.BaseMediator;
	import com.xgame.godwar.core.login.command.ShowWelcomeMediatorCommand;
	import com.xgame.godwar.core.login.proxy.LoginProxy;
	
	import flash.events.MouseEvent;
	
	import game.ui.LoginViewUI;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoginMediator extends BaseMediator
	{
		public static const NAME: String = "LoginMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function LoginMediator()
		{
			super(NAME, new LoginViewUI());
			
			component.btnBack.addEventListener(MouseEvent.CLICK, onButtonBackClick);
			component.btnLogin.addEventListener(MouseEvent.CLICK, onButtonLoginClick);
		}
		
		public function get component(): LoginViewUI
		{
			return viewComponent as LoginViewUI;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE];
		}
		
		override public function handleNotification(notification: INotification):void
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
		
		private function onButtonBackClick(evt: MouseEvent): void
		{
			hide(function(): void
			{
				if(!facade.hasCommand(ShowWelcomeMediatorCommand.SHOW_NOTE))
				{
					facade.registerCommand(ShowWelcomeMediatorCommand.SHOW_NOTE, ShowWelcomeMediatorCommand);
				}
				facade.sendNotification(ShowWelcomeMediatorCommand.SHOW_NOTE);
			});
		}
		
		private function onButtonLoginClick(evt: MouseEvent): void
		{
			hide(function(): void
			{
				var _loginProxy: LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
				_loginProxy.login(component.iptName.text, component.iptPassword.text);
			});
		}
	}
}