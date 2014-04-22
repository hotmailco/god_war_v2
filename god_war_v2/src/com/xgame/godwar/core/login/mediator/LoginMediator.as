package com.xgame.godwar.core.login.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.xgame.godwar.core.login.command.ShowWelcomeMediatorCommand;
	
	import flash.events.MouseEvent;
	
	import game.ui.LoginViewUI;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoginMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoginMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function LoginMediator()
		{
			super(NAME, new LoginViewUI());
			
			component.btnBack.addEventListener(MouseEvent.CLICK, onButtonBackClick);
		}
		
		public function get component(): LoginViewUI
		{
			return viewComponent as LoginViewUI;
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
					if(!UIManager.stage.contains(component))
					{
						UIManager.stage.addChild(component);
					}
					
					component.x = UIManager.stage.stageWidth;
					
					TweenLite.to(component, .5, {x: 0, ease: Strong.easeOut});
					break;
				case HIDE_NOTE:
					if(UIManager.stage.contains(component))
					{
						var callback: Function = notification.getBody() as Function;
						TweenLite.to(component, .5, {x: -UIManager.stage.stageWidth, ease: Strong.easeIn, onComplete: function(): void
						{
							component.remove();
							component.x = 0;
							if(callback != null)
							{
								callback();
							}
						}});
					}
					break;
			}
		}
		
		private function onButtonBackClick(evt: MouseEvent): void
		{
			facade.sendNotification(HIDE_NOTE, function(): void
			{
				if(!facade.hasCommand(ShowWelcomeMediatorCommand.SHOW_NOTE))
				{
					facade.registerCommand(ShowWelcomeMediatorCommand.SHOW_NOTE, ShowWelcomeMediatorCommand);
				}
				facade.sendNotification(ShowWelcomeMediatorCommand.SHOW_NOTE);
			});
		}
	}
}