package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.util.UIUtils;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.CharacterDialog;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class CharacterMediator extends DialogMediator
	{
		public static const NAME: String = "CharacterMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function CharacterMediator()
		{
			super(NAME, new CharacterDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
			UIUtils.center(component, component.width, component.height);
		}
		
		public function get component(): CharacterDialog
		{
			return viewComponent as CharacterDialog;
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