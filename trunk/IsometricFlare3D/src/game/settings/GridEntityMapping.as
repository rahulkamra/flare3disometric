package game.settings
{
	import game.model.GridEntityVO;

	public class GridEntityMapping
	{
		public function GridEntityMapping()
		{
		}
		
		
		public static const KITCHEN_WOOD_HOUSE:GridEntityVO = new GridEntityVO("assets/house/bldg_general_countrykitchen_wood_t3-13.f3d",32,32,1/4,4,4);
		public static const MARKET_STALL:GridEntityVO = new GridEntityVO("assets/house/bldg_general_marketstall_wood_t1-21.f3d",24,24,1/4,3,3);
		public static const FEED_MAKER:GridEntityVO = new GridEntityVO("assets/house/bldg_general_feedmaker_generic_t1-17.f3d",16,16,1/4,2,2);
		
		public static const MALE_CHAR:GridEntityVO = new GridEntityVO("assets/male/avatar_male_surface_rig-11.f3d",8,8,1/2,2,2);
		
		public static const MALE_IDLE:String = "assets/male/avatar_male_anim_idle-15.f3d"
		public static const MALE_TURN_LEFT:String = "assets/male/avatar_male_anim_turn_left-8.f3d"
		public static const MALE_TURN_RIGHT:String = "assets/male/avatar_male_anim_turn_left-8.f3d"
		
	}
}