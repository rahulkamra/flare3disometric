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
		private var gridEntityVO:GridEntityVO
		public var scale:Boolean = true;
		
		
		public function GridEntity(gridEntityVO:GridEntityVO)
		{
			this.gridEntityVO = gridEntityVO;
			pivot3D = IsometricGame.scene.addChildFromFile(gridEntityVO.url) as Pivot3D;
			pivot3D.setRotation(-90,0,0);
			
			pivot3D.setScale(gridEntityVO.scale,gridEntityVO.scale,gridEntityVO.scale); 
				
			pivot3D.x =  gridEntityVO.regX;
			pivot3D.y =  gridEntityVO.regY;
			
			pivot3D.stop()
			
		}
		
		public function setVector(vector3D:Vector3D):void{
			pivot3D.setPosition(vector3D.x,vector3D.y,vector3D.z);
			pivot3D.x =  pivot3D.x + gridEntityVO.regX;
			pivot3D.y =  pivot3D.y  + gridEntityVO.regY;
		}
		
		public function get row():Number{
			if(pivot3D){
				IsometricController.planeToGrid(pivot3D.getPosition())[0];
			}
			return 0 ;
		}
		
		public function get col():Number{
			if(pivot3D){
				IsometricController.planeToGrid(pivot3D.getPosition())[1];
			}
			return 0 ;
		}
	}
}