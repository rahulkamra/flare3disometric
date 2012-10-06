package game
{
	import com.electron.engine.debug.log;
	
	import flare.basic.Scene3D;
	import flare.collisions.CollisionInfo;
	import flare.collisions.RayCollision;
	import flare.core.Camera3D;
	import flare.core.Pivot3D;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;

	public class IsometricController
	{
		public function IsometricController()
		{
		}
		
		private static var _scene3D:Scene3D;
		public static function init(scene:Scene3D):void{
			_scene3D = scene;
			scene.camera = new Camera3D( "myOwnCamera" );
			
			scene.camera.setPosition( 0, 0, -1000);
			scene.camera.lookAt( 0, 0, -1);
			
			scene.camera.setRotation(-45,0,-45);

			scene.camera.fieldOfView = 10;
			
		}
		
		
		public static function screenToWorld(screenX:int,screenY:int):Vector3D{
			var ray:RayCollision = new RayCollision();
			ray.addCollisionWith(IsometricGame.plane,false);
			
			//var from:Vector3D = object3D.localToGlobal( new Vector3D( 0, 100, 0 ) );
			var from:Vector3D = IsometricGame.scene.camera.getPosition(true);
			var dir:Vector3D = IsometricGame.scene.camera.getPointDir(screenX,screenY);
			
			if ( ray.test( from, dir ) )
			{
				// Get the info of the first collision.
				var info:CollisionInfo = ray.data[0];
				return info.point;
			}
			
			return null;
		}
		
		public static function gridToPlane(row:int,col:int):Vector3D{
			var cellSize:int = IsometricGame.cellSize;
			var x:int = col*cellSize - IsometricGame.plane.width/2;
			var y:int = row*cellSize - IsometricGame.plane.height/2;
			var vector3D:Vector3D = new Vector3D(x,y,IsometricGame.plane.z)
			return vector3D
		}
		
		
		public static function planeToGrid(vector3D:Vector3D):Array{
			var col:int = Math.floor((vector3D.x+IsometricGame.plane.width/2)/IsometricGame.cellSize);
			var row:int = Math.floor((vector3D.y+IsometricGame.plane.height/2)/IsometricGame.cellSize);
			return[row,col];
		}
		
	}
}