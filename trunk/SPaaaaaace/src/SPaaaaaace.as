package
{
	import flare.basic.Scene3D;
	import flare.basic.Viewer3D;
	import flare.core.Camera3D;
	import flare.core.Light3D;
	import flare.core.Pivot3D;
	import flare.loaders.Flare3DLoader1;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	import flare.primitives.SkyBox;
	import flare.primitives.Sphere;
	import flare.system.Input3D;
	import flare.utils.Pivot3DUtils;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	
	public class SPaaaaaace extends Sprite
	{

		private var scene:Scene3D;

		private var light0:Light3D;

		private var spcship:Pivot3D;

		private var spcMoveTimer:Timer;
		public function SPaaaaaace()
		{
			// stage configuration.
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			scene = new Scene3D(this);
			scene.registerClass(Flare3DLoader1);
			scene.addEventListener("update",updateEventListener);
			//scene.camera.setPosition( -20, 20, -20 );
			scene.camera.lookAt( 0, 0, 0 );
			
			
			addspaceShip();
			addSkyBox();
			addLights();
			addPlanet();
			addInteractions();
			
			
			addEventListener(Event.RESIZE,resizeHandlerGame);
		}
		
		protected function updateEventListener(event:Event):void
		{
			// TODO Auto-generated method stub
			addInteractions();
		}
		
		private function addInteractions():void
		{
			// TODO Auto Generated method stub
			if(Input3D.keyDown(Input3D.SPACE))
			{
				if(spcMoveTimer.running)
				{
					spcMoveTimer.stop();
				}
				else
				{
					spcMoveTimer.start();
				}
			}
			if(Input3D.keyDown(Input3D.LEFT))
			{
				spcship.rotateY(-1);
			}
			if(Input3D.keyDown(Input3D.RIGHT))
			{
				spcship.rotateY(1);
			}
			if(Input3D.keyDown(Input3D.UP))
			{
				spcship.rotateZ(-1);
			}
			if(Input3D.keyDown(Input3D.DOWN))
			{
				spcship.rotateZ(1);
			}
			//Pivot3DUtils.setPositionWithReference( scene.camera, 10, 30, -50, spcship, 0.025 );
			
			// the next line, point the camera to relative center of the car, that is his (0,0,0).
			// but wathever the camera position is, it always will point to the center (or required values) of the car.
			Pivot3DUtils.lookAtWithReference( scene.camera, 0, 0, 0, spcship );
		}
		
		private function addPlanet():void
		{
			// TODO Auto Generated method stub
			var planet:Pivot3D = scene.addChildFromFile("assets/planet.f3d");
			light0.addChild(planet);
			planet.setPosition(2000,2000,2000);
			planet.setScale(5,5,5);
			var orbitTimer:Timer = new Timer(1);
			orbitTimer.addEventListener(TimerEvent.TIMER,doOrbitRotation);
			orbitTimer.start();
		}
		
		protected function doOrbitRotation(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			light0.rotateZ(0.1);
		}
		
		private function addLights():void
		{
			// TODO Auto Generated method stub
			//scene.defaultLight.color.setTo( 1, 1, 1 );
			
			scene.lights.maxPointLights = 1;
			light0 = new Light3D( "light0", Light3D.DIRECTIONAL );
			light0.setPosition(0,0,0);
			light0.setParams( 0xFFE97F, 10000000000 );
			light0.addChild( new Sphere("", 1000, 24, new Shader3D("red", [new ColorFilter(0xFFE97F)], false ) ) );
			scene.addChild( light0 );
		}
		
		private function addspaceShip():void
		{
			// TODO Auto Generated method stub
			spcship = scene.addChildFromFile("assets/spcship.f3d");
			//skybox.setPosition(10000000,10000000,10000000);
			//scene.camera.fieldOfView = 110;
			scene.addChild(spcship);
			
			spcMoveTimer = new Timer(1);
			spcMoveTimer.addEventListener(TimerEvent.TIMER,moveSpaceShip);
		}
		
		protected function moveSpaceShip(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			spcship.translateX(10);
		}
		
		private function addSkyBox():void
		{
			// TODO Auto Generated method stub
			var skybox:SkyBox = new SkyBox("assets/spacebox",SkyBox.FOLDER_PNG,scene,0.5);
			skybox.setScale(1000,1000,1000);
			scene.addChild(skybox);
		}
		
		protected function resizeHandlerGame(event:Event):void
		{
			
		}	
	}
}