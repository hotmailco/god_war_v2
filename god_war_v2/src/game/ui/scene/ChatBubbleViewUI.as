/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class ChatBubbleViewUI extends View {
		public var imgBubble:Image;
		public var lblContent:Label;
		protected var uiXML:XML =
			<View>
			  <Image url="png.chat_bubble.default" x="0" y="0" sizeGrid="35,10,10,20" var="imgBubble" width="50" height="40"/>
			  <Label text="label" x="5" y="5" width="40" height="20" wordWrap="true" multiline="true" isHtml="true" align="left" autoSize="none" var="lblContent" size="12" font="Microsoft YaHei"/>
			</View>;
		public function ChatBubbleViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}