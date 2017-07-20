package com.ginhangames {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	public class Life extends flash.display.MovieClip{
		
		private static var _maxLife:uint = 3;
		private static var _status:uint;
		private static var _full:Boolean = true;
		
		public function Life(idx:uint, stageW:int) {
			this.y = 30;
			this.name = "health" + idx;
			trace("life name = " + this.name);
			this.x = stageW - (200 - (idx*45));
			this.stop();
		};
		
		public function maxLife():uint {
			return _maxLife;
		};
		
		public function decreaseHealth():void {
			//_full = false;
			this.alpha = .3;
			gotoAndStop("half");
		};
		
		public function resetLives():void {
			_full = true;
		};
		
		public function increaseHealth():void{
			this.alpha = .9;
			gotoAndStop("full");
		};

	}
	
}
