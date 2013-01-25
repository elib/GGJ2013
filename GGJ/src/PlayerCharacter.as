package  
{
	//Gal fix this kthx
	import net.flashpunk.*;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class PlayerCharacter extends PhysicsEntity
	{
		[Embed(source = "res/Character.png")]
		private static const PlayerGraphic:Class;
		
		private static const ACCELERATION_SPEED :Number = 40;
		private static const MAX_SPEED :Number = 50;
		private static const DRAG :Number = 20;
		
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
		
		override public function update():void 
		{
			super.update();
			input();
			physics();
			
			(graphic as Spritemap).angle = FP.angle(0, 0, position.x, position.y) + 90;
		}
		
		private function input():void 
		{
			acceleration.x = acceleration.y = 0;
			if (Input.check(Key.RIGHT)) acceleration.x += ACCELERATION_SPEED;
			if (Input.check(Key.LEFT)) acceleration.x -= ACCELERATION_SPEED;
			if (Input.check(Key.DOWN)) acceleration.y += ACCELERATION_SPEED;
			if (Input.check(Key.UP)) acceleration.y -= ACCELERATION_SPEED;
			
			if (acceleration.x > 0) (graphic as Spritemap).flipped = false;
			if (acceleration.x < 0) (graphic as Spritemap).flipped = true;
		}
		
		override protected function isColliding():Boolean 
		{
			var distFromCenter :Number = FP.distance(0, 0, position.x, position.y);
			return (distFromCenter < 20 || distFromCenter > 200);
		}
		
	}

}