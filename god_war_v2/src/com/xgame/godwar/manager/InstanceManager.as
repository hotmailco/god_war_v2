package com.xgame.godwar.manager
{
	import com.xgame.godwar.parameter.InstanceDataParameter;
	
	import flash.errors.IllegalOperationError;
	import flash.utils.Dictionary;

	public class InstanceManager
	{
		private static var _instance: InstanceManager;
		private static var _allowInstance: Boolean = false;
		
		private var _list: Vector.<InstanceDataParameter>;
		private var _index: Dictionary;
		
		public function InstanceManager()
		{
			if(!_allowInstance)
			{
				throw new IllegalOperationError("不能实例化这个类");
			}
			
			_list = new Vector.<InstanceDataParameter>();
			_index = new Dictionary();
		}
		
		public static function get instance(): InstanceManager
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new InstanceManager();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function addInstance(value: InstanceDataParameter): void
		{
			if(_list.indexOf(value) > -1)
			{
				return;
			}
			_list.push(value);
			_index[value.id] = value;
		}
		
		public function getInstance(id: int): InstanceDataParameter
		{
			return _index[id];
		}

		public function get list():Vector.<InstanceDataParameter>
		{
			return _list;
		}

		public function get index():Dictionary
		{
			return _index;
		}
	}
}