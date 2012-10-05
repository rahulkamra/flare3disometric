package game.entity.base
{
	import flash.geom.Point;

	public interface IBasePath
	{
		 function nextTarget(x:Number , y:Number):Point;
		 function start():void;
		 function stop():void;
		 function reset():void;
		 
		 	
	}
}