package game
{
	import flare.basic.Scene3D;
	import flare.core.Camera3D;

	public class IsometricController
	{
		public function IsometricController()
		{
		}
		
		private static var _scene3D:Scene3D;
		public static function init(scene:Scene3D):void{
			_scene3D = scene;
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 0, -500);
			scene.camera.lookAt( -1024, -1024, -1);
			
			scene.camera.setRotation(-45,0,-45);
			scene.camera.fieldOfView = 1;
			
		}
		
		
	}
}