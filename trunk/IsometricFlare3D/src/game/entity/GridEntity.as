package game.entity
{
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import game.IsometricController;
	import game.IsometricGame;
	import game.model.GridEntityVO;
	import game.pathfinding.Tile;
	import game.settings.GridEntityMapping;
	
	public class GridEntity 
	{
		public var pivot3D:Pivot3D
		public var gridEntityVO:GridEntityVO
		public var scale:Boolean = true;
		
		
		public function GridEntity(gridEntityVO:GridEntityVO)
		{
			this.gridEntityVO = gridEntityVO;
			pivot3D = IsometricGame.scene.addChildFromFile(gridEntityVO.url) as Pivot3D;
			pivot3D.setRotation(-90,0,0);
			pivot3D.rotateY(gridEntityVO.rotation);
			pivot3D.setScale(gridEntityVO.scale,gridEntityVO.scale,gridEntityVO.scale); 
			
			
			if(gridEntityVO.url == GridEntityMapping.TREE_1.url || gridEntityVO.url == GridEntityMapping.TREE_2.url || gridEntityVO.url == GridEntityMapping.TREE_3.url || gridEntityVO.url == GridEntityMapping.TREE_4.url){
				pivot3D.stop();
				pivot3D.setLayer(10);
			}else{
				pivot3D.play();
			}
		}
		
		
		
		public function setVector(vector3D:Vector3D):void{
			pivot3D.setPosition(vector3D.x+gridEntityVO.regX,vector3D.y+gridEntityVO.regY,vector3D.z);
		}
		
		public function getGridX():int{
			return pivot3D.x-gridEntityVO.regX
		}
		
		public function getGridY():int{
			return pivot3D.y-gridEntityVO.regY
		}
		
		public function get tile():Tile{
			var tile:Tile = new Tile(row,col,walkable);
			return tile;
		}
		public function get row():Number{
			if(pivot3D){
				var vector3D:Vector3D = new Vector3D(getGridX(),getGridY(),pivot3D.z)
				return IsometricController.planeToGrid(vector3D)[0];
			}
			return 0 ;
		}
		
		public function get col():Number{
			if(pivot3D){
				var vector3D:Vector3D = new Vector3D(getGridX(),getGridY(),pivot3D.z)
				return IsometricController.planeToGrid(vector3D)[1];
			}
			return 0 ;
		}
		
		public function setPositionByGrid(row:int,col:int):void{
			if(pivot3D){
				var plane:Vector3D = IsometricController.gridToPlane(row,col);
				setVector(plane);
			}
		}
		
		public function get walkable():Boolean{
			return false;
		}
		
		public function get tileWeightage():int{
			return 10;
		}
		
		
		public function get y():Number
		{
			return pivot3D.y
		}
		
		public function set y(value:Number):void
		{
			pivot3D.setPosition(pivot3D.x,value,pivot3D.z);
		}
		
		public function get x():Number
		{
			return pivot3D.x
		}
		
		public function set x(value:Number):void
		{
			pivot3D.setPosition(value,pivot3D.y,pivot3D.z);
		}
	}
}