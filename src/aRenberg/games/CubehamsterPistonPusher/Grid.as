package aRenberg.games.CubehamsterPistonPusher 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * @author andreas
	 */
	public class Grid 
	{
		public function Grid(tileWidth:uint, tileHeight:uint, width:uint, height:uint, spawnerX:uint, spawnerY:uint, recieverX:uint, recieverY:uint):void
		{
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			this.width = width;
			this.height = height;
			
			grid = new Vector.<Tile>(width * height);
			
			//As of right now, it's not possible to change spawner and receiver locations after Grid instantiation.
			spawner = new GridLocation(this, spawnerX, spawnerY);
			reciever = new GridLocation(this, recieverX, recieverY);
			
			container = new Sprite();
			container.graphics.beginBitmapFill(this.draw());
			container.graphics.drawRect(0, 0, tileWidth * width, tileHeight * height);
			container.graphics.endFill();
		}
		
		private var grid:Vector.<Tile>;
		public var container:Sprite;
		public var counter:Clock;
		
		// For now, only allow one spawner and one receiver
		private var spawner:GridLocation;
		private var reciever:GridLocation;
		
		public var offsetX:int = 64;
		public var offsetY:int = 64;
		public var tileWidth:uint;
		public var tileHeight:uint;
		public var width:uint;
		public var height:uint;
		
		public function setTile(tile:Tile, x:uint, y:uint):void
		{
			grid[(y * width) + x] = tile;
		}
		
		public function getTile(x:uint, y:uint):Tile
		{
			return grid[(y * width) + x];
		}
		
		public function getTileLocation(tile:Tile):GridLocation
		{
			var index:uint = grid.indexOf(tile);
			return (index == -1) ? null : new GridLocation(this, uint(index%width), uint(index/width));
		}
		
		public function globalUpdate():void
		{
			if (spawner.getTile() == null)
			{
				Tile.makeTile(TileType.cobblestone, spawner);
			}
			
			var recieverTile:Tile = reciever.getTile();
			if (recieverTile)
			{
			    if (recieverTile.tileType == TileType.ice)
				{
					trace("Score!");
					this.container.removeChild(recieverTile);
					this.setTile(null, reciever.x, reciever.y);
				}
				else
				{
					trace("You DEAD!");
				}
			}
			
		}
		
		
		[Embed(source="../assets/iron.png")]
		private var IronBMP:Class;
		
		[Embed(source="../assets/lava.png")]
		private var LavaBMP:Class;
		
		[Embed(source="../assets/enchantment-table.png")]
		private var EnchantmentTableBMP:Class;
		
		public function draw():BitmapData
		{
			var sourceBMD:BitmapData = Bitmap(new IronBMP()).bitmapData;
			var targetBMD:BitmapData = new BitmapData(tileWidth * width, tileHeight * height, true, 0x00000000);
			
			for (var bgX:int = 0; bgX < width; bgX++)
			{
				for (var bgY:int = 0; bgY < height; bgY++)
				{
					this.setBMDTile(targetBMD, sourceBMD, bgX, bgY);
				}
			}
			
			setBMDTile(targetBMD, Bitmap(new LavaBMP()).bitmapData, spawner.x, spawner.y);
			setBMDTile(targetBMD, Bitmap(new LavaBMP()).bitmapData, reciever.x, reciever.y);
			
			return targetBMD;
		}
		
		private function setBMDTile(targetBMD:BitmapData, sourceBMD:BitmapData, tileX:uint, tileY:uint):void
		{
			targetBMD.copyPixels(sourceBMD, sourceBMD.rect, new Point(tileX * tileWidth + offsetX, tileY * tileHeight + offsetY));
		}
	}
}
