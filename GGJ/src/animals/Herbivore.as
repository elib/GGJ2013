package animals 
{
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author elibrody
	 */
	public class Herbivore extends Animal
	{
		
		[Embed(source = "../res/herbivore.png")]
		private static const HerbivoreImg:Class;
		
		public function Herbivore() 
		{
			super();
			
			graphic = new Spritemap(HerbivoreImg, 20, 20);
		}
		
		override protected function tryBitingAnimal():void 
		{
			// do nothing.
		}
		
	}

}