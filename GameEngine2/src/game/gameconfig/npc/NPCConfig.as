package game.gameconfig.npc
{

	/**
	 * author:MK
	 * 2013-11-18
	 * 
	 */
	/**
	 * npc 配置 像链表一样 可以包括其他的npc的形式
	 */
	
	public class NPCConfig
	{
		public var id:int;
		public var func:Array=new Array();//NameToFunc
		public var str:String;
		public function NPCConfig()
		{
		}
		
		public function getFunctionbyName(name:String):Function
		{
			var func:NameToFunc;
			for(var i:int=0;i<this.func.length;i++)
			{
				func= this.func[i] as NameToFunc;
				if(func.Name==name)
					return func.Func;
			}
			return null;
		}
	}
}