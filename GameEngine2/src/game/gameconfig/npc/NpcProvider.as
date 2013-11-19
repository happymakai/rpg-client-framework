package game.gameconfig.npc
{

	/**
	 * author:MK
	 * 2013-11-18
	 * 
	 */
	
	public class NpcProvider
	{
		static public var npcs:Array=new Array() ;//NPCConfig
		static private var _instance :NpcProvider = new NpcProvider();
		public function NpcProvider()
		{
			var npc:NPCConfig;
			var fun1:NameToFunc;
			var fun2:NameToFunc;
			for(var i:int=0;i<10;i++)
			{
				npc = new NPCConfig();
				npc.id=i;
				npc.str="<a href='event:a"+i+"'>a</a>\n"+
					"<a href='event:b"+i+"'>b</a>\n"+
					"i am "+i;
				fun1 =new NameToFunc();
				 fun1.Name="a"+i;
				 fun1.Func = a;
				 fun2 =new NameToFunc();
				 fun2.Name="b"+i;
				 fun2.Func=b;
				 npc.func.push(fun1);
				 npc.func.push(fun2);
				 npcs.push(npc);					
			}
		}
		
		static public  function  a(i:int):void
		{
			trace("i am"+i+"a");
		}
		static  public function   b(i:int):void
		{
			trace("i am"+i+"b");
		}
		
		static public function getNpcStrById(id:int):String
		{
			var npc :NPCConfig;
			var i:int;
			for(i=0;i<npcs.length;i++)
			{
				npc = NpcProvider.npcs[i] as NPCConfig;
				if(npc .id==id)
				{
					 return npc.str;
				}
			}
			return "";
		}
 
 
		
		static public function getNpcById(id:int):NPCConfig
		{
			var npc :NPCConfig;
			var i:int;
			for(i=0;i<npcs.length;i++)
			{
				npc = npcs[i] as NPCConfig;
				if(npc.id==id)
				{
					return npc;
				}
			}
			return new NPCConfig;
		}
	}
}