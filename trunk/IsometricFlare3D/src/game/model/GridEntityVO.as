package game.model
{
	public class GridEntityVO
	{
		public function GridEntityVO(url:String,regX:int,regY:int,scale:Number,rows:int,cols:int)
		{
			this.url = url;
			this.regX = regX;
			this.regY = regY;
			this.scale = scale;
			
			this.rows = rows;
			this.cols = cols;
				
		}
		
		public var url:String = "";
		public var regX:int = 0;
		public var regY:int = 0;
		public var scale:Number = 0;
		public var rows:int = 0;
		public var cols:int = 0;
		
		
	}
}