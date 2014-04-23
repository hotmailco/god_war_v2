package com.xgame.godwar.core.login.mediator
{
	import com.xgame.godwar.core.general.mediator.BaseMediator;
	import com.xgame.godwar.core.login.command.ShowWelcomeMediatorCommand;
	import com.xgame.godwar.core.login.proxy.LoginProxy;
	
	import flash.events.MouseEvent;
	
	import game.view.RegisterView;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class RegisterMediator extends BaseMediator
	{
		public static const NAME: String = "RegisterView";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function RegisterMediator()
		{
			super(NAME, new RegisterView());
			
			component.btnBack.addEventListener(MouseEvent.CLICK, onButtonBackClick);
			component.btnRegister.addEventListener(MouseEvent.CLICK, onButtonRegisterClick);
		}
		
		public function get component(): RegisterView
		{
			return viewComponent as RegisterView;
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
		
		private function onButtonRegisterClick(evt: MouseEvent): void
		{
			hide(function(): void
			{
				var _loginProxy: LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
				_loginProxy.register(component.iptName.text, component.iptPassword.text);
			});
		}
	}
}