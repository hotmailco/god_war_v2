/**Created by the Morn,do not modify.*/
package game.ui.scene {
	import morn.core.components.*;
	public class SceneViewUI extends View {
		public var boxMenu:Box;
		public var btnRole:Button;
		public var btnPackage:Button;
		public var btnForce:Button;
		public var btnInstance:Button;
		public var btnCard:Button;
		public var btnStrengthen:Button;
		public var btnSocial:Button;
		public var btnMall:Button;
		public var boxChat:Box;
		public var iptMessage:TextInput;
		public var btnSend:Button;
		public var boxRole:Box;
		public var lblLevel:Label;
		protected var uiXML:XML =
			<View>
			  <Box x="622" y="713" var="boxMenu">
			    <Image url="png.scene.menu_bg" y="12"/>
			    <Button skin="png.scene.btn_menu_role" x="18" var="btnRole"/>
			    <Button skin="png.scene.btn_menu_package" x="88" var="btnPackage"/>
			    <Button skin="png.scene.btn_menu_force" x="158" var="btnForce"/>
			    <Button skin="png.scene.btn_menu_instance" x="228" var="btnInstance"/>
			    <Button skin="png.scene.btn_menu_card" x="298" var="btnCard"/>
			    <Button skin="png.scene.btn_menu_strengthen" x="368" var="btnStrengthen"/>
			    <Button skin="png.scene.btn_menu_social" x="438" var="btnSocial"/>
			    <Button skin="png.scene.btn_menu_mall" x="508" var="btnMall"/>
			  </Box>
			  <Box x="0" y="446" var="boxChat">
			    <Image url="png.scene.chat_bg" sizeGrid="0,50,0,120" visible="false"/>
			    <TextInput skin="png.scene.input_chat" x="62" y="313" width="215" height="26" color="0xff9900" font="Microsoft YaHei" size="12" margin="5,1,5,1" selectable="true" var="iptMessage"/>
			    <Button label="发送" skin="png.scene.btn_send_message" x="277" y="312" labelColors="0xFFFFFF,0xFFFF00,0xAAAAAA" labelFont="Microsoft YaHei" labelSize="11" labelBold="true" var="btnSend"/>
			  </Box>
			  <Box x="0" y="0" var="boxRole">
			    <Image url="png.scene.avatar_down_bg" x="11" y="10"/>
			    <Image url="png.scene.avatar_up_bg" x="0" y="0"/>
			    <Image url="png.scene.level_bg" x="115" y="10"/>
			    <Label text="1" x="122" y="17" font="Microsoft YaHei" size="16" color="0xff9900" width="27" height="25" align="center" bold="true" stroke="0" var="lblLevel"/>
			  </Box>
			</View>;
		public function SceneViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}