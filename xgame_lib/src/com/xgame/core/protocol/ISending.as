package com.xgame.core.protocol
{
	import flash.utils.ByteArray;

	public interface ISending
	{
		function get byteData(): ByteArray;
		function fill(): void;
		function fillTimestamp(): void;
	}
}