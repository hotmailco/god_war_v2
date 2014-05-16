package com.xgame.godwar.core.general.proxy
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.XMLLoader;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.godwar.common.pool.CardParameterPool;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.parameter.card.SoulCardParameter;
	import com.xgame.manager.CommandManager;
	import com.xgame.manager.LanguageManager;
	
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import com.xgame.godwar.command.receive.Receive_Info_RequestCardList;
	import com.xgame.godwar.command.send.Send_Info_RequestCardList;
	
	public class CardProxy extends Proxy implements IProxy
	{
		public static const NAME: String = "CardProxy";
		
		public function CardProxy()
		{
			super(NAME, null);
			
			ProtocolList.instance.bind(SocketContextConfig.INFO_REQUEST_CARD_LIST, Receive_Info_RequestCardList);
			CommandManager.instance.add(SocketContextConfig.INFO_REQUEST_CARD_LIST, onRequestCardList);
		}
		
		public function getConfig(): void
		{
			var _loader: XMLLoader = new XMLLoader("config/" + LanguageManager.language + "/soul_card_config.xml", {onComplete: onGetSoulConfig});
			_loader.load();
		}
		
		private function onGetSoulConfig(evt: LoaderEvent): void
		{
			var _config: XML = (evt.currentTarget as XMLLoader).content;
			var parameter: SoulCardParameter;
			
			for(var i: int = 0; i < _config.card.length(); i++)
			{
				parameter = new SoulCardParameter();
				parameter.id = _config.card[i].id;
				parameter.resourceClass = _config.card[i].resource_id;
				parameter.name = _config.card[i].name;
				parameter.attack = _config.card[i].attack;
				parameter.def = _config.card[i].def;
				parameter.mdef = _config.card[i].mdef;
				parameter.health = _config.card[i].health;
				parameter.energy = _config.card[i].energy;
				parameter.level = _config.card[i].level;
				parameter.race = _config.card[i].race;
				for(var j: int = 0; j < _config.card[i].skills.skill.length(); j++)
				{
					parameter.skillList.push(_config.card[i].skills.skill[j]);
				}
				CardParameterPool.instance.add(parameter.id, parameter);
			}
		}
		
		public function requestCardList(): void
		{
			var protocol: Send_Info_RequestCardList = new Send_Info_RequestCardList();
			
			CommandManager.instance.send(protocol);
		}
		
		private function onRequestCardList(protocol: Receive_Info_RequestCardList): void
		{
			setData(protocol);
		}
	}
}