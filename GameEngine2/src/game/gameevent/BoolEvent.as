package game.gameevent
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	import flash.events.Event;
	
	public class BoolEvent extends Event
	{
		static public const logincheck:String ="logincheck";
		
		private var _param:Boolean;
		
		public function BoolEvent(type:String,param:Boolean = false, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_param = param;
		}	
		
		public function get param():Boolean
		{
			return _param;
		}
		override public function clone():Event
		{
			return new TemplateEvent(type, _param, bubbles, cancelable);
		}
	}
}