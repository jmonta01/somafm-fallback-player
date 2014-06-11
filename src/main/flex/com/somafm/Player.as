package com.somafm {
	import com.somafm.audio.AudioPlayer;
	import com.somafm.controls.ControlBar;
	import com.somafm.events.ControlEvent;
	import com.somafm.events.PlayerEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	public class Player extends Sprite {
		//------------------
		// private vars
		//------------------
		private var _player:AudioPlayer;
		private var _controlBar:ControlBar;
		
		private var _width:Number;
		private var _height:Number;
		
		
		//------------------
		// contructor
		//------------------
		public function Player() {
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.addEventListener(Event.RESIZE, _handleRedraw);
			
			this.addEventListener(Event.ADDED_TO_STAGE, function (e:Event):void {
				_player = new AudioPlayer();
				_player.addEventListener(PlayerEvent.PLAYING_CHANGED, _handlePlayerChanged);
				
				_controlBar = new ControlBar(stage.stageWidth, stage.stageHeight);
				_controlBar.enabled = false;
				addChild(_controlBar);
				
				_controlBar.addEventListener(ControlEvent.PLAY, _handlePlayEvent);
				_controlBar.addEventListener(ControlEvent.PAUSE, _handlePauseEvent);
				_controlBar.addEventListener(ControlEvent.STOP, _handleStopEvent);
				
				_controlBar.addEventListener(ControlEvent.MUTE, _handleMuteEvent);
				_controlBar.addEventListener(ControlEvent.UNMUTE, _handleUnmuteEvent);
				
				_controlBar.addEventListener(ControlEvent.MAX_VOL, _handlemaxVolEvent);
				_controlBar.addEventListener(ControlEvent.SET_VOL, _handleSetVolEvent);

				if (ExternalInterface.available) {
					loadStreams(ExternalInterface.call("getStreams"));
				}

			});
			
		}
		
		//------------------
		// public functions
		//------------------
		public function loadStreams(streams:Array):void {
			if (streams && streams.length > 0) {
				_controlBar.enabled = true;
				_player.loadStreams(streams);		
			}
		}
		
		//------------------
		// private functions
		//------------------
		
		private function _handleRedraw(e:Event):void {
			_controlBar.redraw(stage.stageWidth, stage.stageHeight);
		}
		
		private function _handlePlayerChanged(e:PlayerEvent):void {
			switch (e.type) {
				case PlayerEvent.PLAYING_CHANGED:
					_controlBar.isPlaying = _player.isPlaying;
					break;
				case PlayerEvent.MUTE_CHANGED:
					break;
				case PlayerEvent.VOLUME_CHANGED:
					break;
			}
		}
		
		private function _handlePlayEvent(e:ControlEvent):void {
			_player.togglePause(false);
		}
		
		private function _handlePauseEvent(e:ControlEvent):void {
			_player.togglePause(true);
		}
		
		private function _handleStopEvent(e:ControlEvent):void {
			_player.stop();
		}
		
		private function _handleMuteEvent(e:ControlEvent):void {
			_player.toggleMute(true);
			_controlBar.setVolume(_player.volume);
		}
		
		private function _handleUnmuteEvent(e:ControlEvent):void {
			_player.toggleMute(false);
			_controlBar.setVolume(_player.volume);
		}
		
		private function _handlemaxVolEvent(e:ControlEvent):void {
			_player.setVol(1);
			_controlBar.setVolume(_player.volume);
		}
		
		private function _handleSetVolEvent(e:ControlEvent):void {
			_player.setVol(e.newVolLevel);
		}
		
	}
}