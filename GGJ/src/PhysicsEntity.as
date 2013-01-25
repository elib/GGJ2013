package  
{
	import flash.geom.Point;
	import heroes.Tank;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class PhysicsEntity extends Entity 
	{
		
		public static const UP :uint = 1;
		public static const DOWN :uint = 2;
		public static const RIGHT :uint = 4;
		public static const LEFT :uint = 8;
		
		private var collidingSides :uint;
		
		public var position :Point = new Point();
		protected var velocity :Point = new Point();
		protected var acceleration :Point = new Point(0, GameWorld.GRAVITY);
		protected var drag :Point = new Point();
		protected var maxSpeed :Point = new Point(9999, 9999);
		protected var elasticity :Number = 0;
		
		public function PhysicsEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			position.x = x;
			position.y = y;
		}
		
		protected function physics():void 
		{
			var realDrag :Number;
			var direction :int;
			collidingSides = 0;
			
			velocity.x += acceleration.x * FP.elapsed;
			
			realDrag = drag.x * FP.elapsed;
			
			if (velocity.x - realDrag > 0) velocity.x -= realDrag;
			else if (velocity.x + realDrag < 0) velocity.x += realDrag;
			else velocity.x = 0;
			
			velocity.x = FP.clamp(velocity.x, -maxSpeed.x, maxSpeed.x);
			
			position.x += velocity.x * GameWorld.GAME_SCALE * FP.elapsed;
			if (collide("Map", position.x, position.y) || position.x < 0 || position.x + width > (FP.world as GameWorld).theMap.width)
			{
				direction = FP.sign(velocity.x);
				while (collide("Map", position.x, position.y))
					position.x -= 0.1 * direction;
				if (position.x < 0)
					position.x = 0;
				if (position.x + width > (FP.world as GameWorld).theMap.width)
					position.x = (FP.world as GameWorld).theMap.width - width;
				if (position.x <= 0 || velocity.x < 0)
					collidingSides |= LEFT;
				else
					collidingSides |= RIGHT;
					
				velocity.x *= -elasticity;
			}
			
			
			velocity.y += acceleration.y * FP.elapsed;
			
			realDrag = drag.y  * FP.elapsed;
			if (velocity.y - realDrag > 0) velocity.y -= realDrag;
			else if (velocity.y + realDrag < 0) velocity.y += realDrag;
			else velocity.y = 0;
			
			velocity.y = FP.clamp(velocity.y, -maxSpeed.y, maxSpeed.y);
			
			position.y += velocity.y * GameWorld.GAME_SCALE * FP.elapsed;
			if (collide("Map", position.x, position.y))
			{
				direction = FP.sign(velocity.y);
				while (collide("Map", position.x, position.y))
					position.y -= 0.1 * direction;
				if (velocity.y > 0)
					collidingSides |= DOWN;
				else
					collidingSides |= UP;
				velocity.y *= -elasticity;
			}
				
			x = /*Math.floor(*/position.x/*)*/;
			y = /*Math.floor(*/position.y/*)*/;
		}
		
		public function isCollidingOnSides(sides :uint) :Boolean
		{
			return ((collidingSides & sides) != 0);
		}
		
		
	}

}