package com.xgame.godwar.parameter
{
	import com.xgame.godwar.parameter.card.SoulCardParameter;

	public class CardGroupParameter extends Object
	{
		public var groupId: int = int.MIN_VALUE;
		public var groupName: String = null;
		public var cardList: Vector.<SoulCardParameter>;
		public var energyCost: int;
		public var cardListReady: Boolean = false;
		
		public function CardGroupParameter()
		{
			super();
		}
	}
}