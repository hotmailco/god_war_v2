package
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameManager extends Sprite
	{
		public function GameManager()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		protected function init(evt: Event = null): void
		{
			if(evt != null)
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
	}
}