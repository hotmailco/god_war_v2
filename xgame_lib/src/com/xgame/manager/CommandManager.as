package com.xgame.manager
{
	import com.xgame.core.network.socket.SmartSocket;
	import com.xgame.core.protocol.IReceiving;
	import com.xgame.core.protocol.ISending;
	import com.xgame.core.protocol.ProtocolList;
	import com.xgame.event.network.CommandEvent;
	import com.xgame.util.debug.Debug;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;

	public class CommandManager extends BaseManager
	{
		private var _socket: SmartSocket;
		private var _commandList: ProtocolList;
		private static var _instance: CommandManager;
		private static var _allowInstance: Boolean = false;
		
		public function CommandManager()
		{
			super();
			if(!_allowInstance)
			{
				throw new IllegalOperationError("不能直接实例化");
				return;
			}
			_socket = SmartSocket.instance;
			_socket.callback = process;
			
			_socket.addEventListener(Event.CLOSE, onClosed);
			_socket.addEventListener(Event.CONNECT, onConnected);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			_commandList = ProtocolList.instance;
		}
		
		public static function get instance(): CommandManager
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new CommandManager();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function get connected(): Boolean
		{
			return _socket.connected;
		}
		
		private function onClosed(event: Event): void
		{
			CONFIG::DebugMode
			{
				Debug.info(this, "服务器已断开连接");
			}
			dispatchEvent(new CommandEvent(CommandEvent.CLOSED_EVENT));
		}
		
		private function onConnected(event: Event): void
		{
			CONFIG::DebugMode
			{
				Debug.info(this, "服务器已连接");
			}
			dispatchEvent(new CommandEvent(CommandEvent.CONNECTED_EVENT));
		}
		
		private function onIOError(event: IOErrorEvent): void
		{
			CONFIG::DebugMode
			{
				Debug.error(this, "服务器连接错误");
			}
			dispatchEvent(new CommandEvent(CommandEvent.IOERROR_EVENT));
		}
		
		private function onSecurityError(event: SecurityErrorEvent): void
		{
			CONFIG::DebugMode
			{
				Debug.error(this, "服务器安全沙箱冲突");
			}
			dispatchEvent(new CommandEvent(CommandEvent.SECURITYERROR_EVENT));
		}
		
		public function connect(host: String, port: int): void
		{
			CONFIG::DebugMode
			{
				Debug.info(this, "服务器连接中...(IP=" + host + ", Port=" + port + ")");
			}
			_socket.connect(host, port);
		}
		
		public function close(): void
		{
			removeEventListeners();
			if(_socket.connected)
			{
				_socket.close();
			}
		}
		
		private function process(protocolId: uint, data: ByteArray): void
		{
			var _protocol: IReceiving = _commandList.getProtocol(protocolId);
			if(_protocol == null)
			{
				return;
			}
			_protocol.fill(data);
			_protocol.fillTimestamp(data);
			riseTrigger(protocolId, _protocol);
		}
		
		public function add(protocolId: uint, callback: Function): void
		{
			addTrigger(protocolId, callback);
		}
		
		public function remove(protocolId: uint, callback: Function): void
		{
			removeTrigger(protocolId, callback);
		}
		
		public function send(protocol: ISending): void
		{
			protocol.fill();
			protocol.fillTimestamp();
			_socket.send(protocol.byteData);
			CONFIG::DebugMode
			{
				Debug.info(this, "数据发送");
			}
		}
		
		public function dispose(): void
		{
			if(_socket.hasEventListener(Event.CLOSE))
			{
				_socket.removeEventListener(Event.CLOSE, onClosed);
			}
			if(_socket.hasEventListener(Event.CONNECT))
			{
				_socket.removeEventListener(Event.CONNECT, onConnected);
			}
			if(_socket.hasEventListener(IOErrorEvent.IO_ERROR))
			{
				_socket.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			}
			if(_socket.hasEventListener(SecurityErrorEvent.SECURITY_ERROR))
			{
				_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			}
			_socket.dispose();
			_commandList.dispose();
			_socket = null;
			_instance = null;
		}
	}
}