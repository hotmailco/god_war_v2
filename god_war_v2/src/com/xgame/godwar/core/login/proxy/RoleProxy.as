package com.xgame.godwar.core.login.proxy
{
	import com.greensock.events.LoaderEvent;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Info_Account;
	import com.xgame.godwar.command.receive.Receive_Info_AccountRole;
	import com.xgame.godwar.command.send.Send_Info_RegisterAccountRole;
	import com.xgame.godwar.command.send.Send_Info_RequestAccountRole;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.InitSceneCommand;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.login.command.ShowCreateRoleMediatorCommand;
	import com.xgame.godwar.core.login.mediator.CreateRoleMediator;
	import com.xgame.godwar.core.login.mediator.StartBackgroundMediator;
	import com.xgame.manager.CommandManager;
	import com.xgame.util.Int64;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class RoleProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "RequestRoleProxy";
		
		public var accountId: Int64;
		
		public function RoleProxy(data:Object=null)
		{
			super(NAME, data);
			
			if(!facade.hasCommand(ShowCreateRoleMediatorCommand.SHOW_NOTE))
			{
				facade.registerCommand(ShowCreateRoleMediatorCommand.SHOW_NOTE, ShowCreateRoleMediatorCommand);
			}
			if(!facade.hasCommand(InitSceneCommand.INIT_SCENE_NOTE))
			{
				facade.registerCommand(InitSceneCommand.INIT_SCENE_NOTE, InitSceneCommand);
			}
		}
		
		public function requestAccountRole(): void
		{
			if(CommandManager.instance.connected)
			{
				var protocol: Receive_Info_Account = facade.retrieveProxy(LoginProxy.NAME).getData() as Receive_Info_Account;
				if(protocol != null || protocol.GUID != null)
				{
					sendNotification(LoadingIconMediator.SHOW_NOTE);
					
					ProtocolList.instance.bind(SocketContextConfig.REQUEST_ACCOUNT_ROLE, Receive_Info_AccountRole);
					CommandManager.instance.add(SocketContextConfig.REQUEST_ACCOUNT_ROLE, onRequestAccountRole);
					
					var data: Send_Info_RequestAccountRole = new Send_Info_RequestAccountRole();
					data.GUID = protocol.GUID;
					CommandManager.instance.send(data);
				}
			}
		}
		
		private function onRequestAccountRole(protocol: Receive_Info_AccountRole): void
		{
			sendNotification(LoadingIconMediator.HIDE_NOTE);
//			facade.registerCommand(LoadAvatarConfigCommand.LOAD_NOTE, LoadAvatarConfigCommand);
			
			setData(protocol);
			accountId = protocol.accountId;
			
			if(protocol.accountId.toNumber() == -1)
			{
				facade.sendNotification(ShowCreateRoleMediatorCommand.SHOW_NOTE);
			}
			else
			{
//				facade.sendNotification(LoadAvatarConfigCommand.LOAD_NOTE);
				facade.sendNotification(CreateRoleMediator.HIDE_NOTE);
				facade.sendNotification(StartBackgroundMediator.HIDE_NOTE);
				facade.sendNotification(InitSceneCommand.INIT_SCENE_NOTE);
			}
		}
		
		public function registerAccountRole(roleName: String): void
		{
			if(CommandManager.instance.connected)
			{
				var protocol: Receive_Info_Account = facade.retrieveProxy(LoginProxy.NAME).getData() as Receive_Info_Account;
				if(protocol != null || protocol.GUID != null)
				{
					sendNotification(LoadingIconMediator.SHOW_NOTE);
					
					ProtocolList.instance.bind(SocketContextConfig.REGISTER_ACCOUNT_ROLE, Receive_Info_AccountRole);
					CommandManager.instance.add(SocketContextConfig.REGISTER_ACCOUNT_ROLE, onRegisterAccountRole);
					
					var data: Send_Info_RegisterAccountRole = new Send_Info_RegisterAccountRole();
					data.GUID = protocol.GUID;
					data.nickName = roleName;
					CommandManager.instance.send(data);
				}
			}
		}
		
		private function onRegisterAccountRole(protocol: Receive_Info_AccountRole): void
		{
			sendNotification(LoadingIconMediator.HIDE_NOTE);
			
			setData(protocol);
			accountId = protocol.accountId;
			
			facade.sendNotification(CreateRoleMediator.HIDE_NOTE);
			facade.sendNotification(StartBackgroundMediator.HIDE_NOTE);
			facade.sendNotification(InitSceneCommand.INIT_SCENE_NOTE);
		}
	}
}