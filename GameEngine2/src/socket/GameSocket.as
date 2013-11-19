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
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.InitEventType;
	import game.gameevent.IntEvent;

	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	public class GameSocket
	{
		//
		private var _socket:Socket;
		static private var _instance:GameSocket;
		
		
		private var _currentHost:String;
		private var _currentPort:int;
		private var _hearBeatTimer:Timer;//心跳包计时器
		private var _connected:Boolean;
		private var _reconnectTimer:Timer; //重连的定时器
		private var _autoCloseSocketTimer:Timer; //自动踢下线的定时器
		//保存当前连接的IP和端口,用于重连
		public function GameSocket()
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
			DataEventDispatcher.dispatchEvent(new Event(InitEventType.connected));			 
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
			switch(bytes.readInt())
			{
				case SocketType.sCheck:
					DataEventDispatcher.dispatchEvent(new BoolEvent(BoolEvent.logincheck,true,true));
				 
			} 
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
		
	
		
		static public function get instance():GameSocket
		{
			if(_instance)
				return _instance;
			else
				return _instance = new GameSocket();
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
		
		public function enableHeartBeat(enable:Boolean):void
		{
			if(enable)
			{
				if(!_hearBeatTimer)
				{
					_hearBeatTimer = new Timer(60000);    //1分钟
					_hearBeatTimer.addEventListener(TimerEvent.TIMER, onHeartBeatTimer);
					_hearBeatTimer.start();
				}
			}
			else
			{
				if(!_hearBeatTimer) return;
				_hearBeatTimer.stop();
				_hearBeatTimer.removeEventListener(TimerEvent.TIMER, onHeartBeatTimer);
				_hearBeatTimer = null;
			}
		}
		
		private function onHeartBeatTimer(e:Event):void
		{
			this.sendHeartBeat();
		}
		
		private function sendHeartBeat():void
		{
			this.sendSocket(new ByteArray());
		}
		
 
		
		public function enableReconnect(enable:Boolean):void
		{
			if(enable)
			{
				if(!_reconnectTimer)
				{
					_reconnectTimer = new Timer(15000);    //20秒
					_reconnectTimer.addEventListener(TimerEvent.TIMER, onReconnect);
					_reconnectTimer.start();
				}
			}
			else
			{
				if(!_reconnectTimer) return;
				_reconnectTimer.stop();
				_reconnectTimer.removeEventListener(TimerEvent.TIMER, onReconnect);
				_reconnectTimer = null;
			}
		}
		
		protected function onReconnect(e:Event):void
		{
			this.reconnect();
		}
		
		
		
		 
	}
}