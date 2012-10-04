package game
{
	import com.electron.engine.debug.log;
	import com.electron.engine.debug.log2DArray;
	import com.electron.engine.util.Utils;
	
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.collisions.CollisionInfo;
	import flare.collisions.RayCollision;
	import flare.core.Camera3D;
	import flare.core.Lines3D;
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
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
	
	import game.entity.GridEntity;
	
	public class IsometricGame extends Sprite
	{
		
		public static var scene:Scene3D;
		private static var _stage:Stage
		
		public static var plane:Plane;
		
		
		private static var bitmap:Bitmap;
		
		public static var wrapperPlane:Plane;
		
		private var debugPlane:Plane;
		
		public static var cellSize:int = 16;;
		public static var rows:int;
		public static var cols:int;
		
		private static var gridArray:Array;

		public static var isometricGrid:IsometricGrid;
		
		
		
		public function IsometricGame(stage:Stage)
		{
			_stage  = stage;
			scene = new Scene3D(this);
			
			IsometricController.init(scene);
			
			scene.camera.zoom = 0.4;
			
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
			
			isometricGrid = new IsometricGrid();
			wrapperPlane.addChild(isometricGrid);
			
			cols = bitmap.width/cellSize;
			rows= bitmap.height/cellSize;
			isometricGrid.init(rows,cols,cellSize);
			isometricGrid.z = plane.z-1;
			
			initGrid();
			
				
				
		}
		
		private function initGrid():void
		{
			// TODO Auto Generated method stub
			gridArray = Utils.Instance.create2DArray(rows,cols,0);
		}		
		
		public static function addObject(gridEntity:GridEntity,populateValue:Boolean = false):void
		{
			// TODO Auto Generated method stub
			var object3D:Pivot3D = gridEntity.pivot3D;
			
			var ray:RayCollision = new RayCollision();
			ray.addCollisionWith(wrapperPlane,false);
			var from:Vector3D = object3D.localToGlobal( new Vector3D( 0, 100, 0 ) );
			var dir:Vector3D = object3D.getDown();
			if ( ray.test( from, dir ) )
			{
				// Get the info of the first collision.
				var info:CollisionInfo = ray.data[0];
				
				// Set the astronaut container at the collision point.
				object3D.setPosition( info.point.x, info.point.y, info.point.z );
				
				// Align the astronaut container to the collision normal.
				object3D.setNormalOrientation( info.normal, 0.05 );
			}
			//object3D.setPosition(object3D.x,object3D.y,object3D.z+1); 
			plane.addChild(object3D);
			
			if(populateValue){
				
				for(var row:int = 0 ; row < gridEntity.gridEntityVO.rows ; row++){
					for(var col:int = 0 ; col < gridEntity.gridEntityVO.cols ; col++){
						gridArray[gridEntity.row+row][gridEntity.col+col] = 1
					}
				}
			}
			
			_log2DArray(gridArray);
		}
		
		public static function canPlace(gridEntity:GridEntity):Boolean{
			
			for(var row:int = 0 ; row < gridEntity.gridEntityVO.rows ; row++){
				for(var col:int = 0 ; col < gridEntity.gridEntityVO.cols ; col++){
					if(gridArray[gridEntity.row+row][gridEntity.col+col] == 1){
						return false;
					}
				}
			}
			return true;
		}
		
	}
}