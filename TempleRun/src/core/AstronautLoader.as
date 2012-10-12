package core
{
	import com.electron.engine.core.SingletonManager;
	
	import constants.GameConstants;
	
	import flare.basic.Scene3D;
	import flare.core.Pivot3D;
	import flare.loaders.Flare3DLoader1;
	
	import flash.events.Event;
	
	public class AstronautLoader
	{
		public function AstronautLoader()
		{
		}
		
		
		private var scene:Scene3D;
		private var pivot3D:Pivot3D;
		
		public static function get Instance():AstronautLoader{
			return SingletonManager.getInstance(AstronautLoader) as AstronautLoader
		}
		
		public function loadAnimations(scene:Scene3D):void{
			Flare3DLoader1;
			this.scene = scene;
			scene.addEventListener( Scene3D.COMPLETE_EVENT, animationComplete );
			pivot3D = Main.scene.addChildFromFile(GameConstants.ASTRONAUT) as Pivot3D;
			
		}
		
		private var animationLoaded:Boolean = false;
		
		protected function animationComplete(event:Event):void
		{	
			scene.removeEventListener( Scene3D.COMPLETE_EVENT, animationComplete );
			Main.char = new Character();
			Main.char.addChild(pivot3D);
			Main.char.char3D = pivot3D;
			Main.addObject(Main.char);
		}
	}
}