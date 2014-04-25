package com.xgame.godwar.core.login.mediator
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import game.ui.StartBackgroundViewUI;
	
	import morn.core.components.Image;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class StartBackgroundMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "StartBackgroundMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		private var currentBack: Image;
		
		public function StartBackgroundMediator()
		{
			super(NAME, new StartBackgroundViewUI());
			
			component.imgBack.alpha = 0;
		}
		
		public function get component(): StartBackgroundViewUI
		{
			return viewComponent as StartBackgroundViewUI;
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
//					if(!UIManager.uiLayer.contains(component))
//					{
//						UIManager.uiLayer.addChild(component);
//					}
//					component.visible = true;
//					hideCurrentBack();
//					
//					var id: int = int(notification.getBody());
//					if(id == 0)
//					{
//						currentBack = component.imgBack;
//					}
//					showCurrentBack();
					break;
				case HIDE_NOTE:
					if(UIManager.uiLayer.contains(component))
					{
						TweenLite.to(component, .5, {alpha: 0, onComplete: function(): void
						{
							component.remove();
							component.alpha = 1;
						}});
					}
					break;
			}
		}
		
		public function hideCurrentBack(): void
		{
			if(currentBack != null)
			{
				TweenLite.to(currentBack, .5, {alpha: 0, ease: Strong.easeOut, onComplete: function(): void
				{
					currentBack.remove();
					currentBack.alpha = 1;
				}});
			}
		}
		
		public function showCurrentBack(): void
		{
			if(currentBack != null)
			{
				currentBack.alpha = 0;
				if(!component.contains(currentBack))
				{
					component.addChild(currentBack);
				}
				TweenLite.to(currentBack, .5, {alpha: 1, ease: Strong.easeOut});
			}
		}
	}
}