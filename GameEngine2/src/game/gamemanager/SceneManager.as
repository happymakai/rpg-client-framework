package game.gamemanager
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import Win.NPCWin;
	import Win.ui.CloseWin;
	
	import game.gameconfig.npc.NpcProvider;
	import game.gameelement.Map;
	import game.gameelement.Monster;
	import game.gameelement.Npc;
	import game.gameelement.Role;
	import game.gameelement.Scene;
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.IntEvent;
	
 
 
	
	public class SceneManager extends Sprite
	{
		
		/**
		 * role
		 */

		
		/**
		 * scene
		 * 
		 */
		public var _cachedScene:Scene;
		public var _currentScene:Scene;
		public var _parentScene:Scene;
		
		
		
		[Embed(source="res/npc1.png")]
		private const NPC1:Class;
		[Embed(source="res/npc2.png")]
		private const NPC2:Class;
		[Embed(source="res/npc3.png")]
		private const NPC3:Class;
		
		[Embed(source="res/npc4.png")]
		private const NPC4:Class;
		[Embed(source="res/npc5.png")]
		private const NPC5:Class;
		[Embed(source="res/npc6.png")]
		private const NPC6:Class;

		
		
		public var currentMap:Map
		
		public var ItemList:Array;//掉落到地图上的物品
		public var Npcs:Array;//npc 的分布
		public var Monsters:Array;//怪物的分布
		//GameData.currentRole;
		//GameData.otherRole in this scene		
		public var id:int;
		
		public var npcS:String;
		static private var _instance :SceneManager;
	//	private var npc1:Npc = new Npc;
		public function SceneManager()
		{
			super();
			
//			npc1.x=100;
//			npc1.y=200;
//			npc1.id=1;
//			//npc1._bitmap =(new NPC1 as Bitmap).bitmapData;
//			this.addChild(npc1);			
			DataEventDispatcher.addEventListener(IntEvent.npcCommunication,onNpc);
			
		}
		
		public  function  InitEvent():void
		{
			//监听npc ,一般由系统固定有多少
			//监听鼠标,键盘
			//监听怪物物品掉落
			//监听怪物的刷新		
			//scene改变
		}
		
		public function RemoveEvent():void
		{
			
		}
		
		private function onNpc(e:IntEvent):void
		{
 
			var str:String = NpcProvider.getNpcStrById(e.param)
			NPCWin.setWord(str);
			var bitmap:Bitmap = new NPC2();
			//npc1.bitmap.bitmapData = bitmap.bitmapData;			
			//UiManager.instance.addChild(new NPC3);
			NPCWin.instance.id=e.param;
			UiManager.instance.addChild(NPCWin.instance);
		}
		
		static public function constractScene():void
		{
			_instance.addChild(_instance.currentMap.map); 
		}
		
		static public function get instance():SceneManager
		{
			if(_instance)
				return _instance;
			else
				return _instance = new SceneManager();
		}
		
		
	}
}