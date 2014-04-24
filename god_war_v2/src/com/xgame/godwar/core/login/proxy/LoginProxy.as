package com.xgame.godwar.core.login.proxy
{
	
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Info_Account;
	import com.xgame.godwar.command.send.Send_Info_Login;
	import com.xgame.godwar.command.send.Send_Info_QuickStart;
	import com.xgame.godwar.command.send.Send_Info_Register;
	import com.xgame.godwar.config.GlobalContextConfig;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.login.command.ShowLoginMediatorCommand;
	import com.xgame.godwar.core.login.command.ShowRegisterMediatorCommand;
	import com.xgame.godwar.core.login.command.ShowServerMediatorCommand;
	import com.xgame.manager.CommandManager;
	import com.xgame.util.StringUtils;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class LoginProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "LoginProxy";
		
		public function LoginProxy(data:Object=null)
		{
			super(NAME, data);
			ProtocolList.getInstance().bind(SocketContextConfig.QUICK_START, Receive_Info_Account);
			CommandManager.getInstance().add(SocketContextConfig.QUICK_START, onAccount);
			
			ProtocolList.getInstance().bind(SocketContextConfig.INFO_LOGIN, Receive_Info_Account);
			CommandManager.getInstance().add(SocketContextConfig.INFO_LOGIN, onAccountLogin);
			
			ProtocolList.getInstance().bind(SocketContextConfig.INFO_REGISTER, Receive_Info_Account);
			CommandManager.getInstance().add(SocketContextConfig.INFO_REGISTER, onAccountRegister);
		}
		
		public function quickStart(): void
		{
			if(CommandManager.getInstance().connected)
			{
				sendNotification(LoadingIconMediator.SHOW_NOTE);
				
				var _protocol: Send_Info_QuickStart = new Send_Info_QuickStart();
				_protocol.GameId = GlobalContextConfig.GameId;
				CommandManager.getInstance().send(_protocol);
			}
		}
		
		public function login(userName: String, userPass: String): void
		{
			if(CommandManager.getInstance().connected && !StringUtils.empty(userName) && !StringUtils.empty(userPass))
			{
				sendNotification(LoadingIconMediator.SHOW_NOTE);
				
				var _protocol: Send_Info_Login = new Send_Info_Login();
				_protocol.userName = userName;
				_protocol.userPass = userPass;
				CommandManager.getInstance().send(_protocol);
			}
		}
		
		public function register(userName: String, userPass: String): void
		{
			if(CommandManager.getInstance().connected && !StringUtils.empty(userName) && !StringUtils.empty(userPass))
			{
				sendNotification(LoadingIconMediator.SHOW_NOTE);
				
				var _protocol: Send_Info_Register = new Send_Info_Register();
				_protocol.userName = userName;
				_protocol.userPass = userPass;
				CommandManager.getInstance().send(_protocol);
			}
		}
		
		private function onAccount(protocol: Receive_Info_Account): void
		{
			sendNotification(LoadingIconMediator.HIDE_NOTE);
			
			facade.registerCommand(ShowServerMediatorCommand.SHOW_NOTE, ShowServerMediatorCommand);
			sendNotification(ShowServerMediatorCommand.SHOW_NOTE);
			
			setData(protocol);
		}
		
		private function onAccountLogin(protocol: Receive_Info_Account): void
		{
			sendNotification(LoadingIconMediator.HIDE_NOTE);
			
			if(protocol.flag == -1)
			{
				facade.sendNotification(ShowLoginMediatorCommand.SHOW_NOTE);
				return;
			}
			facade.registerCommand(ShowServerMediatorCommand.SHOW_NOTE, ShowServerMediatorCommand);
			sendNotification(ShowServerMediatorCommand.SHOW_NOTE);
			
			setData(protocol);
		}
		
		private function onAccountRegister(protocol: Receive_Info_Account): void
		{
			sendNotification(LoadingIconMediator.HIDE_NOTE);
			
			if(protocol.flag == -1)
			{
				facade.sendNotification(ShowRegisterMediatorCommand.SHOW_NOTE);
				return;
			}
			facade.registerCommand(ShowServerMediatorCommand.SHOW_NOTE, ShowServerMediatorCommand);
			sendNotification(ShowServerMediatorCommand.SHOW_NOTE);
			
			setData(protocol);
		}
	}
}