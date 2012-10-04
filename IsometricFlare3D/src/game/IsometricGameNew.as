package game
{
	import com.electron.engine.debug.log;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.core.Lines3D;
	import flare.core.Texture3D;
	import flare.events.MouseEvent3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.TextureFilter;
	import flare.primitives.Plane;
	import flare.utils.Vector3DUtils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	public class IsometricGameNew extends Sprite
	{
		
		private static var scene:Scene3D;
		private static var _stage:Stage
		
		private static var plane:Plane;
		
		
		private static var bitmap:Bitmap;
		
		private var wrapperPlane:Plane;
		
		private var debugPlane:Plane;
		
		private var cellSize:int;
		
		
		
		public function IsometricGameNew(stage:Stage)
		{
			_stage  = stage;
			scene = new Scene3D(this);
			
			IsometricController.init(scene);
			
			scene.camera.zoom = 0.4
			//scene.camera.far = 10000000;
			initWorld();
			stage.addEventListener(Event.ENTER_FRAME,_enterFrame);
		}
		
		private function initWorld():void
		{
			// TODO Auto Generated method stub
			wrapperPlane = new Plane();
			scene.addChild(wrapperPlane);			
			addMap();
			addGrid();
			CameraInteraction.init(_stage,scene,plane);
		}		
		
		protected function _enterFrame(event:Event):void
		{
			if(scene){
			}
		}		
		
		public function addMap():void{
			
			
			bitmap = new CityBuilderFlare3D.Map()
			var texture:Texture3D = new Texture3D(bitmap.bitmapData);
			
			var material:Shader3D = new Shader3D( "", null, false);
			material.filters.push( new TextureFilter( texture ) ); 
			material.build();
			
			plane = new Plane( "sourcePlane", bitmap.width, bitmap.width, 1, material );
			plane.x = bitmap.width/2;
			plane.y = bitmap.width/2;
			wrapperPlane.addChild(plane);
		}
		
		private function addGrid():void
		{
			// TODO Auto Generated method stub
			
			var isometricGrid:IsometricGrid = new IsometricGrid();
			wrapperPlane.addChild(isometricGrid);
			isometricGrid.init(bitmap.width/32,bitmap.height/32,32);
			isometricGrid.z = plane.z-1
		}
		
		
	}
}