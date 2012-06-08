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
		
		private function updatePower():void
		{
			updatePowerTo(GridLocation.UP);
			updatePowerTo(GridLocation.DOWN);
			updatePowerTo(GridLocation.LEFT);
			updatePowerTo(GridLocation.RIGHT);
		}
		
		private function updatePowerTo(side:int):void
		{
			var location:GridLocation = this.getLocation().getByID(side);
			if (location)
			{
				var piston:Piston = location.getTile() as Piston;
				if (piston)
				{
					piston.extended = this.powered;
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
			
			this.updatePower();
		}
	}
}
