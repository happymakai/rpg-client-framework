package game.gamemanager
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
 
	
 

	public class UiManager extends Sprite
	{
		
		static private var _instance :UiManager;
		public function UiManager()
		{
//			this.graphics.beginFill(0xff0000);
//			this.graphics.drawCircle(100,100,60);
//			this.graphics.endFill();
		}
		
		static public function get instance():UiManager
		{
			if(_instance)
				return _instance;
			else
				return _instance = new UiManager();
		}
		
		public function showBasicUI(state:int):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function show(child:DisplayObject):DisplayObject
		{

				return this.addChild(child);
		}
		
		public function createWinbyXML():void
		{
			 /**
			 *    win : type
			 * 	  ui-button : width height x y text event
			 * 
			  */
			 
		    
			
			
		}
	}
}