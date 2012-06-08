package aRenberg.games.CubehamsterPistonPusher 
{
	import flash.geom.Point;
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	/**
	 * @author andreas
	 */
	public class Clock extends BitmapData
	{
		public function Clock() 
		{
			super(13 * 64, 7 * 64, true, 0x000000);
			
			this.redraw();
			this.value = _value;
		}
		
		private var _value:uint = 0;
		public function get value():uint
		{ return _value; }
		public function set value(newValue:uint):void
		{
			_value = newValue;
			var str:String = _value.toString();
			while (str.length < 3) { str = "0" + str; }
			
			for (var i:int = 0; i < str.length; i++)
			{
				const digitWidth:uint = 3;
				const paddingX:uint = 1;
				const offsetX:uint = 1;
				const offsetY:uint = 1;
				
				this.setDigit(str.substr(i, 1), digitWidth, ((digitWidth + paddingX) * i) + offsetX, offsetY);
			}
		}
		
		[Embed(source="../assets/obsidian.png")]
		private var ObsidianBMP:Class;
		private var obsidianBMD:BitmapData = Bitmap(new ObsidianBMP()).bitmapData;
		
		[Embed(source="../assets/lamp-on.png")]
		private var LampOnBMP:Class;
		private var lampOnBMD:BitmapData = Bitmap(new LampOnBMP()).bitmapData;
		
		[Embed(source="../assets/lamp-off.png")]
		private var LampOffBMP:Class;
		private var lampOffBMD:BitmapData = Bitmap(new LampOffBMP()).bitmapData;
		
		
		private function redraw():void
		{
			for (var bx:int = 0; bx < 13; bx++)
			{
				for (var by:int = 0; by < 7; by++)
				{
					this.copyPixels(obsidianBMD, obsidianBMD.rect, new Point(bx * obsidianBMD.width, by * obsidianBMD.height));
				}
			}
		}
		
		private function setDigit(digit:String, digitWidth:uint, offsetX:uint, offsetY:uint):void
		{
			var arr:Array = getDigit(digit);
			for (var i:int = 0; i < arr.length; i++)
			{
				var bmd:BitmapData = arr[i];
				this.copyPixels(bmd, bmd.rect, new Point((offsetX + (i % digitWidth))*bmd.width, (offsetY + uint(i/digitWidth)) * bmd.width));
			}
		}
		
		private function getDigit(digit:String):Array
		{
			const x:BitmapData = obsidianBMD;
			const I:BitmapData = lampOnBMD;
			const o:BitmapData = lampOffBMD;
			
			switch(digit)
			{
				case "0" : return [I, I, I,  I, x, I,  I, o, I,  I, x, I,  I, I, I];
				case "1" : return [o, o, I,  o, x, I,  o, o, I,  o, x, I,  o, o, I];
				case "2" : return [I, I, I,  o, x, I,  I, I, I,  I, x, o,  I, I, I];
				case "3" : return [I, I, I,  o, x, I,  I, I, I,  o, x, I,  I, I, I];
				case "4" : return [I, o, I,  I, x, I,  I, I, I,  o, x, I,  o, o, I];
				case "5" : return [I, I, I,  I, x, o,  I, I, I,  o, x, I,  I, I, I];
				case "6" : return [I, I, I,  I, x, o,  I, I, I,  I, x, I,  I, I, I];
				case "7" : return [I, I, I,  o, x, I,  o, o, I,  o, x, I,  o, o, I];
				case "8" : return [I, I, I,  I, x, I,  I, I, I,  I, x, I,  I, I, I];
				case "9" : return [I, I, I,  I, x, I,  I, I, I,  o, x, I,  I, I, I];
				default  : return [o, o, o,  o, x, o,  o, o, o,  o, x, o,  o, o, o];
			}
		}
	}
}
