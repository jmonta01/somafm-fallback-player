package com.somafm.controls {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class Button extends Sprite {
		//------------------
		// public vars
		//------------------	
		public function get backgroundColor():uint {
			return _backgroundColor;
		}
		public function set backgroundColor(val:uint):void {
			if (_backgroundColor == val) {
				return;
			}
			_backgroundColor = val;
			redraw();
		}
		
		public function get backgroundAlpha():uint {
			return _backgroundAlpha;
		}
		public function set backgroundAlpha(val:uint):void {
			if (_backgroundAlpha == val) {
				return;
			}
			_backgroundAlpha = val;
			redraw();
		}
		
		public function get icon():BitmapData {
			return _icon;
		}
		
		public function set icon(val:BitmapData):void {
			if (_icon == val) {
				return;
			}
			
			_icon = val;
			redraw();
		}

		//------------------
		// private vars
		//------------------
		private var _backgroundColor:uint = 0xCCCCCC;
		private var _backgroundAlpha:Number = 1;
		private var _icon:BitmapData;

		
		//------------------
		// constructor
		//------------------
		public function Button() {
			super();
			this.buttonMode = true;
			redraw();
		}
		
		//------------------
		// public functions
		//------------------
		public function redraw():void {
			
			this.graphics.beginFill(_backgroundColor);
			this.graphics.drawRect(x, y, 50, 50);
			this.graphics.endFill();
			
			
		}
		
		//------------------
		// private functions
		//------------------
		

	}
}