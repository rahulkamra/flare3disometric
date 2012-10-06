package game
{
	import caurina.transitions.Tweener;
	
	import com.electron.engine.debug.log;
	
	import flare.basic.Scene3D;
	import flare.events.MouseEvent3D;
	import flare.primitives.Plane;
	import flare.utils.Vector3DUtils;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	import game.controller.DragManager;
	import game.pathfinding.Tile;
	
	import mx.core.FlexGlobals;
	
	import spark.components.Button;
	
	public class CameraInteraction
	{
		public function CameraInteraction()
		{
		}
		
		private static var scene:Scene3D
		private static var stage:Stage
		
		private static var isMouseDown:Boolean  = false;
		
		private static var regX:Number  =0;
		private static var regY:Number  =0;
		private static var regZ:Number  =0;
		
		private static var regV:Vector3D  =null;
		
		private static var plane:Plane  =null;
		
		private static var justDragged:Boolean  =false;
		private static var canZoom:Boolean  =true;
		
		
		
		public static function init(stage:Stage,scene:Scene3D,plane:Plane):void{
			CameraInteraction.scene = scene;
			CameraInteraction.stage = stage;
			CameraInteraction.plane = plane;
			
			
			plane.addEventListener(MouseEvent3D.MOUSE_DOWN,_mouseDown);
			plane.addEventListener(MouseEvent3D.MOUSE_UP,_mouseUp);
			plane.addEventListener(MouseEvent3D.MOUSE_MOVE,_mouseMove);
			
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,_mouseWheel);
			stage.addEventListener(MouseEvent.MOUSE_UP,_mouseUpFlash);
			
		}
		
		protected static function _mouseUpFlash(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			if(!DragManager._onMouse){
				if(!justDragged){
					if(!(event.target is Button)){
						var collisionPoint:Vector3D = IsometricController.screenToWorld(stage.mouseX,stage.mouseY);
						try{
							var localPoint:Vector3D = IsometricGame.plane.globalToLocal(collisionPoint);
							var grid:Array = IsometricController.planeToGrid(localPoint);
							if(grid[0] > IsometricGame.rows-1 || grid[1] > IsometricGame.cols-1){
							}else{
								IsometricGame.char.moveToATile(new Tile(grid[0],grid[1],true))
							}
						}catch(e:Error){
							trace("Clicked outside");
						}
					}
				}
			}
		}
		
		protected static function _mouseMove(event:MouseEvent3D):void
		{
			if(!isMouseDown)return;
			var tempV:Vector3D = new Vector3D(regX,regY,regZ);
			
			var changeV:Vector3D = Vector3DUtils.sub(tempV,event.info.point);
			
			if(Math.abs(changeV.x) > 10 || Math.abs(changeV.y) > 10){
				justDragged = true;
			}
			
			plane.parent.x = plane.parent.x + (-changeV.x);
			plane.parent.y = plane.parent.y + (-changeV.y);
			
			//trace(plane.parent.x,plane.parent.y)
			regX = event.info.point.x;
			regY = event.info.point.y;
			regV = event.info.point;
		}  
		
		protected static function _mouseUp(event:MouseEvent3D):void
		{
			isMouseDown = false;
			justDragged = false
			
		}
		
		protected static function _mouseDown(event:MouseEvent3D):void
		{
			isMouseDown = true;
			regX = event.info.point.x;
			regY = event.info.point.y;
			regZ = event.info.point.z;
			
			regV = event.info.point;
		}	
		
		
		private static var currentZoom:int = 3;
		
		private static var level1FieldView:int = 31;
		private static var level1Camera:int = -70;
		private static var level1XMove:int = 480;
		private static var level1YMove:int = 480;
		
		public static var level2FieldView:int = 27;
		private static var level2Camera:int = -60;
		private static var level2XMove:int = 0;
		private static var level2YMove:int = 0;
		
		
		
		private static var level3FieldView:int = 19;
		private static var level3Camera:int = -60;
		private static var level3XMove:int = 0;
		private static var level3YMove:int = 0;
		
		private static var level4FieldView:int = 15;
		private static var level4Camera:int = -60;
		private static var level4XMove:int = 0;
		private static var level4YMove:int = 0;
		
		
		
		protected static function _mouseWheel(event:MouseEvent):void
		{
			var temp : int  = event.delta;
			if(!canZoom)return;
			
			if(temp < 1 ){
				if(currentZoom > 1){
					currentZoom = currentZoom -1;
					syncCamera(-1);
					canZoom = false;
				}
			}
			
			
			if(temp > 1 ){
				if(currentZoom < 4){
					currentZoom = currentZoom + 1;
					syncCamera(1);
					canZoom = false;
				}
			}
		}
		
		
		public static function get cameraX():int
		{
			return plane.parent.x
		}
		
		public static function set cameraX(value:int):void
		{
			plane.parent.x = value;
		}
		
		public static function get cameraY():int
		{
			return plane.parent.y;
		}
		
		public static function set cameraY(value:int):void
		{
			plane.parent.y = value;
		}
		
		private static function syncCamera(delta:int):void
		{
			var toFieldView:int = CameraInteraction["level"+currentZoom+"FieldView"];
			var toCameraRotation:int = CameraInteraction["level"+currentZoom+"Camera"];
			
			var xMove:int = CameraInteraction["level"+currentZoom+"XMove"];
			var yMove:int = CameraInteraction["level"+currentZoom+"YMove"];
			
			if(currentZoom == 2 && delta == 1){
				xMove = -  CameraInteraction["level"+(currentZoom-1)+"XMove"];
				yMove =  - CameraInteraction["level"+(currentZoom-1)+"YMove"];
			}
			
			Tweener.addTween(scene.camera,{fieldOfView:toFieldView, time:0.5, transition:"linear"});
			Tweener.addTween(IsometricController,{cameraRotation:toCameraRotation, time:0.5, transition:"linear"});
			
			Tweener.addTween(CameraInteraction,{cameraX:cameraX+xMove, time:0.5, transition:"linear",onComplete:zoomDone});
			Tweener.addTween(CameraInteraction,{cameraY:cameraY+yMove, time:0.5, transition:"linear",onComplete:zoomDone});
			
		}
		
		private static function zoomDone():void{
			canZoom = true;
		}
		
	}
}