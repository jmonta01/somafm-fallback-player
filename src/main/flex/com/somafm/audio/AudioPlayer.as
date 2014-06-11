package com.somafm.audio {
	import com.somafm.events.PlayerEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	
	public class AudioPlayer extends EventDispatcher {
		//------------------
		// public vars
		//------------------
		public function get isPlaying():Boolean {
			return true;
		}
		
		public function get volume():Number {
			return _soundTrans.volume;
		}

		//------------------
		// private vars
		//------------------
		private var _streams:Array;
		private var _activeStream:String;
		
		private var _sound:Sound;
		private var _soundTrans:SoundTransform;
		private var _soundChannel:SoundChannel;
		
		private var _isPlaying:Boolean = false;
		
		private var _lastVol:Number = 1;
		private var _lastPos:Number;
		
		//------------------
		// constructor
		//------------------
		public function AudioPlayer() {
			super();	
			
			_sound = new Sound();			
			_sound.addEventListener(IOErrorEvent.IO_ERROR, _handleFault);
			_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, _handleSampleData);
			_sound.addEventListener(Event.OPEN, _handleOpen);
			
			_soundTrans = new SoundTransform();
		}
		
		//------------------
		// public functions
		//------------------
		public function log(msg:String):void {
			trace(msg);
		}
		
		public function loadStreams(streams:Array):void {
			_streams = streams;
			_playStream(_streams.pop())
		}
		
		public function togglePause(val:Boolean):void {
			if (val) {
				_lastPos = _soundChannel.position;
				_soundChannel.stop();
			} else {
				_soundChannel = _sound.play(_lastPos, 0, _soundTrans);
			}
			
		}
		
		public function stop():void {
			_soundChannel.stop();
			_sound.close();
		}
		
		public function toggleMute(val:Boolean):void {
			_soundTrans.volume = val ? 0 : _lastVol;
			_soundChannel.soundTransform = _soundTrans;
		}
		
		public function setVol(val:Number):void {
			_lastVol = val;
			_soundTrans.volume = _lastVol;
			_soundChannel.soundTransform = _soundTrans;
		}

		//------------------
		// private functions
		//------------------
		private function _playStream(stream:String):void {
			log("play stream" + stream);
			_activeStream = stream;
			_sound.load(new URLRequest(stream));
			_soundChannel = _sound.play(0, 0, _soundTrans);
		}
		
		private function _handleOpen(e:Event):void {
			log(e.toString());
			_isPlaying = true;
			dispatchEvent(new PlayerEvent(PlayerEvent.PLAYING_CHANGED));
		}
		
		private function _handleSampleData(e:SampleDataEvent):void {
			log(e.toString());
		}
		
		private function _handleFault(e:Event):void {
			log(e.toString());
		}


	}
}