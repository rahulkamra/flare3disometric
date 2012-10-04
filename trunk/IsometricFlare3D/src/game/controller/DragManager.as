package game.controller
{
	import com.electron.engine.debug.log;
	
	import flare.events.MouseEvent3D;
	
	import flash.geom.Vector3D;
	
	import game.IsometricController;
	import game.IsometricGame;
	import game.entity.GridEntity;

	public class DragManager
	{
		public function DragManager()
		{
		}
		
		private static var _onMouse:GridEntity;
		public static function addDrag(gridEntity:GridEntity):void{
			DragManager._onMouse = gridEntity;
			IsometricGame.plane.addEventListener(MouseEvent3D.MOUSE_DOWN,_mouseDown);
			IsometricGame.plane.addEventListener(MouseEvent3D.MOUSE_MOVE,_mouseMove);
		}
		
		protected static function _mouseMove(event:MouseEvent3D):void
		{
			var localPoint:Vector3D = IsometricGame.plane.globalToLocal(event.info.point);
			var gridPoint:Array = IsometricController.planeToGrid(localPoint);
			var planeCoordinates:Vector3D = IsometricController.gridToPlane(gridPoint[0],gridPoint[1]);
			_onMouse.setVector(planeCoordinates);	
			
			
		}
		
		protected static function _mouseDown(event:MouseEvent3D):void
		{
			if(IsometricGame.canPlace(_onMouse)){
				IsometricGame.plane.removeEventListener(MouseEvent3D.MOUSE_DOWN,_mouseDown);
				IsometricGame.plane.removeEventListener(MouseEvent3D.MOUSE_MOVE,_mouseMove);
				IsometricGame.addObject(_onMouse,true);
				_onMouse = null;
			}
			
		}
	}
}