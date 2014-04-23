package com.xgame.core.protocol
{
	public class ProtocolBase extends Object implements IProtocol
	{
		public static const TYPE_INT: int = 0;
		public static const TYPE_LONG: int = 1;
		public static const TYPE_STRING: int = 2;
		public static const TYPE_FLOAT: int = 3;
		public static const TYPE_BOOL: int = 4;
		public static const TYPE_DOUBLE: int = 5;
		
		public static const ACK_CONFIRM: int = 1;
		public static const ACK_ERROR: int = 0;
		public static const ORDER_CONFIRM: int = 2;
		
		private var _protocolId: uint = 0;
		
		public function ProtocolBase(protocolId: uint)
		{
			super();
			_protocolId = protocolId;
		}
		
		public function get protocolId():uint
		{
			return _protocolId;
		}
	}
}