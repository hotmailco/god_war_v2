package com.xgame.godwar.core.scene.proxy
{
	import com.xgame.common.display.PlayerDisplay;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.core.scene.Scene;
	import com.xgame.godwar.command.receive.Receive_Info_AccountRole;
	import com.xgame.godwar.command.receive.Receive_Msg_SendPublic;
	import com.xgame.godwar.command.send.Send_Msg_SendPublic;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	import com.xgame.godwar.manager.ChatBubbleManager;
	import com.xgame.manager.CommandManager;
	
	import flash.text.TextFieldAutoSize;
	
	import game.view.scene.ChatBubbleView;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ChatProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "ChatProxy";
		
		public function ChatProxy(data:Object=null)
		{
			super(NAME, data);
			
			ProtocolList.instance.bind(SocketContextConfig.MSG_SEND_PUBLIC, Receive_Msg_SendPublic);
			CommandManager.instance.add(SocketContextConfig.MSG_SEND_PUBLIC, onMessagePublic);
		}
		
		public function sendMessagePublic(value: String): void
		{
			if(CommandManager.instance.connected)
			{
				var _protocol: Send_Msg_SendPublic = new Send_Msg_SendPublic();
				_protocol.content = value;
				CommandManager.instance.send(_protocol);
			}
		}
		
		private function onMessagePublic(protocol: Receive_Msg_SendPublic): void
		{
			var proxy: RoleProxy = facade.retrieveProxy(RoleProxy.NAME) as RoleProxy;
			var p: Receive_Info_AccountRole = proxy.getData() as Receive_Info_AccountRole;
			if(protocol.guid == p.guid)
			{
				ChatBubbleManager.instance.showBubble(Scene.instance.player, protocol.content);
			}
			else
			{
				var player: PlayerDisplay = Scene.instance.getDisplayByGuid(protocol.guid) as PlayerDisplay;
				if(player != null)
				{
					ChatBubbleManager.instance.showBubble(player, protocol.content);
				}
			}
		}
	}
}