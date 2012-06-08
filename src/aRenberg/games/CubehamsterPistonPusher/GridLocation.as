package aRenberg.games.CubehamsterPistonPusher 
{
	/**
	 * @author andreas
	 */
	public class GridLocation 
	{
		public function GridLocation(grid:Grid, x:uint, y:uint)
		{
			this.grid = grid;
			this.x = x;
			this.y = y;
		}
		
		public var grid:Grid;
		public var x:uint;
		public var y:uint;
		
		public function clone():GridLocation
		{
			return new GridLocation(grid, x, y);
		}
		
		public function getTile():Tile
		{
			return (grid) ? grid.getTile(x, y) : null;
		}
		
		public function get globalX():Number
		{ return (x * grid.tileWidth) + grid.offsetX; }
		
		public function get globalY():Number
		{ return (y * grid.tileHeight) + grid.offsetY; }
		
		public static const LEFT:int = -1;
		public static const RIGHT:int = 1;
		public static const UP:int = -2;
		public static const DOWN:int = 2;
		
		public static function getRotation(id:int):Number
		{
			switch (id)
			{
				case LEFT: return (-90 * Math.PI / 180);
				case RIGHT: return (90 * Math.PI / 180);
				case UP: return (0 * Math.PI / 180);
				case DOWN: return (180 * Math.PI / 180);
				default: return 0;
			}
		}
		
		public function getByID(id:int):GridLocation
		{
			switch (id)
			{
				case LEFT: return getLeft();
				case RIGHT: return getRight();
				case UP: return getAbove();
				case DOWN: return getBelow();
				default: return null;
			}
		}
		
		public function getAbove():GridLocation
		{
			return (y > 0) ? new GridLocation(grid, x, y-1) : null;
		}
		
		public function getBelow():GridLocation
		{
			return ((y+1) < grid.height) ? new GridLocation(grid, x, y+1) : null;
		}
		
		public function getLeft():GridLocation
		{
			return (x > 0) ? new GridLocation(grid, x-1, y) : null;
		}
		
		public function getRight():GridLocation
		{
			return ((x+1) < grid.width) ? new GridLocation(grid, x+1, y) : null;
		}
	}
}
