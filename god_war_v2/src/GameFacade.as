package
{
	import com.xgame.godwar.core.GameInitCommand;
	
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class GameFacade extends Facade
	{
		
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
			registerCommand(GameInitCommand.APP_START, GameInitCommand);
		}
		
		public function start(app: Main): void
		{
			sendNotification(GameInitCommand.APP_START, app);
		}
	}
}