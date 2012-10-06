package game.controller
{
	import com.electron.engine.core.SingletonManager;
	
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
	
	import game.IsometricGame;
	import game.entity.GridEntity;
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
		private var tree:Flare3DLoader
		private var scene:Scene3D
		
		public function loadAnimations(scene:Scene3D):void{
			this.scene = scene;
			scene.addEventListener( Scene3D.COMPLETE_EVENT, animationComplete );
			
			idleAnimation = new Flare3DLoader(  GridEntityMapping.MALE_IDLE);
			IsometricGame.scene.library.push(idleAnimation);
			
			runningAnimation = new Flare3DLoader(  GridEntityMapping.MALE_RUN );
			IsometricGame.scene.library.push(runningAnimation);
			
			turnLeft = new Flare3DLoader(  GridEntityMapping.MALE_TURN_LEFT );
			IsometricGame.scene.library.push(turnLeft);
			
			turnRight = new Flare3DLoader(  GridEntityMapping.MALE_TURN_RIGHT );
			IsometricGame.scene.library.push(turnRight);
			
		}
		
		private var animationLoaded:Boolean = false;
		protected function animationComplete(event:Event):void
		{	
			
			scene.removeEventListener( Scene3D.COMPLETE_EVENT, animationComplete );
			if(!animationLoaded){
				Pivot3DUtils.appendAnimation( IsometricGame.char.asset3D, idleAnimation, SmurfCharacter.IDLE);
				IsometricGame.char.asset3D.addLabel( new Label3D( SmurfCharacter.IDLE, 1, 90) );
				
				Pivot3DUtils.appendAnimation( IsometricGame.char.asset3D, runningAnimation, SmurfCharacter.RUN);
				IsometricGame.char.asset3D.addLabel( new Label3D( SmurfCharacter.RUN, 92, 107) );
				
				
				Pivot3DUtils.appendAnimation( IsometricGame.char.asset3D, turnLeft, SmurfCharacter.TURN_LEFT);
				IsometricGame.char.asset3D.addLabel( new Label3D( SmurfCharacter.TURN_LEFT, 109, 123) );
				
				Pivot3DUtils.appendAnimation( IsometricGame.char.asset3D, turnRight, SmurfCharacter.TURN_RIGHT);
				IsometricGame.char.asset3D.addLabel( new Label3D( SmurfCharacter.TURN_RIGHT, 125, 139) );
	
				trace( "IsometricGame.char.pivot3D.labels",IsometricGame.char.asset3D.labels[SmurfCharacter.TURN_RIGHT])
				
				IsometricGame.char.showIdle();
				animationLoaded = true;
			}else{
				trace("this is not possible");
			}
			preLoadTrees()
		}
		
		private static var dict:Dictionary = new Dictionary();
		private var pivotToRemove:Array = new Array
		public function preLoadTrees():void{
			Flare3DLoader1;
			scene.addEventListener( Scene3D.COMPLETE_EVENT, treePreloadingComplete );
			
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.TREE_1.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.TREE_2.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.TREE_3.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.TREE_4.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.FEED_MAKER.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.KITCHEN_WOOD_HOUSE.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.MARKET_STALL.url));
			pivotToRemove.push(scene.addChildFromFile(GridEntityMapping.RING));
		}
		
		public function treePreloadingComplete(event:Event):void{
			scene.removeEventListener( Scene3D.COMPLETE_EVENT, treePreloadingComplete );
			
			for(var count:int = 0 ;count < pivotToRemove.length; count++){
				scene.removeChild(pivotToRemove[count] as Pivot3D);
			}
			IsometricGame.addTrees();
		}
		
			
	}
}