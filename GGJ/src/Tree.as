package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Tree extends Entity implements ILiving
	{
		
		private var spritemap :Spritemap;
		
		private static const GROW_TIME :Number = 30;
		
		public var tilemapNum :int = 0;
		public var canBeEaten:Boolean = false;
		
		private static const MAX_HEALTH :Number = 100;
		private var health :Number = MAX_HEALTH;
		
		[Embed(source = "res/audio/tree-grow.mp3")]
		private static const TreeGrowSound :Class;
		
		private var TreeGrowSFX :Sfx = new Sfx(TreeGrowSound);
		
		public function Tree(treeGraphics :Class, frameWidth :int, frameHeight :int, growFrames :Array) 
		{
			super();
			
			graphic = spritemap = new Spritemap(treeGraphics, frameWidth, frameHeight, animationEnded);
			var arr :Array = new Array();
			spritemap.add("growing", growFrames, growFrames.length / GROW_TIME * (FP.random * 0.5 - 0.25 + 1), false);
			spritemap.play("growing");
			
			this.layer = Layers.LAYER_TREE;
			
			//spritemap.x = -frameWidth / 2;
			//spritemap.y = -frameHeight;
			
			setHitboxTo(spritemap);
		}
		
		private function animationEnded():void 
		{
			if (spritemap.currentAnim == "growing")
			{
				canBeEaten = true;
				TreeGrowSFX.play(FP.clamp((FP.world as GameWorld).getPlayerDistanceFromHeart() / 200, 0, 1));
			}
		}
		
		public function RotateTo(theAngle:Number):void {
			spritemap.relative = false;
			this.spritemap.angle = theAngle;
			spritemap.x = this.x;
			spritemap.y = this.y;
			FP.rotateAround(spritemap, new Point(0, 0), theAngle);
		}
		
		private var _center :Point = new Point(0, 0);
		
		override public function update():void 
		{
			super.update();
		}	
		public function bited(amount :Number):void 
		{
			health -= amount;
			if (health <= 0)
				die();
		}
		
		/* INTERFACE ILiving */
		
		public function getLife():Number 
		{
			return health / MAX_HEALTH;
		}
		
		private function die():void 
		{
			// TODO: Die
		}
		
	}
}