package com.xgame.godwar.core.general.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import game.view.LoadingIconView;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoadingIconMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoadingIconMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function LoadingIconMediator()
		{
			super(NAME, new LoadingIconView());
		}
		
		public function get component(): LoadingIconView
		{
			return viewComponent as LoadingIconView;
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
					show();
					break;
				case HIDE_NOTE:
					hide();
					break;
			}
		}
		
		private function show(): void
		{
			UIManager.stage.addChild(component);
			component.alpha = 0;
			TweenLite.to(component, .5, {alpha: 1, ease: Strong.easeOut});
		}
		
		private function hide(): void
		{
			TweenLite.to(component, .5, {alpha: 0, ease: Strong.easeOut, onComplete: function(): void
			{
				component.remove();
			}});
		}
	}
}