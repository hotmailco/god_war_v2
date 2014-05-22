package com.xgame.godwar.core.scene.proxy
{
	
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Hall_AddGroup;
	import com.xgame.godwar.command.receive.Receive_Hall_DeleteGroup;
	import com.xgame.godwar.command.receive.Receive_Hall_RequestCardGroup;
	import com.xgame.godwar.command.send.Send_Hall_AddGroup;
	import com.xgame.godwar.command.send.Send_Hall_DeleteGroup;
	import com.xgame.godwar.command.send.Send_Hall_RequestCardGroup;
	import com.xgame.godwar.command.send.Send_Hall_SaveCardGroupCards;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.scene.mediator.AddGroupMediator;
	import com.xgame.godwar.core.scene.mediator.CardMediator;
	import com.xgame.godwar.core.scene.mediator.DeleteGroupMediator;
	import com.xgame.godwar.parameter.CardGroupParameter;
	import com.xgame.manager.CommandManager;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class CardGroupProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "CardGroupProxy";
		
		public function CardGroupProxy()
		{
			super(NAME, null);
			
			ProtocolList.instance.bind(SocketContextConfig.INFO_REQUEST_CARD_GROUP, Receive_Hall_RequestCardGroup);
			CommandManager.instance.add(SocketContextConfig.INFO_REQUEST_CARD_GROUP, onRequestCardGroup);
			
			ProtocolList.instance.bind(SocketContextConfig.INFO_CREATE_GROUP, Receive_Hall_AddGroup);
			CommandManager.instance.add(SocketContextConfig.INFO_CREATE_GROUP, onCreateGroup);
			
			ProtocolList.instance.bind(SocketContextConfig.INFO_DELETE_GROUP, Receive_Hall_DeleteGroup);
			CommandManager.instance.add(SocketContextConfig.INFO_DELETE_GROUP, onDeleteGroup);
		}
		
		public function requestCardGroup(): void
		{
			if(CommandManager.instance.connected)
			{
				sendNotification(LoadingIconMediator.SHOW_NOTE);
				
				var protocol: Send_Hall_RequestCardGroup = new Send_Hall_RequestCardGroup();
				CommandManager.instance.send(protocol);
			}
		}
		
		private function onRequestCardGroup(protocol: Receive_Hall_RequestCardGroup): void
		{
			sendNotification(LoadingIconMediator.HIDE_NOTE);
			sendNotification(CardMediator.SHOW_CARD_GROUP_NOTE, protocol.list);
			setData(protocol);
		}
		
		public function saveCardGroupCards(list: Vector.<CardGroupParameter>): void
		{
			if(CommandManager.instance.connected)
			{
				var protocol: Send_Hall_SaveCardGroupCards = new Send_Hall_SaveCardGroupCards();
				protocol.list = list;
				
				CommandManager.instance.send(protocol);
			}
		}
		
		public function createGroup(groupName: String): void
		{
			if(CommandManager.instance.connected)
			{
				var protocol: Send_Hall_AddGroup = new Send_Hall_AddGroup();
				protocol.groupName = groupName;
				
				CommandManager.instance.send(protocol);
			}
		}
		
		private function onCreateGroup(protocol: Receive_Hall_AddGroup): void
		{
			facade.sendNotification(AddGroupMediator.HIDE_NOTE);
			
			var parameter: CardGroupParameter = new CardGroupParameter();
			parameter.groupId = protocol.groupId;
			parameter.groupName = protocol.groupName;
			parameter.addCard(null);
			
			facade.sendNotification(CardMediator.ADD_GROUP_NOTE, parameter);
		}
		
		public function deleteGroup(groupId: int): void
		{
			if(CommandManager.instance.connected)
			{
				var protocol: Send_Hall_DeleteGroup = new Send_Hall_DeleteGroup();
				protocol.groupId = groupId;
				
				CommandManager.instance.send(protocol);
			}
		}
		
		private function onDeleteGroup(protocol: Receive_Hall_DeleteGroup): void
		{
			facade.sendNotification(DeleteGroupMediator.HIDE_NOTE);
			facade.sendNotification(CardMediator.DELETE_GROUP_NOTE, protocol.groupId);
		}
	}
}