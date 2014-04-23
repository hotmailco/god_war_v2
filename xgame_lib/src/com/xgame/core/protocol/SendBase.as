package com.xgame.core.protocol
{
	
	import com.xgame.util.Int64;
	
	import flash.utils.ByteArray;
	
	public class SendBase extends ProtocolBase implements ISending
	{
		protected var _byteData: ByteArray;
		
		public function SendBase(protocolId:uint)
		{
			super(protocolId);
			_byteData = new ByteArray();
		}
		
		public function get byteData():ByteArray
		{
			return _byteData;
		}
		
		public function fill():void
		{
			_byteData.clear();
			_byteData.writeShort(protocolId);
		}
		
		public function fillTimestamp(): void
		{
			var time: Number = new Date().time;
			var time64: Int64 = Int64.fromNumber(time);
			
			_byteData.writeInt(8);
			_byteData.writeByte(TYPE_LONG);
			_byteData.writeInt(time64.high);
			_byteData.writeUnsignedInt(time64.low);
		}
		
		public function get protocolName():String
		{
			return "SendingBase";
		}
	}
}