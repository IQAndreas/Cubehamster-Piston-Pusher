package aRenberg.games.CubehamsterPistonPusher 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	/**
	 * @author andreas
	 */
	public class Tile extends Sprite
	{
		public static function makeTile(tileType:TileType, loc:GridLocation):Tile
		{
			if (tileType.isPiston)
			{
				return new Piston(tileType, loc, false);
			}
			else if (tileType == TileType.torchOn)
			{
				return new Redstone(tileType, loc, true);
			}
			else if (tileType == TileType.torchOff)
			{
				return new Redstone(tileType, loc, false);
			}
			
			//else
			return new Tile(tileType, loc);
		}
		
		public function Tile(tileType:TileType, loc:GridLocation)
		{
			this.grid = loc.grid;
			this._tileType = tileType;
			
			grid.setTile(this, loc.x, loc.y);
			this.x = loc.globalX;
			this.y = loc.globalY;
			
			this.redraw();
			grid.container.addChild(this);
			
			this.update();
		}
		
		public var grid:Grid;
		
		public final function update():void
		{
			this.onUpdate();
		}
		
		protected function onUpdate():void
		{
			//Override me plz...
		}
		
		private var _tileType:TileType;
		public function get tileType():TileType
		{ return _tileType; }
		public function set tileType(value:TileType):void
		{
			_tileType = value;
			this.redraw();
		}
		
		private function redraw():void
		{
			this.graphics.clear();
			this.graphics.beginBitmapFill(tileType.bmd);
			this.graphics.drawRect(0, 0, grid.tileWidth, grid.tileHeight);
			this.graphics.endFill();
		}
		
		public function getLocation():GridLocation
		{
			return grid.getTileLocation(this);
		}
		
		public function moveTo(loc:GridLocation, tween:Boolean):void
		{
			var currentLoc:GridLocation = this.getLocation();
			grid.setTile(null, currentLoc.x, currentLoc.y);
			grid.setTile(this, loc.x, loc.y);
			
			if (tween) { this.tweenTo(loc.globalX, loc.globalY); }
		}
		
		protected function tweenTo(tweenX:Number, tweenY:Number, callback:Function = null, ... callbackParams):void
		{
			numTweensRunning++;
			TweenMax.to(this, 0.3, {x:tweenX, y:tweenY, onComplete:tweenFinished, onCompleteParams:[callback, callbackParams]});
		}
		
		private function tweenFinished(callback:Function, callbackParams:Array):void
		{
			if (callback) { callback.apply(null, callbackParams); }
			
			numTweensRunning--;
			if (numTweensRunning == 0)
			{
				grid.globalUpdate();
			}
		}
		
		private static var numTweensRunning:int;
		public static function get tweensRunning():Boolean
		{
			return (numTweensRunning != 0);
		}
	}
}
