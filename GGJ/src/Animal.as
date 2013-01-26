package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author Galman33
	 */
	public class Animal extends PhysicsEntity implements ILiving
	{
		private var health :Number = MAX_HEALTH;
		private var hungriness :Number = 0;
		
		private static const MAX_HEALTH :Number = 100;
		
		private static const HUNGRY_TREE :Number = 10;
		private static const HUNGRY_ANIMAL :Number = 25;
		
		public var tilemapNum:int = 0;
		
		public function Animal() 
		{
			super();
			
			layer = Layers.LAYER_ANIMAL;
		}
		
		override public function update():void 
		{
			super.update();
			
			setToTopOfTileMap();
			
			showRotatedImage();
			
			hungriness += FP.elapsed;
			health -= hungriness * FP.elapsed;
			if (hungriness >= HUNGRY_ANIMAL)
				tryBitingAnimal();
			if (hungriness >= HUNGRY_TREE)
				tryBitingTree();
			if (health <= 0)
				die(true);
		}
		
		private function setToTopOfTileMap():void {
			//TODO: IT
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
			// TODO: Check if can bite other animals
		}
		
		private function biteAnimal(animal :Animal) :void
		{
			animal.bited(hungriness);
			hungriness = 0;
		}
		
		private function bited(amount :Number):void 
		{
			health -= amount;
			if(health <= 0)
				die(false);
		}
		
		protected function tryBitingTree():void 
		{
			// TODO: Check if can bite a tree
		}
		
		private function biteTree(tree :Tree) :void 
		{
			tree.bited(hungriness);
			hungriness = 0;
		}
		
		private function die(corpse :Boolean):void 
		{
			// TODO: die
			if (corpse)
			{
				// TODO: add corpse
			}
		}
		
	}

}