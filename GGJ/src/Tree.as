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
		
		private var spritemap :Spritemap;
		
		private static const GROW_TIME :Number = 30;
		
		public function Tree(treeGraphics :Class, frameWidth :int, frameHeight :int, growFrames :Array) 
		{
			super();
			graphic = spritemap = new Spritemap(treeGraphics, frameWidth, frameHeight);
			var arr :Array = new Array();
			spritemap.add("growing", growFrames, growFrames.length / GROW_TIME, false);
			spritemap.play("growing");
			this.x = x;
			this.y = y;
		}
		
	}

}