package Win.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	
	public class NineGridBitmap extends Bitmap
	{
		public var _leftTop:BitmapData;
		public  var _leftCenter:BitmapData;
		public var _leftBottom:BitmapData;
		
		public var _rightTop:BitmapData;
		public var _rightCenter:BitmapData;
		public var _rightBottom:BitmapData;
		
		public var _midTop:BitmapData;
		public var _midCenter:BitmapData;
		public var _midBottom:BitmapData;
		
		private var _cutted:Boolean=false;
		
		 
		public function NineGridBitmap(bitmap:Bitmap,left:Number,right:Number,top:Number,bottom:Number)
		{
			if(bitmap.bitmapData)
			{
				this.bitmapData = bitmap.bitmapData.clone();
		 
				if(left+right<bitmap.width)
				{
					if(top+bottom<bitmap.height)
					{
						var height :Number=bitmap.height;
						var width :Number= bitmap.width;
						
						this._cutted=true;
						_leftTop = new BitmapData(left,top);
						_leftTop.draw(bitmapData,null,null,null,new Rectangle(0,0,left,top));
	
//						_leftCenter = new BitmapData(left,height-top-bottom);
//						_leftCenter.draw(bitmapData,null,null,null,new Rectangle(0,top,left,height-top-bottom));
						
						_leftBottom = new BitmapData(left,bottom);
						_leftBottom.draw(bitmapData,null,null,null,new Rectangle(0,height-bottom,left,bottom));
						_leftBottom.draw(bitmapData,null,null,null,new Rectangle(0,0,left,bottom));
						
						
						_rightTop = new BitmapData(right,top);
						_rightTop.draw(bitmapData,null,null,null,new Rectangle(width-right,0,right,top));
						
						_rightCenter = new BitmapData(right,height-top-bottom);
						_rightCenter.draw(bitmapData,null,null,null,new Rectangle(width-right,top,right,height-top-bottom));
						
						_rightBottom = new BitmapData(right,bottom);
						_rightBottom.draw(bitmapData,null,null,null,new Rectangle(width-right,height-bottom,right,bottom));
						
						
						_midTop = new BitmapData(width-left-right,top);						
						_midTop.draw(bitmapData,null,null,null,new Rectangle(left,0,width-left-right,top));
						
						_midCenter = new BitmapData(width-left-right,height-top-bottom);						
						_midCenter.draw(bitmapData,null,null,null,new Rectangle(left,top,width-left-right,height-top-bottom));
						
						_midBottom = new BitmapData(width-left-right,bottom);						
						_midBottom.draw(bitmapData,null,null,null,new Rectangle(left,height-bottom,width-left-right,bottom));
					
					}
					
				}
			}
		}
		
		public function setSize(width:Number,height:Number):void
		{
			if(this._cutted)
			{
				this.bitmapData = new BitmapData(width,height);
//				this.bitmapData.draw(_leftTop);
//				this.bitmapData.draw(_leftCenter);
			 
//				this.bitmapData.draw(_leftBottom); //----
//				this.bitmapData = _rightTop;
				this.bitmapData.draw(_rightTop);//---
//				this.bitmapData.draw(_rightCenter);//---
//				this.bitmapData.draw(_rightBottom);//---
//				this.bitmapData.draw(_midTop);
//				this.bitmapData.draw(_midCenter);
//				this.bitmapData.draw(_midBottom);//===
					
				
			}
 		}
		
		
		
		
		
	}
}