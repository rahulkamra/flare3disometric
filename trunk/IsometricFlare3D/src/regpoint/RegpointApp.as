package regpoint
{
	import flare.basic.Scene3D;
	import flare.primitives.Plane;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import game.IsometricController;
	
	public class RegpointApp extends Sprite
	{
		
		private static var scene:Scene3D;
		private static var _stage:Stage
		
		private static var plane:Plane;
		
		private var wrapperPlane:Plane;
		
		private var debugPlane:Plane;
		
		
		public function RegpointApp(stage:Stage)
		{
			
			_stage  = stage;
			scene = new Scene3D(this);
			
			IsometricController.init(scene);
			
			scene.camera.zoom = 0.4
			//scene.camera.far = 10000000;
		}
	}
}