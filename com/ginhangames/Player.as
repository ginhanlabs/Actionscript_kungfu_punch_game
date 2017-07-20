package  com.ginhangames {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	
	public class Player extends flash.display.MovieClip { 
		
		private var attacks:Array = ["_bow", "_left_punch", "_left_kick", "_right_kick", "_right_punch"];
		private var _playerNum:uint;
		private static const LEFT_ARROW:uint  = 37;
		private static const UP_ARROW:uint  = 38;
		private static const RIGHT_ARROW:uint  = 39;
		private static const DOWN_ARROW:uint  = 40;
		
		
		public function Player(W:int, H:int, pNum:uint) {
			this.name = "player" + pNum;
			this._playerNum = pNum;
			this.x = W/2;
			this.y = H - 20;
			this.gotoAndStop(this.name + attacks[0]);
		}
		
		public function playerNum():uint {
			return _playerNum;
		};
		
		public function bow():void{
			this.gotoAndStop(this.name + attacks[0]);
		}

		public function leftPunch():void{
			this.gotoAndStop(this.name + attacks[1]);
		}
		
		public function leftKick():void{
			this.gotoAndPlay(this.name + attacks[2]);
		}
		
		public function rightKick():void{
			this.gotoAndPlay(this.name + attacks[3]);
		}
		
		public function rightPunch():void{
			this.gotoAndStop(this.name + attacks[4]);
		}
		
		public function keyUpAction(e:KeyboardEvent):void {
			var kc = e.keyCode;
			if (kc == UP_ARROW) {
				bow();
			}
			 else if (kc == LEFT_ARROW){
				 bow();
			} else if ( kc == DOWN_ARROW){
				bow();
			} else if (kc == RIGHT_ARROW){
				bow();
			} else {
				bow();
			}; 
		}
		
		public function keyDownAction(e:KeyboardEvent):void {
			var kc = e.keyCode;
			if (kc == UP_ARROW) {
				trace("left kick"  + this._playerNum);
				leftKick();
			}
			else if (kc == LEFT_ARROW){
				trace("left punch");
				leftPunch();
			} else if ( kc == DOWN_ARROW){
				trace("right kick");
				rightKick();
			} else if (kc == RIGHT_ARROW){
				trace("right punch");
				rightPunch();
			} else {
				bow();
			};
		}
	}
	
}
