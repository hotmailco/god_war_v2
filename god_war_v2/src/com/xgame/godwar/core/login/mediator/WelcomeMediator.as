package com.xgame.godwar.core.login.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.xgame.util.UIUtils;
	
	import flash.events.MouseEvent;
	
	import game.ui.StartViewUI;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class WelcomeMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "WelcomeMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function WelcomeMediator()
		{
			super(NAME, new StartViewUI());
			
			component.btnStart.scale = 2;
			UIUtils.center(component.btnStart);
			
			component.btnStart.alpha = 0;
			component.btnRegister.y += 50;
			component.btnRegister.alpha = 0;
			component.btnLogin.y += 50;
			component.btnLogin.alpha = 0;
			component.btnStart.addEventListener(MouseEvent.CLICK, onButtonStartClick);
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
					if(!UIManager.stage.contains(component))
					{
						UIManager.stage.addChild(component);
					}
					
					TweenLite.to(component.btnStart, .5, {transformAroundCenter: { scale: 1, alpha: 1 }, ease: Strong.easeOut});
					TweenLite.to(component.btnRegister, .5, {delay: .3, y: "-50", alpha: 1, ease: Strong.easeOut});
					TweenLite.to(component.btnLogin, .5, {delay: .4, y: "-50", alpha: 1, ease: Strong.easeOut});
					break;
				case HIDE_NOTE:
					
					break;
			}
		}
		
		private function onButtonStartClick(evt: MouseEvent): void
		{
			
		}
	}
}