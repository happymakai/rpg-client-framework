package game.gameelement
{
	/**
	 * author:MK
	 * 2013-11-17
	 * 
	 */
	
	public class Scene
	{
		
		
		public var currentMap:Map
		
		public var ItemList:Array;//掉落到地图上的物品
		public var Npcs:Array;//npc 的分布
		public var Monsters:Array;//怪物的分布
		//GameData.currentRole;
		//GameData.otherRole in this scene		
		public var id:int;
		public function Scene()
		{
		}
		
		
	}
}