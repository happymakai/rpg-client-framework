package screen
{
	import flash.events.Event;
 

	/**
	 * author:MK
	 * 2013-11-16
	 * 
	 */
	public interface IScreen
	{
		
		/**
		 * protected 
		 */
		function onRun(e:Event):void
 		
		/**
		 * protected 
		 */
		function update():void
 
		
		/**
		 * protected 
		 */
		function init():void
 
		
		/**
		 * protected 
		 */
		function initEvent():void

		
		/**
		 * protected 
		 */
		function removeEvent():void

		
		/**
		 * protected 
		 */
		function dipose():void

		
		/**
		 * protected 
		 */
		function over():void
	 
		
	}
}