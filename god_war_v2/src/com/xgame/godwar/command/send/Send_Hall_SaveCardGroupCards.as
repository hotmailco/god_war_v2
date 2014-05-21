package com.xgame.godwar.command.send
{
	import com.xgame.core.protocol.SendBase;
	import com.xgame.godwar.config.SocketContextConfig;
	import com.xgame.godwar.parameter.CardGroupParameter;

	public class Send_Hall_SaveCardGroupCards extends SendBase
	{
		public var list: Vector.<CardGroupParameter>;
		
		public function Send_Hall_SaveCardGroupCards()
		{
			super(SocketContextConfig.INFO_SAVE_CARD_GROUP_CARDS);
		}
		
		override public function fill():void
		{
			super.fill();
			
			if(list != null)
			{
				var cards: String = "";
				
				for(var i: int = 0; i<list.length; i++)
				{
					_byteData.writeInt(4);
					_byteData.writeByte(TYPE_INT);
					_byteData.writeInt(list[i].groupId);
					
					cards = list[i].cards;
					_byteData.writeInt(cards.length);
					_byteData.writeByte(TYPE_STRING);
					_byteData.writeUTF(cards);
				}
			}
		}
	}
}