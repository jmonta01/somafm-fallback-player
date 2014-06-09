package com.somafm.audio {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	public class AudioPlayer extends Sprite {
		//------------------
		// public vars
		//------------------

		//------------------
		// private vars
		//------------------
		private var _streams:Array;
		private var _activeStream:String;
		
		private var _sound:Sound;
		private var _soundTrans:SoundTransform;
		private var _soundChannel:SoundChannel;
		
		private var _lastVol:Number = 1;
		
		private var _logger:TextField;
		
		private var _w:Number;
		private var _h:Number;

		//------------------
		// constructor
		//------------------
		public function AudioPlayer(w:Number, h:Number) {
			super();	
			
			_sound = new Sound();			
			_sound.addEventListener(IOErrorEvent.IO_ERROR, _handleNetFault);
			
			_soundTrans = new SoundTransform();

			redraw(w, h);			
			
			_logger = new TextField();
			_logger.width = w;
			_logger.height = h;
			_logger.text = "Logging...";
			this.addChild(_logger);
		}
		
		//------------------
		// public functions
		//------------------
		public function log(msg:String):void {
			_logger.text = msg + "\n" + _logger.text ;
		}
		
		public function loadStreams(streams:Array):void {
			_streams = streams;
			_playStream(_streams.pop())
		}
		
		public function play():void {
			log("play");
			_playStream(_activeStream);
		}
		
		public function togglePause(val:Boolean):void {
			log("toggle pause: " + val);
			if (val) {
				_sound.close();
			} else {
				_playStream(_activeStream);	
			}
			
		}
		
		public function stop():void {
			log("stop");
			_sound.close();
		}
		
		public function toggleMute(val:Boolean):void {
			_soundTrans.volume = val ? 0 : _lastVol;
			_soundChannel.soundTransform = _soundTrans;
		}
		
		public function setVol(val:Number):void {
			_lastVol = val;
			_soundTrans.volume = _lastVol;
		}
		
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
			
			this.graphics.beginFill(0xffffff);
			this.graphics.drawRect(x, y, width, height);
			this.graphics.endFill();
			
		}

		//------------------
		// private functions
		//------------------
		private function _playStream(stream:String):void {
			_activeStream = stream;
			_sound.load(new URLRequest(stream));
			_soundChannel = _sound.play(0, 0, _soundTrans);
			//_stream.play(_activeStream);
			log("play stream" + stream);
		}
		
		private function _handleNetFault(e:Event):void {
			log(e.toString());
		}


	}
}