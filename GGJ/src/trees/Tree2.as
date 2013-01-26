package trees
{
	/**
	 * ...
	 * @author Galman33
	 */
	public class Tree2 extends Tree 
	{
		
		[Embed(source = "../res/Tree2.png")]
		private static const Tree2Graphics :Class;
		
		public function Tree2() 
		{
			super(Tree2Graphics, 128, 64, [0, 1, 2, 3, 4, 5, 6, 7]);
		}
		
	}

}