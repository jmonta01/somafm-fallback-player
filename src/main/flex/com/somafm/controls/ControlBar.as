package com.somafm.controls {
	import com.somafm.events.ControlEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ControlBar extends Sprite {
		//------------------
		// public vars
		//------------------			
		public var backgroundColor:uint = 0xcccccc;
		
		public var hGap:Number = 10;
		public var marginLeft:Number = 0;
		public var marginRight:Number = 0;
		
		//------------------
		// private vars
		//------------------	
		private var _playBtn:Button;
		private var _pauseBtn:Button;
		
		private var _muteVolBtn:Button;
		private var _unmuteVolBtn:Button;
		private var _volSlider:VolumeSlider;
		private var _maxBtn:Button;
		
		private var _isPlaying:Boolean = true;
		private var _isMuted:Boolean = false;
		
		private var _w:Number;
		private var _h:Number;
		
		//------------------
		// constructor
		//------------------
		public function ControlBar(w:Number, h:Number) {
			super();	
			
			_playBtn = new Button();
			_playBtn.addEventListener(MouseEvent.CLICK, _handlePlayClicked);
			_playBtn.backgroundColor = 0xff0000;
			addChild(_playBtn);
			
			_pauseBtn = new Button();
			_pauseBtn.addEventListener(MouseEvent.CLICK, _handlePauseClicked);
			_pauseBtn.backgroundColor = 0x330000;
			addChild(_pauseBtn);
			
			_muteVolBtn = new Button();
			_muteVolBtn.addEventListener(MouseEvent.CLICK, _handleMuteClicked);
			_muteVolBtn.backgroundColor = 0x00ff00;
			addChild(_muteVolBtn);
			
			_unmuteVolBtn = new Button();
			_unmuteVolBtn.addEventListener(MouseEvent.CLICK, _handleUnmuteClicked);
			_unmuteVolBtn.backgroundColor = 0x003300;
			addChild(_unmuteVolBtn);
			
			_volSlider = new VolumeSlider();
			addChild(_volSlider);
			
			_maxBtn = new Button();
			_maxBtn.addEventListener(MouseEvent.CLICK, _handleMaxVolClicked);
			_maxBtn.backgroundColor = 0x0000ff;
			addChild(_maxBtn);
			
			redraw(w, h);
		}
		
		//------------------
		// public functions
		//------------------
		public function redraw(width:Number=-1, height:Number=-1):void {
			
			if (width < 0) {
				width = _w;
			} else {
				_w = width;
			}
			
			if (height < 0) {
				height = _h;
			} else {
				_h = height;
			}

			this.graphics.beginFill(backgroundColor);
			this.graphics.drawRect(x, y, width, height);
			this.graphics.endFill();

			
			_playBtn.width = _playBtn.height = 50;
			_pauseBtn.width = _pauseBtn.height = 50;
			
			_playBtn.x = _pauseBtn.x = x + marginRight;
			_playBtn.y = _pauseBtn.y = (height - _playBtn.height) / 2;
		
			_playBtn.visible = !_isPlaying;
			_pauseBtn.visible = _isPlaying;
			
			_muteVolBtn.x = _unmuteVolBtn.x = _playBtn.x + _playBtn.width + hGap;
			_muteVolBtn.y = _unmuteVolBtn.y = (height - _muteVolBtn.height) / 2;
			
			_muteVolBtn.visible = !_isMuted;
			_unmuteVolBtn.visible = _isMuted;
			
			_volSlider.x = _muteVolBtn.x + _muteVolBtn.width + hGap;
			_volSlider.y = (height - _volSlider.height) / 2;
			
			_maxBtn.x = _volSlider.x + _volSlider.width + hGap;
			_maxBtn.y = (height - _maxBtn.height) / 2;			
		}
		
		//------------------
		// private functions
		//------------------
		private function _handlePlayClicked(e:MouseEvent):void {
			_isPlaying = true;
			dispatchEvent(new ControlEvent(ControlEvent.PLAY, true));	
			redraw();
		}
		
		private function _handlePauseClicked(e:MouseEvent):void {
			_isPlaying = false;
			dispatchEvent(new ControlEvent(ControlEvent.PAUSE));
			redraw();
		}
		
		private function _handleMuteClicked(e:MouseEvent):void {
			_isMuted = true;
			dispatchEvent(new ControlEvent(ControlEvent.MUTE));
			redraw();
		}
		
		private function _handleUnmuteClicked(e:MouseEvent):void {
			_isMuted = false;
			dispatchEvent(new ControlEvent(ControlEvent.UNMUTE));
			redraw();
		}
		
		private function _handleMaxVolClicked(e:MouseEvent):void {
			_isMuted = true;
			dispatchEvent(new ControlEvent(ControlEvent.MAX_VOL));
			redraw();
		}
		
		
	}
}