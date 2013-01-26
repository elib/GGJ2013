package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Tree extends Entity 
	{
		
		private var spritemap :Spritemap;
		
		private static const GROW_TIME :Number = 30;
		
		public var tilemapNum :int = 0;
		
		public function Tree(treeGraphics :Class, frameWidth :int, frameHeight :int, growFrames :Array) 
		{
			super();
			
			graphic = spritemap = new Spritemap(treeGraphics, frameWidth, frameHeight);
			var arr :Array = new Array();
			spritemap.add("growing", growFrames, growFrames.length / GROW_TIME, false);
			spritemap.play("growing");
			//spritemap.x = -frameWidth / 2;
			//spritemap.y = -frameHeight;
			//spritemap.relative = false;
			setHitboxTo(spritemap);
		}
		
		private var _center :Point = new Point(0, 0);
		
		override public function update():void 
		{
			super.update();
			/*
			spritemap.x = Math.sin(Math.PI * 2 / 6 * tilemapNum) * FP.distance(0, 0, x + spritemap.width / 2, y + spritemap.height);
			spritemap.y = Math.cos(Math.PI * 2 / 6 * tilemapNum) * FP.distance(0, 0, x + spritemap.width / 2, y + spritemap.height);
			spritemap.angle = 360 /  6 * tilemapNum;
			*/
		}	
	}
}