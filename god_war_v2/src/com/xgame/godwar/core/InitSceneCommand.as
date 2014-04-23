package com.xgame.godwar.core
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import starling.core.Starling;
	
	public class InitSceneCommand extends SimpleCommand
	{
		public static const INIT_SCENE_NOTE: String = "InitSceneCommand.InitSceneNote";
		
		public function InitSceneCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var _s: Starling = new Starling(Scene, UIManager.stage);
			_s.start();
		}
	}
}