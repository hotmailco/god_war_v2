package com.xgame.core.protocol
{
	import flash.utils.ByteArray;

	public interface IReceiving
	{
		function fill(data: ByteArray): void;
		function fillTimestamp(data: ByteArray): void;
		function equals(value: IReceiving): Boolean;
	}
}