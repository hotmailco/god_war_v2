package
{
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class GameFacade extends Facade
	{
		public static const APP_START_NOTE: String = "GameFacade.AppStartNote";
		
		public function GameFacade()
		{
			super();
		}
		
		public static function getInstance(): GameFacade
		{
			if(instance == null)
			{
				instance = new GameFacade();
			}
			return instance as GameFacade;
		}
		
		override protected function initializeController():void
		{
			super.initializeController();
//			registerCommand(APP_START_NOTE, GameInitCommand);
		}
		
		public function start(app: Main): void
		{
			sendNotification(APP_START_NOTE, app);
		}
	}
}