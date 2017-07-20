package com.ginhangames {
	
	import flash.display.MovieClip;
	
	public class playBtn extends flash.display.MovieClip{

		public function playBtn(W, H) {
			// constructor code
			this.x = W/2;
			this.visible = false;
			this.y = H/2;
		}
		
		public function setActive():void{
			this.visible = true;
			this.enabled = true;
		}
		
		public function deActivate():void{
			this.visible = false;
			this.enabled = false;
		}

	}
	
}
