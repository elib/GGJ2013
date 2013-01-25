package  
{
	//Gal fix this kthx
	import net.flashpunk.*;
	import net.flashpunk.graphics.Spritemap;
	
	public class PlayerCharacter extends Entity
	{
		[Embed(source = "res/Character.png")]
		private static const PlayerGraphic:Class;
		
		public function PlayerCharacter() 
		{
			graphic = new Spritemap(PlayerGraphic, 10, 12);
			type = Types.TYPE_PLAYER;
		}
		
	}

}