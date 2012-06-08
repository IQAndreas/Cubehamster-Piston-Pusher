package aRenberg.games.CubehamsterPistonPusher {
	import aRenberg.games.CubehamsterPistonPusher.Tile;
	import aRenberg.games.CubehamsterPistonPusher.TileType;

	/**
	 * @author andreas
	 */
	public class PistonHead extends Tile 
	{
		public function PistonHead(loc:GridLocation, pistonRotation:int, tween:Boolean) 
		{
			this.pistonRotation = pistonRotation;
			super(getTileType(pistonRotation), loc);
			
			if (tween)
			{
				var originLoc:GridLocation = loc.getByID(-pistonRotation);
				this.x = originLoc.globalX;
				this.y = originLoc.globalY;
				this.moveTo(loc, true);
			}
		}
		
		public function remove(tween:Boolean):void
		{
			var currentLoc:GridLocation = this.getLocation();
			var originLoc:GridLocation = currentLoc.getByID(-pistonRotation);
			var originPiston:Piston = (originLoc) ? originLoc.getTile() as Piston : null;
			
			grid.setTile(null, currentLoc.x, currentLoc.y); 
			if (tween) { this.tweenTo(originLoc.globalX, originLoc.globalY, removeFromContainer, originPiston); }
			else { this.removeFromContainer(originPiston); }
		}
		
		private function removeFromContainer(originPiston:Piston):void
		{
			grid.container.removeChild(this);
			if (originPiston)
			{
				originPiston.setRetracted();
			}
		}
		
		private function getTileType(rotation:int):TileType
		{
			switch (rotation)
			{
				case GridLocation.LEFT: 	return TileType.pistonExtendedHeadL;
				case GridLocation.RIGHT: 	return TileType.pistonExtendedHeadR;
				case GridLocation.UP: 		return TileType.pistonExtendedHeadU;
				case GridLocation.DOWN: 	return TileType.pistonExtendedHeadD;
				default: return null;
			}
		}
		
		public var pistonRotation:int;
	}
}
