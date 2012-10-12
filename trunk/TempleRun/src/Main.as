package
{
	import core.AnimationLoader;
	import core.AstronautLoader;
	import core.Character;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.collisions.CollisionInfo;
	import flare.collisions.RayCollision;
	import flare.core.Camera3D;
	import flare.core.Pivot3D;
	import flare.primitives.Plane;
	import flare.utils.Pivot3DUtils;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	
	public class Main extends Sprite
	{
		
		public static var scene:Scene3D;
		private static var _stage:Stage
		public static var char:Character;
		public static var wrapperPlane:Plane;

		private static var plane:Plane;
		
		public function Main(stage:Stage)
		{
			_stage  = stage;
			scene = new Viewer3D(this);
			//initChar();
			
			wrapperPlane = new Plane();
			
			scene.addChild(wrapperPlane);
			
			addGround();
			AstronautLoader.Instance.loadAnimations(scene);
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			stage.addEventListener(Event.ENTER_FRAME,_enterFrame);
		}
		
		protected function updateEvent(event:Event):void
		{
			return;
			if(!char)return;
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 500, 800, char, 1 );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 100, 0, char );
		}
		
		protected function _enterFrame(event:Event):void
		{
			
		}		
		
		
		private function addGround():void
		{
			plane = new Plane("Plane",3000,300);
			plane.rotateZ(90);
			plane.rotateY(270);
			wrapperPlane.addChild(plane);
		}
		
		private function initCamera():void
		{
			
			/*scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 100, 200);
			scene.camera.lookAt( 0, 0, 0);*/
		}
		
		
		public static function addObject(object3D:Pivot3D):void
		{
			// TODO Auto Generated method stub
			var ray:RayCollision = new RayCollision();
			ray.addCollisionWith(wrapperPlane,false);
			var from:Vector3D = object3D.localToGlobal( new Vector3D( 0, 0, 0 ) );
			var dir:Vector3D = object3D.getDown();
			trace(from,dir);
			if ( ray.test( from, dir ) )
			{
				// Get the info of the first collision.
				var info:CollisionInfo = ray.data[0];
				
				// Set the astronaut container at the collision point.
				object3D.setPosition( info.point.x, info.point.y, info.point.z );
				trace(info.point);
				// Align the astronaut container to the collision normal.
				object3D.setNormalOrientation( info.normal, 0.05 );
			}
		//	object3D.setPosition(object3D.x,object3D.y,object3D.z+1); 
			trace(from);
			wrapperPlane.addChild(object3D);
		}
	}
}