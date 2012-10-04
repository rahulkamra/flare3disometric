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
			
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 0, -500);
			scene.camera.lookAt( -1024, -1024, -1);
			
			scene.camera.setRotation(-45,0,-45);
			
			scene.camera.fieldOfView = 1;
			//scene.camera.far = 10000000;
			
			addMap();
			stage.addEventListener(Event.ENTER_FRAME,_enterFrame);
		}
		
		protected function _enterFrame(event:Event):void
		{
			if(scene){
			}
		}		
		
		public function addMap():void{
			
			wrapperPlane = new Plane();
			debugPlane = new Plane();
			
			bitmap = new CityBuilderFlare3D.Map()
			var texture:Texture3D = new Texture3D(bitmap.bitmapData);
			
			var material:Shader3D = new Shader3D( "", null, false);
			material.filters.push( new TextureFilter( texture ) ); 
			material.build();
			
			plane = new Plane( "sourcePlane", 2048, 2048, 1, material );
			
			var isometricGrid:IsometricGrid = new IsometricGrid();
			wrapperPlane.addChild(isometricGrid);
			isometricGrid.init(100,100,32);
			
			/*wrapperPlane.addChild(debugPlane);
			make2DGrid();*/
			
			wrapperPlane.addChild(plane);
			isometricGrid.z = plane.z-1
			scene.addChild(wrapperPlane);
			
			
			plane.addEventListener(MouseEvent3D.MOUSE_DOWN,_mouseDown);
			plane.addEventListener(MouseEvent3D.MOUSE_UP,_mouseUp);
			plane.addEventListener(MouseEvent3D.MOUSE_MOVE,_mouseMove);
				
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL,_mouseWheel);
			
		}
		
		
		private var isMouseDown:Boolean  = false;
		
		private var regX:Number  =0;
		private var regY:Number  =0;
		private var regZ:Number  =0;
		
		private var regV:Vector3D  =null;
		
		
		protected function _mouseMove(event:MouseEvent3D):void
		{
			if(!isMouseDown)return;
			 
			
			//trace(event.info.point , regV);
			var tempV:Vector3D = new Vector3D(regX,regY,regZ);
			
			var changeV:Vector3D = Vector3DUtils.sub(tempV,event.info.point);
			
			trace(changeV.x/500);
			
			wrapperPlane.translateX(-changeV.x);
			wrapperPlane.translateY(-changeV.y);
			
			regX = event.info.point.x;
			regY = event.info.point.y;
			regV = event.info.point;
		}  
		
		protected function _mouseUp(event:MouseEvent3D):void
		{
			isMouseDown = false;
		}
		
		protected function _mouseDown(event:MouseEvent3D):void
		{
			isMouseDown = true;
			regX = event.info.point.x;
			regY = event.info.point.y;
			regZ = event.info.point.z;
			
			regV = event.info.point;
		}		
		
		
		
		protected function _mouseWheel(event:MouseEvent):void
		{
			var temp : int  = event.delta;
			
			if(temp < 1 ){
				if(scene.camera.zoom < 4){
					scene.camera.zoom = scene.camera.zoom + 0.2
				}
			}
			
			if(temp > 1 ){
				if(scene.camera.zoom > 1.3){
					scene.camera.zoom = scene.camera.zoom - 0.2 
				}
				
			}	
			
		}
		
	}
}