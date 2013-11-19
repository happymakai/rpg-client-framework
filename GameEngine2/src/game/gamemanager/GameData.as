package game.gamemanager
{
	import flash.display.Sprite;
	
	import game.gameelement.Mission;
	import game.gameelement.Role;
	import game.gameelement.Scene;
 

	/**
	 * 这里存放英雄的
	 */
	public class GameData
	{
		static public var port:int//服务器端口
		static public var host:String;//服务器
		static public var gameInstance:Sprite;//游戏的实例
		static public var toLoadedResource:Array;//游戏加载资源 LoadItem
		static public var assertHost:String;//资源服务器
		static public var assertPort:int;//资源服务器端口
		static public var toLoadedAssert:Array;//资源 LoadItem
		
		/**
		 * mission
		 */
		static public  var mainMission:Array//主任务
		static public  var acceptMission:Array//可接的任务	
		
		/**
		 * role
		 */
		static public var roleList:Vector.<Role>;//服务器下发的人物
		static public var currentRole:Role;//服务器创建人物
		static public var otherRole:Vector.<Role>;

 
		static private  var _instance:GameData = new GameData;
		public function GameData()
		{
			//
			  
		}
		
 
 
		
		static public function  get instance():GameData
		{
			if(_instance)
				return _instance;
			else
				return _instance = new GameData;
		}
	}
}