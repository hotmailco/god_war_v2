package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.godwar.event.SceneInstanceEvent;
	import com.xgame.godwar.parameter.InstanceParameter;
	import com.xgame.util.UIUtils;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.InstanceDialog;
	
	import org.puremvc.as3.interfaces.INotification;
	import com.xgame.godwar.parameter.InstanceEntranceParameter;
	
	public class InstanceMediator extends DialogMediator
	{
		public static const NAME: String = "InstanceMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		public static const SHOW_INSTANCE_NOTE: String = NAME + ".ShowEntranceNote";
		
		public function InstanceMediator()
		{
			super(NAME, new InstanceDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onBtnCloseClick);
			component.btnPrev.addEventListener(MouseEvent.CLICK, onBtnPrevClick);
			component.btnNext.addEventListener(MouseEvent.CLICK, onBtnNextClick);
			UIUtils.center(component, component.width, component.height);
			
			component.addEventListener(SceneInstanceEvent.ENTRANCE_CLICK_EVENT, onEntranceClick);
		}
		
		public function get component(): InstanceDialog
		{
			return viewComponent as InstanceDialog;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE, SHOW_INSTANCE_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					show(function(): void
					{
						var callback: Function = notification.getBody() as Function;
						callback.apply();
					});
					break;
				case HIDE_NOTE:
					hide();
					break;
				case SHOW_INSTANCE_NOTE:
					showInstance(notification.getBody() as Vector.<InstanceParameter>);
					break;
			}
		}
		
		private function onBtnCloseClick(evt: MouseEvent): void
		{
			hide();
		}
		
		private function onBtnPrevClick(evt: MouseEvent): void
		{
			component.prev();
		}
		
		private function onBtnNextClick(evt: MouseEvent): void
		{
			component.next();
		}
		
		private function showInstance(instanceList: Vector.<InstanceParameter>): void
		{
			component.instanceList = instanceList;
		}
		
		private function onEntranceClick(evt: SceneInstanceEvent): void
		{
			
		}
	}
}