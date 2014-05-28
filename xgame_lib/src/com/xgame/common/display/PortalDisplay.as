package com.xgame.common.display
{
	import com.xgame.common.behavior.Behavior;
	
	public class PortalDisplay extends BitmapMovieDispaly
	{
		
		public function PortalDisplay(behavior:Behavior=null)
		{
			super(behavior == null ? new Behavior() : behavior);
		}
	}
}