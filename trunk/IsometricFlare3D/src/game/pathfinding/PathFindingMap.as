package game.pathfinding
{
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.graphics.SolidColorFill;
	
	import com.ubisoft.smurfs.game.constants.SmurfConstants;
	import com.ubisoft.smurfs.game.controller.IsometricController;
	import com.ubisoft.smurfs.game.settings.SmurfSettings;
	
	public class PathFindingMap
	{
		public function PathFindingMap()
		{
		}
		
		public static function generate():void{
			IsometricController.Instance.scene.removeAllChildren();
			var color:uint = 0xff0000
			for(var count:int =0 ; count < IsometricController.Instance.mapVO.gridRows ; count ++){
				for(var innerCount:int =0 ; innerCount < IsometricController.Instance.mapVO.gridCols ; innerCount ++){
					var node:Node = IsometricController.Instance.getNodeAt(count,innerCount);
					var box:IsoBox = new IsoBox;
					box.fills = [
						new SolidColorFill(color, 0.2),
						new SolidColorFill(color, 0.2),
						new SolidColorFill(color, 0.2),
						new SolidColorFill(color, 0.2),
						new SolidColorFill(color, 0.2),
						new SolidColorFill(color, 0.2)];
					
					box.width = SmurfSettings.CELL_SIZE*1;
					box.length = SmurfSettings.CELL_SIZE*1;
					box.height =1;
					box.x = count*SmurfSettings.CELL_SIZE;
					box.y = innerCount*SmurfSettings.CELL_SIZE;
					if(node.walkable == false){
						IsometricController.Instance.scene.addChild(box);
					}
				}
			}
		}
	}
}