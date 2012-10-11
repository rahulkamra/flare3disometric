package core
{
	import constants.GameConstants;
	
	import flare.core.Pivot3D;

	public class Character extends Pivot3D
	{
		
		public var char:Pivot3D
		public function Character()
		{
			char  = Main.scene.addChildFromFile(GameConstants.MALE_CHAR) as Pivot3D;
			addChild(char);
		}
	}
}