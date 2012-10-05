package game.entity.base
{
	import game.entity.AvatarEvent;
	import game.entity.SmurfCharacter;
	
	public class AvatarPath extends BasePath
	{
		public function AvatarPath(smurfCharacter:SmurfCharacter)
		{
			super(smurfCharacter);
		}
		
		override public function get normalTime():Number{
			return 0.4;
		}
		public function get avatar():SmurfCharacter{
			return character as SmurfCharacter
		}
		
		override public function movementStart():void{
			(character as SmurfCharacter).showRun();
			dispatchEvent(new AvatarEvent(AvatarEvent.AVATAR_MOVEMENT_START));
		}
		private function moveToPath(path:Array):void{
			move(path);
		}
		
		override public  function movementEnd():void{
			avatar.showIdle();
			dispatchEvent(new AvatarEvent(AvatarEvent.AVATAR_MOVEMENT_END));
		}
		
		override public function stop():void
		{
			super.stop();
			avatar.showIdle();
			
		}
		
	}
}