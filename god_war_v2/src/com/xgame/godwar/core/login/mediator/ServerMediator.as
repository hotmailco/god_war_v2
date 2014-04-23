package com.xgame.godwar.core.login.mediator
{
	import com.xgame.godwar.core.InitGameSocketCommand;
	import com.xgame.godwar.core.general.mediator.BaseMediator;
	import com.xgame.godwar.core.login.proxy.ServerListProxy;
	import com.xgame.godwar.parameter.ServerListParameter;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import game.ui.ServerViewUI;
	import game.view.ServerListView;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ServerMediator extends BaseMediator
	{
		public static const NAME: String = "ServerMediator";
		
		public static const SHOW_NOTE: String = NAME + ".ShowNote";
		public static const HIDE_NOTE: String = NAME + ".HideNote";
		public static const SHOW_LIST_NOTE: String = NAME + ".ShowListNote";
		
		public function ServerMediator()
		{
			super(NAME, new ServerViewUI());
		}
		
		public function get component(): ServerViewUI
		{
			return viewComponent as ServerViewUI;
		}
		
		override public function listNotificationInterests():Array
		{
			return [SHOW_NOTE, HIDE_NOTE, SHOW_LIST_NOTE];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case SHOW_NOTE:
					show(function (): void
					{
						requestServerList();
						
						var callback: Function = notification.getBody() as Function;
						if(callback != null)
						{
							callback();
						}
					});
					break;
				case HIDE_NOTE:
					hide(notification.getBody() as Function);
					break;
				case SHOW_LIST_NOTE:
					showServerList();
					break;
			}
		}
		
		private function requestServerList(): void
		{
			var proxy: ServerListProxy = facade.retrieveProxy(ServerListProxy.NAME) as ServerListProxy;
			if(proxy == null)
			{
				proxy = new ServerListProxy();
				facade.registerProxy(proxy);
			}
			proxy.getServerList();
		}
		
		private function showServerList(): void
		{
			var proxy: ServerListProxy = facade.retrieveProxy(ServerListProxy.NAME) as ServerListProxy;
			var container: Vector.<ServerListParameter> = proxy.getData() as Vector.<ServerListParameter>;
			
			if(container != null && container.length > 0)
			{
				var offsetX: int = 70;
				var offsetY: int = 0;
				var point1: Point = new Point(0, 0);
				for(var i: int = 0; i<container.length; i++)
				{
					var _item: ServerListView = new ServerListView();
					
					_item.x = point1.x;
					_item.y = point1.y;
					
					_item.lblName.text = container[i].name;
					_item.imgStatusNormal.visible = false;
					_item.imgStatusHot.visible = false;
					_item.imgStatusBusy.visible = false;
					_item.parameter = container[i];
					
					if(container[i].hot)
					{
						_item.imgStatusHot.visible = true;
					}
					else
					{
						_item.imgStatusNormal.visible = true;
					}
					
					if(!container[i].recommand)
					{
						_item.imgHot.visible = false;
					}
					
					if((i-1) % 2 == 0)
					{
						point1.x = 160;
						point1.y += _item.height + offsetY;
					}
					else
					{
						point1.x += _item.width + offsetX;
					}
					
					component.container.addChild(_item);
					_item.addEventListener(MouseEvent.CLICK, onItemClick);
				}
			}
		}
		
		private function onItemClick(evt: MouseEvent): void
		{
			var item: ServerListView = evt.currentTarget as ServerListView;
			if(item != null)
			{
				facade.sendNotification(InitGameSocketCommand.CONNECT_SOCKET_NOTE, item.parameter);
			}
		}
	}
}