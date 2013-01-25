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
		private var player:PlayerCharacter;
		
		public static var GRAVITY :Number = 100;
		
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
		
		override public function update():void 
		{
			super.update();
			FP.camera.x = FP.lerp(FP.camera.x, player.centerX - FP.halfWidth, 0.02);
			FP.camera.y = FP.lerp(FP.camera.y, player.centerY - FP.halfHeight, 0.02);
		}
		
	}

}