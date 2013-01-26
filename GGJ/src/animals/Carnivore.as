package animals 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author elibrody
	 */
	public class Carnivore extends Animal
	{
		
		[Embed(source = "../res/carnivore.png")]
		private static const CarnivoreImg:Class;
		
		public function Carnivore() 
		{
			super(CarnivoreImg, 20, 20);
			
			spritemap.add(ANIM_IDLE, [0]);
			spritemap.add(ANIM_WALK, [1, 2, 3, 4, 5], 5);
			spritemap.add(ANIM_HIT, [19], 1);
			spritemap.add(ANIM_EAT, [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 10, false);
			spritemap.add(ANIM_DIE, [20, 21, 22]);
		}
		
		override protected function tryBitingTree():void 
		{
			// do nothing.
		}
		
	}

}