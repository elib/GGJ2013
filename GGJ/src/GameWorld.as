package  
{
	import animals.Carnivore;
	import animals.Herbivore;
	import animals.SpiderGoat;
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
		public var player:PlayerCharacter;
		
		public static var GRAVITY :Number = 100;
		
		private var heart :Heart;
		
		
		private var numMaps:int = 6;
		public var allMaps:Array;
		
		public function get radiusFactor() :Number {
			return 1 / ( 2 * Math.sin(Math.PI / numMaps));
		}
		
		public function GameWorld() 
		{
			super();
			
			
			
			var eachAngle:Number = 360 / Number(numMaps);
			
			//initializaition
			allMaps = new Array();
			
			for (var i :int = 0; i < numMaps; i++)
			{
				map = new Map(360 / numMaps * i, Levels.LEVELS[i], radiusFactor);
				allMaps.push(map);
				add(map);
			}
			
			player = new PlayerCharacter();
			add(player);
			
			heart = new Heart();
			add(heart);
			
			var theMap:Map;
			var col:int, x:int;
			
			//add animals
			for (var p:int = 0; p < 50; p++) {
				var animal :Animal= (add(new (FP.choose([Herbivore, Carnivore, SpiderGoat]) as Class)) as Animal);
				animal.tilemapNum = FP.rand(numMaps);
				
				theMap = allMaps[animal.tilemapNum] as Map;
				theMap.animals.push(animal);
				
				x = FP.rand(theMap.grid.columns);
				
				animal.x = x * 32 - theMap.grid.width / 2;
				animal.y = -animal.height - theMap.grid.height / 4 + theMap.width * radiusFactor;
			}
			
			//add trees
			for (var q :int = 0 ; q < 50; q++)
			{
				var tree :Tree = (add(new (FP.choose([Tree1, Tree2, Tree3]) as Class)) as Tree);
				tree.tilemapNum = FP.rand(numMaps);
				
				theMap = allMaps[tree.tilemapNum] as Map;
				theMap.trees.push(tree);
				
				x = FP.rand(theMap.grid.columns);
				col = x;
				
				var found:Boolean = false;
				var hei:int = -1;
				
				while (!found) {
					hei++;
					found = theMap.grid.getTile(col, hei);
				}
				
				tree.x = x * 32 - theMap.grid.width/2 - tree.width/4;
				tree.y = hei * 32 - tree.height -theMap.grid.height / 4 + theMap.width * radiusFactor;
				
				tree.RotateTo(eachAngle * tree.tilemapNum);
			}
			
			// Add clouds
			for (var c :int = FP.rand(15) + 10; c > 0; c--)
				add(new Cloud());
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
			FP.screen.color = FP.getColorRGB((1 - getWorldHealth()) * 0x99, 0, getWorldHealth() * 0x99);
			Music.setGoodMusicLevel(getWorldHealth());
		}
			
		public function getWorldHealth() :Number
		{
			var arr :Vector.<ILiving> = new Vector.<ILiving>();
			getClass(ILiving, arr);
			var sum :Number = 0;
			for (var i :int = 0; i < arr.length; i++)
				sum += arr[i].getLife();
			return FP.clamp(sum / arr.length, 0, 1);
		}
		
		public function getPlayerDistanceFromHeart() :Number
		{
			return FP.distance(0, 0, player.x, player.y);
		}
		
	}
}