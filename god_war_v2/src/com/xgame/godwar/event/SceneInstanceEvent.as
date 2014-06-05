package com.xgame.godwar.event
{
	import flash.events.Event;
	import com.xgame.godwar.parameter.InstanceEntranceParameter;
	
	public class SceneInstanceEvent extends Event
	{
		private static const NAME: String = "SceneInstanceEvent";
		public static const ENTRANCE_CLICK_EVENT: String = NAME + ".EntranceClickEvent";
		
		public var instanceId: int;
		public var level: int;
		
		public function SceneInstanceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}