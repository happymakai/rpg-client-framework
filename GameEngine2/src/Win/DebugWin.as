package Win
{
	/**
	 *  Arthur:MK
	 *  Date:2013-11-12
	 * Debug界面
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import game.gamemanager.GameData;
	

	
	public class DebugWin extends Sprite
	{
		//framerate
		//memory
		//mouseX Y
		static private var _instance:DebugWin =new DebugWin();
		private var text:TextField;
		private var enabled:Boolean;
		private var children:int;
		public function DebugWin()
		{
			super();
			text = new TextField();
			text.background =true;
			text.alpha = 0.5;
			text.backgroundColor =0xff0000;
			text.width = 100;
			text.height =200;
			this.addChild(text);
			this.addEventListener(Event.ENTER_FRAME,onRender);
			children =GameData.gameInstance.numChildren;
			
		}
		static public function enable(enable:Boolean):void
		{
			if(enable)
			{
				if(!_instance.enabled)
				{
					GameData.gameInstance.addChild(_instance);
					_instance.enabled = enable;
				}
			}
			else
			{
				if(_instance.enabled)
				{
					//_instance.removeEventListener(Event.ENTER_FRAME,_instance.onRender);
					if(_instance.parent)
						_instance.parent.removeChild(_instance);
					_instance.enabled = enable;
				}
			}
		}
		
		static public function log(string:String):void
		{
			string+="\n";
			_instance.text.appendText(string);
		}
		
		static public function get instance():DebugWin
		{
			if(_instance)
				return _instance;
			else
				return _instance = new DebugWin();
		}
		
		private function onRender(e:Event):void
		{
			if(children!=GameData.gameInstance.numChildren)
			{
				children = GameData.gameInstance.numChildren;
				GameData.gameInstance.addChildAt(this,children-1);	
			}
	 
		}
		
		
		
		
		
	}
}