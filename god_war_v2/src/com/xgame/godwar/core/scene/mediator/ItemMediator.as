package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.util.UIUtils;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.ItemDialog;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ItemMediator extends DialogMediator
	{
		public static const NAME: String = "ItemMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function ItemMediator()
		{
			super(NAME, new ItemDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
			UIUtils.center(component, component.width, component.height);
		}
		
		public function get component(): ItemDialog
		{
			return viewComponent as ItemDialog;
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
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			hide();
		}
	}
}