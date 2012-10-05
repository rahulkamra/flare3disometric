package game.entity
{
	import flash.events.Event;
	
	public class AvatarEvent extends Event
	{
		public static const AVATAR_MOVEMENT_END:String = "AvatarMovementEnd";
		public static const AVATAR_MOVEMENT_START:String = "AvatarMovementStart";
		
		public function AvatarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new AvatarEvent(type,bubbles, cancelable);
		}
	}
}