package com.ginhangames{
	
	import flash.display.MovieClip;
	
	public class Obstacle extends flash.display.MovieClip{
		/* obstacles must be certain height in order for player to hit  */
		
		private static var _direction:int;
		private static var _speed:int;
		private const SPEED: uint = 7;
		private const MAXINCREASE:uint = 10;
		private const GROUNDSPEED:uint = 21;
		private static var _previousSpeed:uint;
		private var increase:uint;
		private static var y_Obstacle_Start_for_player01: Array = [230,90, 460 ]; //punch, kick, ground
		public static var y: uint;
		public static var x: uint;
		private static var xEndGoal: int;
		private static var _isGround: Boolean;
		
		//private var obstacleTimer:Timer;
		

		public function Obstacle(width: int, accel: uint, numObj: uint):void {
			_isGround = false;
			this.name = "obstacle";
			this.increase = accel;
			this.setDirection();
			this.setEndGoal(width);
			this.setY();
			getObject(numObj);
		}
		
		private function getObject(n):void{
			/*if (n >=3 ){
				n = 2;
			}*/
			
			var r:int = Math.floor(Math.random() * 6*n);
			this.gotoAndStop(r);
			
		};
		
		public function get direction():int{
			return _direction;
		}
		
		public function get speed():int {
			return _speed;
		}
		
		public function get isGround():Boolean{
				return _isGround;
		}
		
		private function groundObstacleSpeed():void {
			_speed = SPEED * 3;
			//trace("ground speed @ " + _speed);
		};
		
		private function setDirection():void {
			var d = Math.round(Math.random() * 10);
			if (d >= 5){
				_direction = 1;
			}
			else {
				_direction = -1;
			}
		};
		
		private function setEndGoal(w):void {
			if (_direction > 0){
				 x = 0;
				xEndGoal = Math.round(w);
				
			}
			else {
				x = w;
				xEndGoal = 0;
			};
		};
		
		private function setY():void{
			var r:int = Math.floor(Math.random() * 3);
			y = y_Obstacle_Start_for_player01[r];
			trace("obstacle y @ " + r);
			if (r == 2){
				//trace("is ground object ");
				//groundObstacleSpeed();
				_speed = GROUNDSPEED;
				_isGround = true;
			}
			else {
				//trace("increase = " + increase );
				if (increase < MAXINCREASE) {
					_speed = SPEED + (increase * 1);
					_previousSpeed = _speed;
				}
				else {
					_speed = _previousSpeed;
				}
				//trace("new speed " + _speed  + " _previousSpeed " + _previousSpeed);
			}
		};
	}
	
}
