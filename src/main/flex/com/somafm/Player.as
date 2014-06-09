package com.somafm {
	import com.somafm.controls.ControlBar;
	import com.somafm.events.ControlEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import com.somafm.audio.AudioPlayer;
	
	public class Player extends Sprite {
		//------------------
		// private vars
		//------------------
		private var _player:AudioPlayer;
		private var _controlBar:ControlBar;
		
		private var _width:Number;
		private var _height:Number;
		
		private var _streams:Array = [
				"http://uwstream1.somafm.com:80/;",
				"http://xstream1.somafm.com:8032",
				"http://uwstream2.somafm.com:8032",
				"http://ice.somafm.com/groovesalad"
		]
		
		//------------------
		// contructor
		//------------------
		public function Player() {
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.addEventListener(Event.RESIZE, _handleRedraw);
			
			_player = new AudioPlayer(stage.stageWidth, 100);
			_player.loadStreams(_streams);
			addChild(_player);
			
			_controlBar = new ControlBar(stage.stageWidth, stage.stageHeight-100);
			_controlBar.y = 100;
			addChild(_controlBar);
			
			_controlBar.addEventListener(ControlEvent.PLAY, _handlePlayEvent);
			_controlBar.addEventListener(ControlEvent.PAUSE, _handlePauseEvent);
			_controlBar.addEventListener(ControlEvent.STOP, _handleStopEvent);
			
			_controlBar.addEventListener(ControlEvent.MUTE, _handleMuteEvent);
			_controlBar.addEventListener(ControlEvent.UNMUTE, _handleUnmuteEvent);
			
			_controlBar.addEventListener(ControlEvent.MAX_VOL, _handlemaxVolEvent);
			_controlBar.addEventListener(ControlEvent.SET_VOL, _handleSetVolEvent);
		}
		
		//------------------
		// private functions
		//------------------
		
		private function _handleRedraw(e:Event):void {
			_controlBar.redraw(stage.stageWidth, stage.stageHeight-100);
		}
		
		private function _handlePlayEvent(e:ControlEvent):void {
			_player.play();
		}
		
		private function _handlePauseEvent(e:ControlEvent):void {
			_player.togglePause(true);
		}
		
		private function _handleStopEvent(e:ControlEvent):void {
			_player.stop();
		}
		
		private function _handleMuteEvent(e:ControlEvent):void {
			_player.toggleMute(true);
		}
		
		private function _handleUnmuteEvent(e:ControlEvent):void {
			_player.toggleMute(false);
		}
		
		private function _handlemaxVolEvent(e:ControlEvent):void {
			_player.setVol(1);	
		}
		
		private function _handleSetVolEvent(e:ControlEvent):void {
			_player.setVol(e.newVolLevel);
		}
		
	}
}