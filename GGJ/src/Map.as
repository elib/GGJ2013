package  
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Galman33
	 */
	public class Map extends Entity 
	{
		
		private var tilemap :Tilemap;
		private var grid :Grid
		
		[Embed(source="res/TileSet.png")]
		private static const TilesetGraphic :Class;
		
		[Embed(source = "res/mockup_level_1.tmx", mimeType = "application/octet-stream")]
		private static const LEVEL_1 :Class;
		
		private static const SOLID_TILES :Array = [1, 2, 3, 4, 5, 6];
		
		private var bitmap :BitmapData;
		
		private var angle :Number;
		
		public function Map(angle :Number) 
		{
			super();
			loadMap();
			type = Types.TYPE_MAP;
			mask = grid = tilemap.createGrid(SOLID_TILES);
			bitmap = new BitmapData(tilemap.width, tilemap.height);
			
			var radius :Number = tilemap.width / ( 2 * Math.sin(Math.PI / 6));
			
			angle = angle / 180 * Math.PI + Math.PI / 2;
			x = Math.sin(angle) * radius;
			y = -Math.cos(angle) * radius;
			this.angle = angle - Math.PI / 2 - Math.PI * 2 / 6 * 2;
		}
		
		private function loadMap():void 
		{
			var bytes :ByteArray = new LEVEL_1();
			var xml :XML = new XML(bytes.readUTFBytes(bytes.length));
			graphic = tilemap = new Tilemap(TilesetGraphic, (int)(xml.@width) * (int)(xml.@tilewidth), (int)(xml.@height) * (int)(xml.@tileheight), xml.@tilewidth, xml.@tileheight);
			tilemap.loadFromString(xml.layer.data, ",", ",\n");
			for (var xx :int = 0; xx < tilemap.columns; xx++) {
				for (var yy :int = 0; yy < tilemap.rows; yy++) {
					var current:int = tilemap.getTile(xx, yy);
					if (current != 0) {
						tilemap.setTile(xx, yy, current - 1);
					}
				}
			}
		}
		
		private var _point :Point = new Point();
		private var _matrix :Matrix = new Matrix();
		
		override public function render():void 
		{
			bitmap.fillRect(bitmap.rect, 0);
			tilemap.render(bitmap, _point, _point);
			
			_matrix.identity();
			_matrix.rotate(angle);
			_matrix.translate( -FP.camera.x + x, -FP.camera.y + y);
			
			FP.buffer.draw(bitmap, _matrix);
		}
		
	}

}