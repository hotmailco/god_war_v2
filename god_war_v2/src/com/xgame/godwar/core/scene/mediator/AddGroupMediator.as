package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.AddGroupDialog;
	
	import org.puremvc.as3.interfaces.INotification;
	import com.xgame.godwar.core.scene.proxy.CardGroupProxy;
	
	public class AddGroupMediator extends DialogMediator
	{
		public static const NAME: String = "AddGroupMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function AddGroupMediator()
		{
			super(NAME, new AddGroupDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
			component.btnConfirm.addEventListener(MouseEvent.CLICK, onBtnConfirmClick);
		}
		
		public function get component(): AddGroupDialog
		{
			return viewComponent as AddGroupDialog;
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
		
		private function onBtnConfirmClick(evt: MouseEvent): void
		{
			if(component.iptName.text != "")
			{
				var proxy: CardGroupProxy = facade.retrieveProxy(CardGroupProxy.NAME) as CardGroupProxy;
				proxy.createGroup(component.iptName.text);
			}
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			hide();
		}
	}
}