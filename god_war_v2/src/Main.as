package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Security;
	
	[SWF(width="1200", height="800", backgroundColor="0x000000",frameRate="30")]
	public class Main extends Sprite
	{
		public function Main()
		{
			super();
			Security.allowDomain("*");
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(evt: Event = null): void
		{
			if(evt)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
			GameFacade.getInstance().start(this);
		}
	}
}