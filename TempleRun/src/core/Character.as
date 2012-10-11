package core
{
	import constants.GameConstants;
	
	import flare.core.Pivot3D;
	
	import flash.events.Event;

	public class Character extends Pivot3D
	{
		public static const IDLE:String = "idle";
		public static const RUN:String = "run";
		public static const TURN_LEFT:String = "turn_left";
		public static const TURN_RIGHT:String = "turn_right";
		public static const JUMP:String = "jump";
		
		public var char3D:Pivot3D
		public function Character()
		{
			char3D  = Main.scene.addChildFromFile(GameConstants.MALE_CHAR) as Pivot3D;
			addChild(char3D);
		}
		
		
		public function showIdle():void{
			char3D.gotoAndPlay( IDLE,1);
		}
		
		public function showRun():void{
			char3D.frameSpeed = 0.5;
			char3D.gotoAndPlay(RUN);
		}
		
		public function showJump():void{
			char3D.frameSpeed = 0.5;
			char3D.gotoAndPlay(JUMP,0,Pivot3D.ANIMATION_STOP_MODE);
		}
		
		public function showJumpAndRun():void{
			var t:Pivot3D = this;
			char3D.frameSpeed = 0.5;
			char3D.gotoAndPlay(JUMP,0,Pivot3D.ANIMATION_STOP_MODE);
			char3D.children[1].addEventListener("animationComplete",function jumpComplete(event:Event):void{
				//showRun();
			});
				
		}
		
	}
}