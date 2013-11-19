package screen
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.InitEventType;
	
	public class LoginScreen extends Sprite
	{
		private var text:TextField
		public function LoginScreen()
		{
			super();
			text = new TextField();
			text.text="login";
			text.x=100;
			text.y=100;
			text.height=20;
			text.background =true;
			text.backgroundColor =0x00ff00;
			text.addEventListener(MouseEvent.CLICK,onLogin);
			this.addChild(text);
			
		}
		
		private function onLogin(e:Event):void
		{
			text.removeEventListener(MouseEvent.CLICK,onLogin);
			trace("login in");
			if(parent)
				parent.removeChild(this);
			DataEventDispatcher.dispatchEvent(new Event(InitEventType.Logined));
		}
	}
}