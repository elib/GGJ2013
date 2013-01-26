package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Cloud extends Entity 
	{
		
		[Embed(source = "res/Cloud.png")]
		private static const CloudsGraphics :Class;
		
		private var cloudAngle :Number;
		private var cloudRadius :Number;
		private var cloudSpeed :Number;
		
		public function Cloud() 
		{
			super();
			graphic = new Spritemap(CloudsGraphics, 64, 32);
			(graphic as Spritemap).frame = FP.rand(4);
			(graphic as Spritemap).centerOO();
			
			cloudAngle = FP.random * 360;
			cloudRadius = FP.random * 250 + 100;
			cloudSpeed = FP.random * 20 + 5;
		}
		
		override public function update():void 
		{
			super.update();
			cloudAngle += cloudSpeed * FP.elapsed;
			FP.angleXY(this, cloudAngle, cloudRadius);
			(graphic as Spritemap).angle = cloudAngle - 90;
		}
		
	}

}