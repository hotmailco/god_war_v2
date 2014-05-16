package com.xgame.godwar.parameter.card
{
	public class RoleCardParameter extends CardParameter
	{
		public var attack: int = int.MIN_VALUE;
		public var def: int = int.MIN_VALUE;
		public var mdef: int = int.MIN_VALUE;
		public var health: int = int.MIN_VALUE;
		
		public function RoleCardParameter()
		{
			super();
		}
	}
}