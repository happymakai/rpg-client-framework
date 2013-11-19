package socket
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	public interface IGameSocket
	{
		public function connect(host:String,port:int):void;
		public function reconnect(host:String,port:int):void;
		

	}
}