package game.entity
{
	
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	import game.entity.base.AvatarPath;
	import game.entity.base.Character;
	import game.model.GridEntityVO;
	import game.pathfinding.Tile;
	
	public class SmurfCharacter extends Character 
	{
		public function SmurfCharacter(gridEntityVO:GridEntityVO)
		{
			preloadAllAnimations()
			pathDriver = new AvatarPath(this);
			super(gridEntityVO);
			
		}
		
		private function preloadAllAnimations():void
		{
			
		}		
		
		
		public function turnToTile(tile:Tile):void{
			pathDriver.currentDirection = pathDriver.calculateDirection(this.tile,tile);
			/*if(tile.row > this.tile.row){
				pathDriver.currentDirection = BasePath.BOTTOM_RIGHT;
			}else if(tile.row < this.tile.row){
				pathDriver.currentDirection = BasePath.TOP_LEFT;
			}else if(tile.col > this.tile.col){
				pathDriver.currentDirection = BasePath.BOTTOM_LEFT;
			}else if(tile.col < this.tile.col){
				pathDriver.currentDirection = BasePath.TOP_RIGHT;
			}*/
		}
		
		/**
		 * 
		 * 
		 * Movement Controls
		 * 
		 **/
		override public  function showTopLeft():void{
		}
		
		override public function showTopRight():void{
		}
		
		override public function showBottomLeft():void{
		}
		
		override public function showBottomRight():void{
		}
		
		
		
		
		
		protected function mouseMove(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
		}
		
		public function sRollOver(event:MouseEvent):Boolean{
			return true;
		}
		
		public function sRollOut(event:MouseEvent):Boolean{
			return true;
		}
		/**
		 * 
		 * 
		 **/
		
		
	}
}