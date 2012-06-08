package aRenberg.games.CubehamsterPistonPusher 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import aRenberg.games.CubehamsterPistonPusher.Tile;
	import aRenberg.games.CubehamsterPistonPusher.TileType;
	import aRenberg.games.CubehamsterPistonPusher.GridLocation;

	/**
	 * @author andreas
	 */
	public class Redstone extends Tile 
	{
		public function Redstone(tileType:TileType, loc:GridLocation, powered:Boolean) 
		{
			super(tileType, loc);
			
			this.powered = powered;
			
			this.addEventListener(MouseEvent.CLICK, clicked);
		}
		
		private function clicked(event:Event):void
		{
			if (Tile.tweensRunning) return;
			
			this.powered = !this.powered;
		}
		
		private function updateAdjacentTile(side:int):void
		{
			var location:GridLocation = this.getLocation().getByID(side);
			if (location)
			{
				var tile:Tile = location.getTile();
				if (tile)
				{
					tile.update();
				}
			}
		}
		
		public function get powered():Boolean
		{
			return (tileType == TileType.torchOn);
		}
		public function set powered(value:Boolean):void
		{
			if (value)
			{
				this.tileType = TileType.torchOn;
			}
			else
			{
				this.tileType = TileType.torchOff;
			}
			
			// Update all surrounding tiles
			updateAdjacentTile(GridLocation.UP);
			updateAdjacentTile(GridLocation.DOWN);
			updateAdjacentTile(GridLocation.LEFT);
			updateAdjacentTile(GridLocation.RIGHT);
		}
	}
}
