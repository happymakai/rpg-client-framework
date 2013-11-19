package game.gameevent
{
	/**
	 *    Time:下午11:07:17
	 *    Aurthor:MK
	 */
	import flash.events.Event;
	
	public class TemplateEvent extends Event
	{
		static public const TEMPLATEEVENT:String ="template_event";
		private var _templateObject:Object;
		private var _param:Object;
		
		public function TemplateEvent(type:String,templateObject:Object=null,param:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_templateObject = templateObject;
			_param = param;
		}	

		public function get templateObject():Object
		{
			return _templateObject;
		}
		public function get param():Object
		{
			return _param;
		}
		override public function clone():Event
		{
			return new TemplateEvent(type, _templateObject, _param, bubbles, cancelable);
		}
		
	}
}


 
	
	