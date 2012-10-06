package game
{
	import flare.core.Lines3D;
	import flare.primitives.Plane;
	
	import flash.geom.Vector3D;

	public class IsometricGrid extends Plane
	{
		private var debugPlane:Plane;
		public function IsometricGrid()
		{
		}
		
		
		private var rows:int = 0;
		private var cols:int = 0;
		private var cellSize:int = 0;
		
		public function init(rows:int,cols:int , cellSize:int):void{
			this.rows = rows;
			this.cols = cols;
			this.cellSize = cellSize;
			make2DGrid();
			visible = false;
			mouseEnabled = false;
		}
		
		private function make2DGrid():void{
			var startX:int = 0;
			var startY:int = 0;
			
			for(var row:int  = 0 ;row<= rows ; row++ ){
				createLine(0,row*cellSize,rows*cellSize,row*cellSize)
			}
			
			for(var col:int  = 0 ;col<= cols ; col++ ){
				createLine(col*cellSize,0,col*cellSize,cols*cellSize);				
			}
			
			
		}
		
		private function createLine(xFrom:int , yFrom:int , xTo:int , yTo:int):void{
			var line:Lines3D = new Lines3D();
			line.lineStyle(1,0xcccccc,0.1);
			var point:Vector3D = getDown(false);
			
			var startPointX:int = point.x
			var startPointY:int = point.y
			
			line.moveTo(startPointX+xFrom,startPointY+yFrom,point.z);
			line.lineTo(startPointX+xTo,startPointY+yTo,point.z);
			
			addChild(line);
		}
		
		
/*		public function getGridData(vector3D:Vector3D):Array{
			return[Math.floor(vector3D.x/cellSize),Math.floor(vector3D.y/cellSize)];
		}
*/	}
}