package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Heart extends Entity 
	{
		
		[Embed(source = "res/Heart.png")]
		private static const HeartGraphic :Class;
		
		[Embed(source = "res/audio/heartBeat.mp3")]
		private static const HeartSound :Class;
		
		private var heartSFX :Sfx = new Sfx(HeartSound);
		
		private var spritemap :Spritemap;
		
		public function Heart() 
		{
			super();
			graphic = spritemap = new Spritemap(HeartGraphic, 70, 70);
			spritemap.add("idle", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1], 10);
			spritemap.play("idle");
			x = - spritemap.width / 2;
			y = - spritemap.height / 2;
			heartSFX.loop();
		}
		
		override public function update():void 
		{
			super.update();
			heartSFX.volume = FP.clamp((1 - ((FP.world as GameWorld).getPlayerDistanceFromHeart() / 500)) * 2,0,2);
		}
		
	}

}