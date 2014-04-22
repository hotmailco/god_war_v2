package com.xgame.godwar.core.loader.mediator
{
	import game.ui.LoaderViewUI;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class LoaderMediator extends Mediator implements IMediator
	{
		public static const NAME: String = "LoaderMediator";
		
		public static const SHOW_LOADER_NOTE: String = NAME + ".ShowLoaderNote";
		public static const HIDE_LOADER_NOTE: String = NAME + ".HideLoaderNote";
		public static const SET_LOADER_TITLE_NOTE: String = NAME + ".SetLoaderTitleNote";
		public static const SET_LOADER_PERCENT_NOTE: String = NAME + ".SetLoaderPercentNote";
		
		public function LoaderMediator()
		{
			super(NAME, new LoaderViewUI());
		}
		
		public function get component(): LoaderViewUI
		{
			return viewComponent as LoaderViewUI;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_LOADER_NOTE, HIDE_LOADER_NOTE, SET_LOADER_TITLE_NOTE, SET_LOADER_PERCENT_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_LOADER_NOTE:
					if(!UIManager.stage.contains(component))
					{
						UIManager.stage.addChild(component);
					}
					component.visible = true;
					setZero();
					break;
				case HIDE_LOADER_NOTE:
					if(UIManager.stage.contains(component))
					{
						UIManager.stage.removeChild(component);
					}
					break;
				case SET_LOADER_TITLE_NOTE:
					var title: String = String(notification.getBody());
					component.lblMessage.text = title;
					break;
				case SET_LOADER_PERCENT_NOTE:
					var percent: Number = Number(notification.getBody());
					component.progress.value = percent;
					component.lblPercent.text = Math.floor(percent * 100) + "%";
					break;
			}
		}
		
		public function setZero(): void
		{
			component.progress.value = 0;
			component.lblPercent.text = "0%";
		}
	}
}