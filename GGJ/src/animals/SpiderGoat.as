package animals 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author elibrody
	 */
	public class SpiderGoat extends Animal
	{
		
		[Embed(source = "../res/Spidergoat.png")]
		private static const SpiderGoatImg:Class;
		
		public function SpiderGoat() 
		{
			super(SpiderGoatImg, 20, 20);
			
			spritemap.add(ANIM_IDLE, [0]);
			spritemap.add(ANIM_WALK, [1, 2, 3, 4, 5, 6, 7, 8], 8);
			spritemap.add(ANIM_HIT, [12, 13], 2);
			spritemap.add(ANIM_EAT, [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 10, false);
			spritemap.add(ANIM_DIE, [14, 15, 16, 17], 4, false);
		}
		
	}

}