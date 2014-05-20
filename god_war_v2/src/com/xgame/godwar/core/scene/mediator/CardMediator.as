package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.command.receive.Receive_Hall_RequestCardGroup;
	import com.xgame.godwar.command.receive.Receive_Info_RequestCardList;
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.godwar.core.general.proxy.CardProxy;
	import com.xgame.godwar.core.scene.proxy.CardGroupProxy;
	import com.xgame.godwar.parameter.CardGroupParameter;
	import com.xgame.godwar.parameter.card.SoulCardParameter;
	
	import flash.events.MouseEvent;
	
	import game.view.scene.CardDialog;
	
	import morn.core.handlers.Handler;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class CardMediator extends DialogMediator
	{
		public static const NAME: String = "CardMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		public static const SHOW_CARD_GROUP_NOTE: String = NAME + ".ShowCardGroupNote";
		public static const SHOW_CARD_GROUP_CARDS_NOTE: String = NAME + ".ShowCardGroupCardsNote";
		public static const SET_CURRENT_GROUP: String = NAME + ".SetCurrentGroup";
		
		private var _cardGroup: Vector.<CardGroupParameter>;
		private var currentCardGroup: int;
		
		public function CardMediator()
		{
			super(NAME, new CardDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onButtonCloseClick);
			component.lstGroup.mouseHandler = new Handler(onItemGroupClick);
			component.lstStandby.mouseHandler = new Handler(onItemStandbyClick);
			
			component.lstGroup.array = [];
			component.lstChosen.array = [];
			component.lstStandby.array = [];
			
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
			return [SHOW_NOTE, HIDE_NOTE, SHOW_CARD_GROUP_NOTE, SHOW_CARD_GROUP_CARDS_NOTE,
				SET_CURRENT_GROUP];
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
				case SHOW_CARD_GROUP_NOTE:
					showCardGroup(notification.getBody() as Vector.<CardGroupParameter>);
					break;
				case SHOW_CARD_GROUP_CARDS_NOTE:
					showCardGroupCards(notification.getBody() as Vector.<SoulCardParameter>);
					break;
				case SET_CURRENT_GROUP:
					currentCardGroup = int(notification.getBody());
					break;
			}
		}
		
		private function onItemGroupClick(evt: MouseEvent, index: int): void
		{
			if(evt.type == MouseEvent.CLICK && cardGroup != null && index < cardGroup.length)
			{
				var parameter: CardGroupParameter = cardGroup[index];
				
				if(parameter.cardList == null)
				{
					var proxy: CardProxy = facade.retrieveProxy(CardProxy.NAME) as CardProxy;
					proxy.requestCardGroupCards(parameter.groupId);
				}
				else
				{
					showCardGroupCards(parameter.cardList);
				}
				
				currentCardGroup = parameter.groupId;
			}
		}
		
		private function onItemStandbyClick(evt: MouseEvent, index: int): void
		{
			
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
			
			var cardProxy: CardProxy = facade.retrieveProxy(CardProxy.NAME) as CardProxy;
			if(cardProxy.getData() != null)
			{
				var cardProtocol: Receive_Info_RequestCardList = cardProxy.getData() as Receive_Info_RequestCardList;
				showStandbyCardList(cardProtocol.container);
			}
		}
		
		private function showCardGroup(list: Vector.<CardGroupParameter>): void
		{
			var parameter: CardGroupParameter;
			var groupArray: Array = new Array();
			for(var i: int = 0; i < list.length; i++)
			{
				parameter = list[i];
				groupArray.push({label: parameter.groupName});
			}
			component.lstGroup.array = groupArray;
			
			_cardGroup = list;
		}
		
		private function showStandbyCardList(list: Vector.<SoulCardParameter>): void
		{
			var parameter: SoulCardParameter;
			var cardArray: Array = new Array();
			for(var i: int = 0; i<list.length; i++)
			{
				parameter = list[i];
				cardArray.push({label: parameter.name});
			}
			component.lstStandby.array = cardArray;
		}
		
		private function showCardGroupCards(list: Vector.<SoulCardParameter>): void
		{
			var parameter: SoulCardParameter;
			var cardArray: Array = new Array();
			for(var i: int = 0; i<list.length; i++)
			{
				parameter = list[i];
				cardArray.push({label: parameter.name});
			}
			component.lstChosen.array = cardArray;
		}

		public function get cardGroup():Vector.<CardGroupParameter>
		{
			return _cardGroup;
		}

	}
}