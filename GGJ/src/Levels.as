package  
{
	/**
	 * ...
	 * @author Galman33
	 */
	public class Levels 
	{
		
		[Embed(source = "res/mockup_level_1.tmx", mimeType = "application/octet-stream")]
		private static const LEVEL_1 :Class;
		
		[Embed(source = "res/mockup_level_2.tmx", mimeType = "application/octet-stream")]
		private static const LEVEL_2 :Class;
		
		public static const LEVELS :Array = [LEVEL_1, LEVEL_2, LEVEL_1, LEVEL_2, LEVEL_1, LEVEL_2];
		
	}

}