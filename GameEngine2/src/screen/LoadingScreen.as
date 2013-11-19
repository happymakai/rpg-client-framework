package screen
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.StringEvent;
	import game.gameevent.InitEventType;

	public class LoadingScreen extends Sprite
	{
		private var totalLoaded:int=100;
		private var hasLoaded:int=100;
		private var text:TextField;
		public function LoadingScreen()
		{
			DataEventDispatcher.addEventListener(StringEvent.ChildLoading,onChildLoading);
			DataEventDispatcher.addEventListener(InitEventType.LOADED,onLoaded);
			text =new TextField();
			text.x=100;
			text.y=100;
			text.height=20;
			text.background=true;
			text.backgroundColor=0x00ff00;
			this.addChild(text);
		}
		
		private function onChildLoading(e:StringEvent):void
		{
			this.text.text=e.param+"      "+hasLoaded+"/"+totalLoaded;
		}
		
		private function onLoaded(e:Event):void
		{
			DataEventDispatcher.removeEventListener(StringEvent.ChildLoading,onChildLoading);
			DataEventDispatcher.removeEventListener(InitEventType.LOADED,onLoaded);			
			DataEventDispatcher.dispatchEvent(new Event(InitEventType.LOADINgSceneOVER));
			this.dipose();
		}
		
		private function dipose():void
		{
			if(parent)
				parent.removeChild(this);
		}
		
		
		
		 
	}
}