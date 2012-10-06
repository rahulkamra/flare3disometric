package game.controller
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import game.IsometricGame;

	public class ByteLoader
	{
		public function ByteLoader()
		{
		}
		
		public static var dict:Dictionary = new Dictionary();
		private var url:String;
		
		public function loadAsset(url:String):void{
			this.url = url;
			var _loader:URLLoader = new URLLoader();
			_loader.addEventListener( Event.COMPLETE, completeEvent );
			_loader.load( new URLRequest(url) );
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		private function completeEvent( e:Event ):void
		{
			var loader:URLLoader = e.target as URLLoader;
			dict[url] = loader.data;
			IsometricGame.addTrees();
				
		}
		
	}
}