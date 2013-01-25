package  
{
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
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
		
		private static const SOLID_TILES :Array = [1, 2];
		
		public function Map() 
		{
			super();
			loadMap();
			grid = tilemap.createGrid(SOLID_TILES);
		}
		
		private function loadMap():void 
		{
			var bytes :ByteArray = new LEVEL_1();
			var xml :XML = new XML(bytes.readUTFBytes(bytes.length));
			graphic = tilemap = new Tilemap(TilesetGraphic, (int)(xml.@width) * (int)(xml.@tilewidth), (int)(xml.@height) * (int)(xml.@tileheight), xml.@tilewidth, xml.@tileheight);
			tilemap.loadFromString(xml.layer.data);
			for (var xx :int = 0; xx < tilemap.columns; xx++) {
				for (var yy :int = 0; yy < tilemap.rows; yy++) {
					var current:int = tilemap.getTile(xx, yy);
					if (current != 0) {
						tilemap.setTile(xx, yy, current - 1);
					}
				}
			}
		}
		
	}

}