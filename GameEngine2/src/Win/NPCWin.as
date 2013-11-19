package Win
{
	import flash.events.TextEvent;
	import flash.text.TextField;
	
	import Win.ui.CloseWin;
	
	import game.gameconfig.npc.NPCConfig;
	import game.gameconfig.npc.NpcProvider;
	
	public class NPCWin extends CloseWin
	{
		private var _text:TextField;
		static private var _instance:NPCWin;
		public  var id:int;
		public function NPCWin()
		{
			super();
			this.setSize(200,200);
			_text = new TextField();
			_text.x=20;
			_text.y=20;
			//_text.width=150;
			//_text.height=20;
			_text.background=true;
			_text.backgroundColor=0xff0000;
			this.addChild(_text);
			this.addEventListener(TextEvent.LINK,onLink);
		}
		
		static public function setWord(str:String):void
		{
			instance._text.htmlText=str;
		}
		
		static public function get instance():NPCWin
		{
			if(_instance)
				return _instance;
			else
				return _instance=new NPCWin();
		}
		
		private function onLink(e:TextEvent):void
		{
			var npc :NPCConfig;
			var func:Function;
			npc =NpcProvider.getNpcById(this.id);
			func = npc.getFunctionbyName(e.text);
			if(func==null)
				return;
			func(this.id); 
		}
		
	}
}