/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class ChatBubbleViewUI extends View {
		public var lblContent:Label;
		protected var uiXML:XML =
			<View>
			  <Label x="0" y="0" wordWrap="true" multiline="false" isHtml="true" align="left" autoSize="left" var="lblContent" size="12" font="Microsoft YaHei" skin="png.chat_bubble.default" sizeGrid="35,10,10,20" margin="5,5,5,20" width="200" height="40"/>
			</View>;
		public function ChatBubbleViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}