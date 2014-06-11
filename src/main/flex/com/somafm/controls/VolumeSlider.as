package com.somafm.controls {
	import com.somafm.events.ControlEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class VolumeSlider extends Sprite {
		
		//------------------
		// public vars
		//------------------
		override public function set width(value:Number):void {
			super.width = value;
			_redraw();
		}
		
		public function setVolume(val:Number):void {
			_volume = val;
			_level.scaleX = _volume;
		}
		
		//------------------
		// private vars
		//------------------
		private var _track:Sprite;
		private var _level:Sprite;

		private var _volume:Number = 1;
		private var _dragging:Boolean = false;
		//------------------
		// constructor
		//------------------
		public function VolumeSlider() {
			super();
			
			_track = new Sprite();
			_track.buttonMode = true;
			this.addChild(_track);
			
			_level = new Sprite();
			_level.mouseEnabled = false;
			this.addChild(_level);
			
			addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
				addEventListener(MouseEvent.MOUSE_DOWN, _handleMouseDown);
				addEventListener(MouseEvent.MOUSE_MOVE, _handleMouseMove);
				addEventListener(MouseEvent.MOUSE_UP, _handleMouseUp);
			});
			
			_redraw();
		}
				
		//------------------
		// private functions
		//------------------
		private function _redraw():void {
			_track.graphics.clear();			

			_track.graphics.beginFill(0x1a1a1a);
			_track.graphics.drawRect(0, 0, 200, 10);
			_track.graphics.endFill();			
				
			_track.graphics.beginFill(0x282828);
			_track.graphics.drawRect(1, 1, 198, 8);
			_track.graphics.endFill();			

			_level.graphics.clear();
			_level.graphics.beginFill(0x767676);
			_level.graphics.drawRect(1, 1, 198, 8);
			_level.graphics.endFill();			
		}
		
		//------------------
		// handlers
		//------------------
		private function _handleMouseDown(e:MouseEvent):void {
			if (!_dragging) {
				_dragging = true;
				_setVolume();
			}
		}
		
		private function _handleMouseMove(e:MouseEvent):void {
			if (_dragging) {
				_setVolume();
			}
		}
		
		private function _handleMouseUp(e:MouseEvent):void {
			if (_dragging) {
				_setVolume();
				_dragging = false;
			}
		}
		
		private function _setVolume():void {
			var mouseCoords:Point = new Point(stage.mouseX, 0);
			var localCoords:Point = this.globalToLocal(mouseCoords);
			_volume = Math.min(1, Math.max(0, (localCoords.x-_track.x)/_track.width));
			_level.scaleX = _volume;
			
			var e:ControlEvent = new ControlEvent(ControlEvent.SET_VOL, true);
			e.newVolLevel = _volume;
			dispatchEvent(e);
		}
		
		
	}
}