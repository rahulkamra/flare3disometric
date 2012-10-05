package  
{
	
	import flare.basic.*;
	import flare.core.*;
	import flare.loaders.Flare3DLoader;
	import flare.materials.Material3D;
	import flare.system.*;
	import flare.utils.Mesh3DUtils;
	import flare.utils.Pivot3DUtils;
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import spark.effects.animation.Animation;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Introducing Flare3D Format v2.
	 * 
	 * @author Ariel Nehmad
	 */
	public class Test30_Flare3DLoader2 extends Base 
	{
		public var scene:Scene3D;

		public var model:Pivot3D;
		private var mesh:Mesh3D;
		private var anim1:Flare3DLoader;
		private var loadingAnimation:Boolean;
		
		public function Test30_Flare3DLoader2(stage:Stage) 
		{
			super( "Introducing Flare3D Format v2." );
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			scene = new Viewer3D( this);
			scene.antialias = 2;
			
			scene.addEventListener( Scene3D.PROGRESS_EVENT, progressEvent )
			scene.addEventListener( Scene3D.COMPLETE_EVENT, completeEvent )
			//scene.setViewport( 0, 0, 1000, 1000 );
			stage.addEventListener( Event.RESIZE, resizeEvent );
			
		}
		
		
		
		public function load(url:String):void{
			if(model){
				model.parent.removeChild(model);
			}
			model = scene.addChildFromFile(url);
			scene.showLogo = false;
		}
		
		public function loadAndPlay(url:String):void{
			loadingAnimation = true;
			anim1 = new Flare3DLoader( url );
			scene.library.push( anim1 as Flare3DLoader );
		}
		
		private function resizeEvent(e:Event):void 
		{
		}
		
		private function progressEvent(e:Event):void 
		{
			trace( scene.loadProgress );
		}
		
		private function completeEvent(e:Event):void 
		{
			if(loadingAnimation){
				Pivot3DUtils.appendAnimation( model, anim1, "anim1" );
				//model.play(1);
				model.addEventListener(Pivot3D.ANIMATION_COMPLETE_EVENT,animationComplete);
				model.gotoAndPlay( "anim1" );
			}
			loadingAnimation = false;
		}
		
		protected function animationComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			trace("Complete");
		}
	}
}

