package com.xgame.godwar.core.login.command
{
	
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class RequestAccountRoleCommand extends SimpleCommand
	{
		public static const REQUEST_ACCOUNT_ROLE_NOTE: String = "RequestAccountRoleCommand.RequestAccountRoleNote";
		
		public function RequestAccountRoleCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _proxy: RoleProxy = facade.retrieveProxy(RoleProxy.NAME) as RoleProxy;
			if(_proxy == null)
			{
				_proxy = new RoleProxy();
				facade.registerProxy(_proxy);
			}
			_proxy.requestAccountRole();
		}
	}
}