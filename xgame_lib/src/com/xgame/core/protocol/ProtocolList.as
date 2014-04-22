package com.xgame.core.protocol
{
	import flash.errors.IllegalOperationError;

	public class ProtocolList extends ProtocolCollector
	{
		private static var _instance: ProtocolList;
		private static var _allowInstance: Boolean = false;
		
		public function ProtocolList()
		{
			super();
			if(!_allowInstance)
			{
				throw new IllegalOperationError("不能直接实例化");
			}
		}
		
		public static function get instance(): ProtocolList
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new ProtocolList();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function bind(protocolId: uint, protocolRef: Class): void
		{
			if(_commandList[protocolId] != null)
			{
				return;
			}
			_commandList[protocolId] = protocolRef;
		}
		
		public function unbind(protocolId: uint): void
		{
			if(_commandList[protocolId] != null)
			{
				_commandList[protocolId] = null;
				delete _commandList[protocolId];
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			_instance = null;
		}
	}
}