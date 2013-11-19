package screen
{
	/**
	 * 特定的窗口
	 * 逻辑需要的
	 */
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.InitEventType;
	
 
	
	public class GameStartScreen extends Sprite
	{
		[Embed(source="res/mark.png")]
		private const MARK:Class;
		
		private var _timer:Timer;
		  
		public function GameStartScreen()
		{
			super();
			this.init();
 
			
		}
		
		private function onTimer(e:Event):void
		{
			var timer:TimerEvent ;
			if(e is TimerEvent)
			{
				timer = e as TimerEvent;
				if(e.type ==TimerEvent.TIMER)
				{
					update();
				}
				else if(e.type == TimerEvent.TIMER_COMPLETE)
				{
 						this.over();
						this.removeEvent();
						this.dipose();

				}
			}
		}
		
		
		protected function update():void
		{
//			this.x +=10;
//			this.y +=10;
//			this.graphics.clear();
//			this.graphics.beginFill(0xff0000);
//			this.graphics.drawCircle(100,100,10);
//			this.graphics.endFill();
			//_sp.play();
		}
		
		protected function init():void
		{
			_timer = new Timer(1000,3);
			this.initEvent();
			_timer.start();
			this.addChild(new MARK());
		}
		
		protected function initEvent():void
		{
			_timer .addEventListener(TimerEvent.TIMER,onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
		}
		
		protected function removeEvent():void
		{
			_timer.removeEventListener(TimerEvent.TIMER,onTimer);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			
		}
		
		protected function dipose():void
		{
			if(parent)
				parent.removeChild(this);
		}
		
		protected function over():void
		{
			DataEventDispatcher.dispatchEvent(new Event(InitEventType.INITOVER,true))
		}		
	}
}