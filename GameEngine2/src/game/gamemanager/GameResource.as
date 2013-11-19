package game.gamemanager
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	public class GameResource
	{
		static private var _instance ;
		public function GameResource()
		{
		}
	   static public function get instance():GameResource
	   {
		   if(_instance)
			   return _instance;
		   else
			   return _instance = new GameResource();
	   }
	}
}