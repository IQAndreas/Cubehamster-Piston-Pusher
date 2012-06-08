package aRenberg.games.CubehamsterPistonPusher 
{
	import aRenberg.games.CubehamsterPistonPusher.Tile;
	import aRenberg.games.CubehamsterPistonPusher.TileType;

	/**
	 * @author andreas
	 */
	public class Piston extends Tile 
	{
		public function Piston(tileType : TileType, loc:GridLocation, sticky:Boolean) 
		{
			this.pistonRotation = tileType.rotation;
			this.sticky = sticky;

			super(tileType, loc);		
		}
		
		public var pistonRotation:int;
		public var sticky:Boolean;
		public var increasesCounter:Boolean = true;
		private var _extended:Boolean;
			
		override protected function onUpdate():void 
		{
			if (adjacentTileIsPowered())
			{
				this.extended = true;
			}
			else
			{
				this.extended = false;
			}
		}
		
		private function adjacentTileIsPowered():Boolean
		{
			return tileIsPowered(GridLocation.UP)
				||	tileIsPowered(GridLocation.DOWN)
				||	tileIsPowered(GridLocation.LEFT)
				||	tileIsPowered(GridLocation.RIGHT);
		}
		
		private function tileIsPowered(side:int):Boolean
		{
			var location:GridLocation = this.getLocation().getByID(side);
			var redstoneTorch:Redstone = location ? location.getTile() as Redstone : null;
			if (redstoneTorch)
			{
				return redstoneTorch.powered;
			}
			else
			{
				return false;
			}
		}
		
		public function get extended():Boolean
		{ return _extended; }
		
		public function set extended(value:Boolean):void
		{
			if (value == _extended) return;
			
			var headLoc:GridLocation = this.getLocation().getByID(this.pistonRotation);
			
			if (value)
			{
				var pushArray:Vector.<Tile> = getPushArray();
				
				if (increasesCounter) { grid.counter.value++; } 
				
				if (pushArray)
				{
					for each (var tile:Tile in pushArray)
					{
						var targetLoc:GridLocation = tile.getLocation().getByID(this.pistonRotation);
						tile.moveTo(targetLoc, true);
					}
					
					//Now create the piston head
					//Will automatically add itself to grid
					new PistonHead(headLoc, pistonRotation, true);
					this.setExtended();
					
					//Make sure this object is always on top!
					grid.container.addChild(this);
					
					_extended = true;
				}
			}
			else
			{
				//Retract
				var head:PistonHead = grid.getTile(headLoc.x, headLoc.y) as PistonHead;
				if (head && (head.pistonRotation == this.pistonRotation)) 
				{
					head.remove(true);
					
					if (this.sticky)
					{
						var stuckTileLoc:GridLocation = headLoc.getByID(pistonRotation);
						var stuckTile:Tile = (stuckTileLoc) ? stuckTileLoc.getTile() : null;
						if (stuckTile && stuckTile.tileType.pushable)
						{
							stuckTile.moveTo(headLoc, true);
						}
					}
				}
				//If there is no head, something is afoot!
				
				_extended = false;
			}
		}
		
		private function getPushArray():Vector.<Tile>
		{
			var pushArray:Vector.<Tile> = new Vector.<Tile>();
			
			var loc:GridLocation = this.getLocation();
			//Max 12 outward (avoids endless loops etc
			for (var i:int = 0; i < 12; i++)
			{
				loc = loc.getByID(this.pistonRotation);
				if (!loc) 
				{
					return null;
				}
				else 
				{
					var tile:Tile = loc.getTile();
					if (!tile)
					{
						return pushArray;
					}
					else if (tile.tileType.pushable)
					{
						pushArray.unshift(tile);
						continue;
					}
					else
					{
						return null;
					}
				}
			}
			
			//Array too long
			return null;
		}
		
		
		internal function setExtended():void
		{
			this.tileType = getExtendedBase();
		}
		
		internal function setRetracted():void
		{
			this.tileType = getRetractedBase();
		}
		
		private function getExtendedBase():TileType
		{
			switch (pistonRotation)
			{
				case GridLocation.LEFT: 	return TileType.pistonExtendedBaseL;
				case GridLocation.RIGHT: 	return TileType.pistonExtendedBaseR;
				case GridLocation.UP: 		return TileType.pistonExtendedBaseU;
				case GridLocation.DOWN: 	return TileType.pistonExtendedBaseD;
				default: return null;
			}
		}
		
		private function getRetractedBase():TileType
		{
			switch (pistonRotation)
			{
				case GridLocation.LEFT: 	return TileType.pistonRetractedL;
				case GridLocation.RIGHT: 	return TileType.pistonRetractedR;
				case GridLocation.UP: 		return TileType.pistonRetractedU;
				case GridLocation.DOWN: 	return TileType.pistonRetractedD;
				default: return null;
			}
		}
		
	}
}
