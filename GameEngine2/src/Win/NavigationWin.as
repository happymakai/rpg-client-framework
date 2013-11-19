package Win
{
	/**
	 * 主界面
	*/

	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import game.gamemanager.GameData;

	
	public class NavigationWin extends Sprite
	{
		
	   // 
		static private var _instance:NavigationWin=new NavigationWin();
		private var _WinArray :Array;
		//1.chat win 
		//2.任务
		//3.小地图
		//4.
		private var facePanel:Sprite;
		private var smallMap:Sprite;
		private var newsButton:Array=new Array()//Sprite;
		private var chatPanel:Sprite;
		private var gameInfoPanel:Sprite;
		private var gameButton:Array=new Array();//Sprite;
		[Embed(source="res/P1.png")]
		private const P1:Class;
		[Embed(source="res/P2.png")]
		private const P2:Class;
		[Embed(source="res/P3.png")]
		private const P3:Class;
		[Embed(source="res/P4.png")]
		private const P4:Class;
		[Embed(source="res/P5.png")]
		private const P5:Class;
		[Embed(source="res/P6.png")]
		private const P6:Class;
		[Embed(source="res/P7.png")]
		private const P7:Class;
		[Embed(source="res/P8.png")]
		private const P8:Class;
		[Embed(source="res/P9.png")]
		private const P9:Class;
		[Embed(source="res/P10.png")]
		private const P10:Class;
		[Embed(source="res/P11.png")]
		private const P11:Class;
		[Embed(source="res/P12.png")]
		private const P12:Class;
		[Embed(source="res/P13.png")]
		private const P13:Class;
		[Embed(source="res/face.png")]
		private const FACE:Class;
		[Embed(source="res/map.png")]
		private const MAP:Class;
		
		static private var point_face:Point=new Point();
		//private var point_small:Point = new Point(GameData.gameInstance.stage.width
		static public var arrayP:Array
		
		 
		
		
		public function NavigationWin()
		{
			super();		
			arrayP=[P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12,P13];
			//this.addEventListener(Event.RESIZE,onResize); 
			facePanel = new Sprite();
			facePanel.alpha=0.5;
			facePanel.addChild(new FACE());
 
			this.addChild(facePanel);
			
			var upButton:Sprite
			for(var i:int=0;i<8;i++)
			{
				upButton = new Sprite();
				upButton.addChild(new arrayP[i]);
				upButton.x=205+50*i;
				upButton.y=0;
				this.addChild(upButton);
				newsButton.push(upButton);
			}

			var boButton:Sprite
			for(i=0;i<5;i++)
			{
				boButton = new Sprite();
				boButton.addChild(new arrayP[i+8]);
				boButton.x=1440-80;
				boButton.y=250+i*50;
				this.addChild(boButton);
				gameButton.push(boButton);
			}
			
			gameInfoPanel = new Sprite();
			gameInfoPanel.addChild(new MAP()); 
			gameInfoPanel.alpha=0.5;
			gameInfoPanel.x=1440-200;
			gameInfoPanel.y=0;
			this.addChild(gameInfoPanel);
			this.addEventListener(Event.ADDED_TO_STAGE,onStage);
			
		}
		
		private function onStage(e:Event):void
		{
			this.stage.addEventListener(Event.RESIZE,onResize);
		}
		
		private function onRemove(e:Event):void
		{
			
		}
		
		private function onResize(e:Event):void
		{
		 
			var btn:Sprite;
			for(var i:int=0;i<gameButton.length;i++)
			{
				btn= gameButton[i] as Sprite
			 
				btn.x=this.stage.stageWidth-80;
			}
			
			gameInfoPanel.x = this.stage.stageWidth-200;
				
		}
		
		public function reSize(width:int,height:int):void
		{
			var btn:Sprite;
			for(var i:int=0;i<gameButton.length;i++)
			{
				btn= gameButton[i] as Sprite
			 
				btn.x=width-80;
			}
			
			gameInfoPanel.x =width-200;
		}
		
		
		
		static public function get instance():NavigationWin
		{
			if(_instance)
				return _instance;
			else
				return _instance = new NavigationWin();
		}
 
		
		 
	}
}