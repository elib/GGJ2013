package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Heart extends Entity 
	{
		
		[Embed(source = "res/Heart.png")]
		private static const HeartGraphic :Class;
		
		private var spritemap :Spritemap;
		
		public function Heart() 
		{
			super();
			graphic = spritemap = new Spritemap(HeartGraphic, 70, 70);
			spritemap.add("idle", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1], 10);
			spritemap.play("idle");
			x = - spritemap.width / 2;
			y = - spritemap.height / 2;
		}
		
	}

}