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
	import flare.loaders.Flare3DLoader;
	import flare.materials.Shader3D;
	import flare.materials.filters.TextureFilter;
	import flare.primitives.Plane;
	import flare.primitives.SkyBox;
	import flare.utils.Vector3DUtils;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	import game.controller.AnimationLoader;
	import game.entity.GridEntity;
	import game.entity.SmurfCharacter;
	import game.pathfinding.Grid;
	import game.pathfinding.Node;
	import game.pathfinding.Tile;
	import game.settings.GridEntityMapping;
	
	public class IsometricGame extends Sprite
	{
		
		public static var scene:Scene3D;
		private static var _stage:Stage
		
		public static var plane:Plane;
		
		
		private static var bitmap:Bitmap;
		
		public static var wrapperPlane:Plane;
		
		public static var debugPlane:Plane;
		
		public static var cellSize:int = 16;
		public static var rows:int;
		public static var cols:int;
		
		public static var gridArray:Array;
		public static var aStartGrid:Grid;
		
		public static var char:SmurfCharacter;
		
		public static var isometricGrid:IsometricGrid;
		
		
		
		public function IsometricGame(stage:Stage)
		{
			_stage  = stage;
			scene = new Scene3D(this);
			scene.setLayerSortMode( 10, Scene3D.SORT_BACK_TO_FRONT );
			IsometricController.init(scene);
			initWorld();
			AnimationLoader.Instance.loadAnimations(scene);
		}
		
		
		protected function completeEvent(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("Loaded" , event.target);
		}
		
		private function initWorld():void
		{
			// TODO Auto Generated method stub
			wrapperPlane = new Plane();
			scene.addChild(wrapperPlane);			
			addMap();
			addGrid();
			addChar();
			
			addSkybox();
			CameraInteraction.init(_stage,scene,plane);
			initSettings();
		}		
		
		private function initSettings():void
		{
			// TODO Auto Generated method stub
			CameraInteraction.cameraX = 163 
			CameraInteraction.cameraY = 172;
			
			scene.camera.fieldOfView = CameraInteraction.level2FieldView
				
		}
		
		private function addSkybox():void
		{
			var skybox:SkyBox = new SkyBox("assets/skybox",SkyBox.FOLDER_JPG,scene,0.05);
			skybox.setRotation(-135,0,-45);
			scene.addChild(skybox,false);
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
		
		private function addChar():void
		{
			// TODO Auto Generated method stub
			char = new SmurfCharacter(GridEntityMapping.MALE_CHAR);
			char.setPositionByGrid(rows/2,cols/2);
			addObject(char);
		}
		
		public static function addTrees():void
		{
			var count:int = 0 ;
			for(var row:int = 0 ; row < rows ; row ++){
				for(var col:int = 0 ; col < cols; col ++){
					if(row < rows/4 || row > rows/4*3){
						addTree(row,col);
						count++;
					}else{
						if(col < cols/4 || col > cols/4*3){
							addTree(row,col);
							count++;
						}
					}
				}
			}
			
			trace(count);
			
		}
		
		private static function addTree(row:int,col:int):void{
			var gridEntity:GridEntity
			if(Utils.Instance.canDo(1)){
				var index:int = Utils.Instance.getRandomIntegerBetween(1,4);
				switch(index){
					case 1:{
						gridEntity  = new GridEntity(GridEntityMapping.TREE_1);
						break;
					}
					case 2:{
						gridEntity   = new GridEntity(GridEntityMapping.TREE_2);
						break;
					}
					case 3:{
						gridEntity   = new GridEntity(GridEntityMapping.TREE_3);
						break;
					}
					case 4:{
						gridEntity  = new GridEntity(GridEntityMapping.TREE_4);
						break;
					}
				}
				
				gridEntity.setPositionByGrid(row,col);
				IsometricGame.addObject(gridEntity,true);
			}
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
			createPathFindingGrid();
		}
		
		private function initGrid():void
		{
			// TODO Auto Generated method stub
			gridArray = Utils.Instance.create2DArray(rows,cols,0);
		}
		
		public function createPathFindingGrid():void{
			aStartGrid = new Grid(cols,rows);
			//add unwalkable areas'
		}
		
		public static function getNodeAt(row:int,col:int):Node{
			return aStartGrid.getNode(row,col)
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
				fillPathfindingGrid(gridEntity,gridEntity.tile);
				for(var row:int = 0 ; row < gridEntity.gridEntityVO.rows ; row++){
					for(var col:int = 0 ; col < gridEntity.gridEntityVO.cols ; col++){
						gridArray[gridEntity.row+row][gridEntity.col+col] = 1
					}
				}
			}
		}
		
		public static function canPlace(gridEntity:GridEntity):Boolean{
			try{
				for(var row:int = 0 ; row < gridEntity.gridEntityVO.rows ; row++){
					for(var col:int = 0 ; col < gridEntity.gridEntityVO.cols ; col++){
						if(gridArray[gridEntity.row+row][gridEntity.col+col] == 1){
							return false;
						}
					}
				}
				return true;
			}catch(e:Error){
				return false;
			}
			return false
		}
		
		
		
		public static function fillPathfindingGrid(gridEntity:GridEntity,tile:Tile):void{
			for(var count:int =0 ; count < gridEntity.gridEntityVO.rows ;count++){
				for(var innterCount:int = 0 ; innterCount < gridEntity.gridEntityVO.cols ;innterCount++){
					var node:Node = getNodeAt(tile.row+count,tile.col+innterCount);
					node.walkable = gridEntity.walkable;
					node.costMultiplier = gridEntity.tileWeightage;
				}	
			}
		}
		
		public function getNodeAt(row:int,col:int):Node{
			return aStartGrid.getNode(row,col)
		}
		
		
	}
}