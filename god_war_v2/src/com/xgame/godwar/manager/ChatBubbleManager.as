package com.xgame.godwar.manager
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.xgame.common.display.PlayerDisplay;
	
	import flash.errors.IllegalOperationError;
	
	import game.view.scene.ChatBubbleView;

	public class ChatBubbleManager
	{
		private static var _instance: ChatBubbleManager;
		private static var _allowInstance: Boolean = false;
		
		public function ChatBubbleManager()
		{
			if(!_allowInstance)
			{
				throw new IllegalOperationError("不能实例化这个类");
			}
		}
		
		public static function get instance(): ChatBubbleManager
		{
			if(_instance == null)
			{
				_allowInstance = true;
				_instance = new ChatBubbleManager();
				_allowInstance = false;
			}
			return _instance;
		}
		
		public function showBubble(player: PlayerDisplay, content: String): void
		{
			var bubble: ChatBubbleView;
			if(player.chatBubble == null)
			{
				bubble = new ChatBubbleView();
				bubble.x = -20;
				player.chatBubble = bubble;
			}
			else
			{
				bubble = player.chatBubble as ChatBubbleView;
				bubble.alpha = 1;
				bubble.visible = true;
				player.addAdditionalDisplay(bubble);
			}
			TweenLite.killTweensOf(bubble);
			
			bubble.content = content;
			bubble.y = -player.graphic.frameHeight - bubble.height;
			TweenLite.to(bubble, .5, {delay: 5, alpha: 0, ease: Strong.easeOut, onComplete: function(): void
			{
				bubble.visible = false;
				player.removeAdditionalDisplay(bubble);
			}});
		}
	}
}