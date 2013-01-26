package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.TiledSpritemap;
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
		
		private var allMaps:Array;
		
		public function GameWorld() 
		{
			super();
			
			//initializaition
			allMaps = new Array();
			for (var i :int = 0; i < 6; i++)
			{
				map = new Map(360 / 6 * i, Levels.LEVELS[i]);
				allMaps.push(map);
				add(map);
			}
			
			player = new PlayerCharacter();
			add(player);
			
			heart = new Heart();
			add(heart);
			
			//test tree
			for (var q :int = 0 ; q < 5; q++)
			{
				var tree :Tree = (add(new (FP.choose([Tree1, Tree2, Tree3]) as Class)) as Tree);
				tree.whichTileMap = FP.rand(6);
				
				var theMap:Map = allMaps[tree.whichTileMap] as Map;
				
				var x:int = FP.rand(20);
				var col:int = x;
				
				var found:Boolean = false;
				var hei:int = -1;
				
				while (!found) {
					hei++;
					found = theMap.grid.getTile(col, hei);
				}
				
				trace("found at: " + x + ", " + hei);
				tree.x = x * 32 + theMap.x;
				tree.y = hei * 32 + theMap.y;
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