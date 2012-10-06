package game
{
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
			plane.parent.translateX(-changeV.x);
			plane.parent.translateY(-changeV.y);
			
			regX = event.info.point.x;
			regY = event.info.point.y;
			regV = event.info.point;
			
			
		}  
		
		protected static function _mouseUp(event:MouseEvent3D):void
		{
			isMouseDown = false;
			/*if(!DragManager._onMouse){
				if(!justDragged){
					
					var localPoint:Vector3D = IsometricGame.plane.globalToLocal(event.info.point);
					trace(event.info.point);
					var grid:Array = IsometricController.planeToGrid(localPoint);
					if(grid[0] > IsometricGame.rows-1 || grid[1] > IsometricGame.cols-1){
					}else{
						trace("Moving to a tile")
						IsometricGame.char.moveToATile(new Tile(grid[0],grid[1],true))
					}
				}
			}*/
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
		
		protected static function _mouseWheel(event:MouseEvent):void
		{
			var temp : int  = event.delta;
			
			if(temp < 1 ){
				if(scene.camera.fieldOfView < 25){
					scene.camera.fieldOfView ++;
				}
			}
			
			if(temp > 1 ){
				if(scene.camera.fieldOfView > 5){
					scene.camera.fieldOfView --;
				}
				
			}	
		}
		
	}
}