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
		private static const PlayerGraphic:Class;
		
		public function Herbivore() 
		{
			super();
			
			graphic = new Spritemap(PlayerGraphic, 10, 12);
		}
		
		
		
	}

}