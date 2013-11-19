package Win.ui
{
	/**
	 * author:MK
	 * 2013-11-15
	 * 
	 */
	public interface IUI
	{
		  function drawBg():void;
		  function drawItem():void;
		  function initEvent():void;
		  function removeEvent():void;
		  function setData(obj:Object=null):void
		  function move(x:Number,y:Number):void
		  function setSize(width:Number,height:Number):void
	}

}