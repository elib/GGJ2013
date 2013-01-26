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
			FP.world = new GameWorld();
		}
		
	}
	
}