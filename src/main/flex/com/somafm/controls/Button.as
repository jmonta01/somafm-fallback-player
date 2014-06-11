package com.somafm.controls {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	public class Button extends Sprite {
		//------------------
		// public vars
		//------------------	
		public static const BTN_WIDTH:Number = 50;
		public static const BTN_HEIGHT:Number = 50;
		
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
		
		public function get icon():Bitmap {
			return _icon;
		}
		
		public function set icon(val:Bitmap):void {
			if (_icon == val) {
				return;
			}
			
			_icon = val;
			redraw();
		}

		//------------------
		// private vars
		//------------------
		private var _iconColor:uint = 0x767676;
		private var _iconOverColor:uint = 0xFFFFFF;
		
		private var _backgroundColor:uint = 0xFF0000;
		private var _backgroundAlpha:Number = 0;
		private var _icon:Bitmap;

		private var _overTransform:ColorTransform;
		private var _baseTransform:ColorTransform;
		//------------------
		// constructor
		//------------------
		public function Button() {
			super();
			
			_baseTransform = new ColorTransform();
			_baseTransform.color = _iconColor;
			
			_overTransform = new ColorTransform();
			_overTransform.color = _iconOverColor;
			
			addEventListener(MouseEvent.MOUSE_OVER, _handleMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, _handleMouseOut);
			
			this.buttonMode = true;
			redraw();
		}
		
		//------------------
		// public functions
		//------------------
		public function redraw():void {
			
			this.graphics.clear();
			this.graphics.beginFill(_backgroundColor, _backgroundAlpha);
			this.graphics.drawRect(x, y, BTN_WIDTH, BTN_HEIGHT);
			this.graphics.endFill();
			
			if (_icon) {
				if (!contains(_icon)) {
					addChild(_icon);
					_icon.transform.colorTransform = _baseTransform;
				}
				_icon.x = (width - _icon.width)/2;
				_icon.y = (height - _icon.height)/2;
			}
			
			
		}
		
		//------------------
		// private functions
		//------------------
		private function _handleMouseOver(e:MouseEvent):void {
			if (_icon) {
				_icon.transform.colorTransform = _overTransform;
			}
		}
		
		private function _handleMouseOut(e:MouseEvent):void {
			if (_icon) {
				_icon.transform.colorTransform = _baseTransform		
			}			
		}

	}
}