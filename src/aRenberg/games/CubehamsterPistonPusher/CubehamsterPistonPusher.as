package aRenberg.games.CubehamsterPistonPusher 
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;

	[SWF(backgroundColor="#000000", frameRate="30", width="928", height="480")]
	public class CubehamsterPistonPusher extends Sprite 
	{
		[Embed(source="../assets/bg.png")]
		private var bgPNG:Class;
		
		public function CubehamsterPistonPusher() 
		{
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			
			this.scaleX = 0.5;
			this.scaleY = 0.5;
			
			stage.addEventListener(Event.RESIZE, updateBG);
			updateBG();
			
			//var spawner:GridLocation = new GridLocation(null, 2, 10);
			//var reciever:GridLocation = new GridLocation(null, 6, 6);
			
			grid = new Grid(64, 64, 13, 13, 2, 10, 6, 6);
			this.addChild(grid.container);
			
			this.fillGrid();
			grid.counter = new Clock();
			grid.globalUpdate();
			
			var clockBMP:Bitmap = new Bitmap(grid.counter);
			clockBMP.x = (grid.width + 1) * grid.tileWidth + grid.offsetX;
			clockBMP.y = grid.offsetY;
			this.addChild(clockBMP);
		}
		
		public var grid:Grid;
		
		private function fillGrid():void
		{
			// I could make a fancy level creator, but perhaps another time.
			
			var x:TileType = TileType.obsidian;
			var i:TileType = TileType.torchOff;
			var c:TileType = TileType.ice;
			
			var u:TileType = TileType.pistonRetractedU;
			var d:TileType = TileType.pistonRetractedD;
			var l:TileType = TileType.pistonRetractedL;
			var r:TileType = TileType.pistonRetractedR;
			
			var A:Object = null; //speical tiles
			
			var arr:Array = [
				[x, x, i, i, i, i, i, i, i, i, i, x, x ],
				[x, x, d, d, d, d, d, d, d, d, d, x, x ],
				[i, r, 0, c, 0, x, 0, 0, 0, 0, 0, l, i ],
				[i, r, 0, i, 0, 0, i, 0, 0, i, 0, l, i ],
				[i, r, 0, 0, 0, i, 0, 0, 0, 0, 0, l, i ],
				[i, r, 0, 0, 0, i, c, 0, 0, 0, 0, l, i ],
				[i, r, 0, 0, 0, x, A, x, i, 0, 0, l, i ],
				[i, r, 0, 0, 0, c, 0, 0, i, 0, 0, l, i ],
				[i, r, 0, i, A, 0, 0, 0, 0, 0, 0, l, i ],
				[i, r, 0, 0, 0, 0, 0, 0, 0, 0, 0, l, i ],
				[i, r, A, 0, 0, 0, 0, x, c, i, 0, l, i ],
				[x, x, u, u, u, u, u, u, u, u, A, x, x ],
				[x, x, i, i, i, i, i, i, i, i, i, x, x ],
			];
			
			for (var gx:uint = 0; gx < grid.width; gx++)
			{
				for (var gy:uint = 0; gy < grid.height; gy++)
				{
					var tileType:TileType = arr[gy][gx] as TileType;
					if (tileType)
					{
						Tile.makeTile(tileType, new GridLocation(grid, gx, gy));
					}
				}
			}
			
			// Speical tiles
			var stickyPiston:Piston = new Piston(TileType.pistonRetractedU, new GridLocation(grid, 4, 8), true);
			stickyPiston.increasesCounter = false;
			
			//var stickyPiston2:Piston = 
			new Piston(TileType.pistonRetractedU, new GridLocation(grid, 10, 11), true);
			
		}
		
		
		
		private var bg:Bitmap;
		private function updateBG(event:Event = null):void
		{
			var bgTile:BitmapData = Bitmap(new bgPNG()).bitmapData;
			var bgBMD:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x000000);
			for (var bgX:int = 0; bgX <= stage.stageWidth; bgX += bgTile.width)
			{
				for (var bgY:int = 0; bgY <= stage.stageHeight; bgY += bgTile.height)
				{
					bgBMD.copyPixels(bgTile, bgTile.rect, new Point(bgX, bgY));
				}
			}
			
			if (!bg) { bg = new Bitmap(); }
			bg.bitmapData = bgBMD;
			stage.addChild(bg);
			stage.addChild(this);
		}
	}
}
