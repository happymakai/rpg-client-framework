package game.gameevent
{
	import flash.events.Event;
	import flash.utils.ByteArray;

	/**
	 * author:MK
	 * 2013-11-16
	 * 
	 */
	
	public class BytesEvent extends Event
	{
		static public const gameconfig:String ="gameconfig";
		
		private var _param:ByteArray;
		
		public function BytesEvent(type:String,param:ByteArray = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_param = param;
		}	
		
		public function get param():ByteArray
		{
			return _param;
		}
		override public function clone():Event
		{
			return new TemplateEvent(type, _param, bubbles, cancelable);
		}
	}
}