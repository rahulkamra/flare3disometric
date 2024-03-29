package game.settings
{
	import game.model.GridEntityVO;

	public class GridEntityMapping
	{
		public function GridEntityMapping()
		{
		}
		
		
		public static const KITCHEN_WOOD_HOUSE:GridEntityVO = new GridEntityVO("assets/house/bldg_general_countrykitchen_wood_t3-13.f3d",[1,3,4],32,32,1/4,4,4);
		public static const MARKET_STALL:GridEntityVO = new GridEntityVO("assets/house/bldg_general_marketstall_wood_t1-21.f3d",[8,9,13],24,24,1/4,3,3);
		public static const FEED_MAKER:GridEntityVO = new GridEntityVO("assets/house/bldg_general_feedmaker_generic_t1-17.f3d",[2,3,4],16,16,1/4,2,2);
		
		public static const TREE_1:GridEntityVO = new GridEntityVO("assets/trees/tree1.f3d",[2,3,4],8,8,1/4,1,1,45);
		public static const TREE_2:GridEntityVO = new GridEntityVO("assets/trees/tree2.f3d",[2,3,4],8,8,1/4,1,1,45);
		public static const TREE_3:GridEntityVO = new GridEntityVO("assets/trees/tree3.f3d",[2,3,4],8,8,1/4,1,1,45);
		public static const TREE_4:GridEntityVO = new GridEntityVO("assets/trees/tree4.f3d",[2,3,4],8,8,1/4,1,1,45);
		
		public static const MALE_CHAR:GridEntityVO = new GridEntityVO("assets/male/avatar_male_surface_rig-11.f3d",[],8,8,1/2,2,2);
		
		public static const MALE_IDLE:String = "assets/male/avatar_male_anim_idle-15.f3d"
		public static const MALE_RUN:String = "assets/male/avatar_male_anim_run-7.f3d"
			
		public static const MALE_TURN_LEFT:String = "assets/male/avatar_male_anim_turn_left-8.f3d"
		public static const MALE_TURN_RIGHT:String = "assets/male/avatar_male_anim_turn_left-8.f3d"
			
			
		public static const BLUE_RING:String = "assets/ring/ring.f3d"
		public static const RED_RING:String = "assets/ring/redring.f3d"
			
		
	}
}