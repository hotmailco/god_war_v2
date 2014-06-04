package com.xgame.godwar.core.scene.proxy
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.command.receive.Receive_Base_VerifyMap;
	import com.xgame.godwar.command.receive.Receive_Info_AccountRole;
	import com.xgame.godwar.command.receive.Receive_Scene_TriggerInstancePortal;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.core.login.proxy.RoleProxy;
	import com.xgame.godwar.manager.InstanceManager;
	import com.xgame.godwar.parameter.InstanceDataParameter;
	import com.xgame.godwar.parameter.InstanceEntranceParameter;
	import com.xgame.godwar.parameter.InstanceParameter;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.LanguageManager;
	import com.xgame.util.debug.Debug;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class MapProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "MapProxy";
		
		public function MapProxy(data:Object=null)
		{
			super(NAME, data);
			ProtocolList.instance.bind(SocketContextConfig.BASE_VERIFY_MAP, Receive_Base_VerifyMap);
			CommandManager.instance.add(SocketContextConfig.BASE_VERIFY_MAP, onMapDataReceive);
			
			CommandManager.instance.add(SocketContextConfig.SCENE_TRIGGER_INSTANCE_PORTAL, onInstancePortalTriiger);
			ProtocolList.instance.bind(SocketContextConfig.SCENE_TRIGGER_INSTANCE_PORTAL, Receive_Scene_TriggerInstancePortal);
		}
		
		public function getInstanceConfig(): void
		{
			var _loader: XMLLoader = new XMLLoader("config/" + LanguageManager.language + "/instances.xml", {onComplete: onInstanceConfig});
			_loader.load();
		}
		
		private function onInstanceConfig(evt: LoaderEvent): void
		{
			var _config: XML = (evt.currentTarget as XMLLoader).content;
			var parameter: InstanceDataParameter;
			var entrance: InstanceEntranceParameter;
			
			for(var i: int = 0; i < _config.instance.length(); i++)
			{
				parameter = new InstanceDataParameter();
				parameter.id = _config.instance[i].id;
				parameter.name = _config.instance[i].name;
				for(var j: int = 0; j<_config.instance[i].entrances.entrance.length(); j++)
				{
					entrance = new InstanceEntranceParameter();
					entrance.level = _config.instance[i].entrances.entrance[j].level;
					entrance.name = _config.instance[i].entrances.entrance[j].name;
					entrance.x = _config.instance[i].entrances.entrance[j].x;
					entrance.y = _config.instance[i].entrances.entrance[j].y;
					parameter.list.push(entrance);
				}
				InstanceManager.instance.addInstance(parameter);
			}
		}
		
		private function onMapDataReceive(protocol: Receive_Base_VerifyMap): void
		{
			if(protocol.mapId != int.MIN_VALUE)
			{
				setData(protocol);
			}
			else
			{
				if(CONFIG::DebugMode)
				{
					Debug.error(this, "地图验证信息错误，未获取到MapID");
				}
			}
		}
		
		private function onInstancePortalTriiger(protocol: Receive_Scene_TriggerInstancePortal): void
		{
			var roleProxy: RoleProxy = facade.retrieveProxy(RoleProxy.NAME) as RoleProxy;
			if(roleProxy != null)
			{
				var roleProtocol: Receive_Info_AccountRole = roleProxy.getData() as Receive_Info_AccountRole;
				var instanceList: Vector.<InstanceParameter> = new Vector.<InstanceParameter>();
				for(var i: int = 0; i<protocol.instanceList.length; i++)
				{
					if(roleProtocol.instanceIndex[protocol.instanceList[i]] != null)
					{
						instanceList.push(roleProtocol.instanceIndex[protocol.instanceList[i]]);
					}
				}
			}
		}
	}
}