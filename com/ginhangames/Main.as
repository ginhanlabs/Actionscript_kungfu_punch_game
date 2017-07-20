/* This game is just a refresher on using actionscript just for the fun of it */
/* Feel free to use build on it and make this game better */
/* More comments maybe placed to better document the coding here in the future */


package  com.ginhangames  {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.*;
	
	import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
	
	import flash.utils.Timer;
    import flash.events.TimerEvent;
	
	import com.ginhangames.*;
	
	public class Main extends flash.display.MovieClip{
		
		public var player:Player;
		public var healthMeter: Life;
		public var obstacle: Obstacle;
		public var _playAgainBtn: playBtn;
		public var selectPlayersContainer: MovieClip;
		public var selectPlayers : SelectPlayers;
		
		private const W:int = stage.stageWidth;
		private const H:int = stage.stageHeight;
		
		
		private static const SPACEBAR:uint = 32;
		private static const ONE:uint = 49;
		private static const NUMPAD_ONE:uint = 97;
		
		private static const TWO:uint = 50;
		private static const NUMPAD_TWO:uint = 98;
		
		private static const THREE:uint = 51;
		private static const NUMPAD_THREE:uint = 99;
		
		private static const FOUR:uint = 52;
		private static const NUMPAD_FOUR:uint = 100;
		
		private static const FIVE:uint = 53;
		private static const NUMPAD_FIVE:uint = 101;
		
		public static var healthCounter:uint;
		private var _gameOver: Boolean;
		
		private var scoreTextField:TextField;
        private var txtFormat:TextFormat;
		private var score: uint;
		private var level: uint;
		private var playerPicked : uint;
		private var unlockTracker:Array;
		
		private var numUnlocked:uint = 1;

		// add more players to SelectPlayers and then modify int
		private var maxPlayers: uint = 2;
		
		public function Main() {
			unlockTracker = [true, false, false, false, false, false];
			selectPlayersContainer = new MovieClip();
			selectPlayersContainer.name = "selectPlayersContainer";
			/* container for players to select */
			for(var i=1; i <= maxPlayers; i++){
				selectPlayers = new SelectPlayers(i);
				selectPlayersContainer.x = 50;
				selectPlayersContainer.y = 300;
				selectPlayersContainer.addChild(selectPlayers);
			}
			addChild(selectPlayersContainer);
			titleScreen();
		}
		
		public function titleScreen():void {
			gotoAndStop("title");
			trace(numUnlocked + " = numUnlocked");
			/* unlock any playable players */
			for (var i = 1; i <= numUnlocked; i++){
				var unlockPlayer = this.selectPlayersContainer.getChildByName("player_" + i);
				unlockPlayer.reveal(i);
				unlockPlayer.unlock();
				trace(" title screen unlocked = " + "player_" + i);
			}
			selectPlayersContainer.visible = true;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, selectPlayerHandler);
		}
		
		public function selectPlayerHandler(e:KeyboardEvent){
			
			selectPlayersContainer.visible = false;
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,selectPlayerHandler);
			//trace(e.keyCode + " selecPlayeHandler");
			if (e.keyCode == ONE || e.keyCode == NUMPAD_ONE){
				playerPicked = 1;
				startGame();
			} 
			else if ( ( e.keyCode == TWO || e.keyCode == NUMPAD_TWO) && numUnlocked >= 2){
				playerPicked = 2;
				startGame();
			}
			else if ( ( e.keyCode == THREE || e.keyCode == NUMPAD_THREE) && numUnlocked >= 3){
				playerPicked = 3;
				startGame();
			}
			else if ( ( e.keyCode == FOUR || e.keyCode == NUMPAD_FOUR) && numUnlocked >= 4){
				playerPicked = 4;
				startGame();
			}
			else if ( ( e.keyCode == FIVE || e.keyCode == NUMPAD_FIVE) && numUnlocked >= 5){
				playerPicked = 5;
				startGame();
			};
		}
	
		public function startGame():void {
			stage.focus = stage;
			gotoAndStop("start");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, playerKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, playerKeyUpHandler);
			addEventListener(Event.ENTER_FRAME, gameLoop);
			initGame();
		};
		
		public function gameLoop(e:Event):void {
			if (!_gameOver){
				moveObstacles();
				detectHit();
			};
		};
		
		public function initGame():void {
			setGame();
			addObstacles();
			addScoreBoard();
			addPlayBtn();
		 };
	   
	   public function setGame(){
			level = 0 ;
			score = 0 ;
		    addPlayer();
		    addHealthMeter();
			healthCounter = 0;
		   _gameOver = false;
		 }
	
		public function moveObstacles():void{
				// moving left to right
				if (obstacle.direction > 0 && obstacle.x < W){
					obstacle.x += obstacle.speed;
				}
				// moving right to left
				else if (obstacle.direction < 0 && obstacle.x > 0){
					obstacle.x = obstacle.x + (obstacle.speed*obstacle.direction);
				}
				else {
					if (!obstacle.isGround){
						breakHeart();
					} else {
						removeObstacle();
						addObstacles();
					}
				}
		};
		
		function removeObstacle():void{
			var obs = this.getChildByName("obstacle");
			if (obs !== null){
				removeChild(obs);
			}
		};
		public function breakHeart():void {
			var heart = this.getChildByName("health" + healthCounter);
			heart.decreaseHealth();
			healthCounter++
			if (healthCounter == 3){
				_gameOver = true;
				trace("breakheart removeObs");
				removeObstacle();
				gameOver();
			} else {
				removeObstacle();
				addObstacles();
			}
		};
		
		public function addHealth():void{
			if (healthCounter > 0 && healthCounter < 3){
				healthCounter--;
				var heart = this.getChildByName("health" + healthCounter);
				heart.increaseHealth();
				if(healthCounter <= 0) {
					healthCounter = 0;
				};
			}
		}
		
		public function detectHit():void{
			/* either punch or kick */
			if (player.hotSpot.hitTestObject(obstacle) && obstacle.isGround){
				 trace("not dodged");
				// removeObstacle();
				 breakHeart();
			 } else if (player.hotSpot.hitTestObject(obstacle)){
				trace("hit");
				addScore();
				removeObstacle();
				addObstacles();
			 }
		}
		
		public function playerKeyUpHandler(e:KeyboardEvent): void{
			player.keyUpAction(e);
		}
		
		public function playerKeyDownHandler(e:KeyboardEvent):void{
			player.keyDownAction(e);
		}; 
		
		public function addPlayer():void {
			player = new Player(W,H, playerPicked);
			addChild(player);
		}; 
		
		public function addHealthMeter():void {
			for (var h = 0; h < 3; h++){
				var health = new Life(h, W);
				addChild(health);
			};
			
		}; // end addHealthMeter
		
		public function removeHealthMeter():void{
			for (var h = 0; h < 3; h++){
				removeChild(this.getChildByName("health" + h));
			};
		};
		
		public function addObstacles():void {
			obstacle = new Obstacle(W, level, numUnlocked);
			addChild(obstacle);
		};
		
		public function addScoreBoard():void{
			scoreTextField = new TextField();
			scoreTextField.x = 20;
			scoreTextField.y = 10;
			scoreTextField.width = 400;
			scoreTextField.name = "scoreTextField";
			addChild(scoreTextField);
			
			txtFormat = new TextFormat();
			txtFormat.font = "Verdana";
            txtFormat.color = 0xFF0000;
            txtFormat.size = 15;
            scoreTextField.defaultTextFormat = txtFormat;
			scoreTextField.text = "Level : " + level + " Score: " + score;
		};
		
		public function addScore():void {
			score = score+10;
			var unlockedAlert = ""
			if (score % 100 == 0){
				level++;
			};
			
			switch(score){
				case 200 : 
						if (!unlockTracker[2]){
							numUnlocked = 2;
							unlockTracker[2] = true;
							unlockedAlert = "        Player Unlocked";
						};
						break;
				case 500 : // 500 add health
							addHealth();
							break;
				case  600 : 
						if (!unlockTracker[3]){
							numUnlocked = 3;
							unlockTracker[3] = true;
							unlockedAlert = "        Player Unlocked";
						};
						break;
				case  900 : 
						if (!unlockTracker[4]){
							numUnlocked = 4;
							unlockTracker[4] = true;
							unlockedAlert = "        Player Unlocked";
						};
						break;
				case 1000 : // 1000 add health
							addHealth();
							break;
				case  1200 : 
						if (!unlockTracker[5]){
							numUnlocked = 5;
							unlockTracker[5] = true;
							unlockedAlert = "        The Master Unlocked";
						};
						break;
				default: break;
				};
					
			
			scoreTextField.text = "Level : " + level + " Score: " + score + unlockedAlert;
		}
		
		public function addPlayBtn():void{
			_playAgainBtn = new playBtn(W - 100, H);
			addChild(_playAgainBtn);
		};
		
		public function gameOver():void{
			trace("game over");
			removeChild(player);
			
			scoreTextField.x = W/2 - 100;
			scoreTextField.y = H/2 - 100;
			scoreTextField.text = "Level : " + level + " Score: " + score
			removeHealthMeter();
			_playAgainBtn.setActive();
			
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,playerKeyDownHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP,playerKeyUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, playHandler);
		}
		
		public function playHandler(e:KeyboardEvent){
			//trace(" playHandler " + e.keyCode);
			if (e.keyCode == SPACEBAR){
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, playHandler);
				removeChild(scoreTextField);
				_playAgainBtn.deActivate();
				
				titleScreen();
			}
			
			
		}

	}; //end Main
	
}
