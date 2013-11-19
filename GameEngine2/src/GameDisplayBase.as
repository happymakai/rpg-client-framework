package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class GameDisplayBase extends Sprite
	{
		private var elist:Array;
		public function GameDisplayBase()
		{
			super();
			elist=new Array();
			this.addEventListener(Event.ADDED_TO_STAGE,AddToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemove);
		}
		protected function addEventList(cls:Object,eventType:String,callBackFun:Function):void
		{
			elist.push([cls,eventType,callBackFun])
		}
		private function ,AddToStage(e:Event):void
		{
			for(var i:int=0;i<elist.length;i++)
			{
				elist[i][0].addEventListener(elist[i][1],elist[i][2]);
			}
		}
		private function onRemove(e:Event):void
		{
			for(var i:int=0;i<elist.length;i++)
			{
				elist[i][0].removeEventListener(elist[i][1],elist[i][2]);
			}
		}
		public function dispose():void
		{
			elist=null;
		}
	}
}