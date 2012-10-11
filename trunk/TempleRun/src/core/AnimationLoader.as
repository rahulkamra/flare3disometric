package core
{
	import com.electron.engine.core.SingletonManager;
	
	import constants.GameConstants;
	
	import core.Character;
	
	import flare.basic.Scene3D;
	import flare.core.Label3D;
	import flare.core.Pivot3D;
	import flare.loaders.Flare3DLoader;
	import flare.loaders.Flare3DLoader1;
	import flare.loaders.Flare3DLoader3;
	import flare.utils.Pivot3DUtils;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	

	public class AnimationLoader
	{
		public function AnimationLoader()
		{
		}
		
		public static function get Instance():AnimationLoader{
			return SingletonManager.getInstance(AnimationLoader) as AnimationLoader
		}
		
		
		private var idleAnimation:Flare3DLoader
		private var runningAnimation:Flare3DLoader
		private var turnLeft:Flare3DLoader
		private var turnRight:Flare3DLoader
		private var tree:Flare3DLoader
		private var scene:Scene3D
		
		public function loadAnimations(scene:Scene3D):void{
			this.scene = scene;
			scene.addEventListener( Scene3D.COMPLETE_EVENT, animationComplete );
			
			idleAnimation = new Flare3DLoader(GameConstants.MALE_IDLE);
			Main.scene.library.push(idleAnimation);
			
			runningAnimation = new Flare3DLoader(  GameConstants.MALE_RUN );
			Main.scene.library.push(runningAnimation);
			
			jumpingAnimation = new Flare3DLoader(  GameConstants.MALE_JUMP );
			Main.scene.library.push(jumpingAnimation);
			
		}
		
		private var animationLoaded:Boolean = false;

		private var jumpingAnimation:Flare3DLoader;
		protected function animationComplete(event:Event):void
		{	
			
			scene.removeEventListener( Scene3D.COMPLETE_EVENT, animationComplete );
			if(!animationLoaded){
				Pivot3DUtils.appendAnimation( Main.char.char3D, idleAnimation, Character.IDLE);
				Main.char.char3D.addLabel( new Label3D( Character.IDLE, 1, 90) );
				
				
				Pivot3DUtils.appendAnimation( Main.char.char3D, runningAnimation, Character.RUN);
				Main.char.char3D.addLabel( new Label3D( Character.RUN, 92, 107) );
				
				Pivot3DUtils.appendAnimation( Main.char.char3D, jumpingAnimation, Character.JUMP);
				Main.char.char3D.addLabel( new Label3D( Character.JUMP, 109, 124) );
				
				/*Pivot3DUtils.appendAnimation( IsometricGame.char.asset3D, turnLeft, SmurfCharacter.TURN_LEFT);
				IsometricGame.char.asset3D.addLabel( new Label3D( SmurfCharacter.TURN_LEFT, 109, 123) );
				
				Pivot3DUtils.appendAnimation( IsometricGame.char.asset3D, turnRight, SmurfCharacter.TURN_RIGHT);
				IsometricGame.char.asset3D.addLabel( new Label3D( SmurfCharacter.TURN_RIGHT, 125, 139) );
	
				trace( "IsometricGame.char.pivot3D.labels",IsometricGame.char.asset3D.labels[SmurfCharacter.TURN_RIGHT])*/
				
				//trace( "IsometricGame.char.pivot3D.labels",Main.char.char3D.labels[Character.JUMP])
				
				Main.char.showIdle();
				animationLoaded = true;
			}else{
				trace("this is not possible");
			}
		}
		
			
	}
}