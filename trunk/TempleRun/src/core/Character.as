package core
{
	import constants.GameConstants;
	
	import flare.core.Pivot3D;
	
	import flash.events.Event;
	
	public class Character extends Pivot3D
	{
		public static const IDLE:String = "idle";
		public static const RUN:String = "run";
		public static const JUMP:String = "jump";
		public  var currentState:String = "run"
		
		public var char3D:Pivot3D
		public function Character()
		{
		}
		
		
		public function showIdle():void{
			char3D.gotoAndPlay( IDLE,1); 
		}
		
		public function showRun():void{
			/*		char3D.frameSpeed = 0.5;
			char3D.gotoAndPlay(RUN);*/
			
			char3D.gotoAndPlay(RUN);
		}
		
		public function showJump():void{
			//char3D.frameSpeed = 0.5;
			char3D.gotoAndPlay(JUMP,3);
		}
		
		public function showJumpAndRun():void{
			var t:Pivot3D = this;
			char3D.gotoAndPlay(JUMP,0,Pivot3D.ANIMATION_STOP_MODE);
			char3D.children[0].addEventListener("animationComplete",jumpComplete)
		}
		
		private function jumpComplete(event:Event):void{
			char3D.children[0].removeEventListener("animationComplete",jumpComplete);
			char3D.frameSpeed = 1;
			showRun();
		}
		
	}
}