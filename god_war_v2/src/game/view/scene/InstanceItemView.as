package game.view.scene
{
	import com.xgame.godwar.parameter.InstanceEntranceParameter;
	
	import game.ui.scene.InstanceItemViewUI;
	
	public class InstanceItemView extends InstanceItemViewUI
	{
		private var _entranceParameter: InstanceEntranceParameter;
		
		public function InstanceItemView(parameter: InstanceEntranceParameter)
		{
			super();
			
			_entranceParameter = parameter;
		}

		public function get entranceParameter():InstanceEntranceParameter
		{
			return _entranceParameter;
		}

	}
}