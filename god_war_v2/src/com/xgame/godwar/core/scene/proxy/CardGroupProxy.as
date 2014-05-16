package com.xgame.godwar.core.scene.proxy
{
	
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Hall_RequestCardGroup;
	import com.xgame.godwar.command.send.Send_Hall_RequestCardGroup;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.scene.mediator.CardMediator;
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
	}
}