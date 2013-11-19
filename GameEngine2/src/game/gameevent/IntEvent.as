package game.gameevent
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	import flash.events.Event;
	
	public class IntEvent extends Event
	{
		static public const serverState:String ="serverState";
		static public const npcCommunication:String="npccall"
		
		private var _param:int;
		
		public function IntEvent(type:String,param:int = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_param = param;
		}	
		
		public function get param():int
		{
			return _param;
		}
		override public function clone():Event
		{
			return new TemplateEvent(type, _param, bubbles, cancelable);
		}
	}
}