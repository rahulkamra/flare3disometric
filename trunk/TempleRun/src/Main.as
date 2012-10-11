package
{
	import core.Character;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.utils.Pivot3DUtils;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		
		public static var scene:Scene3D;
		private static var _stage:Stage

		private var char:Character;
		
		public function Main(stage:Stage)
		{
			_stage  = stage;
			scene = new Scene3D(this);
			initChar();
			
			initCamera();
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			stage.addEventListener(Event.ENTER_FRAME,_enterFrame);
		}
		
		protected function updateEvent(event:Event):void
		{
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 100, 1000, char, 0.025 );
			
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, char );
		}
		
		protected function _enterFrame(event:Event):void
		{
			//trace(scene.camera.getRotation());
			//Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, char, char.getDir(), 0.05 );
		}		
		
		private function initChar():void
		{
			char = new Character();
			scene.addChild(char);
			
		}
		
		
		private function initCamera():void
		{
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 100, 200, char, 0.1 );
			
			/*scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 100, 200);
			scene.camera.lookAt( 0, 0, 0);*/
		}
		
		
		
	}
}