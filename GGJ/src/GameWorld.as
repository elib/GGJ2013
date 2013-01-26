package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.World;
	import trees.*;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class GameWorld extends World 
	{
		
		private var map :Map;
		private var player:PlayerCharacter;
		
		public static var GRAVITY :Number = 100;
		
		private var heart :Heart;
		
		public function GameWorld() 
		{
			super();
			
			//initializaition
			for (var i :int = 0; i < 6; i++)
			{
				map = new Map(360 / 6 * i, Levels.LEVELS[i]);
				add(map);
			}
			
			player = new PlayerCharacter();
			add(player);
			
			heart = new Heart();
			add(heart);
			
			//test tree
			for (var i :int = 0 ; i < 5; i++)
			{
				var tree :Tree = (add(new (FP.choose([Tree1, Tree2, Tree3]) as Class)) as Tree);
				tree.x = FP.rand(200) - 100;
				tree.y = FP.rand(200) - 100;
			}
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
		
		override public function render():void 
		{
			super.render();
			Draw.circle(0, 0, 5);
			Draw.circle(0, 0, 640);
		}
		
	}

}