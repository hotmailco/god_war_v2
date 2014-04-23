package com.xgame.godwar.core.login.mediator
{
	import com.xgame.godwar.core.general.mediator.BaseMediator;
	
	import game.view.CreateRoleView;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class CreateRoleMediator extends BaseMediator
	{
		public static const NAME: String = "CreateRoleMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function CreateRoleMediator()
		{
			super(NAME, new CreateRoleView());
		}
		
		public function get component(): CreateRoleView
		{
			return viewComponent as CreateRoleView;
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
	}
}