package com.somafm.events {
	import flash.events.Event;
	
	public class ControlEvent extends Event {
		//------------------
		// public vars
		//------------------
		public static const PLAY:String = "play";
		public static const PAUSE:String = "pause";
		public static const STOP:String = "stop";
		
		public static const MUTE:String = "mute";
		public static const UNMUTE:String = "unmute";
		
		public static const MAX_VOL:String = "maxVol";
		public static const SET_VOL:String = "setVol";
		
		//------------------
		// private vars
		//------------------
		public var newVolLevel:Number;

		//------------------
		// contructor
		//------------------
		public function ControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}