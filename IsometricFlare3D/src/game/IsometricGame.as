package game
{
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.geom.transformations.IsometricTransformation;
	
	import com.electron.engine.util.Utils;
	
	import flare.basic.Scene3D;
	import flare.collisions.RayCollision;
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
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	public class IsometricGame extends Sprite
	{
		
		private static var scene:Scene3D;
		private static var _stage:Stage
		
		private static var plane:Plane;
		
		public function IsometricGame(stage:Stage) 
		{
			_stage  = stage;
			
			scene = new Scene3D(this);
			
			scene.camera = new Camera3D( "myOwnCamera" );
			scene.camera.setPosition( 0, 0, 0);
			
			
			addMap();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE,_mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,_mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,_mouseUp);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,_mouseWheel);
			
		}
		
		
		
		public function addMap():void{
			
			wrapperPlane = new Plane();
			debugPlane = new Plane();
			
			
			bitmap = new CityBuilderFlare3D.Map()
			var texture:Texture3D = new Texture3D(bitmap.bitmapData);
			
			var material:Shader3D = new Shader3D( "", null, false);
			material.filters.push( new TextureFilter( texture ) ); 
			material.build();
			
			plane = new Plane( "sourcePlane", 5600, 3930, 1, material );
			
			wrapperPlane.addChild(plane);
			wrapperPlane.addChild(debugPlane);
			
			
			scene.addChild(wrapperPlane);
			
			plane.z = 1 / scene.camera.zoom * _stage.stageWidth;
			
			plane.addEventListener(MouseEvent3D.MOUSE_MOVE,move);
			
			Utils.Instance.callVeryLate(function temp():void{
				addLine();
			},1000);
			
		}
		
		
		private function addLine():void
		{
			// TODO Auto Generated method stub
			drawGeometry();
			//make2DGrid();
		}		
		
		
		private var isMouseDown:Boolean  = false;
		
		private var regX:Number  = 0;
		private var regY:Number  = 0;
		
		private static var bitmap:Bitmap;
		
		private var wrapperPlane:Plane;
		
		private var debugPlane:Plane;
		
		
		
		protected function _mouseUp(event:MouseEvent):void
		{
			isMouseDown = false;
		}
		
		protected function _mouseDown(event:MouseEvent):void
		{
			isMouseDown = true;
			regX = stage.mouseX;
			regY = stage.mouseY;
		}
		
		protected function move(event:MouseEvent3D):void
		{
			// TODO Auto-generated method stub
			trace(event.info.point);
		}
		
		protected function _mouseMove(event:MouseEvent):void
		{
			
			if(!isMouseDown)return
			var changeX:int = (stage.mouseX - regX);
			var changeY:int = (stage.mouseY - regY);
			
			scene.camera.translateX((-changeX * scene.camera.zoom)/1.5);
			scene.camera.translateY((changeY * scene.camera.zoom)/1.5);
			
			regX = stage.mouseX;
			regY = stage.mouseY;
			
			
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
		
		
		
		
		private var gridSize:Array = [25,25];
		private var cSize:int = 32;
		
		protected function drawGeometry ():void
		{
			var pt:Pt = new Pt();
			
			var i:int;
			var m:int = int(gridSize[0]);
			var line:Lines3D;
			while (i <= m)
			{
				pt = IsoMath.isoToScreen(new Pt(cSize * i));
				line= getLine();
				moveTo(line,pt.x,pt.y);
				pt = IsoMath.isoToScreen(new Pt(cSize * i, cSize * gridSize[1]));
				lineTo(line,pt.x,pt.y);
				add(line);
				
				i++;
			}
			
			i = 0;
			m = int(gridSize[1]);
			while (i <= m)
			{
				pt = IsoMath.isoToScreen(new Pt(0, cSize * i));
				
				line= getLine();
				moveTo(line,pt.x,pt.y);
				
				pt = IsoMath.isoToScreen(new Pt(cSize * gridSize[0], cSize * i));
				lineTo(line,pt.x,pt.y);
				add(line);
				
				i++;
			}
		}
		
		private function getLine():Lines3D{
			var line:Lines3D = new Lines3D();
			var point:Vector3D = plane.getLeft();
			return line;
		}
		
		private function moveTo(line:Lines3D,xTo:int,yTo:int):void{
			var point:Vector3D = plane.getLeft();
			line.moveTo(point.x+xTo,point.y+yTo,point.z);
		}
		
		private function lineTo(line:Lines3D,xTo:int,yTo:int):void{
			var point:Vector3D = plane.getLeft();
			line.lineTo(point.x+xTo,point.y+yTo,point.z);
		}
		private function add(line:Lines3D):void{
			debugPlane.addChild(line);
			debugPlane.z = 1 / scene.camera.zoom * _stage.stageWidth-1;
		}
		
		private function createLine(xFrom:int , yFrom:int , xTo:int , yTo:int):void{
			var line:Lines3D = new Lines3D();
			
			var point:Vector3D = plane.getLeft();
			
			line.moveTo(point.x+xFrom,point.y+yFrom,point.z);
			line.lineTo(point.x+xTo,point.y+yTo,point.z);
			
			debugPlane.addChild(line);
			debugPlane.z = 1 / scene.camera.zoom * _stage.stageWidth-1;
		}
		
		
		
	}
}