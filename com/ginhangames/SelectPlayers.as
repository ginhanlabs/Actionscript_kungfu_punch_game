package  com.ginhangames {
	
	import flash.display.MovieClip;
	
	public class SelectPlayers extends flash.display.MovieClip {
		
		private var _lock: Boolean;

		public function SelectPlayers(idx:uint) {
			stop();
			this.name = "player_" + idx;
			this._lock = true;
			this.x = (this.width * idx )+ 10;
			trace(this.name);
			//if (idx == 0){
			//	unlock();
			//	reveal(idx);
			//}
			
		}
		
		public function reveal(n):void{
			gotoAndStop("player" + n);
		}
		
		public function lock():Boolean {
			return _lock;
		}
		
		public function unlock():void{
			this._lock = !_lock;
		}
	}
	
}
