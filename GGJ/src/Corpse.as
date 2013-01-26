package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Corpse extends Entity 
	{
		
		private var timeToVanish :Number = 10;
		
		public function Corpse() 
		{
			super();
		}
		
		
		override public function update():void 
		{
			super.update();
			timeToVanish -= FP.elapsed;
			if (timeToVanish <= 0)
				vanish();
		}
		
		private function watered() :void
		{
			// TODO: respawn tree
		}
		
		private function vanish():void 
		{
			// TODO: vanishing
		}
		
	}

}