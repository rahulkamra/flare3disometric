package game.entity
{
	
	import flare.loaders.Flare3DLoader;
	import flare.utils.Pivot3DUtils;
	
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	
	import game.IsometricGame;
	import game.entity.base.AvatarPath;
	import game.entity.base.Character;
	import game.model.GridEntityVO;
	import game.pathfinding.Tile;
	import game.settings.GridEntityMapping;
	
	public class SmurfCharacter extends Character 
	{
		
		public static const IDLE:String = "idle";
		public function SmurfCharacter(gridEntityVO:GridEntityVO)
		{
			pathDriver = new AvatarPath(this);
			super(gridEntityVO);
			preloadAllAnimations()
		}
		
		private function preloadAllAnimations():void
		{
			var idleAnimation:String = GridEntityMapping.MALE_IDLE;
			
			var idle:Flare3DLoader = new Flare3DLoader( idleAnimation);
			IsometricGame.scene.library.push(idle);
			Pivot3DUtils.appendAnimation( pivot3D, idle, "idle" );
			
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
			trace("showTopLeft");
		}
		
		override public function showTopRight():void{
			trace("showTopRight");
		}
		
		override public function showBottomLeft():void{
			trace("showBottomLeft");
		}
		
		override public function showBottomRight():void{
			trace("showBottomRight");
		}
		
		
		public function showIdle():void{
			pivot3D.gotoAndPlay( IDLE);
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