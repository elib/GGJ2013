package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Tree extends Entity 
	{
		
		[Embed(source = "res/Tree.png")]
		private static const TreeGraphics :Class;
		
		private var spritemap :Spritemap;
		
		private static const GROW_TIME :Number = 30;
		
		public function Tree(x :Number, y :Number) 
		{
			super();
			graphic = spritemap = new Spritemap(TreeGraphics, 64, 128);
			spritemap.add("growing", [0, 1, 2, 3, 4, 5, 6], 7 / GROW_TIME, false);
			spritemap.play("growing");
			this.x = x;
			this.y = y;
		}
		
	}

}