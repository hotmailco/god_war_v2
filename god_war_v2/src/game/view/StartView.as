package game.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	
	import game.ui.StartViewUI;
	
	public class StartView extends StartViewUI
	{
		public function StartView()
		{
			super();
			
			TweenLite.from(imgBack, .5, {alpha: 0, ease: Strong});
		}
	}
}