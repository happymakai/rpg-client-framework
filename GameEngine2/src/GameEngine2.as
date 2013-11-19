package
{
 	
 
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import Win.NavigationWin;
	import Win.ui.CloseWin;
	
	import core.Camera;
	import core.loading.LoaderItem;
	import core.loading.ResourceLoader;
	
	import game.gameelement.Map;
	import game.gameevent.BoolEvent;
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.InitEventType;
	import game.gameevent.IntEvent;
	import game.gamemanager.GameData;
	import game.gamemanager.SceneManager;
	import game.gamemanager.UiManager;
	
	import screen.GameStartScreen;
	import screen.LoadingScreen;
	import screen.LoginScreen;
	
	import socket.GameSocket;
	
	

 
	
	public class GameEngine2 extends Sprite
	{
		
		private var loadingSceneAdded:Boolean;
		[Embed(source="res/a.png")]
		private const  BG:Class;
		[Embed(source="res/1.swf")]
		private const SF:Class;
		//[Embed(source="res/2.png")]
		//private const MAPM:Class;
		private var grid:Sprite;
 
		
		public function GameEngine2()
		{
 			init();
			grid= new Sprite();
			grid.graphics.beginFill(0x00ff00);
			grid.graphics.drawRect(0,0,10,10);
			grid.graphics.endFill();
 
			 
 		}
		
		public function init():void
		{
			setStageProperties();
			initGameData();
			initEvent();			
			this.addChild(new GameStartScreen());
			

		
		}
		
		private function initGameData():void
		{
 			GameData.host = "127.0.0.1"
			GameData.port =  51423;
			GameData.assertHost="127.0.0.1";
			GameData.assertPort= 51424;
			GameData.toLoadedAssert=
				[new LoaderItem("res/","a.png",new Function(),true)
				,new LoaderItem("res/","a.xml",new Function)];
			//网络测试
			//本地测试
			GameData.toLoadedResource=[];
			//网络测试
			//本地测试 
			GameData.gameInstance = this;
			//ResourceLoader.instance.load(GameData.toLoadedResource);
			ResourceLoader.instance.start();
			/**
			 * Test:Socket
			 */
//			GameSocket.instance.connect(GameData.host,GameData.port);	
//			AssertSocket.instance.connect(GameData.assertHost,GameData.assertPort);
			/**
			 * Test:DebugWin
			 */
//			DebugWin.enable(true);
			/**
			 *Test:NineGridBitmap 
			 */
//			var bit:Bitmap = new BG();
//			var nine:NineGridBitmap = new NineGridBitmap(bit,40,40,40,40);
//			//nine.setSize(600,600);
//			this.addChild(new Bitmap(nine._leftBottom));
			
			 
			
		}
 
		
		private function initEvent():void
		{
			DataEventDispatcher.addEventListener(InitEventType.INITOVER,onInitOver);//初始画面
			DataEventDispatcher.addEventListener(InitEventType.LOADED,onLoaded);//资源加载
			DataEventDispatcher.addEventListener(InitEventType.LOADINgSceneOVER,onLoadingSceneOver);//加载界面
			DataEventDispatcher.addEventListener(BoolEvent.logincheck,onLoginChecked);//登录检验完成
			DataEventDispatcher.addEventListener(InitEventType.assertConnected,onAssertConnected);//提供借口
			DataEventDispatcher.addEventListener(InitEventType.connected,onConnected);//提供借口
			DataEventDispatcher.addEventListener(IntEvent.serverState,onServerState);	//最主要的是这个将是我们一直监听的			 
		}
		
		
		private function removeEvent():void
		{
			DataEventDispatcher.removeEventListener(InitEventType.INITOVER,onInitOver);
			DataEventDispatcher.removeEventListener(InitEventType.LOADINgSceneOVER,onLoadingSceneOver)

			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onAssertConnected(e:Event):void
		{
			
		}
	
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onServerState(e:IntEvent):void
		{
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onLoginChecked(e:BoolEvent):void
		{
			DataEventDispatcher.removeEventListener(BoolEvent.logincheck,onLoginChecked);	

		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onConnected(e:Event):void
		{
			DataEventDispatcher.removeEventListener(InitEventType.connected,onConnected);
			GameSocket.instance.askForCheck();	
			 
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onLoadingSceneOver(e:Event):void
		{
			removeEvent();
			this.addChild(new LoginScreen());
			DataEventDispatcher.addEventListener(InitEventType.Logined,onLogined);
				 
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onLogined(e:Event):void
		{
			DataEventDispatcher.removeEventListener(InitEventType.Logined,onLogined);
			this.addChild(SceneManager.instance);
 			this.addChild(UiManager.instance);
			UiManager.instance.addChild(NavigationWin.instance);
			NavigationWin.instance.reSize(this.stage.stageWidth,this.stage.stageHeight);
			Camera.initCamera();
//			var m:Map = new Map();
//			m.map =new MAPM();
//			SceneManager.instance.addChild(m);
			this.addChild(grid);
			SceneManager.instance.stage.addEventListener(MouseEvent.CLICK,onClick);
			
//			var c:CloseWin =new CloseWin();
//			c.initEvent();
//			c.setSize(200,400);
//			this.addChild(c);
			
	
			
		}
 
		
		private  function onClick(e:MouseEvent):void
		{
 
			trace(e.localX+"  localX")
			trace(e.localY+"  localY");
			trace(e.stageX+"  stageX")
			trace(e.stageY+"  stageY");
			trace(Camera.x);
			grid.x = e.stageX-(Camera.x+e.stageX)%10;
			trace(grid.x);
			
			grid.y = e.stageY-(Camera.y+e.stageY)%10;	
			trace(grid.y);
			//this.addChild(grid);	
			//grid.x=100;
			//grid.y=100;
		}
		

		
		/**
		 * 
		 * @param e
		 * 
		 */
		private function onInitOver(e:Event):void
		{
			if(!ResourceLoader.loaded)
			{
				DataEventDispatcher.removeEventListener(InitEventType.LOADED,onLoaded)
				this.addChild(new LoadingScreen());
				loadingSceneAdded=true;
			}
		}
		
		/**
		 * 资源加载结束
		 * @param e
		 * 
		 */
		private function onLoaded(e:Event):void
		{
			DataEventDispatcher.removeEventListener(InitEventType.LOADED,onLoaded);
			ResourceLoader.loaded =true;
			if(!loadingSceneAdded)
			{
				DataEventDispatcher.dispatchEvent(new Event(InitEventType.LOADINgSceneOVER));				
			}
		}
		
		/**
		 * 
		 * 
		 */
		private  function setStageProperties():void
		{
			stage.frameRate =60;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.NORMAL;
			stage.color= 0x000000;
		}

		

		
 
 
		
	}
}