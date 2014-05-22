package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.godwar.core.scene.proxy.CardGroupProxy;
	import com.xgame.godwar.parameter.CardGroupParameter;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.DeleteGroupDialog;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class DeleteGroupMediator extends DialogMediator
	{
		public static const NAME: String = "DeleteGroupMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		private var _currentGroup: CardGroupParameter;
		
		public function DeleteGroupMediator()
		{
			super(NAME, new DeleteGroupDialog());
			
			component.btnConfirm.addEventListener(MouseEvent.CLICK, onBtnConfirmClick);
			component.btnCancel.addEventListener(MouseEvent.CLICK, onBtnCancelClick);
			component.btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
		}
		
		public function get component(): DeleteGroupDialog
		{
			return viewComponent as DeleteGroupDialog;
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
					_currentGroup = notification.getBody() as CardGroupParameter;
					if(_currentGroup != null)
					{
						component.lblContent.text = "确定要删除 [<font color='#FFFF00'>" + _currentGroup.groupName + "</font>] 卡组吗？";
						show();
					}
					break;
				case HIDE_NOTE:
					hide();
					break;
			}
		}
		
		private function onBtnConfirmClick(evt: MouseEvent): void
		{
			var proxy: CardGroupProxy = facade.retrieveProxy(CardGroupProxy.NAME) as CardGroupProxy;
			proxy.deleteGroup(_currentGroup.groupId);
		}
		
		private function onBtnCancelClick(evt: MouseEvent): void
		{
			hide();
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			hide();
		}
	}
}