package com.somafm.controls
{
	import flash.display.Sprite;
	
	public class VolumeSlider extends Sprite
	{
		public function VolumeSlider()
		{
			super();
			
			this.graphics.beginFill(0x000000);
			this.graphics.drawRect(x, y, 40, 10);
			this.graphics.endFill();

		}
	}
}