package  
{
	//Gal fix this kthx
	import flash.geom.Point;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class PlayerCharacter extends PhysicsEntity
	{
		[Embed(source = "res/Character.png")]
		private static const PlayerGraphic:Class;
		
		[Embed(source="res/audio/flight-blow.mp3")]
		private static const FlightSound :Class;
		
		private var FlightSFX :Sfx = new Sfx(FlightSound);
		
		private static const ACCELERATION_SPEED :Number = 100;
		private static const MAX_SPEED :Number = 120;
		private static const DRAG :Number = 50;
		
		private var idleTime:Number = 0;
		private var yOffset:Number = 0;
		
		public function PlayerCharacter() 
		{
			graphic = new Spritemap(PlayerGraphic, 10, 12);
			type = Types.TYPE_PLAYER;
			(graphic as Spritemap).centerOrigin();
			setHitboxTo(graphic);
			originX = (graphic as Spritemap).width / 2;
			originY = (graphic as Spritemap).height / 2;
			acceleration.y = 0;
			maxSpeed.x = MAX_SPEED;
			maxSpeed.y = MAX_SPEED;
			drag.x = DRAG;
			drag.y = DRAG;
			position.y = 100;
		}
		
		private function get worldAngle():Number {
			return FP.angle(0, 0, position.x, position.y) + 90;
		}
		
		private function get downDirection():Point {
			var pt:Point = new Point();
			var ang:Number = worldAngle;
			
			pt.x = -Math.sin(Math.PI * ang / 180);
			pt.y = -Math.cos(Math.PI * ang / 180);
			
			return pt;
		}
		
		override public function update():void 
		{
			super.update();
			input();
			physics();
			
			(graphic as Spritemap).angle = worldAngle;
		}
		
		private function input():void 
		{
			acceleration.x = acceleration.y = 0;
			
			if (Input.pressed(Key.RIGHT) || Input.pressed(Key.D) || Input.pressed(Key.LEFT) || Input.pressed(Key.A)
				|| Input.pressed(Key.DOWN) || Input.pressed(Key.S) || Input.pressed(Key.UP) || Input.pressed(Key.W))
				FlightSFX.play(1);
			
			if (Input.check(Key.RIGHT) || Input.check(Key.D)) acceleration.x += 1;
			if (Input.check(Key.LEFT) || Input.check(Key.A) ) acceleration.x -= 1;
			if (Input.check(Key.DOWN) || Input.check(Key.S)) acceleration.y += 1;
			if (Input.check(Key.UP) || Input.check(Key.W)) acceleration.y -= 1;
			
			//prevent bicording 
			if (acceleration.length > 0) {
				acceleration.normalize(ACCELERATION_SPEED);
				
				//z element of cross product to determine direction
				// a x r
				var cross:Number = acceleration.x * position.y - position.x * acceleration.y;
				if (cross > 0) {
					(graphic as Spritemap).flipped = false;
				} else {
					(graphic as Spritemap).flipped = true;
				}
			}
			
			//Breakfast: It's Not Just For Idle Anymore
			idleTime += FP.elapsed;
			
			var amount:Number = Math.sin(idleTime * 2 * Math.PI / 3) * 5;
			var pt:Point = downDirection.clone();
			pt.normalize(amount);
			
			
			graphic.x = pt.x;
			graphic.y = pt.y;
		}
		
		override protected function isColliding():Boolean 
		{
			var distFromCenter :Number = FP.distance(0, 0, position.x, position.y);
			return (distFromCenter < 20 || distFromCenter > 700);
		}		
		
		public function getBelongingTilemap() :int
		{
			// TODO : FIXIXIXIIXIXIX
			var out :int = Math.floor((worldAngle - 90) / (360 / 6)) - 4;
			if (out < 0) out = 4 + out;
			return out;
		}
	}

}