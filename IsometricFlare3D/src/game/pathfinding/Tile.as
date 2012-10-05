package game.pathfinding
{
	public class Tile
	{
		public function Tile(row:int,col:int,walkable:Boolean)
		{
			this.row = row;
			this.col = col;
			this.walkable = walkable
		}
		
		/* from zero to max-1*/
		public var row:int = 0
		public var col:int = 0
		public var walkable:Boolean;
	}
}