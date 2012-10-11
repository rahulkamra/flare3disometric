package
{
	import core.Character;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Main extends Sprite
	{
		
		public static var scene:Scene3D;
		private static var _stage:Stage
		
		public function Main(stage:Stage)
		{
			_stage  = stage;
			scene = new Viewer3D(this);
			initCamera();
			initChar();
			stage.addEventListener(Event.ENTER_FRAME,_enterFrame);
		}
		
		protected function _enterFrame(event:Event):void
		{
			trace(scene.camera.getRotation());
			
		}		
		
		private function initChar():void
		{
			var char:Character = new Character();
			scene.addChild(char);
			
		}
		
		private function initCamera():void
		{
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 0, 200);
			scene.camera.lookAt( 0, 0, 0);
		}
	}
}