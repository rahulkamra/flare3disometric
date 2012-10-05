package game.entity.base
{
	
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	
	import game.IsometricController;
	import game.entity.GridEntity;
	import game.model.GridEntityVO;
	import game.pathfinding.Node;
	import game.pathfinding.PathController;
	import game.pathfinding.Tile;
	
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.flash.UIMovieClip;
	
	public class Character extends GridEntity
	{
		public function Character(gridEntityVO:GridEntityVO)
		{
			super(gridEntityVO);
		}
		
		
		
		override public function get walkable():Boolean{
			return true;
		}
		public var speed:Number; // no of pixels moveObjn in 1 sec
		
		public var pathDriver:BasePath;
		
		private var _type:String;
		
		public function get type():String{
			return _type;
		}
		/**
		 * These function must be overridden by all the monster who extend this
		 * 
		 * birth - > when a monster is born this function is called
		 * start ->when a mosnter walk this function is called
		 * die - > when a monster is killed this function is called
		 * 
		 * Rest of the function are direction based functions
		 * 
		 **/
		public function birth():void{
			
		}
		
		public function start():void{
			
		}
		
		public  function die():void{
			
		}	
		
		
		public  function showLeft():void{
			
		}
		
		public  function showRight():void{
			
		}
		
		public  function showBottom():void{
			
		}
		
		public  function showTop():void{
			
		}
		
		public  function showTopLeft():void{
			
		}
		
		public  function showTopRight():void{
			
		}
		
		public  function showBottomLeft():void{
			
		}
		
		public  function showBottomRight():void{
			
		}
		
		
		public function moveToATile(tile:Tile):Boolean{
			var path:Array = PathController.findPathToTile(this.tile,tile);
			
			
			if(path.length == 0){
				return false
			}else{
				pathDriver.move(path);
				return true;				
			}
			return false;
		}
		public function moveToAGridEntity(gridEntity:GridEntity):Boolean{
			var path:Array = PathController.findPathToGridEntity(this.tile,gridEntity);
			if(path.length == 0){
				return false
			}else{
				pathDriver.move(path);
				return true;				
			}
			return false;
		}
		
		/**
		 * This function stop the monster instantly 
		 **/
		
		public function stop():void{
			this.pathDriver.stop()
		}
		
		/**
		 * This function change the path of the monster
		 **/
		public function changePath(path:BasePath):void{
			this.pathDriver = path;
			path.character = this;
			
		}
		
		
		/**
		 * 
		 * This functon move the character from one position to another
		 * 
		 * 
		 **/
		
		
		
	}
}

