package core
{
	import game.gamemanager.GameData;

	/**
	 * author:MK
	 * 2013-11-16
	 * 
	 */
	
	public class Camera
	{
		static private var _instance:Camera  =new Camera();
		static private  var _x:Number;
		static private var _y:Number;
		static private var _height:Number;
		static private var _width:Number;
		public function Camera()
		{
		}
		public function initEvent():void
		{
			//监听人物位置改变
			//场景改变
		}
		static public function get x():Number
		{
			return _x;
		}
		
		static public function get y():Number
		{
			return _y;
		}
		static public function get width():Number
		{
			return _width;
		}
		
		static public function get height():Number
		{
			return _height;
		}
		
		static public function initCamera():void
		{
			_x=0;
			_y=0;
			_width=GameData.gameInstance.stage.stageWidth;
			_height=GameData.gameInstance.stage.stageWidth;
		}
		
		
	}
}