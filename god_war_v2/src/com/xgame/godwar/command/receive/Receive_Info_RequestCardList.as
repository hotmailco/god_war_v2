package com.xgame.godwar.command.receive
{
	
	import com.xgame.core.protocol.ReceiveBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.parameter.card.SoulCardParameter;
	import com.xgame.util.Int64;
	import com.xgame.util.StringUtils;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class Receive_Info_RequestCardList extends ReceiveBase
	{
		public var container: Vector.<SoulCardParameter>;
		public var index: Dictionary;
		
		public function Receive_Info_RequestCardList()
		{
			super(SocketContextConfig.INFO_REQUEST_CARD_LIST);
			
			container = new Vector.<SoulCardParameter>();
			index = new Dictionary();
		}
		
		override public function fill(data:ByteArray):void
		{
			
			super.fill(data);
			
			if (message == ACK_CONFIRM)
			{
				var length: int;
				var type: int;
				
				var parameter: SoulCardParameter = new SoulCardParameter();
				while (data.bytesAvailable > 8)
				{
					length = data.readInt();
					type = data.readByte();
					switch(type)
					{
						case TYPE_STRING:
							if (StringUtils.empty(parameter.id))
							{
								parameter.id = data.readUTFBytes(length);
							}
							else if(StringUtils.empty(parameter.name))
							{
								parameter.name = data.readUTFBytes(length);
							}
							break;
						case TYPE_INT:
							if(parameter.attack == int.MIN_VALUE)
							{
								parameter.attack = data.readInt();
							}
							else if(parameter.def == int.MIN_VALUE)
							{
								parameter.def = data.readInt();
							}
							else if(parameter.mdef == int.MIN_VALUE)
							{
								parameter.mdef = data.readInt();
							}
							else if(parameter.health == int.MIN_VALUE)
							{
								parameter.health = data.readInt();
							}
							else if(parameter.energy == int.MIN_VALUE)
							{
								parameter.energy = data.readInt();
							}
							else if(parameter.level == int.MIN_VALUE)
							{
								parameter.level = data.readInt();
							}
							else if(parameter.race == int.MIN_VALUE)
							{
								parameter.race = data.readInt();
							}
							break;
						case TYPE_LONG:
							if(parameter.guid == null)
							{
								parameter.guid = new Int64();
								parameter.guid.high = data.readInt();
								parameter.guid.low = data.readUnsignedInt();
							}
							break;
					}
					
					if(parameter.guid != null &&
					!StringUtils.empty(parameter.id) && !StringUtils.empty(parameter.name) &&
					parameter.attack != int.MIN_VALUE && parameter.def != int.MIN_VALUE &&
					parameter.mdef != int.MIN_VALUE && parameter.health != int.MIN_VALUE &&
					parameter.energy != int.MIN_VALUE && parameter.level != int.MIN_VALUE &&
					parameter.race != int.MIN_VALUE)
					{
						container.push(parameter);
						index[parameter.guid.toString()] = parameter;
						parameter = new SoulCardParameter();
					}
				}
			}
		}
	}
}