
package 
{
	import as3isolib.core.as3isolib_internal;
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.IStroke;
	import as3isolib.graphics.Stroke;
	
	import flash.display.Graphics;
	
	use namespace as3isolib_internal;
	
	/**
	 * IsoGrid provides a display grid in the X-Y plane.
	 */
	public class Iso3DGrid 
	{
		////////////////////////////////////////////////////
		//	GRID SIZE
		////////////////////////////////////////////////////
		
		private var gSize:Array = [0, 0];
		
		/**
		 * Returns an array containing the width and length of the grid.
		 */
		public function get gridSize ():Array
		{
			return gSize;
		}
		
		/**
		 * Sets the number of grid cells in each direction respectively.
		 * 
		 * @param width The number of cells along the x-axis.
		 * @param length The number of cells along the y-axis.
		 * @param height The number of cells along the z-axis (currently not implemented).
		 */
		public function setGridSize (width:uint, length:uint, height:uint = 0):void
		{
			if (gSize[0] != width || gSize[1] != length || gSize[2] != height)
			{
				gSize = [width, length, height];
			}
		}
		
		////////////////////////////////////////////////////
		//	CELL SIZE
		////////////////////////////////////////////////////
		
		private var cSize:Number;
		
		/**
		 * @private
		 */
		public function get cellSize ():Number
		{
			return cSize;
		}
		
		/**
		 * Represents the size of each grid cell.  This value sets both the width, length and height (where applicable) to the same size.
		 */
		public function set cellSize (value:Number):void
		{
			if (value < 2)
				throw new Error("cellSize must be a positive value greater than 2");
			
			if (cSize != value)
			{
				cSize = value;
			}
		}
		
		////////////////////////////////////////////////////
		//	SHOW ORIGIN
		////////////////////////////////////////////////////
		
		private var bShowOrigin:Boolean = false;
		private var showOriginChanged:Boolean = false;
		
		
		////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoGrid (descriptor:Object = null)
		{
			super(descriptor);
			
			if (!descriptor)
			{
				cellSize = 25;
				setGridSize(5, 5);
			}
		}
		
		
		
		/**
		 * @inheritDoc
		 */
		override protected function drawGeometry ():void
		{
			var g:Graphics = mainContainer.graphics;
			g.clear();
			
			var stroke:IStroke = IStroke(strokes[0]);
			if (stroke)
				stroke.apply(g);
			
			var pt:Pt = new Pt();
			
			var i:int;
			var m:int = int(gridSize[0]);
			while (i <= m)
			{
				pt = IsoMath.isoToScreen(new Pt(cSize * i));
				g.moveTo(pt.x, pt.y);
				
				pt = IsoMath.isoToScreen(new Pt(cSize * i, cSize * gridSize[1]));
				g.lineTo(pt.x, pt.y);
				
				i++;
			}
			
			i = 0;
			m = int(gridSize[1]);
			while (i <= m)
			{
				pt = IsoMath.isoToScreen(new Pt(0, cSize * i));
				g.moveTo(pt.x, pt.y);
				
				pt = IsoMath.isoToScreen(new Pt(cSize * gridSize[0], cSize * i));
				g.lineTo(pt.x, pt.y);
				
				i++;
			}
			
			//now add the invisible layer to receive mouse events
			pt = IsoMath.isoToScreen(new Pt(0, 0));
			g.moveTo(pt.x, pt.y);
			g.lineStyle(0, 0, 0);
			g.beginFill(0xFF0000, 0.0);
			
			pt = IsoMath.isoToScreen(new Pt(cSize * gridSize[0], 0));
			g.lineTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(cSize * gridSize[0], cSize * gridSize[1]));
			g.lineTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(0, cSize * gridSize[1]));
			g.lineTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(0, 0));
			g.lineTo(pt.x, pt.y);
			g.endFill();
		}
	}
}