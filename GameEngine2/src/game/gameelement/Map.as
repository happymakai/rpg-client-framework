package game.gameelement
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import core.Camera;
	


	public class Map extends Bitmap
	{
		static public const defaultMapImage:Bitmap = new Bitmap(new BitmapData(800,600,false,0xff0000));
		public var mapWidth:Number;
		public var mapHeight:Number;
		public var gridWidth:Number;//通过这里就可以查看出相对坐标
		public var girdHeight:Number;
		public var type:int;//2d横版 2.5d
		private var _map:BitmapData;
		//由服务器来判断 不可通过的区域
		public var building:Array;//半透明的点
		

		
		/*		
		public var gridWidth:int;
		public var gridHeight:int;
		public var xml:int;//分为小块的
		public var bitmapLoaded:Boolean;//biamap是否加载完成
		public var constructed:Boolean;//是否构建
		public var numBitamp:int;
		public var bitmapList:Vector.<BitmapData>;
		*/
		
		
		public function Map()
		{
			_map=Map.defaultMapImage.bitmapData;
			this.bitmapData =Map.defaultMapImage.bitmapData;
			
		}
		
		public function update():void
		{
			 this.bitmapData.copyPixels(this._map,this.rect,new Point(0,0));
		}
		
		public function set map(img:Bitmap):void
		{
			_map=img.bitmapData
			this.mapHeight = img.height;
			this.mapWidth = img.width;
			this.bitmapData.copyPixels(this._map,this.rect,new Point(0,0));
		}
		
		public function get map():Bitmap
		{
			return new Bitmap(_map);
		}
		
			
		private  function get rect():Rectangle
		{
			var x:int = Camera.x>=0?Camera.x:0;
			var y:int= Camera.y>=0?Camera.y:0;
			var width:int = Camera.width>0?Camera.width:800;
			var height:int = Camera.height>0?Camera.height:600;

			
			if(x+width>this.mapWidth)
			{
				if(width>=this.mapWidth)
				{
					width=this.mapWidth
					x=0;
				}
				else
				{
					x= this.mapWidth-width;
				}
			}
			
			if(y+height>this.mapHeight)
			{
				if(height>=this.mapHeight)
				{
					height= this.mapHeight;
					y=0;
				}
				else
				{
					y=this.mapHeight-height;
				}
			}
			return new Rectangle(x,y,width,height);
		}
		
	}
}