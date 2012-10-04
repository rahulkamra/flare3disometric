package  
{
	import com.electron.engine.util.Utils;
	
	import flare.basic.*;
	import flare.core.*;
	import flare.materials.*;
	import flare.materials.filters.*;
	
	import flash.display.*;
	
	[SWF(frameRate = 60, width = 800, height = 450, backgroundColor = 0x000000)]
	
	/**
	 * Custom mesh test.
	 * 
	 * @author Ariel Nehmad.
	 */
	public class Test14_CustomMesh3D extends Sprite 
	{
		private var scene:Scene3D;
		private var mesh:Mesh3D;
		
		public function Test14_CustomMesh3D(stage:Stage) 
		{
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			scene = new Viewer3D(this);
			scene.camera.setPosition( 0, 20, -30 );
			scene.camera.lookAt( 0, 0, 0 );
			
			mesh = new Mesh3D();
			mesh.surfaces[0] = new Surface3D();
			mesh.surfaces[0].addVertexData( Surface3D.POSITION, 3 );
			mesh.surfaces[0].addVertexData( Surface3D.NORMAL, 3 );
			mesh.surfaces[0].addVertexData( Surface3D.UV0, 2 );
			
				
			var size:int = 1;
												// position,   	normal,  	uv0 
			mesh.surfaces[0].vertexVector.push( -size, 0, size, 	0, 1, 0, 	0, 0,
												 size, 0, size, 	0, 1, 0, 	2, 0,
												-size, 0, -size, 	0, 1, 0, 	0, 2,
												size, 0, -size, 	0, 1, 0, 	2, 2 );
			
			mesh.surfaces[0].indexVector.push( 0, 1, 2, 
											   1, 3, 2 );
			
			var shader:Shader3D = new Shader3D( "material", [new TextureFilter()] );
			shader.twoSided = false;
			
			mesh.surfaces[0].material = shader;			
			
			
			scene.addChild( mesh );
			
			
			
			Utils.Instance.callVeryLate(function temp():void{
				var line:Lines3D = new Lines3D();
				line.moveTo(0,0,0);
				line.setScale(100,100,100);
				line.lineTo(150,200,100);
				line.upload(scene);
				line.draw();
			},1000);
		}
		
	}

}