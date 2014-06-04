package com.xgame.godwar.parameter
{
	public class InstanceDataParameter
	{
		public var id: int;
		public var name: String;
		public var list: Vector.<InstanceEntranceParameter>;
		
		public function InstanceDataParameter()
		{
			list = new Vector.<InstanceEntranceParameter>();
		}
	}
}