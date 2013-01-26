package  
{
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	/**
	 * ...
	 * @author Galman33
	 */
	public class Music 
	{
		
		[Embed(source = "res/music/AI-maj.mp3")]
		private static const MusicGood :Class;
		
		[Embed(source = "res/music/AI-min.mp3")]
		private static const MusicBad :Class;
		
		private static var goodMusic :Sfx = new Sfx(MusicGood);
		private static var badMusic :Sfx = new Sfx(MusicBad);
		
		private static var goodMusicLevel :Number = 1;
		
		public static function init() :void
		{
			goodMusic = new Sfx(MusicGood);
			badMusic = new Sfx(MusicBad);
			goodMusic.loop(0.3);
			badMusic.loop(0.3);
			mute();
		}
		
		public static function resume() :void
		{
			goodMusic.volume = goodMusicLevel;
			badMusic.volume = 1 - goodMusicLevel;
		}
		
		public static function mute() :void
		{
			goodMusic.volume = 0;
			badMusic.volume = 0;
		}
		
		public static function setGoodMusicLevel(amount :Number) :void
		{
			goodMusicLevel = amount;
			resume();
		}
		
	}

}