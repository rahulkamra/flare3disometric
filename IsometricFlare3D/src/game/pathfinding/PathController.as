package game.pathfinding
{
	
	import flash.geom.Point;
	
	import game.IsometricController;
	import game.IsometricGame;
	import game.entity.GridEntity;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.utils.ObjectUtil;
	
	public class PathController
	{
		public function PathController()
		{
		}
		
		/* return array collection of Tiles*/
		private static function getNeighboursBasedOnRowsAndCols(startRow:int,startCol:int,numberOfRows:int,numberOfCols:int, isWalkable:Boolean):ArrayCollection{
			var acToReturn:ArrayCollection = new ArrayCollection();
			
			for(var count:int = startRow-1 ; count < startRow+numberOfRows+1 ; count++){
				for(var innercount:int = startCol-1 ; innercount < startCol+numberOfCols+1 ; innercount++){
					
					if((count >= startRow && count < startRow+numberOfRows) && (innercount >= startCol && innercount < startCol+numberOfCols)){
						continue;	
					}
					if(count<0 || innercount<0)continue;
					if(count>IsometricGame.rows-1 || innercount > IsometricGame.cols-1)continue;
					if(isWalkable){
						if(!IsometricGame.getNodeAt(count,innercount).walkable){
							continue;
						}
					}
					
					acToReturn.addItem(new Tile(count,innercount,true));
				}
			}
			
			var initAc:Array = acToReturn.toArray().slice(0,2*numberOfRows+2);
			var leftOver:Array = acToReturn.toArray().slice(2*numberOfRows+2,acToReturn.length);
			var newArray:Array = leftOver.concat(initAc.reverse());
			
			return new ArrayCollection(newArray);
		}
		
		public static function allTilesAroundTile(row:int,col:int,distance:int, isWalkable:Boolean):ArrayCollection{
			var acToReturn:ArrayCollection = new ArrayCollection();
			for(var count:int = row-distance ; count < row+distance+1 ; count++){
				for(var innercount:int = col-distance ; innercount < col+distance+1 ; innercount++){
					if(count == row && innercount == col){
						continue
					}
					if(count<0 || innercount<0)continue;
					if(count>IsometricGame.rows-1 || innercount > IsometricGame.cols-1)continue;
					if(isWalkable){
						if(!IsometricGame.getNodeAt(count,innercount).walkable){
							continue;
						}
					}
					acToReturn.addItem(new Tile(count,innercount,true));
				}
			}
			return acToReturn;
		}
		
		public static function sortTiles(centerTile:Tile , tiles:ArrayCollection):void
		{
			for(var outCounter:int=1;outCounter<tiles.length;outCounter++) {
				for(var innerCounter:int=0;innerCounter<tiles.length-outCounter;innerCounter++){
					var item_one:Tile=tiles[innerCounter] as Tile;
					var item_two:Tile=tiles[innerCounter+1] as Tile;
					if(Math.abs(item_one.col - centerTile.col) > Math.abs(item_two.col - centerTile.col)) {
						tiles.setItemAt(item_one,innerCounter+1);
						tiles.setItemAt(item_two,innerCounter);
					}
				}
			}
		}
		
		
		
		

		
		
		
		public static function getNeighbours(gridEntity:GridEntity, isWalkable:Boolean):ArrayCollection{
			var startRow:int = gridEntity.tile.row;
			var startCol:int = gridEntity.tile.col;
			
			var numberOfRows:int  = gridEntity.gridEntityVO.rows;
			var numberOfCols:int  = gridEntity.gridEntityVO.cols;
			
			return getNeighboursBasedOnRowsAndCols(startRow,startCol,numberOfRows,numberOfCols,isWalkable);
		}
		
		public static function getNeighboursByTile(tile:Tile, isWalkable:Boolean):ArrayCollection{
			var startRow:int = tile.row;
			var startCol:int = tile.col;
			
			var numberOfRows:int  = 1;
			var numberOfCols:int  = 1;
			
			return getNeighboursBasedOnRowsAndCols(startRow,startCol,numberOfRows,numberOfCols,isWalkable);
		}
		
		public static function findPathToGridEntity(fromTile:Tile , toGridEntity:GridEntity):Array{
			var neighbours:ArrayCollection = getNeighbours(toGridEntity,true);
			return findShortestPath(fromTile,neighbours);
		}
		
		private static function findShortestPath(fromTile:Tile,tiles:ArrayCollection):Array{
			var pathsArray:Array = new Array();
			for(var count:int = 0 ; count < tiles.length ; count++){
				var eachTile:Tile = tiles.getItemAt(count) as Tile;
				var eachNode:Node = IsometricGame.getNodeAt(eachTile.row,eachTile.col);
				if(eachNode.walkable == false){
					continue;
				}
				
				var eachPath:Array = getPath(fromTile,eachTile);
				if(eachPath.length !=0){
					return eachPath;
				}
			}
			return [];
			
		}
		
		public static function findPathToTile(fromTile:Tile , toTile:Tile):Array{
			var node:Node = IsometricGame.getNodeAt(toTile.row,toTile.col);
			if(node.walkable){
				return getPath(fromTile,toTile);
			}else{
				return [];
			}
		}
		
		public static function getPath(fromTile:Tile,toTile:Tile):Array{
			var path:Array = getPathWithGrid(fromTile,toTile,IsometricGame.aStartGrid);
			return path;
		}
		
		public static function getPathWithGrid(fromTile:Tile,toTile:Tile,grid:Grid):Array{
			//return [new Node(fromTile.row,fromTile.col),
			//new Node(toTile.row,toTile.col)]
			var aStar:AStar = new AStar;
			grid.setStartNode(fromTile.row,fromTile.col);
			grid.setEndNode(toTile.row,toTile.col);
			if(aStar.findPath(grid)){
				return aStar.path;
			}else{
				return []
			}
		}
		
		
		
	}
}