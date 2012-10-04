package
{
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	public class IsoBuilder extends Sprite
	{
		
		private var _stage:Stage;

		public static var scene:Viewer3D;
		public function IsoBuilder(stage:Stage)
		{
			this._stage = stage;
			
			scene = new Viewer3D( this);
			scene.antialias = 2;
			
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent )
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent )
			//scene.setViewport( 0, 0, 1000, 1000 );
			stage.addEventListener( Event.RESIZE, resizeEvent );
			
		}
		
		
		private function resizeEvent(e:Event):void 
		{
			scene.setViewport( 0, 0, stage.stageWidth, stage.stageHeight );
		}
		
		private function progressEvent(e:Event):void 
		{
		}
		
		private function completeEvent(e:Event):void 
		{
			
		}
	}
}