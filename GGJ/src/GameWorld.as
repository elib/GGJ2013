package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class GameWorld extends World 
	{
		
		private var map :Map;
		
		public static var GRAVITY :Number = 100;
		
		public function GameWorld() 
		{
			super();
			//initializaition
			map = new Map();
			add(map);
		}
		
		override public function begin():void 
		{
			super.begin();
			//world begin
			FP.screen.color = 0x000099;
		}
		
	}

}