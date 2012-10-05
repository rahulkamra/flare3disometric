package
{
	import mx.collections.ArrayCollection;

	public class GetData
	{
		public function GetData()
		{
		}
		
		public static function getData():ArrayCollection{
			var ac:ArrayCollection = new ArrayCollection();
			ac.addItem({name:'Goat' , url:'assets/goat/goat_adult_white_surface_rig-3.f3d'});
			
			ac.addItem({name:'Chicken' , url:'assets/chicken/chicken_adult_white_surface_rig-2.f3d',
			animation : [
				
				'assets/chicken/chicken_adult_generic_anim_idle-2.f3d',
				'assets/chicken/chicken_adult_generic_anim_bristle-2.f3d',
				'assets/chicken/chicken_adult_generic_anim_drink-1.f3d',
				'assets/chicken/chicken_adult_generic_anim_eat_not_hungry-2.f3d',
				'assets/chicken/chicken_adult_generic_anim_fidget_a-2.f3d',
				'assets/chicken/chicken_adult_generic_anim_eat-2.f3d',
				'assets/chicken/chicken_adult_generic_anim_happy-2.f3d',
				'assets/chicken/chicken_adult_generic_anim_notice_me-3.f3d',
				'assets/chicken/chicken_adult_generic_anim_notice_me-3.f3d'
			]});
			
			ac.addItem({name:'Horse' , url:'assets/horse/horse_child_camarillo_surface_rig-5.f3d'});
			
			ac.addItem({name:'Male' , url:'assets/male/avatar_male_surface_rig-11.f3d',
				animation : ['' +
					'assets/male/avatar_male_anim_idle-15.f3d',
					'assets/male/avatar_male_anim_axe-9.f3d',
					'assets/male/avatar_male_anim_bored-9.f3d',
					'assets/male/avatar_male_anim_bottle_feed-5.f3d',
					'assets/male/avatar_male_anim_celebrate_a-5.f3d',
					'assets/male/avatar_male_anim_celebrate_b-10.f3d',
					'assets/male/avatar_male_anim_celebrate_c-2.f3d',
					'assets/male/avatar_male_anim_cheer-11.f3d',
					'assets/male/avatar_male_anim_crew_a-1.f3d',
					'assets/male/avatar_male_anim_customize_a-11.f3d',
					'assets/male/avatar_male_anim_fidget_a-13.f3d',
					'assets/male/avatar_male_anim_teleport-5.f3d',
					'assets/male/avatar_male_anim_turn_left-8.f3d',
					'assets/male/avatar_male_anim_turn_right-8.f3d',
					'assets/male/avatar_male_anim_wave_rancherlady-3.f3d',
					'assets/male/avatar_male_anim_run_start-3.f3d',
					'assets/male/avatar_male_anim_run-7.f3d',
					'assets/male/avatar_male_anim_run_stop-7.f3d',
					'assets/male/avatar_male_anim_run_magic-16.f3d'
					
				]
				
			});
			
			ac.addItem({name:'Female' , url:'assets/female/avatar_female_fullbody_rancherlady_surface_rig-4.f3d',
				animation : [
					'assets/female/avatar_female_rancherlady_dismount-12.f3d',
					'assets/female/avatar_female_rancherlady_idle-6.f3d',
					'assets/female/avatar_female_rancherlady_mount-8.f3d',
					'assets/female/avatar_female_rancherlady_ride-6.f3d'
				]
			});
			
			trace("zz");
			ac.addItem({name:'Wood' , url:'assets/wood/tera_general_wood_stump_a-9.f3d',animation : [
			]
			});
			
			
			ac.addItem({name:'Stone' , url:'assets/stone/tera_general_stone_rockedgy_b-12.f3d',animation : [
			]
			});
			
			ac.addItem({name:'Foreground' , url:'assets/foreground/tera_general_foreground_chunk_32-16.f3d',animation : [
			]
			});
			
			ac.addItem({name:'Sky' , url:'assets/sky/tera_general_background_small_sky-3.f3d',animation : [
			]
			});
			
			ac.addItem({name:'Road' , url:'assets/road/tera_general_foreground_road_dirt-16.f3d',animation : [
			]
			});
			
			ac.addItem({name:'House1' , url:'assets/house/bldg_general_countrykitchen_wood_t3-13.f3d',animation : [
			]
			});
			
			ac.addItem({name:'House2' , url:'assets/house/bldg_general_feedmaker_generic_t1-17.f3d',animation : [
			]
			});
			
			ac.addItem({name:'House3' , url:'assets/house/bldg_general_marketstall_wood_t1-21.f3d',animation : [
			]
			});
			
			
			
			return ac;
		}
	}
}