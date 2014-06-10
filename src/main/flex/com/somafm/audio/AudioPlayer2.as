package com.somafm.audio {
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	[Event(name="ready", type="flash.events.Event")]
	
	public class AudioPlayer2 extends Sprite {
		
		//------------------
		// public vars
		//------------------
		
		//------------------
		// private vars
		//------------------
		private var _nc:NetConnection;
		private var _ns:NetStream;
		
		private var _soundTransform:SoundTransform;
		private var _lastVolume:Number = 1;
		
		private var _streams:Array;

		//------------------
		// constructor
		//------------------		
		public function AudioPlayer2(streams:Array) {
			super();
			_streams = streams;
			_createNetConnection();
		}
		
		//------------------
		// public functions
		//------------------
		public function togglePause(val:Boolean):void {
			if (val) {
				_ns.play();
			} else {
				_ns.pause();
			}
		}
		
		public function toggleMute(val:Boolean):void {
			if (val) {
				_soundTransform.volume = 0;	
			} else {
				_soundTransform.volume = _lastVolume;
			}
			_ns.soundTransform = _soundTransform;	
		}
		
		public function setVolume(val:Number):void {
			_soundTransform.volume = _lastVolume = val;
			_ns.soundTransform = _soundTransform;
		}
		
		//------------------
		// private functions
		//------------------
		private function _createNetConnection():void {
			if (!_nc) {
				_nc = new NetConnection();
				_nc.addEventListener(NetStatusEvent.NET_STATUS, _handleNetConnStatus);
				_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _handleError);
				_nc.addEventListener(IOErrorEvent.IO_ERROR, _handleError);
				_nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, _handleError);
			}
			
			if (!_nc.connected) {
				_nc.connect(null);
			}
		}
		
		private function _createNetStream():void {
			_ns = new NetStream(_nc);
			_ns.addEventListener( NetStatusEvent.NET_STATUS, _handleNetStreamStatus);
			_ns.addEventListener( AsyncErrorEvent.ASYNC_ERROR, _handleError );
			_ns.addEventListener( IOErrorEvent.IO_ERROR, _handleError );
			_loadNextStream();
		}
		
		private function _loadNextStream():void {
			if (_streams.length > 0) {
				_playStream(_streams.pop());
			} else {
				trace("all streams exhausted");
			}
		}
		
		private function _playStream(streamUrl:String):void {
			trace("ns play: ", streamUrl);
			_ns.play(streamUrl);
			_ns.soundTransform = _soundTransform;
		}
		
		//------------------
		// handlers
		//------------------
		private function _handleNetConnStatus(e:NetStatusEvent):void {
			trace("netStatusHandler:code: " + e.info.code);
			switch( e.info.code ) {
				case "NetConnection.Connect.Success":
					//handle connection success, connect stream
					_createNetStream();
					break;
				case "NetConnection.Connect.Failed":
					//handle connection failure
					trace("net connection failed");
					break;
				case "NetStream.Play.Stop":					
					break;
				default:
					break;
			}
		}
		
		private function _handleNetStreamStatus(e:NetStatusEvent):void {
			trace("netStatusHandler:code: " + e.info.code);
			switch( e.info.code ) {
				case "NetConnection.Connect.Success":
					//handle connection success, connect stream
					trace("playing");
					break;
				case "NetStream.Play.StreamNotFound":
					_loadNextStream();
					break;
				case "NetStream.Play.Stop":					
					break;
				default:
					break;
			}			
		}
		
		private function _handleError(e:Event):void {
			trace(e.toString());
		}
	}
}


class NetStreamClient {
		
}


