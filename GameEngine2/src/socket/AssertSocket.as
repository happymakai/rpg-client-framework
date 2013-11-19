package socket
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import game.gameevent.BoolEvent;
	import game.gameevent.BytesEvent;
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.InitEventType;

	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	public class AssertSocket
	{
 
		
		private var _socket:Socket;
		static private var _instance:AssertSocket;
		private var _currentHost:String;
		private var _currentPort:int;
		
	 	private var _connected:Boolean;
		private var _reconnectTimer:Timer; //重连的定时器
		public function AssertSocket()
		{
			_socket = new Socket();
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData)
			_socket.addEventListener(Event.CONNECT,onConnected);
			_socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity)
		}
		
		public  function askForCheck():void
		{
			
		}		
		
		private function onConnected(e:Event):void
		{
			DataEventDispatcher.dispatchEvent(new Event(InitEventType.assertConnected));			 
		}
		
		
		
		
		
		private function onError(e:IOErrorEvent):void
		{
			trace(e.text);
		}
		
		private function onSecurity(e:SecurityErrorEvent):void
		{
			trace(e.text);			 
		}
		
		private function onSocketData(e:ProgressEvent):void
		{
			var bytes:ByteArray =this.readSocket();
			DataEventDispatcher.dispatchEvent(new BytesEvent(BytesEvent.gameconfig,bytes,true));
 
		}
		
		public function sendSocket(bytes:ByteArray):void
		{
			_socket.writeBytes(bytes,0,bytes.length);
			_socket.flush();
		}
		
		private function readSocket():ByteArray
		{
			var bytes:ByteArray =new ByteArray();
			_socket.readBytes(bytes,0,_socket.bytesAvailable);
			return bytes;
		}
		
		
		
		static public function get instance():AssertSocket
		{
			if(_instance)
				return _instance;
			else
				return _instance = new AssertSocket();
		}
		
		public function connect(host:String , port:int):void
		{
			if(_connected)
				disconnect();
			else
			{
				_currentHost = host;
				_currentPort = port;
				_socket.connect(host,port);
			}
		}
		
		public function disconnect():void
		{
			_socket.close();
		}		 
		
		public function reconnect(diff:Boolean = false,host:String="",port:int=-1):void
		{
			if(!diff)
			{
				this.connect(_currentHost,_currentPort);
			}
			else
			{
				connect(host,port);
			}
			
		}
		
 
		
	 
		
	  
		
	}
}