package game.entity
{
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	
	import flash.geom.Vector3D;
	
	import game.IsometricController;
	import game.IsometricGame;
	import game.model.GridEntityVO;
	
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
			
			pivot3D.setScale(gridEntityVO.scale,gridEntityVO.scale,gridEntityVO.scale); 
			pivot3D.play();
			
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
		
		public function setRowPositionByGrid(row:int,col:int):void{
			if(pivot3D){
				var plane:Vector3D = IsometricController.gridToPlane(row,col);
				setVector(plane);
			}
		}
	}
}