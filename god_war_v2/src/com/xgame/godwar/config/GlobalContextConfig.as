package com.xgame.godwar.config
{
	import flash.display.DisplayObjectContainer;
	import flash.errors.IllegalOperationError;
	
	/**
	 * ...
	 * @author john
	 */
	public final class GlobalContextConfig 
	{
		public static var FrameRate: int = 30;
		public static var GameId: int = 1001;
		public static var container: DisplayObjectContainer;
		
		public function GlobalContextConfig() 
		{
			throw new IllegalOperationError("Config类不允许实例化");
		}
	}

}