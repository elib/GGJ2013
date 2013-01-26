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
			super();
			
			graphic = new Spritemap(CarnivoreImg, 20, 20);
		}
		
		override protected function tryBitingTree():void 
		{
			// do nothing.
		}
		
	}

}