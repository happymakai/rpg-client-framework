package game.gameelement
{
	 
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.gameevent.DataEventDispatcher;
	import game.gameevent.IntEvent;

	//npc逻辑在这里

	public class Npc extends Sprite
	{
 
 
	  public var id:int;
 	  public var bitmap:Bitmap;
	  [Embed(source="res/npc1.png")]
	  private const NPC1:Class;
		public function Npc()
		{
				bitmap= new NPC1;
				this.addChild(bitmap);
				this.addEventListener(MouseEvent.CLICK,onCommunication)
				this.addEventListener(Event.ADDED_TO_STAGE,onStage);
				this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
		}
		
		public function npcTalk():void
		{
			
		}
		
		private function onStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		
		private function onRemoveStage(e:Event):void
		{
			this.removeEventListener(MouseEvent.CLICK,onCommunication);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStage);
		}
		
		private function onCommunication(e:Event):void
		{
			DataEventDispatcher.dispatchEvent(new IntEvent(IntEvent.npcCommunication,this.id,true));
		}
		
		
	}
}