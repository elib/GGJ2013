package trees
{
	/**
	 * ...
	 * @author Galman33
	 */
	public class Tree3 extends Tree 
	{
		
		[Embed(source = "../res/Tree3.png")]
		private static const Tree3Graphics :Class;
		
		public function Tree3() 
		{
			super(Tree3Graphics, 64, 64, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
		}
		
	}

}