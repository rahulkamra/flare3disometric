package
{
	import core.AnimationLoader;
	import core.Character;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.primitives.Plane;
	import flare.utils.Pivot3DUtils;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	
	public class Main extends Sprite
	{
		
		public static var scene:Scene3D;
		private static var _stage:Stage
		public static var char:Character;
		
		public function Main(stage:Stage)
		{
			_stage  = stage;
			scene = new Viewer3D(this);
			initChar();
			addGround();
			scene.addEventListener( Scene3D.UPDATE_EVENT, updateEvent );
			stage.addEventListener(Event.ENTER_FRAME,_enterFrame);
			AnimationLoader.Instance.loadAnimations(scene);
		}
		
		protected function updateEvent(event:Event):void
		{
			return;
			Pivot3DUtils.setPositionWithReference( scene.camera, 0, 500, 800, char, 1 );
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 100, 0, char );
		}
		
		protected function _enterFrame(event:Event):void
		{
			
		}		
		
		private function initChar():void
		{
			char = new Character();
			scene.addChild(char);
			
		}
		
		private function addGround():void
		{
			var plane:Plane = new Plane("zzzz",3000,300);
			plane.rotateZ(90);
			plane.rotateY(270);
			
			scene.addChild(plane);
		}
		
		private function initCamera():void
		{
			
			/*scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 100, 200);
			scene.camera.lookAt( 0, 0, 0);*/
		}
		
		
		
	}
}