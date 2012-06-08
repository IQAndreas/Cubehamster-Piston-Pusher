package aRenberg.games.CubehamsterPistonPusher 
{
	import flash.geom.Matrix;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * @author andreas
	 */
	public class TileType 
	{
		//INIT
		{
			obsidian = 		new TileType(false, false, Bitmap(new ObsidianBMP()).bitmapData);
			cobblestone = 	new TileType(false, true, Bitmap(new CobblestoneBMP()).bitmapData);
			ice = 			new TileType(false, true, Bitmap(new IceBMP()).bitmapData);
			
			torchOff = new TileType(false, false, Bitmap(new TorchOffBMP()).bitmapData);
			torchOn  = new TileType(false, false, Bitmap(new TorchOnBMP()).bitmapData);
			
			pistonRetractedU  = new TileType(true, true, Bitmap(new PistonRetractedBMP()).bitmapData, GridLocation.UP);
			pistonRetractedD  = new TileType(true, true, Bitmap(new PistonRetractedBMP()).bitmapData, GridLocation.DOWN);
			pistonRetractedL  = new TileType(true, true, Bitmap(new PistonRetractedBMP()).bitmapData, GridLocation.LEFT);
			pistonRetractedR  = new TileType(true, true, Bitmap(new PistonRetractedBMP()).bitmapData, GridLocation.RIGHT);
		
			pistonExtendedHeadU  = new TileType(true, false, Bitmap(new PistonExtendedHeadBMP()).bitmapData, GridLocation.UP);
			pistonExtendedHeadD  = new TileType(true, false, Bitmap(new PistonExtendedHeadBMP()).bitmapData, GridLocation.DOWN);
			pistonExtendedHeadL  = new TileType(true, false, Bitmap(new PistonExtendedHeadBMP()).bitmapData, GridLocation.LEFT);
			pistonExtendedHeadR  = new TileType(true, false, Bitmap(new PistonExtendedHeadBMP()).bitmapData, GridLocation.RIGHT);
		
			pistonExtendedBaseU  = new TileType(true, false, Bitmap(new PistonExtendedBaseBMP()).bitmapData, GridLocation.UP);
			pistonExtendedBaseD  = new TileType(true, false, Bitmap(new PistonExtendedBaseBMP()).bitmapData, GridLocation.DOWN);
			pistonExtendedBaseL  = new TileType(true, false, Bitmap(new PistonExtendedBaseBMP()).bitmapData, GridLocation.LEFT);
			pistonExtendedBaseR  = new TileType(true, false, Bitmap(new PistonExtendedBaseBMP()).bitmapData, GridLocation.RIGHT);
		}
		
		[Embed(source="../assets/obsidian.png")]
		private static var ObsidianBMP:Class;
		public static var obsidian:TileType;
		
		[Embed(source="../assets/cobblestone.png")]
		private static var CobblestoneBMP:Class;
		public static var cobblestone:TileType;
		
		[Embed(source="../assets/ice.png")]
		private static var IceBMP:Class;
		public static var ice:TileType;
		
		
		[Embed(source="../assets/torch-on.png")]
		private static var TorchOnBMP:Class;
		public static var torchOn:TileType;
		
		[Embed(source="../assets/torch-off.png")]
		private static var TorchOffBMP:Class;
		public static var torchOff:TileType;
		
		[Embed(source="../assets/piston.png")]
		private static var PistonRetractedBMP:Class;
		public static var pistonRetractedU:TileType;
		public static var pistonRetractedD:TileType;
		public static var pistonRetractedL:TileType;
		public static var pistonRetractedR:TileType;
		
		[Embed(source="../assets/piston-extended-head.png")]
		private static var PistonExtendedHeadBMP:Class;
		public static var pistonExtendedHeadU:TileType;
		public static var pistonExtendedHeadD:TileType;
		public static var pistonExtendedHeadL:TileType;
		public static var pistonExtendedHeadR:TileType;
		
		[Embed(source="../assets/piston-extended-base.png")]
		private static var PistonExtendedBaseBMP:Class;
		public static var pistonExtendedBaseU:TileType;
		public static var pistonExtendedBaseD:TileType;
		public static var pistonExtendedBaseL:TileType;
		public static var pistonExtendedBaseR:TileType;
		
		
		public function TileType(isPiston:Boolean, pushable:Boolean, bmd:BitmapData, rotation:int = 0)
		{
			this.isPiston = isPiston;
			this.pushable = pushable;
			this.rotation = rotation;
			
			if (rotation == 0)
			{
				this.bmd = bmd;
			}
			else
			{
				var matrix:Matrix = new Matrix();
				matrix.translate(-bmd.width / 2, -bmd.height / 2);
				matrix.rotate(GridLocation.getRotation(rotation));
				matrix.translate(bmd.height / 2, bmd.width / 2);
				var matriximage:BitmapData = new BitmapData(bmd.height, bmd.width, true, 0x00000000);
				matriximage.draw(bmd, matrix);
				
				this.bmd = matriximage;
			}
		}
		
		public var pushable:Boolean;
		public var rotation:int;
		public var isPiston:Boolean;
		public var bmd:BitmapData;
	}
}
