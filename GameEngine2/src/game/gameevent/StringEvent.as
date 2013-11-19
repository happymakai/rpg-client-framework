package game.gameevent
{
	import flash.events.Event;

	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	public class StringEvent extends Event
	{
		/**
		 * loading
		 */
		static public const ChildLoading:String ="childloading";
		
		private var _param:String;
		
		public function StringEvent(type:String,param:String = "", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_param = param;
		}	
		
		public function get param():String
		{
			return _param;
		}
		override public function clone():Event
		{
			return new TemplateEvent(type, _param, bubbles, cancelable);
		}
	}
}