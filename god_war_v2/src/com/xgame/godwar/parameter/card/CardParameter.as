package com.xgame.godwar.parameter.card
{
	import com.xgame.util.Int64;

	public class CardParameter
	{
		public var guid: Int64;
		public var id: String;
		public var resourceClass: String;
		public var name: String;
		public var energy: int = int.MIN_VALUE;
		
		public function CardParameter()
		{
		}
	}
}