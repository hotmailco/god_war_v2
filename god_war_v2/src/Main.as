package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.view.StartView;
	
	import morn.core.handlers.Handler;
	
	import starling.core.Starling;
	
	[SWF(width="1200", height="800", backgroundColor="0x000000",frameRate="30")]
	public class Main extends Sprite
	{
		private var _s: Starling;
		
		public function Main()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(evt: Event = null): void
		{
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			GameFacade.getInstance().start(this);
			
			UIManager.init(this);
			UIManager.loader.loadAssets(["assets/ui.swf"], new Handler(loadComplete));
			
			_s = new Starling(Game, stage);
			_s.start();
		}
		
		private function loadComplete():void {
			//实例化场景
			UIManager.stage.addChild(new StartView());
		}
	}
}