package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.command.receive.Receive_Hall_RequestCardGroup;
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.godwar.core.scene.proxy.CardGroupProxy;
	import com.xgame.godwar.parameter.CardGroupParameter;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.CardDialog;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class CardMediator extends DialogMediator
	{
		public static const NAME: String = "CardMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		
		public function CardMediator()
		{
			super(NAME, new CardDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onButtonCloseClick);
			
			var test: Array = new Array();
			for(var i: int = 0; i<10; i++)
			{
				test.push({label: "test" + i});
			}
			component.lstGroup.array = test;
			
			if(!facade.hasProxy(CardGroupProxy.NAME))
			{
				facade.registerProxy(new CardGroupProxy());
			}
		}
		
		public function get component(): CardDialog
		{
			return viewComponent as CardDialog;
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
					show(function(): void
					{
						var callback: Function = notification.getBody() as Function;
						requestCardList(callback);
					});
					break;
				case HIDE_NOTE:
					hide(notification.getBody() as Function);
					break;
			}
		}
		
		private function onButtonCloseClick(evt: MouseEvent): void
		{
			hide();
		}
		
		private function requestCardList(callback: Function = null): void
		{
			var proxy: CardGroupProxy = facade.retrieveProxy(CardGroupProxy.NAME) as CardGroupProxy;
			if(proxy.getData() != null)
			{
				var protocol: Receive_Hall_RequestCardGroup = proxy.getData() as Receive_Hall_RequestCardGroup;
				showCardGroup(protocol.list);
			}
			else
			{
				proxy.requestCardGroup();
			}
		}
		
		private function showCardGroup(list: Vector.<CardGroupParameter>): void
		{
			var parameter: CardGroupParameter;
			for(var i: int = 0; i < list.length; i++)
			{
				parameter = list[i];
			}
		}
	}
}