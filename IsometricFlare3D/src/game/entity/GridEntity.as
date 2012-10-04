package game.entity
{
	import flare.core.Mesh3D;
	import flare.core.Pivot3D;
	
	import game.IsometricGame;
	import game.model.GridEntityVO;

	public class GridEntity 
	{
		public var mesh3D:Pivot3D
		public function GridEntity(gridEntityVO:GridEntityVO)
		{
			
			mesh3D = IsometricGame.scene.addChildFromFile(gridEntityVO.url) as Pivot3D;
			mesh3D.setRotation(-90,0,0);
			
			mesh3D.scaleX = mesh3D.scaleX*gridEntityVO.scale 
			mesh3D.scaleY = mesh3D.scaleY*gridEntityVO.scale
			mesh3D.scaleZ = mesh3D.scaleZ*gridEntityVO.scale 
			mesh3D.x = gridEntityVO.regX;
			mesh3D.y = gridEntityVO.regY;
			
		}
	}
}