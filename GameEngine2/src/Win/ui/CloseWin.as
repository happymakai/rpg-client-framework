package Win.ui
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 请先设置尺寸
	 */
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	public class CloseWin extends Sprite implements IUI
	{
		private var _bg:Bitmap
		private var _button:Sprite;

		public function CloseWin()
		{
			super();
			_bg = new Bitmap(new BitmapData(1,1,false,0xff0000));
			_button = new Sprite();
			_button .addChild(new Bitmap(new BitmapData(10,10,false,0x00ff00)));
			drawBg();
			this.addEventListener(Event.ADDED_TO_STAGE ,onStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);			
		}
		
		public function drawBg():void
		{
			this.addChild(_bg);
			this.addChild(_button);
		}
		public function drawItem():void
		{
			
		}
		
		public function setSize(width:Number,height:Number):void
		{

			_bg.bitmapData= new BitmapData(width,height,false,0x0000ff);
			this.width=width;
			this.height = height;
			_button.x= width-_button.width;
			_button.y= 0;
		}
		
		public function initEvent():void
		{
			_button.addEventListener(MouseEvent.CLICK,onClose);
			trace("initevent");
		}
		public function removeEvent():void
		{
			_button.removeEventListener(MouseEvent.CLICK,onClose);
			trace("removeEvent");
		}
		public function setData(obj:Object=null):void
		{
			
		}
		public function move(x:Number,y:Number):void
		{
			this.x =x;
			this.y=y;
		}
		
		private function onClose(e:Event):void
		{
			//trace("onClose");
			if(parent)
				parent.removeChild(this);
			
		}
		
		protected  function onStage(e:Event):void
		{
			initEvent()
			//this.removeEventListener(Event.ADDED_TO_STAGE,onStage);
			trace("onStage");
		}
		
		protected function onRemove(e:Event):void
		{
			//this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemove);
			removeEvent();
			trace("onRemove");
		}
		

 
		 
	}
}