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
		
		
		public static function init(stage:Stage,scene:Scene3D,plane:Plane):void{
			CameraInteraction.scene = scene;
			CameraInteraction.stage = stage;
			CameraInteraction.plane = plane;
			
			
			plane.addEventListener(MouseEvent3D.MOUSE_DOWN,_mouseDown);
			plane.addEventListener(MouseEvent3D.MOUSE_UP,_mouseUp);
			plane.addEventListener(MouseEvent3D.MOUSE_MOVE,_mouseMove);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL,_mouseWheel);
			
			
		}
		
		
		protected static function _mouseMove(event:MouseEvent3D):void
		{
			if(!isMouseDown)return;
			var tempV:Vector3D = new Vector3D(regX,regY,regZ);
			
			var changeV:Vector3D = Vector3DUtils.sub(tempV,event.info.point);
			
			plane.parent.translateX(-changeV.x);
			plane.parent.translateY(-changeV.y);
			
			regX = event.info.point.x;
			regY = event.info.point.y;
			regV = event.info.point;
		}  
		
		protected static function _mouseUp(event:MouseEvent3D):void
		{
			isMouseDown = false;
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
				if(scene.camera.zoom < 1){
					scene.camera.zoom = scene.camera.zoom + 0.2
				}
			}
			
			if(temp > 1 ){
				if(scene.camera.zoom > 0.4){
					scene.camera.zoom = scene.camera.zoom - 0.2 
				}
				
			}	
		}
		
	}
}