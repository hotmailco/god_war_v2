package com.xgame.godwar.parameter
{
	import com.xgame.godwar.parameter.card.SoulCardParameter;
	
	import flash.utils.Dictionary;

	public class CardGroupParameter extends Object
	{
		public var groupId: int = int.MIN_VALUE;
		public var groupName: String = null;
		public var energyCost: int;
		private var _cardList: Vector.<SoulCardParameter>;
		private var _cardIndex: Dictionary;
		
		
		public function CardGroupParameter()
		{
			super();
			
			_cardIndex = new Dictionary();
		}
		
		public function get cards(): String
		{
			var s: String = "";
			for(var i: int = 0; i<_cardList.length; i++)
			{
				s += _cardList[i].guid.toString();
				if(i < _cardList.length - 1)
				{
					s += ",";
				}
			}
			
			return s;
		}
		
		public function addCard(card: SoulCardParameter): void
		{
			if(_cardList == null)
			{
				_cardList = new Vector.<SoulCardParameter>();
			}
			_cardList.push(card);
			_cardIndex[card.guid.toString()] = card;
		}

		public function get cardList():Vector.<SoulCardParameter>
		{
			return _cardList;
		}
		
		public function set cardList(value: Vector.<SoulCardParameter>): void
		{
			if(value != null)
			{
				if(_cardList == null)
				{
					_cardList = new Vector.<SoulCardParameter>();
				}
				for(var i: int = 0; i < value.length; i++)
				{
					addCard(value[i]);
				}
			}
		}

		public function get cardIndex():Dictionary
		{
			return _cardIndex;
		}

	}
}