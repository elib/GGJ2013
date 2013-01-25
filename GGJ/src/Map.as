package  
{
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
		
		private static const TILE_SIZE :int = 32;
		
		[Embed(source="res/TileSet.png")]
		private static const TilesetGraphic :Class;
		
		private static const SOLID_TILES :Array = [0, 1];
		
		public function Map() 
		{
			super();
			graphic = tilemap = new Tilemap(TilesetGraphic, TILE_SIZE * 20, TILE_SIZE * 20, TILE_SIZE, TILE_SIZE);
			loadMap();
			grid = tilemap.createGrid(SOLID_TILES);
		}
		
		private function loadMap():void 
		{
			for (var xx :int = 0 ; xx < tilemap.columns; xx++)
				for (var yy :int = 0 ; yy < tilemap.rows; yy++)
					tilemap.setTile(xx, yy, yy > 7 ? 1 : 0);
		}
		
	}

}