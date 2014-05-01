package com.xgame.godwar.core
{
	
	import com.xgame.event.network.CommandEvent;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.login.command.ShowBackgroundMediatorCommand;
	import com.xgame.godwar.core.login.command.ShowWelcomeMediatorCommand;
	import com.xgame.manager.CommandManager;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitLoginSocketCommand extends SimpleCommand
	{
		public static const CONNECT_SOCKET_NOTE: String = "InitLoginSocketCommand.ConnectSocketNote";
		
		public function InitLoginSocketCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _commandCenter: CommandManager = CommandManager.instance;
			_commandCenter.close();
			_commandCenter.addEventListener(CommandEvent.CLOSED_EVENT, onClosed);
			_commandCenter.addEventListener(CommandEvent.CONNECTED_EVENT, onConnected);
			_commandCenter.addEventListener(CommandEvent.IOERROR_EVENT, onIOError);
			_commandCenter.addEventListener(CommandEvent.SECURITYERROR_EVENT, onSecurityError);
			_commandCenter.connect(SocketContextConfig.login_ip, SocketContextConfig.login_port);
			
			facade.sendNotification(LoadingIconMediator.SHOW_NOTE);
		}
		
		private function onClosed(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
		}
		
		private function onConnected(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			
			facade.sendNotification(LoadingIconMediator.HIDE_NOTE);
			facade.registerCommand(ShowBackgroundMediatorCommand.SHOW_NOTE, ShowBackgroundMediatorCommand);
			facade.registerCommand(ShowWelcomeMediatorCommand.SHOW_NOTE, ShowWelcomeMediatorCommand);
			facade.sendNotification(ShowBackgroundMediatorCommand.SHOW_NOTE, 0);
			facade.sendNotification(ShowWelcomeMediatorCommand.SHOW_NOTE);
		}
		
		private function onIOError(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			facade.sendNotification(LoadingIconMediator.HIDE_NOTE);
			
			onConnected(event);
		}
		
		private function onSecurityError(event: CommandEvent): void
		{
			facade.removeCommand(CONNECT_SOCKET_NOTE);
			facade.sendNotification(LoadingIconMediator.HIDE_NOTE);
		}
	}
}