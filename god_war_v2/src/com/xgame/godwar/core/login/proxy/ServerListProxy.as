package com.xgame.godwar.core.login.proxy
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.xgame.godwar.core.general.mediator.LoadingIconMediator;
	import com.xgame.godwar.core.login.mediator.ServerMediator;
	import com.xgame.godwar.parameter.ServerListParameter;
	import com.xgame.manager.LanguageManager;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class ServerListProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "ServerListProxy";
		
		public function ServerListProxy(data:Object=null)
		{
			super(NAME, data);
		}
		
		public function getServerList(): void
		{
			var _loader: XMLLoader = new XMLLoader("config/" + LanguageManager.language + "/server_list.xml", {onComplete: onGetServerList});
			_loader.load();
			
			sendNotification(LoadingIconMediator.SHOW_NOTE);
		}
		
		private function onGetServerList(evt: LoaderEvent): void
		{
			var _config: XML = (evt.currentTarget as XMLLoader).content;
			var _container: Vector.<ServerListParameter> = new Vector.<ServerListParameter>();
			
			for(var i: int = 0; i < _config.server.length(); i++)
			{
				var parameter: ServerListParameter = new ServerListParameter();
				parameter.id = _config.server[i].@id;
				parameter.name = _config.server[i].@name;
				parameter.ip = _config.server[i].@ip;
				parameter.port = _config.server[i].@port;
				parameter.recommand = _config.server[i].@recommand == "true";
				parameter.hot = _config.server[i].@hot == "true";
				_container.push(parameter);
			}
			setData(_container);
			
			//发送通知 显示区服列表
			sendNotification(LoadingIconMediator.HIDE_NOTE);
			sendNotification(ServerMediator.SHOW_LIST_NOTE);
		}
	}
}