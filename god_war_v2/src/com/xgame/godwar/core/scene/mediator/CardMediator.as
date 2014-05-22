package com.xgame.godwar.core.scene.mediator
{
	import com.xgame.godwar.command.receive.Receive_Hall_RequestCardGroup;
	import com.xgame.godwar.command.receive.Receive_Info_RequestCardList;
	import com.xgame.godwar.core.general.mediator.DialogMediator;
	import com.xgame.godwar.core.scene.proxy.CardGroupProxy;
	import com.xgame.godwar.core.scene.proxy.CardProxy;
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
		public static const ADD_GROUP_NOTE: String = NAME + ".AddGroupNote";
		public static const DELETE_GROUP_NOTE: String = NAME + ".DeleteGroupNote";
		
		private var _cardList: Vector.<SoulCardParameter>;
		private var _cardGroup: Vector.<CardGroupParameter>;
		private var _changedGroup: Vector.<CardGroupParameter>;
		private var _currentGroup: CardGroupParameter;
		private var _groupCardChanged: Boolean = false;
		
		public function CardMediator()
		{
			super(NAME, new CardDialog());
			
			component.btnClose.addEventListener(MouseEvent.CLICK, onButtonCloseClick);
			component.lstGroup.mouseHandler = new Handler(onItemGroupClick);
			component.lstStandby.mouseHandler = new Handler(onItemStandbyClick);
			component.btnAdd.addEventListener(MouseEvent.CLICK, onBtnAddClick);
			component.btnDelete.addEventListener(MouseEvent.CLICK, onBtnDeleteClick);
			
			component.lstGroup.array = [];
			component.lstChosen.array = [];
			component.lstStandby.array = [];
			
			if(!facade.hasMediator(AddGroupMediator.NAME))
			{
				facade.registerMediator(new AddGroupMediator());
			}
			if(!facade.hasMediator(DeleteGroupMediator.NAME))
			{
				facade.registerMediator(new DeleteGroupMediator());
			}
			if(!facade.hasProxy(CardGroupProxy.NAME))
			{
				facade.registerProxy(new CardGroupProxy());
			}
			
			_cardList = new Vector.<SoulCardParameter>();
			_changedGroup = new Vector.<CardGroupParameter>();
		}
		
		public function get component(): CardDialog
		{
			return viewComponent as CardDialog;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE, SHOW_CARD_GROUP_NOTE, SHOW_CARD_GROUP_CARDS_NOTE,
				ADD_GROUP_NOTE, DELETE_GROUP_NOTE];
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
				case ADD_GROUP_NOTE:
					addGroup(notification.getBody() as CardGroupParameter);
					break;
				case DELETE_GROUP_NOTE:
					deleteGroup(int(notification.getBody()));
					break;
			}
		}
		
		private function addGroup(parameter: CardGroupParameter): void
		{
			if(parameter != null && _cardGroup != null)
			{
				_cardGroup.push(parameter);
				showCardGroup(_cardGroup);
			}
		}
		
		private function deleteGroup(groupId: int): void
		{
			if(groupId > 0 && _cardGroup != null)
			{
				for(var i: int = 0; i < _cardGroup.length; i++)
				{
					if(_cardGroup[i].groupId == groupId)
					{
						_cardGroup.splice(i, 1);
						showCardGroup(_cardGroup);
						break;
					}
				}
			}
		}
		
		private function onItemGroupClick(evt: MouseEvent, index: int): void
		{
			if(evt.type == MouseEvent.CLICK && _cardGroup != null && index < _cardGroup.length)
			{
				var parameter: CardGroupParameter = _cardGroup[index];
				
				if(parameter.cardList == null)
				{
					var proxy: CardProxy = facade.retrieveProxy(CardProxy.NAME) as CardProxy;
					proxy.requestCardGroupCards(parameter.groupId);
				}
				else
				{
					showCardGroupCards(parameter.cardList);
				}
				
				_currentGroup = parameter;
			}
		}
		
		private function onItemStandbyClick(evt: MouseEvent, index: int): void
		{
			if(evt.type == MouseEvent.CLICK)
			{
				if(_currentGroup != null && _currentGroup.cardList != null)
				{
					if(index < _cardList.length)
					{
						var parameter: SoulCardParameter = _cardList[index];
						_cardList.splice(index, 1);
						_currentGroup.addCard(parameter);
						showCardGroupCards(_currentGroup.cardList);
						showStandbyCardList();
						
						_groupCardChanged = true;
						
						if(_changedGroup.indexOf(_currentGroup) < 0)
						{
							_changedGroup.push(_currentGroup);
						}
					}
				}
			}
		}
		
		private function onButtonCloseClick(evt: MouseEvent): void
		{
			hide();
			
			if(_groupCardChanged)
			{
				_groupCardChanged = false;
				var proxy: CardGroupProxy = facade.retrieveProxy(CardGroupProxy.NAME) as CardGroupProxy;
				if(proxy != null)
				{
					proxy.saveCardGroupCards(_changedGroup);
				}
			}
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
			
			showStandbyCardList();
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
		
		private function showStandbyCardList(): void
		{
			checkCardList();
			
			var parameter: SoulCardParameter;
			var cardArray: Array = new Array();
			for(var i: int = 0; i<_cardList.length; i++)
			{
				parameter = _cardList[i];
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
			
			showStandbyCardList();
		}
		
		private function checkCardList(): void
		{
			var cardProxy: CardProxy = facade.retrieveProxy(CardProxy.NAME) as CardProxy;
			if(cardProxy.getData() != null)
			{
				var cardProtocol: Receive_Info_RequestCardList = cardProxy.getData() as Receive_Info_RequestCardList;
				_cardList.splice(0, _cardList.length);
				for(var i: int = 0; i<cardProtocol.container.length; i++)
				{
					if(_currentGroup != null && _currentGroup.cardIndex[cardProtocol.container[i].guid.toString()] != null)
					{
						continue;
					}
					_cardList.push(cardProtocol.container[i]);
				}
			}
		}
		
		private function onBtnAddClick(evt: MouseEvent): void
		{
			facade.sendNotification(AddGroupMediator.SHOW_NOTE);
		}
		
		private function onBtnDeleteClick(evt: MouseEvent): void
		{
			if(_currentGroup != null)
			{
				facade.sendNotification(DeleteGroupMediator.SHOW_NOTE, _currentGroup);
			}
		}

		public function get cardGroup():Vector.<CardGroupParameter>
		{
			return _cardGroup;
		}


	}
}