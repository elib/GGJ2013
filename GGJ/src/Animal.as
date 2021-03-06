package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	/**
	 * ...
	 * @author Galman33
	 */
	public class Animal extends PhysicsEntity implements ILiving
	{
		private var health :Number = MAX_HEALTH;
		private var hungriness :Number = 0;
		
		public var alive:Boolean = true;
		
		private static const MAX_HEALTH :Number = 100;
		
		private static const HUNGRY_TREE :Number = 5;
		private static const HUNGRY_ANIMAL :Number = 10;
		
		public var tilemapNum:int = 0;
		
		protected var spritemap :Spritemap;
		
		protected static const ANIM_IDLE :String = "ANIM_IDLE";
		protected static const ANIM_WALK :String = "ANIM_WALK";
		protected static const ANIM_HIT :String = "ANIM_HIT";
		protected static const ANIM_EAT :String = "ANIM_EAT";
		protected static const ANIM_DIE :String = "ANIM_DIE";
		
		private var movementAlarm:Alarm;
		
		[Embed(source="res/audio/chew.mp3")]
		private static const BiteSound :Class;
		
		private var BiteSFX :Sfx = new Sfx(BiteSound);
		
		public function Animal(animalGraphics :Class, frameWidth :int, frameHeight :int) 
		{
			super();
			
			this.acceleration = FP.zero;
			this.drag = FP.zero;
			
			movementAlarm = new Alarm(1);
			
			setBehaviorAlarm();
			
			layer = Layers.LAYER_ANIMAL;
			
			graphic = spritemap = new Spritemap(animalGraphics, frameWidth, frameHeight, animationEnded)
		}
		
		override public function added():void 
		{
			super.added();
			spritemap.play(ANIM_IDLE);
		}
		
		private function animationEnded():void 
		{
			if (spritemap.currentAnim != ANIM_IDLE && spritemap.currentAnim != ANIM_WALK && spritemap.currentAnim != ANIM_DIE)
			{
				spritemap.play(ANIM_IDLE);
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			movementAlarm.update();
			
			if(alive) {
				
				doMovement();
				
				physics();
			}
			
			setToTopOfTileMap();
			
			showRotatedImage();
			
			hungriness += FP.elapsed;
			if (spritemap.currentAnim == ANIM_IDLE || spritemap.currentAnim == ANIM_WALK)
				spritemap.play(velocity.x == 0 ? ANIM_IDLE : ANIM_WALK);
			if (velocity.x > 0) spritemap.flipped = false;
			if (velocity.x < 0) spritemap.flipped = true;
			
			if (hungriness > HUNGRY_ANIMAL * 2) {
				health -= FP.elapsed;
			}
			//health -= hungriness * FP.elapsed;
			if (hungriness >= HUNGRY_ANIMAL)
				tryBitingAnimal();
			if (hungriness >= HUNGRY_TREE)
				tryBitingTree();
			if (health <= 0)
				die(true);
		}
		
		private function setBehaviorAlarm():void {
			movementAlarm.reset((FP.random * 5) + 1);
			
			this.velocity.x = 100 * (FP.random - 0.5);
		}
		
		private function doMovement():void {
			if (movementAlarm.percent >= 1) {
				setBehaviorAlarm();
			}
			
			var thisMap:Map = (FP.world as GameWorld).allMaps[tilemapNum];
			var xpos:Number = this.x + thisMap.width / 2;
			xpos = FP.clamp(xpos, 30, thisMap.width - 30);
			this.x = xpos - thisMap.width / 2;
		}
		
		private function setToTopOfTileMap():void {
			//TODO: IT
			
			var radiusFactor:Number = (FP.world as GameWorld).radiusFactor;
			var thisMap:Map = (FP.world as GameWorld).allMaps[tilemapNum];
			
			var x:Number = this.x - this.width / 2 + thisMap.grid.width / 2;
			var col:Number = x / 32;
			
			var found:Boolean = false;
			var hei:int = -1;
			
			var maxHei:int = 20;
			while (!found && hei < maxHei) {
				hei++;
				found = thisMap.grid.getTile(col, hei);
			}
			
			this.y = (hei - 1) * 32 + 10 - thisMap.grid.height / 4 + thisMap.width * radiusFactor;
		}
		
		public function showRotatedImage():void {
			
			var theAngle:Number = tilemapNum * 360 / (FP.world as GameWorld).allMaps.length;
			var spritemap:Spritemap = graphic as Spritemap;
			
			spritemap.relative = false;
			spritemap.angle = theAngle;
			
			spritemap.x = this.x;
			spritemap.y = this.y;
			FP.rotateAround(spritemap, new Point(0, 0), theAngle);
		}
		
		/* INTERFACE ILiving */
		
		public function getLife():Number 
		{
			return health / MAX_HEALTH;
		}
		
		protected function tryBitingAnimal():void 
		{
			var thisMap:Map = (FP.world as GameWorld).allMaps[tilemapNum];
			var closestAnimal:Animal = null;
			var closestDist:Number = 10000;
			for (var i:int = 0; i < thisMap.animals.length; i++) {
				var theAnimal:Animal = thisMap.animals[i];
				if(theAnimal != this && theAnimal.alive) {
					var dist:Number = FP.distanceRects(theAnimal.x, theAnimal.y, theAnimal.width, theAnimal.height, this.x, this.y, this.width, this.height);
					if (dist < closestDist) {
						closestAnimal = theAnimal;
						closestDist = dist;
					}
				}
			}
			
			if (closestAnimal != null) {
				if (closestDist < 40) {
					biteAnimal(closestAnimal);
				}
			}
		}
		
		private function biteAnimal(animal :Animal) :void
		{
			animal.bited(hungriness * 3);
			hungriness = 0;
			playBiteSound();
		}
		
		private function playBiteSound():void 
		{
			if(tilemapNum == (FP.world as GameWorld).player.getBelongingTilemap())
					BiteSFX.play(FP.clamp((1 - ((FP.world as GameWorld).getPlayerDistanceFromHeart() / 500)),0,1));
		}
		
		public function bited(amount :Number):void 
		{
			health -= amount;
			spritemap.play(ANIM_HIT);
			if(health <= 0)
				die(false);
		}
		
		protected function tryBitingTree():void 
		{
			var thisMap:Map = (FP.world as GameWorld).allMaps[tilemapNum];
			
			var closestTree:Tree = null;
			var closestDist:Number = 10000;
			for (var i:int = 0; i < thisMap.trees.length; i++) {
				var theTree:Tree = thisMap.trees[i];
				if(theTree.alive && theTree.canBeEaten) {
					var dist:Number = FP.distanceRects(theTree.x, theTree.y, theTree.width, theTree.height, this.x, this.y, this.width, this.height);
					if (dist < closestDist) {
						closestTree = theTree;
						closestDist = dist;
					}
				}
			}
			
			if (closestTree != null) {
				if (closestDist < 40) {
					biteTree(closestTree);
				}
			}
		}
		
		private function biteTree(tree :Tree) :void 
		{
			tree.bited(hungriness);
			hungriness = 0;
			playBiteSound();
		}
		
		private function die(corpse :Boolean):void 
		{
			// TODO: die
			spritemap.play(ANIM_DIE);
			if (corpse)
			{
				alive = false;
			}
		}
		
	}

}