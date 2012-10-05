package game.pathfinding
{
	import game.IsometricController;
	import game.IsometricGame;
	import game.IsometricGrid;

	/**
	 * Represents a specific node evaluated as part of a pathfinding algorithm.
	 */
	public class Node
	{
		public var x:int;
		public var y:int;
		public var f:Number;
		public var g:Number;
		public var h:Number;
		public var parent:Node;
		public var costMultiplier:Number = 1.0;
		
		public function get gridX():Number{
			return IsometricController.gridToPlane(x,y).x;//  x*IsometricGame.cellSize;
		}
		public function get gridY():Number{
			return IsometricController.gridToPlane(x,y).y;
		}
		
		
		public var walkable:Boolean = true;
		
		public function Node(x:int, y:int)
		{
			this.x = x;
			this.y = y;
		}
	}
}