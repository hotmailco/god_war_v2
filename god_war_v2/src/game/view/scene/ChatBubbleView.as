package game.view.scene
{
	import game.ui.scene.ChatBubbleViewUI;
	
	public class ChatBubbleView extends ChatBubbleViewUI
	{
		public function ChatBubbleView()
		{
			super();
		}
		
		public function set content(value: String): void
		{
			lblContent.width = 200;
			lblContent.commitMeasure();
			lblContent.text = value;
			
			var margin: Array = new Array();
			margin = lblContent.margin.split(",");
			if(margin.length != 4)
			{
				margin = [5, 5, 5, 20];
			}
			
			var w: int = Math.max(50, lblContent.textField.textWidth + int(margin[0]) + int(margin[2]) + 10);
			lblContent.width = w;
			lblContent.height = lblContent.textField.textHeight + int(margin[1]) + int(margin[3]) + 10;
			lblContent.commitMeasure();
		}
		
	}
}