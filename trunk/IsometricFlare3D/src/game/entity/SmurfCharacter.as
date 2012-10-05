package game.entity
{
	
	import flare.loaders.Flare3DLoader;
	import flare.utils.Pivot3DUtils;
	
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	import game.IsometricGame;
	import game.entity.base.AvatarPath;
	import game.entity.base.BasePath;
	import game.entity.base.Character;
	import game.model.GridEntityVO;
	import game.pathfinding.Tile;
	import game.settings.GridEntityMapping;
	
	public class SmurfCharacter extends Character 
	{
		
		public static const IDLE:String = "idle";
		public static const RUN:String = "run";
		public static const TURN_LEFT:String = "turn_left";
		public static const TURN_RIGHT:String = "turn_right";
		
		public function SmurfCharacter(gridEntityVO:GridEntityVO)
		{
			pathDriver = new AvatarPath(this);
			super(gridEntityVO);
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
			var change:int = BasePath.TOP_LEFT - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public function showTopRight():void{
			var change:int = BasePath.TOP_RIGHT - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public function showBottomLeft():void{
			var change:int = BasePath.BOTTOM_LEFT - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public function showBottomRight():void{
			trace("showBottomRight")
			var change:int = BasePath.BOTTOM_RIGHT - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public  function showLeft():void{
			var change:int = BasePath.LEFT - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public  function showRight():void{
			var change:int = BasePath.RIGHT - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public  function showBottom():void{
			var change:int = BasePath.BOTTOM - pathDriver.currentDirection;
			rotate(change);
		}
		
		override public  function showTop():void{
			var change:int = BasePath.TOP - pathDriver.currentDirection;
			rotate(change);
			
		}
		
		public function rotate(change:int):void{
			var times:int = change/45;
			for(var count:int = 0 ;count < Math.abs(times) ; count++){
				if(times < 0){
					rotateLeft();
				}else{
					rotateRight();
				}
			}
		}
		
		public function rotateLeft():void{
			pivot3D.gotoAndPlay(TURN_LEFT);
			showRun();
			pivot3D.rotateY(-45);
		}
		
		public function rotateRight():void{
			pivot3D.gotoAndPlay(TURN_RIGHT,0);
			showRun();
			pivot3D.rotateY(45);
		}
		
		
		
		public function showIdle():void{
			pivot3D.gotoAndPlay( IDLE);
		}
		
		public function showRun():void{
			pivot3D.gotoAndPlay(RUN);
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