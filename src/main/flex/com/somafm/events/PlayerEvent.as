package com.somafm.events {
	import flash.events.Event;
	
	public class PlayerEvent extends Event {
		//------------------
		// public vars
		//------------------
		public static const PLAYING_CHANGED:String = "playingChanged";
		public static const MUTE_CHANGED:String = "muteChanged";
		public static const VOLUME_CHANGED:String = "volumeChanged";
		
		//------------------
		// constructor
		//------------------
		public function PlayerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}