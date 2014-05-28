package com.xgame.common.display
{
	import com.xgame.common.behavior.Behavior;
	
	public class InstancePortalDisplay extends PortalDisplay
	{
		public var instanceList: Vector.<int>;
		
		public function InstancePortalDisplay()
		{
			super();
			instanceList = new Vector.<int>();
		}
	}
}