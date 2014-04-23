package com.xgame.godwar.core.login.proxy
{
	
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Info_Account;
	import com.xgame.godwar.command.receive.Receive_Info_BindSession;
	import com.xgame.godwar.command.receive.Receive_Info_LogicServerBindSession;
	import com.xgame.godwar.command.send.Send_Info_BindSession;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.general.proxy.KeepAliveProxy;
	import com.xgame.godwar.core.login.command.RequestAccountRoleCommand;
	import com.xgame.manager.CommandManager;
	import com.xgame.util.debug.Debug;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class SessionProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "SessionProxy";

		public function SessionProxy()
		{
			super(NAME);
			
			if(!facade.hasCommand(RequestAccountRoleCommand.REQUEST_ACCOUNT_ROLE_NOTE))
			{
				facade.registerCommand(RequestAccountRoleCommand.REQUEST_ACCOUNT_ROLE_NOTE, RequestAccountRoleCommand);
			}
		}
		
		public function requestBindSession(): void
		{
			var _proxy: LoginProxy = facade.retrieveProxy(LoginProxy.NAME) as LoginProxy;
			if(_proxy != null)
			{
				var _protocol: Receive_Info_Account = _proxy.getData() as Receive_Info_Account;
				if(_protocol != null)
				{
					if(CommandManager.instance.connected)
					{
						sendNotification(LoadingIconMediator.SHOW_NOTE);
						
						ProtocolList.instance.bind(SocketContextConfig.INFO_BIND_SESSION, Receive_Info_BindSession);
						CommandManager.instance.add(SocketContextConfig.INFO_BIND_SESSION, onBindSession);
						
						var _send: Send_Info_BindSession = new Send_Info_BindSession();
						_send.accountName = _protocol.accountName;
						CommandManager.instance.send(_send);
					}
				}
				else
				{
					Debug.error(this, "LoginProxy.getData()为空，用户数据不存在");
				}
			}
			else
			{
				Debug.error(this, "LoginProxy未注册");
			}
		}
		
		private function onBindSession(protocol: Receive_Info_BindSession): void
		{
			if(protocol.result == 1)
			{
				setData(protocol);
				
				if(!facade.hasProxy(KeepAliveProxy.NAME))
				{
					var proxy: KeepAliveProxy = new KeepAliveProxy();
					facade.registerProxy(proxy);
					proxy.startHeatbeat();
				}
				facade.sendNotification(RequestAccountRoleCommand.REQUEST_ACCOUNT_ROLE_NOTE);
			}
		}
		
		public function requestLogicServerBindSession(): void
		{
//			var _proxy: RequestRoleProxy = facade.retrieveProxy(RequestRoleProxy.NAME) as RequestRoleProxy;
//			if(_proxy != null)
//			{
//				var _protocol: Receive_Info_AccountRole = _proxy.getData() as Receive_Info_AccountRole;
//				if(_protocol != null)
//				{
//					if(CommandManager.instance.connected)
//					{
//						sendNotification(LoadingIconMediator.SHOW_NOTE);
//						
//						ProtocolList.instance.bind(SocketContextConfig.INFO_LOGICSERVER_BIND_SESSION, Receive_Info_LogicServerBindSession);
//						CommandManager.instance.add(SocketContextConfig.INFO_LOGICSERVER_BIND_SESSION, onLogicServerBindSession);
//						
//						var _send: Send_Info_LogicServerBindSession = new Send_Info_LogicServerBindSession();
//						_send.guid = _protocol.guid;
//						CommandManager.instance.send(_send);
//					}
//				}
//				else
//				{
//					Debug.error(this, "LoginProxy.getData()为空，用户数据不存在");
//				}
//			}
//			else
//			{
//				Debug.error(this, "LoginProxy未注册");
//			}
		}
		
		private function onLogicServerBindSession(protocol: Receive_Info_LogicServerBindSession): void
		{
//			if(protocol.result == 1)
//			{
//				facade.sendNotification(LoadingIconMediator.HIDE_NOTE);
//				
////				if(!facade.hasProxy(KeepAliveProxy.NAME))
////				{
////					var proxy: KeepAliveProxy = new KeepAliveProxy();
////					facade.registerProxy(proxy);
////					proxy.startHeatbeat();
////				}
//				
//				if(!facade.hasCommand(ShowBattleGameMediatorCommand.SHOW_NOTE))
//				{
//					facade.registerCommand(ShowBattleGameMediatorCommand.SHOW_NOTE, ShowBattleGameMediatorCommand);
//				}
//				facade.sendNotification(ShowBattleGameMediatorCommand.SHOW_NOTE);
//			}
		}
	}
}