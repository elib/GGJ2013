package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author elibrody
	 */
	public class Main extends Engine 
	{
		
		
		public function Main():void 
		{
			super(640, 480);
		}
		
		override public function init():void 
		{
			super.init();
			FP.console.enable();
			
			switchToIntro();
			
			Music.init();
			Music.resume();
		}
		
		public function switchToIntro() :void
		{
			FP.world = new IntroWorld();
		}
		
		public function switchToGame() :void
		{
			FP.world = new GameWorld();
		}
		
	}
	
}