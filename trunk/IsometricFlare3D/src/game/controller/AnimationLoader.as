package game.controller
{
	import com.electron.engine.core.SingletonManager;
	
	import flare.basic.Scene3D;
	import flare.core.Label3D;
	import flare.loaders.Flare3DLoader;
	import flare.utils.Pivot3DUtils;
	
	import flash.events.Event;
	
	import game.IsometricGame;
	import game.entity.SmurfCharacter;
	import game.settings.GridEntityMapping;

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
		
		public function loadAnimations(scene:Scene3D):void{
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent );
			
			idleAnimation = new Flare3DLoader(  GridEntityMapping.MALE_IDLE);
			IsometricGame.scene.library.push(idleAnimation);
			
			runningAnimation = new Flare3DLoader(  GridEntityMapping.MALE_RUN );
			IsometricGame.scene.library.push(runningAnimation);
			
			turnLeft = new Flare3DLoader(  GridEntityMapping.MALE_TURN_LEFT );
			IsometricGame.scene.library.push(turnLeft);
			
			turnRight = new Flare3DLoader(  GridEntityMapping.MALE_TURN_RIGHT );
			IsometricGame.scene.library.push(turnRight);
			
		}
		
		protected function completeEvent(event:Event):void
		{
			Pivot3DUtils.appendAnimation( IsometricGame.char.pivot3D, idleAnimation, SmurfCharacter.IDLE);
			IsometricGame.char.pivot3D.addLabel( new Label3D( SmurfCharacter.IDLE, 1, 90) );
			
			Pivot3DUtils.appendAnimation( IsometricGame.char.pivot3D, runningAnimation, SmurfCharacter.RUN);
			IsometricGame.char.pivot3D.addLabel( new Label3D( SmurfCharacter.RUN, 92, 107) );
			
			
			Pivot3DUtils.appendAnimation( IsometricGame.char.pivot3D, turnLeft, SmurfCharacter.TURN_LEFT);
			IsometricGame.char.pivot3D.addLabel( new Label3D( SmurfCharacter.TURN_LEFT, 109, 123) );
			
			Pivot3DUtils.appendAnimation( IsometricGame.char.pivot3D, turnRight, SmurfCharacter.TURN_RIGHT);
			IsometricGame.char.pivot3D.addLabel( new Label3D( SmurfCharacter.TURN_RIGHT, 125, 139) );

			trace( "IsometricGame.char.pivot3D.labels",IsometricGame.char.pivot3D.labels[SmurfCharacter.TURN_RIGHT])
			
			IsometricGame.char.showIdle();
			
		}
	}
}