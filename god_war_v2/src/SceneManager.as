package
{
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	
	public class SceneManager extends Sprite
	{
		public function SceneManager()
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