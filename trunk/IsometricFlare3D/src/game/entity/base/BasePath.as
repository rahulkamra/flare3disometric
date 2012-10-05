package game.entity.base
{
	
	
	import caurina.transitions.Tweener;
	
	import com.greensock.TweenLite;
	
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	
	import game.pathfinding.Node;
	import game.pathfinding.Tile;
	
	import mx.controls.Alert;
	import mx.effects.Move;
	import mx.effects.Tween;
	import mx.events.EffectEvent;
	import mx.events.TweenEvent;
	
	public class BasePath extends EventDispatcher implements IBasePath
	{
		public function BasePath(character:Character)
		{
			this.character = character;
		}
		
		public static const TOP:String="TOP";
		public static const RIGHT:String="RIGHT";
		public static const BOTTOM:String="BOTTOM";
		public static const LEFT:String="LEFT";
		
		public static const TOP_LEFT:String="TOP_LEFT";
		public static const TOP_RIGHT:String="TOP_RIGHT";
		public static const BOTTOM_LEFT:String="BOTTOM_LEFT";
		public static const BOTTOM_RIGHT:String="BOTTOM_RIGHT";
		
		
		public var character:Character;
		public var target:Character;
		public var currentDirection:String;
		/**
		 * 
		 * This functions should be implemented by any bath driver u make
		 **/
		public function nextTarget(x:Number, y:Number):Point
		{
			return null;
		}
		
		
		public function start():void
		{
			
		}
		
		public function birthStart():void{
			start();
		}
		
		public function die():void{
			character.die();
		}
		
		public var path:Array
		protected var currentTween:TweenLite;
		protected var isMoving:Boolean = false;
		private var endNode:Node
		public function move(path:Array):void{
			if(endNode){
				if(path.length > 1){
					var currentEndNode:Node = path[path.length-1];
					if(currentEndNode.x == endNode.x && currentEndNode.y == endNode.y){
						return;
					}
				}
				
			}
			endNode = path[path.length-1];
			Tweener.removeTweens(character);
			movementStart();
			//moveToPath(path);
			moveMe(path);
		} 
		
		/*protected function get speed():Number{
		return SmurfSettings.AVATAR_WALKING_SPEED
		}*/
		
		private function stepStart(cell:Node):void{
			var xpos:Number = cell.gridX
			var ypos:Number = cell.gridY
			if(cell.gridX != character.x || cell.gridY != character.y){
				var toTile:Tile = new Tile(cell.x,cell.y,true);
				changeDirection(toTile);	
			}
		}
		
		private function stepComplete(cell:Node):void{
		}
		/**
		 * 
		 * 
		 * 
		 * 
		 * 
		 * 
		 **/
		public function pathNotFound():void{
			Alert.show("PathNotFOund")
		}
		
		
		public function changeDirection(tile:Tile):void{
			var direction:String = calculateDirection(character.tile, tile);
			currentDirection = direction;
			switch(direction){
				case TOP_LEFT:
					character.showTopLeft();
					break;
				case TOP_RIGHT:
					character.showTopRight();
					break;
				case BOTTOM_LEFT:
					character.showBottomLeft();
					break;
				case BOTTOM_RIGHT:
					character.showBottomRight();
					break;
				
				case TOP:
					character.showTop();
					break;
				case RIGHT:
					character.showRight();
					break;
				case LEFT:
					character.showLeft()
					break;
				case BOTTOM:
					character.showBottom();
					break;	
			}  
		}
		
		public function calculateDirection(fromTile:Tile,toTile:Tile):String{
			var stringVertDir:String;
			var stringHorDir:String;
			var totDir:String="";
			if(fromTile.row > toTile.row){
				stringVertDir = "BOTTOM";
			}
			else if(fromTile.row < toTile.row){
				stringVertDir = "TOP";
			}
			else{
				stringVertDir = "";
			}
			if(fromTile.col > toTile.col){
				stringHorDir = "LEFT";
			}
			else if(fromTile.col < toTile.col){
				stringHorDir = "RIGHT";
			}
			else{
				stringHorDir = "";
			}
			
			if(stringVertDir!="" && stringHorDir!="")
			{
				totDir = stringVertDir+"_"+stringHorDir;
			}
			else
			{
				totDir = stringVertDir + stringHorDir;
			}
			
			if(totDir=="")
			{
				trace("Error in calculating Direction" , fromTile.row,fromTile.col)
				trace("Error in calculating Direction" , toTile.row,toTile.col)
			}
			return totDir;
			
		}
		/**
		 * 
		 * 
		 * 
		 **/
		
		
		
		
		
		protected var speed1:Number = 0;
		protected var delay:Number=0;
		protected var delayfix:Number = 0;
		protected var speedcheck:Boolean = false;
		protected var targetX:Number=0;
		protected var targetY:Number=0;
		protected var leftRightTempX:Number = 0;
		protected var leftRightTempY:Number = 0;
		//protected var speed:Number = 0.4;
		public function get diagonalTime():Number{
			return normalTime*Math.sqrt(2);
			//return normalTime;
		}
		public function get normalTime():Number{
			return 0.4
		}
		private var speed:Number = normalTime;
		
		protected function moveMe(pathArray:Array):void
		{
			if(pathArray.length == 1){
				movementEnd();
			}
			
			for (var i:int = 1; i < pathArray.length; i++)
			{
				var node:Node = pathArray[i] as Node
				targetX = node.gridX + character.gridEntityVO.regX
				targetY = node.gridY + character.gridEntityVO.regY;//for every spot on our waypoint, tween it through every point					
				speedcheck = checkTween(targetX, targetY);
				if(i == pathArray.length-1){
					moveDude(node, i,true);
				}else{
					moveDude(node, i);
				}
			}
			speed1=0;
			delay = 0;
			delayfix = 0;
			speedcheck=false;
			
		}
		private function moveToPath(path:Array):void{
			if(!path){
				pathNotFound();
				return;
			}
			
			isMoving = true;
			if(path.length == 0){
				isMoving = false;
				movementEnd();
				return;
			}
			whileMoving();
			var cell:Node = path.pop();
			var xpos:Number = cell.gridX;
			var ypos:Number = cell.gridY;
			
			if(cell.gridX != character.x || cell.gridY != character.y){
				var fromTile:Tile = new Tile(cell.x,cell.y,true);
				changeDirection(fromTile);	
			}
			currentTween = TweenLite.to(character, .25, { x:xpos, y:ypos, onComplete:moveToPath, onCompleteParams:[path] } );
		}
		
		public function moveDude(node:Node, i:int,isEnd:Boolean = false):void{
			if(i > 1){
				speed1 = speed;
			}
			if(speedcheck == true){
				speed = diagonalTime;
				if(speed1 == normalTime){
					if(i!=1){
						delay = speed1;//finds out how much delay is needed from the last instruction
					}
					Tweener.addTween(character, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear", time:speed, transition:"linear",
						onComplete:onComplete ,onCompleteParams:[node,isEnd],
						onStart:onStart,onStartParams:[node]} );//tween the dude
					delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
				} else {
					if(i!=1){
						delay = speed;//finds out how much delay is needed from the current instruction
					}
					Tweener.addTween(character, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear", time:speed, transition:"linear",
						onComplete:onComplete ,onCompleteParams:[node,isEnd],
						onStart:onStart,onStartParams:[node]} );//tween the dude
					delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
				}
			} else if(speedcheck == false) {
				speed = normalTime;
				if(speed1 == diagonalTime){
					if(i!=1){
						delay = speed1;//finds out how much delay is needed from the last instruction
					}
					Tweener.addTween(character, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear", time:speed, transition:"linear",
						onComplete:onComplete ,onCompleteParams:[node,isEnd],
						onStart:onStart,onStartParams:[node]} );//tween the dude
					delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
				} else {
					if(i!=1){
						delay = speed;//finds out how much delay is needed from the current instruction
					}
					Tweener.addTween(character, {x:targetX, y:targetY, delay:delay+delayfix , time:speed, transition:"linear", time:speed, transition:"linear",
						onComplete:onComplete ,onCompleteParams:[node,isEnd],
						onStart:onStart,onStartParams:[node]} );//tween the dude
					delayfix = delayfix+delay;//adds to the total delay time so the tweens stack on another
				}
				
			}
		}
		
		public function onStart(node:Node):void{
			if(node.gridX != character.x || node.gridY != character.y){
				var toTile:Tile = new Tile(node.x,node.y,true);
				changeDirection(toTile);	
			}
		}
		public function onComplete(node:Node,isEnd:Boolean):void{
			if(isEnd){
				movementEnd();
			}
		}
		public function checkTween(leftrightX:Number, leftrightY:Number):Boolean{
			if (leftrightX < leftRightTempX && leftrightY > leftRightTempY) {
				leftRightTempX = leftrightX;
				leftRightTempY = leftrightY;
				//trace("left");
				return true;
			}else if (leftrightX > leftRightTempX && leftrightY < leftRightTempY) {
				leftRightTempX = leftrightX;
				leftRightTempY = leftrightY;
				//trace("right");
				return true;
			} else {
				leftRightTempX = leftrightX;
				leftRightTempY = leftrightY;
				//trace("regular");
				return false;
			}
		}
		
		
		
		
		
		
		
		
		
		public  function movementEnd():void{
			
		}
		public function movementStart():void{
			
		}
		public function whileMoving():void{
			
		}
		public function stop():void
		{
			Tweener.removeTweens(character);
			speed1= 0;
			delay=0;
			delayfix = 0;
			speedcheck= false;
			targetX=0;
			targetY=0;
			leftRightTempX = 0;
			leftRightTempY= 0;
			endNode = null;
		}
		
		public function reset():void
		{
		}
		
		public function pause():void{
			
		}
		public function resume():void{
			
		}
	}
}