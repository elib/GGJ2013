package  
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class GameWorld extends World 
	{
		
		private var map :Map;
		private var player:PlayerCharacter;
		
		public function GameWorld() 
		{
			super();
			
			//initializaition
			map = new Map();
			add(map);
			
			player = new PlayerCharacter();
			add(player);
		}
		
		override public function begin():void 
		{
			super.begin();
			//world begin
			FP.screen.color = 0x000099;
		}
		
	}

}