package game.view.scene
{
	import com.xgame.godwar.event.SceneInstanceEvent;
	import com.xgame.godwar.manager.InstanceManager;
	import com.xgame.godwar.parameter.InstanceDataParameter;
	import com.xgame.godwar.parameter.InstanceParameter;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import game.ui.scene.InstanceDialogUI;
	
	public class InstanceDialog extends InstanceDialogUI
	{
		private var _instanceList: Vector.<InstanceParameter>;
		private var _currentIndex: int;
		private var _currentInstance: InstanceParameter;
		private var _entranceIndex: Dictionary;
		
		public function InstanceDialog()
		{
			super();
			
			_entranceIndex = new Dictionary();
		}
		
		public function prev(): InstanceParameter
		{
			if(_currentIndex == 0)
			{
				return null;
			}
			else
			{
				if(_instanceList.length > _currentIndex - 1)
				{
					_currentIndex--;
					removeEntrances();
					currentInstance = _instanceList[_currentIndex];
					return _currentInstance;
				}
			}
			
			return null;
		}
		
		public function next(): InstanceParameter
		{
			if(_currentIndex == _instanceList.length - 1)
			{
				return null;
			}
			else
			{
				if(_instanceList.length > _currentIndex + 1)
				{
					_currentIndex++;
					removeEntrances();
					currentInstance = _instanceList[_currentIndex];
					return _currentInstance;
				}
			}
			
			return null;
		}

		public function get instanceList():Vector.<InstanceParameter>
		{
			return _instanceList;
		}

		public function set instanceList(value:Vector.<InstanceParameter>):void
		{
			_instanceList = value;
			
			if(_instanceList.length > 0)
			{
				_currentIndex = 0;
				currentInstance = _instanceList[_currentIndex];
			}
		}
		
		public function set currentInstance(value: InstanceParameter): void
		{
			_currentInstance = value;
			
			var parameter: InstanceDataParameter = InstanceManager.instance.getInstance(_currentInstance.instanceId);
			if(parameter != null)
			{
				var entrance: InstanceItemView;
				for(var i: int = 0; i < parameter.list.length && i < _currentInstance.level; i++)
				{
					entrance = _entranceIndex[parameter.id + parameter.list[i].level];
					if(entrance == null)
					{
						entrance = new InstanceItemView(parameter.list[i]);
						entrance.lblName.text = parameter.list[i].name;
						entrance.imgBg.url = parameter.list[i].bg;
						if(parameter.list[i].type == 0)
						{
							entrance.imgBg1.visible = true;
							entrance.imgBg2.visible = false;
						}
						else
						{
							entrance.imgBg1.visible = false;
							entrance.imgBg2.visible = true;
						}
						entrance.x = parameter.list[i].x;
						entrance.y = parameter.list[i].y;
						entrance.addEventListener(MouseEvent.CLICK, onEntranceClick);
						
						addChild(entrance);
						_entranceIndex[parameter.id + parameter.list[i].level] = entrance;
					}
				}
			}
		}
		
		public function removeEntrances(): void
		{
			for each(var entrance: InstanceItemView in _entranceIndex)
			{
				entrance.removeEventListener(MouseEvent.CLICK, onEntranceClick);
			}
			removeChild(entrance);
		}
		
		private function onEntranceClick(evt: MouseEvent): void
		{
			var entrance: InstanceItemView = evt.currentTarget as InstanceItemView;
			if(entrance != null)
			{
				var event: SceneInstanceEvent = new SceneInstanceEvent(SceneInstanceEvent.ENTRANCE_CLICK_EVENT);
				event.instanceId = _currentInstance.instanceId;
				event.level = entrance.entranceParameter.level;
				dispatchEvent(event);
			}
		}

		public function get currentInstance():InstanceParameter
		{
			return _currentInstance;
		}


	}
}