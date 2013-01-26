package trees
{
	/**
	 * ...
	 * @author Galman33
	 */
	public class Tree1 extends Tree 
	{
		
		[Embed(source = "../res/Tree.png")]
		private static const Tree1Graphics :Class;
		
		public function Tree1() 
		{
			super(Tree1Graphics, 64, 128, [0, 1, 2, 3, 4, 5, 6]);
		}
		
	}

}