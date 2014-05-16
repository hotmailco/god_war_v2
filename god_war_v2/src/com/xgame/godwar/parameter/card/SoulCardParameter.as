package com.xgame.godwar.parameter.card
{
	public class SoulCardParameter extends RoleCardParameter
	{
		public var level: int = int.MIN_VALUE;
		public var race: int = int.MIN_VALUE;
		public var skillList: Vector.<String>;
		
		public function SoulCardParameter()
		{
			super();
			skillList = new Vector.<String>();
		}
	}
}