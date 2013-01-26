package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class IntroWorld extends World 
	{
		
		[Embed(source = "res/Intro.png")]
		private static const IntroGraphic :Class;
		
		private var image :Image;
		
		public function IntroWorld() 
		{
			super();
			image = new Image(IntroGraphic);
			image.x = (FP.width - image.width) / 2;
			image.alpha = 0;
			addGraphic(image);
			FP.screen.color = 0x00009F;
		}
		
		override public function update():void 
		{
			super.update();
			image.alpha += FP.elapsed * 0.5;
			if (Input.mousePressed)
				(FP.engine as Main).switchToGame();
		}
		
	}

}