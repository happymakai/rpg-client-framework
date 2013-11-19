package game.gameevent
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	public class DataEventDispatcher
	{
		
		static private var dispatcher:EventDispatcher = new EventDispatcher();//
		public function DataEventDispatcher()
		{
			
			

		}
		
		static public function destruct():void
		{
			if ( dispatcher )
				dispatcher = null;
		}
		static public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
			//trace(type +"  is start");	
		}
		static public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			
			dispatcher.removeEventListener(type, listener, useCapture);
			//trace(type +"  is over");
		}
		static public function dispatchEvent(event:Event):Boolean
		{
			//trace(event.type +"  is dispatched");
			return dispatcher.dispatchEvent(event);
			
		}
	}
}