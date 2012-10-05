package game.entity
{
	
	import caurina.transitions.Tweener;
	
	import flare.core.Pivot3D;
	import flare.loaders.Flare3DLoader;
	import flare.utils.Pivot3DUtils;
	
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
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
			var change:int = pivot3D.getRotation().z - BasePath.TOP_LEFT;
			rotate(change);
		}
		
		override public function showTopRight():void{
			var change:int = pivot3D.getRotation().z - BasePath.TOP_RIGHT;
			rotate(change);
		}
		
		override public function showBottomLeft():void{
			var change:int = pivot3D.getRotation().z - BasePath.BOTTOM_LEFT;
			rotate(change);
		}
		
		override public function showBottomRight():void{
			var change:int = pivot3D.getRotation().z - BasePath.BOTTOM_RIGHT;
			rotate(change);
		}
		
		override public  function showLeft():void{
			var change:int = pivot3D.getRotation().z - BasePath.LEFT;
			rotate(change);
		}
		
		override public  function showRight():void{
			var change:int = pivot3D.getRotation().z - BasePath.RIGHT;
			rotate(change);
		}
		
		override public  function showBottom():void{
			var change:int = pivot3D.getRotation().z - BasePath.BOTTOM;
			rotate(change);
		}
		
		override public  function showTop():void{
			var change:int = pivot3D.getRotation().z - BasePath.TOP;
			rotate(change);
			
		}
		
		
		public function set rotation(data:Number):void{
			var rotation:Vector3D = pivot3D.getRotation();
			pivot3D.setRotation(rotation.x,rotation.y,data);
		}
		
		public function get rotation():Number{
			var rotation:Vector3D = pivot3D.getRotation();
			return rotation.z
		}
		
		public function rotate(change:Number):void{
			//Tweener.removeTweens(this);
			var rotation:Vector3D = pivot3D.getRotation();
			if(change > 180){
				change = change - 360;
			}
			
			if(change <- 180){
				change = change + 360;
			}
			
			Tweener.addTween(this,{rotation:this.rotation-change, time:0.1, transition:"linear"});
		}
		
		public function rotateLeft():void{
			pivot3D.gotoAndPlay(TURN_LEFT,1,Pivot3D.ANIMATION_STOP_MODE);
			showRun();
			pivot3D.rotateY(-45);
		}
		
		public function rotateRight():void{
			pivot3D.gotoAndPlay(TURN_RIGHT,1,Pivot3D.ANIMATION_STOP_MODE);
			showRun();
			pivot3D.rotateY(45);
		}
		
		
		
		public function showIdle():void{
			pivot3D.gotoAndPlay( IDLE,1);
		}
		
		public function showRun():void{
			pivot3D.frameSpeed = 0.5;
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